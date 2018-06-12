Received: from eggs.gnu.org ([2001:4830:134:3::10]:41072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSgG5-0001e8-UZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSgG1-0001IN-6s
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:10:37 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:48533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSgG1-0001Hc-08
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:10:33 -0400
Received: from player763.ha.ovh.net (unknown [10.109.105.101])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 37801136749
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:10:29 +0200 (CEST)
References: <20180612100857.23093-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <971e8cd7-69c3-0859-249b-2339986018fa@kaod.org>
Date: Tue, 12 Jun 2018 12:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180612100857.23093-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>

Forget that patch its bogus. sending a v2.

On 06/12/2018 12:08 PM, C=C3=A9dric Le Goater wrote:
> On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to =
:
>=20
>   hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
>   hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used u=
ninitialized in this
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
>  same compiler level :/ I don't understand why.=20
> =20
>  hw/intc/xics_kvm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8bdf6afe82a0..2113b6987a45 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -186,8 +186,7 @@ static void ics_get_kvm_state(ICSState *ics)
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &local_err);
>          if (local_err) {
> -            error_report("Unable to retrieve KVM interrupt controller =
state"
> -                    " for IRQ %d: %s", i + ics->offset, strerror(errno=
));
> +            error_report_err(local_err);
>              exit(1);
>          }
> =20
> @@ -273,11 +272,10 @@ static int ics_set_kvm_state(ICSState *ics, int v=
ersion_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, true, &local_err);
> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOU=
RCES,
> +                                i + ics->offset, &state, true, &local_=
err);
>          if (local_err) {
> -            error_report("Unable to restore KVM interrupt controller s=
tate"
> -                    " for IRQs %d: %s", i + ics->offset, strerror(errn=
o));
> +            error_report_err(err);
>              return ret;
>          }
>      }
>=20
