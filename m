Received: from eggs.gnu.org ([2001:4830:134:3::10]:52100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIPV-00028K-LG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIPS-0006bN-Hv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:50:13 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1euIPS-0006a6-Bx
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:50:10 -0500
Received: by mail-wm0-x242.google.com with SMTP id z9so4002748wmb.3
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:50:10 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<20180308130626.12393-7-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180308130626.12393-7-peter.maydell@linaro.org>
Date: Fri, 09 Mar 2018 13:50:07 +0000
Message-ID: <871sgtl5o0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/6] hw/arm/virt: Support -machine
 gic-version=max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add support for passing 'max' to -machine gic-version. By analogy
> with the -cpu max option, this picks the "best available" GIC version
> whether you're using KVM or TCG, so it behaves like 'host' when
> using KVM, and gives you GICv3 when using TCG.
>
> Also like '-cpu host', using -machine gic-version=3Dmax' means there
> is no guarantee of migration compatibility between QEMU versions;
> in future 'max' might mean '4'.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cda4b83586..2c07245047 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1207,16 +1207,23 @@ static void machvirt_init(MachineState *machine)
>      /* We can probe only here because during property set
>       * KVM is not available yet
>       */
> -    if (!vms->gic_version) {
> +    if (vms->gic_version <=3D 0) {
> +        /* "host" or "max" */
>          if (!kvm_enabled()) {
> -            error_report("gic-version=3Dhost requires KVM");
> -            exit(1);
> -        }
> -
> -        vms->gic_version =3D kvm_arm_vgic_probe();
> -        if (!vms->gic_version) {
> -            error_report("Unable to determine GIC version supported by h=
ost");
> -            exit(1);
> +            if (vms->gic_version =3D=3D 0) {
> +                error_report("gic-version=3Dhost requires KVM");
> +                exit(1);
> +            } else {
> +                /* "max": currently means 3 for TCG */
> +                vms->gic_version =3D 3;
> +            }
> +        } else {
> +            vms->gic_version =3D kvm_arm_vgic_probe();
> +            if (!vms->gic_version) {
> +                error_report(
> +                    "Unable to determine GIC version supported by host");
> +                exit(1);
> +            }
>          }
>      }
>
> @@ -1480,9 +1487,11 @@ static void virt_set_gic_version(Object *obj, cons=
t char *value, Error **errp)
>          vms->gic_version =3D 2;
>      } else if (!strcmp(value, "host")) {
>          vms->gic_version =3D 0; /* Will probe later */
> +    } else if (!strcmp(value, "max")) {
> +        vms->gic_version =3D -1; /* Will probe later */
>      } else {
>          error_setg(errp, "Invalid gic-version value");
> -        error_append_hint(errp, "Valid values are 3, 2, host.\n");
> +        error_append_hint(errp, "Valid values are 3, 2, host,
> max.\n");

nit: host is only valid on aarch64 host. However it will fail later on
with:

  qemu-system-aarch64: gic-version=3Dhost requires KVM

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
