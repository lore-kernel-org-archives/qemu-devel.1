Received: from eggs.gnu.org ([2001:4830:134:3::10]:56880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mwinslow@infoblox.com>) id 1d5ILG-0004lO-3g
	for qemu-devel@nongnu.org; Mon, 01 May 2017 16:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mwinslow@infoblox.com>) id 1d5ILB-00060q-0Z
	for qemu-devel@nongnu.org; Mon, 01 May 2017 16:54:46 -0400
Received: from mx2.infoblox.com ([205.234.19.214]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mwinslow@infoblox.com>)
	id 1d5ILA-00060U-Ky
	for qemu-devel@nongnu.org; Mon, 01 May 2017 16:54:40 -0400
Received: from X2008CASHUB1.infoblox.com (x2008cashub1.infoblox.com
	[205.234.19.141]) by mx2.infoblox.com with ESMTP id
	d6tyFEeha1HcOZ39 (version=TLSv1 cipher=AES128-SHA bits=128
	verify=NO) for <qemu-devel@nongnu.org>;
	Mon, 01 May 2017 13:54:33 -0700 (PDT)
From: Michael Winslow <mwinslow@infoblox.com>
Date: Mon, 1 May 2017 20:54:31 +0000
Message-ID: <CY4PR07MB35447D2FDE41B7140AEE27F0B8140@CY4PR07MB3544.namprd07.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] vpc max table entries rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I recently had a problem in uploading a dynamic vpc image created by qemu-i=
mg to Azure.  When creating a dynamic vpc image with qemu-img, the bat size=
 is created by rounding up PhysicalSize/BlockSize.  It needs to be rounded =
up this way to contain the end blocks of the disk.

Uploading the image to Azure, the dynamic image gets converted to a fixed t=
ype image (Azure VMs only work with fixed type vpc images).  In doing so, B=
lockSize * MaxTableEntries space is allocated.  That is, the footer is plac=
ed after that much space within the fixed image file.  This is done without=
 changing the current size or original size fields in the image footer.  Wh=
en Azure then goes to instantiate a VM based on this disk image, it finds t=
hat the space allocated does not match the disk size specified in the image=
 footer, and rejects the image on that basis.  The error I'm seeing looks l=
ike this:

VHD footer 'Current Size' field validation failed. VHD for disk 'cli272bc21=
0215b6e94-os-1492546232759' with blob https://foo.blob.core.windows.net/dis=
ks/blah.vhd specifies size (272734617600) which does not match VHD blob siz=
e (272736715264) - VHD Footer Size (512).

This seems to me to be a problem in the upload utility.  However qemu-img c=
ould make dynamic vpc images that are still usable with Azure upload utilit=
ies if the user chooses the right disk size and it made the rounding calcul=
ation slightly differently.  The calculation is currently done in block/vpc=
.c create_dynamic_disk() by doing this:

    num_bat_entries =3D (total_sectors + block_size / 512) / (block_size / =
512);

This rounds up.  But if total_sectors happens to be a whole-number multiple=
 of block_size it allocates one more bat entry than is necessary.  By chang=
ing this calculation to:

    num_bat_entries =3D (total_sectors - 1 + block_size / 512) / (block_siz=
e / 512);

enough bat entries continue to be allocated in the case where total_sectors=
 is a whole-number multiple of block-size and preserves the rounding up whe=
re it is not.  And the upload utility now will not change the disk size if =
the user chooses a disk size that is a multiple of the block size.
