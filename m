Received: from eggs.gnu.org ([2001:4830:134:3::10]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fShfx-0004Nx-PK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fShfu-0006hC-LM
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:41:25 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:52358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fShfu-0006fq-EY
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:41:22 -0400
Received: from player795.ha.ovh.net (unknown [10.109.108.4])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A177EC4C72
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:41:18 +0200 (CEST)
Date: Tue, 12 Jun 2018 13:41:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180612134104.11bd1b62@bahia.lan>
In-Reply-To: <20180612101135.23852-1-clg@kaod.org>
References: <20180612101135.23852-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 12 Jun 2018 12:11:35 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to :
>=20
>   hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
>   hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this
>     function [-Werror=3Dmaybe-uninitialized]
>              return ret;
>=20
> Fix the breakage and also remove the extra error reporting as
> kvm_device_access() already provides a substantial error message.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Greg, can you please test ? RHEL7.5 does not catch the issue with the
>  same compiler level :/ I don't understand why.
>=20

This fixes the build breakage for me. Now this should really be squashed
into your original patch to preserve bisect on master.

Just one remark:

>  hw/intc/xics_kvm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8bdf6afe82a0..8dba2f84e71e 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -186,8 +186,7 @@ static void ics_get_kvm_state(ICSState *ics)
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &local_err);
>          if (local_err) {
> -            error_report("Unable to retrieve KVM interrupt controller st=
ate"
> -                    " for IRQ %d: %s", i + ics->offset, strerror(errno));
> +            error_report_err(local_err);

This would change the error message from:

Unable to retrieve KVM interrupt controller state for IRQ 4096: Invalid arg=
ument

to

KVM_GET_DEVICE_ATTR failed: Group 1 attr 0x0000000000001000: Invalid argume=
nt

I find it a bit cryptic, and we loose both the IRQ number and direct indica=
tion
that it is related to XICS on KVM. That's why I had suggested to print both=
 with
error_reportf_err().

Since this would result in a very long line, alternatively, you can
keep the current error message, using -ret instead of errno, and call
error_free(local_err).

>              exit(1);
>          }
> =20
> @@ -273,11 +272,10 @@ static int ics_set_kvm_state(ICSState *ics, int ver=
sion_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, true, &local_err);
> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
> +                                i + ics->offset, &state, true, &local_er=
r);
>          if (local_err) {
> -            error_report("Unable to restore KVM interrupt controller sta=
te"
> -                    " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
> +            error_report_err(local_err);



>              return ret;
>          }
>      }
