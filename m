Received: from eggs.gnu.org ([2001:4830:134:3::10]:41076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGWtM-0005HD-Th
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGWtJ-0005eb-PA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGWtJ-0005du-GF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:40:21 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20170601112241.2580-1-ard.biesheuvel@linaro.org>
	<ccc0e728-0348-e386-6f71-0c1c69eaa01d@redhat.com>
Message-ID: <e3a61707-2356-7ad3-0efc-e7d0c4115eea@redhat.com>
Date: Thu, 1 Jun 2017 22:40:07 +0200
MIME-Version: 1.0
In-Reply-To: <ccc0e728-0348-e386-6f71-0c1c69eaa01d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] OvmfPkg/AcpiPlatformDxe: lift 4 GB
 alloc limit for modern ACPI systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, edk2-devel@lists.01.org
Cc: leif.lindholm@linaro.org, jordan.l.justen@intel.com, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>, Drew Jones <drjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 06/01/17 14:25, Laszlo Ersek wrote:

> In QEMU, we could tie both of these extensions to new machine types.
> 
> The result would be:
> 
>   firmware  QEMU  QEMU machine type  result
>   --------  ----  -----------------  -----------------------------------
>   old       new   old                allocate blobs under 4GB
>   old       new   new                breakage, but that's OK, we can
>                                        require refreshed firmware for
>                                        new machine types
>   new       old   old                allocate blobs under 4GB
>   new       new   old                allocate blobs under 4GB
>   new       new   new                allocate blobs from 64-bit space

I think the situation is easier than this. We don't have to tie the
extensions to machine types.

The reason is that old firmware is allowed to fail on new QEMU
(regardless of machine type). Example: the WRITE_POINTER command,
originally introduced for VMGENID. If you run a SeaBIOS binary without
WRITE_POINTER support, in a QEMU VM with "-device vmgenid", the device
will not work. And QEMU doesn't try to prevent that by binding vmgenid
to machine types. Instead, QEMU bundled a SeaBIOS binary with
WRITE_POINTER support, for the release that introduced VMGENID.

(There's no reason for not bundling OVMF and ArmVirtQemu binaries with
QEMU releases now. Gerd already has a build service up and running, at
<http://www.kraxel.org/repos/>.)

The scenario that we *should* avoid is new firmware failing on old QEMU.
And this patch is actually that case, because the new fw would allocate
blobs with such 8-byte addresses that might not fit into 32-bit blob
fields. So, the extensions are necessary, but tying them to machine
types isn't.

  firmware  QEMU  result
  --------  ----  ------------------------------------------------------
  old       new   breakage, but that's OK; we can require refreshed
                    firmware for new QEMU releases
  new       old   allocate blobs under 4GB (alloc zone extension is
                    necessary)
  new       new   allocate blobs from any address range

Thanks
Laszlo
