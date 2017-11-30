Received: from eggs.gnu.org ([2001:4830:134:3::10]:40235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKNbg-0000i0-Bk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKNbb-0003WM-DA
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:06:20 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-8-david@redhat.com>
	<51ed083c-b6d7-9954-9c17-2259156ed3fe@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1a8b5c6e-e138-2799-058e-31547500ac08@redhat.com>
Date: Thu, 30 Nov 2017 13:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <51ed083c-b6d7-9954-9c17-2259156ed3fe@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 30.11.2017 12:01, Thomas Huth wrote:
> On 29.11.2017 21:26, David Hildenbrand wrote:
>> s390_cpu_virt_mem_rw() must always return, so callers can react on
>> an exception (e.g. see ioinst_handle_stcrw()).
>>
>> However, for TCG we always have to exit the cpu loop (and restore the
>> cpu state before that) if we injected a program interrupt. So let's
>> introduce and use s390_cpu_virt_mem_handle_exc() in code that is not
>> purely KVM.
>>
>> Directly pass the retaddr we already have available in these functions=
.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-inst.c  |  7 +++++++
>>  target/s390x/cpu.h        |  1 +
>>  target/s390x/ioinst.c     | 20 +++++++++++++++++---
>>  target/s390x/mmu_helper.c | 14 ++++++++++++++
>>  4 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8123705dfd..6f41083244 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -163,6 +163,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uin=
tptr_t ra)
>>      }
>> =20
>>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer, sizeof=
(*reqh))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>>          return 0;
>>      }
>>      reqh =3D (ClpReqHdr *)buffer;
>> @@ -174,6 +175,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uin=
tptr_t ra)
>> =20
>>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
>>                                 req_len + sizeof(*resh))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>>          return 0;
>>      }
>>      resh =3D (ClpRspHdr *)(buffer + req_len);
>> @@ -189,6 +191,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uin=
tptr_t ra)
>> =20
>>      if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
>>                                 req_len + res_len)) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>>          return 0;
>>      }
> [...]
>=20
> Having to change all these spots is kind of ugly ... and I guess it wil=
l also
> be quite error-prone in the future (if someone is developing new code u=
nder
> KVM only and then forgets to add these handlers for TCG).

The good thing is, it won't break KVM but only TCG. And it has been
broken in TCG for years now without anybody noticing it.

>=20
> Can't you do that simply always at the end of s390_cpu_virt_mem_rw() in=
stead,
> when the function has been called in non-checking mode (i.e. hostbuf !=3D=
 NULL)?
> Then we only need the extra-dance in places where we call the _check fu=
nction?

Oh god no, no such strange calling conventions from the same function.

>=20
>> @@ -212,9 +214,12 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t i=
pb, uintptr_t ra)
>> =20
>>      if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) =3D=
=3D 0) {
>>          setcc(cpu, cc);
>> -    } else if (cc =3D=3D 0) {
>> -        /* Write failed: requeue CRW since STCRW is a suppressing ins=
truction */
>> -        css_undo_stcrw(&crw);
>> +    } else {
>> +        if (cc =3D=3D 0) {
>> +            /* Write failed: requeue CRW since STCRW is suppressing *=
/
>> +            css_undo_stcrw(&crw);
>> +        }
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>>      }
>>  }
>=20
> That hunk would then need to do _check first and in case there is a fai=
lure,
> call css_undo_stcrw() before the s390_cpu_virt_mem_handle_exc() functio=
n, I think.

I don't really like that. And there would be a possibility for a race.
So a no from my side.

>=20
> Alternatively, the s390_cpu_virt_mem_rw() function could get an additio=
nal parameter
> that points to a callback function which is used for "clean-up" right b=
efore the
> cpu_loop_exit ... and in this case the callback function would contain =
the
> css_undo_stcrw().
>=20
> What do you think?

I also thought about this, but adding two parameters to every call is
even uglier. Not talking about having to construct special structs to
pass through the data. Please not that the TPI handler I am about to
introduce will also require to revert stuff in case there was an exceptio=
n.

Another option I thought about was checking in the caller if EXC_PGM has
been set. But missing to add such a check is even easier.

I'd prefer to keep it as is, but if there are other opinions/ideas,
please speak up.

Thanks for having a look!

>=20
>  Thomas
>=20


--=20

Thanks,

David / dhildenb
