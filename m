Received: from eggs.gnu.org ([2001:4830:134:3::10]:33556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dGo08-0006Ii-QP
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dGo04-0008E5-02
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dGo03-0008Do-Pr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:56:27 -0400
Message-ID: <1496415382.16895.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 02 Jun 2017 16:56:22 +0200
In-Reply-To: <e3a61707-2356-7ad3-0efc-e7d0c4115eea@redhat.com>
References: <20170601112241.2580-1-ard.biesheuvel@linaro.org>
	<ccc0e728-0348-e386-6f71-0c1c69eaa01d@redhat.com>
	<e3a61707-2356-7ad3-0efc-e7d0c4115eea@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, edk2-devel@lists.01.org
Cc: leif.lindholm@linaro.org, jordan.l.justen@intel.com, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>, Drew Jones <drjones@redhat.com>

  Hi,

>=C2=A0The reason is that old firmware is allowed to fail on new QEMU
> (regardless of machine type). Example: the WRITE_POINTER command,
> originally introduced for VMGENID. If you run a SeaBIOS binary
> without
> WRITE_POINTER support, in a QEMU VM with "-device vmgenid", the
> device
> will not work.

Old seabios will work just fine on new qemu as long as you don't use
the vmgenid device.

Only when using new features (which require firmware support) new
seabios is needed, and usually we update seabios for that reason.  We
want the new features be usable of course.  But in general there are no
lockstep updates for qemu and seabios (any more).

> And this patch is actually that case, because the new fw would
> allocate
> blobs with such 8-byte addresses that might not fit into 32-bit blob
> fields.

I think ovmf simply checking whenever the pointer fields are 32bit or
64bit, then doing allocations accordingly (as Igor suggested) would be
the best.  Why ask qemu for a hint when ovmf can figure on its own?=20
That adds a new interface and new config knobs for IMO no good reason.

cheers,
  Gerd
