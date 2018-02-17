Received: from eggs.gnu.org ([2001:4830:134:3::10]:59532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emxat-0007SQ-Qv
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emxao-0000jl-RO
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:11:39 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <331dee18-2eb2-9189-852b-bf8723c03d27@redhat.com>
Date: Sat, 17 Feb 2018 09:11:12 +0100
MIME-Version: 1.0
In-Reply-To: <1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 16.02.2018 23:07, Collin L. Walling wrote:
> The s390-ccw firmware needs some information in support of the
> boot process which is not available on the native machine.
> Examples are the netboot firmware load address and now the
> boot menu parameters.
>=20
> While storing that data in unused fields of the IPL parameter block
> works, that approach could create problems if the parameter block
> definition should change in the future. Because then a guest could
> overwrite these fields using the set IPLB diagnose.
>=20
> In fact the data in question is of more global nature and not really
> tied to an IPL device, so separating it is rather logical.
>=20
> This commit introduces a new structure to hold firmware relevant
> IPL parameters set by QEMU. The data is stored at location 204 (dec)
> and can contain up to 7 32-bit words. This area is available to
> programming in the z/Architecture Principles of Operation and
> can thus safely be used by the firmware until the IPL has completed.
>=20
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
[...]
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8a705e0..74469b1 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -16,8 +16,7 @@
>  #include "cpu.h"
> =20
>  struct IplBlockCcw {
> -    uint64_t netboot_start_addr;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[85];
>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -59,6 +58,21 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
> =20
>  #define DIAG308_FLAGS_LP_VALID 0x80
> =20
> +#define QIPL_ADDRESS  0xcc
> +
> +/*
> + * The QEMU IPL Parameters will be stored 32-bit word aligned.
> + * Placement of data fields in this area must account for
> + * their alignment needs.
> + * The entire structure must not be larger than 28 bytes.
> + */
> +struct QemuIplParameters {
> +    uint8_t  reserved1[4];
> +    uint64_t netboot_start_addr;
> +    uint8_t  reserved2[16];
> +} QEMU_PACKED;
> +typedef struct QemuIplParameters QemuIplParameters;
> +
>  union IplParameterBlock {
>      struct {
>          uint32_t len;
> @@ -74,6 +88,7 @@ union IplParameterBlock {
>              IplBlockFcp fcp;
>              IplBlockQemuScsi scsi;
>          };
> +        QemuIplParameters qipl;
>      } QEMU_PACKED;
>      struct {
>          uint8_t  reserved1[110];

I still think that the information should *not* be stored within the
IplParameterBlock to avoid that we pass it via DIAG 0x308, too.
If we do it like this, I'm pretty sure that we will look at this code in
a couple of years and wonder whether we can change it again or whether
this is an established interface between the host and the guest. So
please, let's avoid establishing such "hidden" interfaces just out of
current convenience. There must be a better location for this.
Christian, do you have an idea?

 Thomas
