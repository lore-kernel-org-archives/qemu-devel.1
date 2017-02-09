Received: from eggs.gnu.org ([2001:4830:134:3::10]:33507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbcjn-0003p6-Vq
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbcjl-00020P-E1
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:37:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbcjl-000206-8S
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:37:25 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a6cf75ec-d4b3-02c1-682f-6c1e701b9643@redhat.com>
Date: Thu, 9 Feb 2017 01:37:22 +0100
MIME-Version: 1.0
In-Reply-To: <28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 02/05/17 10:12, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This implements the VM Generation ID feature by passing a 128-bit
> GUID to the guest via a fw_cfg blob.
> Any time the GUID changes, an ACPI notify event is sent to the guest
> 
> The user interface is a simple device with one parameter:
>  - guid (string, must be "auto" or in UUID format
>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  default-configs/i386-softmmu.mak     |   1 +
>  default-configs/x86_64-softmmu.mak   |   1 +
>  hw/acpi/Makefile.objs                |   1 +
>  hw/acpi/vmgenid.c                    | 206 +++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c                 |  10 ++
>  include/hw/acpi/acpi_dev_interface.h |   1 +
>  include/hw/acpi/vmgenid.h            |  37 +++++++
>  7 files changed, 257 insertions(+)
>  create mode 100644 hw/acpi/vmgenid.c
>  create mode 100644 include/hw/acpi/vmgenid.h

[snip]


> +static void vmgenid_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_vmgenid;
> +}

I think in this function, you should set up a dc->realize member as
well. And, in that dc->realize member, you should call
qemu_register_reset().

Because, as it stands now, the "vgia_le" field is not cleared on reset.
It should be; when the guest is rebooted, we should forget any address
returned by its firmware.

In this reset callback, you should also clear the (new) latch that
tracks whether the "vmgenid" blob was selected since reset. (The latch
is for approach (iii) against the race.)

Thanks,
Laszlo
