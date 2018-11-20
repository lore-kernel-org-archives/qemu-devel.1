Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP8yA-0005J0-7W
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP8y9-00078d-9S
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:33:46 -0500
Date: Tue, 20 Nov 2018 17:33:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181120173324.64a36d8e@redhat.com>
In-Reply-To: <20181107123652.23417-3-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 02/14] qom: make interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, lersek@redhat.com

On Wed,  7 Nov 2018 16:36:40 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Interfaces don't have instance, let's make the interface type really
> abstract to avoid confusion.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/acpi/acpi_dev_interface.h | 6 +-----
>  include/hw/arm/linux-boot-if.h       | 5 +----
>  include/hw/fw-path-provider.h        | 4 +---
>  include/hw/hotplug.h                 | 6 +-----
>  include/hw/intc/intc.h               | 4 +---
>  include/hw/ipmi/ipmi.h               | 4 +---
>  include/hw/isa/isa.h                 | 4 ----
>  include/hw/mem/memory-device.h       | 4 +---
>  include/hw/nmi.h                     | 4 +---
>  include/hw/stream.h                  | 4 +---
>  include/hw/timer/m48t59.h            | 4 +---
>  include/qom/object_interfaces.h      | 6 +-----
>  include/sysemu/tpm.h                 | 4 +---
>  target/arm/idau.h                    | 4 +---
>  tests/check-qom-interface.c          | 4 +---
>  15 files changed, 14 insertions(+), 53 deletions(-)
>=20
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
> index dabf4c4fc9..43ff119179 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -25,11 +25,7 @@ typedef enum {
>       INTERFACE_CHECK(AcpiDeviceIf, (obj), \
>                       TYPE_ACPI_DEVICE_IF)
> =20
> -
> -typedef struct AcpiDeviceIf {
> -    /* <private> */
> -    Object Parent;
> -} AcpiDeviceIf;
> +typedef struct AcpiDeviceIf AcpiDeviceIf;
> =20
>  void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
> =20
> diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boot-i=
f.h
> index aba4479a14..7bbdfd1cc6 100644
> --- a/include/hw/arm/linux-boot-if.h
> +++ b/include/hw/arm/linux-boot-if.h
> @@ -16,10 +16,7 @@
>  #define ARM_LINUX_BOOT_IF(obj) \
>      INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
> =20
> -typedef struct ARMLinuxBootIf {
> -    /*< private >*/
> -    Object parent_obj;
> -} ARMLinuxBootIf;
> +typedef struct ARMLinuxBootIf ARMLinuxBootIf;
I like how it makes interface truly opaque and removes the need for
structure declaration but:

 1: I'm not sure if it's acceptable thing to do from language point of view

 2: For a reader not aware of a trick, it's sort of confusing to have forwa=
rd declaration but without structure itself. So if #1 is acceptable we prob=
ably should document interface trick in object.h

[...]
