Received: from eggs.gnu.org ([2001:4830:134:3::10]:43736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKMap-0003Kl-R1
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKMak-0000ED-60
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:01:23 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51ed083c-b6d7-9954-9c17-2259156ed3fe@redhat.com>
Date: Thu, 30 Nov 2017 12:01:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 07/16] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 21:26, David Hildenbrand wrote:
> s390_cpu_virt_mem_rw() must always return, so callers can react on
> an exception (e.g. see ioinst_handle_stcrw()).
>=20
> However, for TCG we always have to exit the cpu loop (and restore the
> cpu state before that) if we injected a program interrupt. So let's
> introduce and use s390_cpu_virt_mem_handle_exc() in code that is not
> purely KVM.
>=20
> Directly pass the retaddr we already have available in these functions.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c  |  7 +++++++
>  target/s390x/cpu.h        |  1 +
>  target/s390x/ioinst.c     | 20 +++++++++++++++++---
>  target/s390x/mmu_helper.c | 14 ++++++++++++++
>  4 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 8123705dfd..6f41083244 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -163,6 +163,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uint=
ptr_t ra)
>      }
> =20
>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer, sizeof(=
*reqh))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>          return 0;
>      }
>      reqh =3D (ClpReqHdr *)buffer;
> @@ -174,6 +175,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uint=
ptr_t ra)
> =20
>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
>                                 req_len + sizeof(*resh))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>          return 0;
>      }
>      resh =3D (ClpRspHdr *)(buffer + req_len);
> @@ -189,6 +191,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uint=
ptr_t ra)
> =20
>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
>                                 req_len + res_len)) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>          return 0;
>      }
[...]

Having to change all these spots is kind of ugly ... and I guess it will =
also
be quite error-prone in the future (if someone is developing new code und=
er
KVM only and then forgets to add these handlers for TCG).

Can't you do that simply always at the end of s390_cpu_virt_mem_rw() inst=
ead,
when the function has been called in non-checking mode (i.e. hostbuf !=3D=
 NULL)?
Then we only need the extra-dance in places where we call the _check func=
tion?

> @@ -212,9 +214,12 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ip=
b, uintptr_t ra)
> =20
>      if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) =3D=3D=
 0) {
>          setcc(cpu, cc);
> -    } else if (cc =3D=3D 0) {
> -        /* Write failed: requeue CRW since STCRW is a suppressing inst=
ruction */
> -        css_undo_stcrw(&crw);
> +    } else {
> +        if (cc =3D=3D 0) {
> +            /* Write failed: requeue CRW since STCRW is suppressing */
> +            css_undo_stcrw(&crw);
> +        }
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>      }
>  }

That hunk would then need to do _check first and in case there is a failu=
re,
call css_undo_stcrw() before the s390_cpu_virt_mem_handle_exc() function,=
 I think.

Alternatively, the s390_cpu_virt_mem_rw() function could get an additiona=
l parameter
that points to a callback function which is used for "clean-up" right bef=
ore the
cpu_loop_exit ... and in this case the callback function would contain th=
e
css_undo_stcrw().

What do you think?

 Thomas
