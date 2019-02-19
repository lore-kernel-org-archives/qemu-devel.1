Received: from eggs.gnu.org ([209.51.188.92]:54793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw15b-0000QF-Gq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw15a-0008Ru-Px
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw15a-0008Rh-Jq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:49:18 -0500
Date: Tue, 19 Feb 2019 09:49:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219084916.yinhlryf4sgx7t5p@sirius.home.kraxel.org>
References: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
Subject: Re: [Qemu-devel] nonzero LUN on USB Bulk Only Transfer fails with
 QEMU+edk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ray Ni <ray.ni@intel.com>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Markus Armbruster <armbru@redhat.com>

  Hi,

> (2) If I change the cmdline to "lun=5", then the exchange is:

Not supported (by the usb protocol).

The protocol has a control message to query the number of devices (grep
for GetMaxLun in qemu).  LUNs are not allowed to be sparse.  So, with a
single storage device the LUN must be zero.  With two devices the LUNs
must be 0,1, with three 0,1,2 etc., you get the idea :)

Maybe usb-bot should check for that and throw an error, I think right
now we only have the generic scsi code check which will verify the lun
isn't too big (<= 15) but will not check the non-sparse requirement.

cheers,
  Gerd
