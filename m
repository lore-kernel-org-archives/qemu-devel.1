Received: from eggs.gnu.org ([209.51.188.92]:56226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gw1Ai-0004Rs-Ub
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gw1Ag-0001eM-Ve
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:54:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gw1Ag-0001dQ-ON
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:54:34 -0500
References: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
	<20190219084916.yinhlryf4sgx7t5p@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <547c2b61-3f31-e958-ca7c-a5215dc8b017@redhat.com>
Date: Tue, 19 Feb 2019 09:54:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190219084916.yinhlryf4sgx7t5p@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ray Ni <ray.ni@intel.com>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Markus Armbruster <armbru@redhat.com>

On 02/19/19 09:49, Gerd Hoffmann wrote:
>   Hi,
> 
>> (2) If I change the cmdline to "lun=5", then the exchange is:
> 
> Not supported (by the usb protocol).
> 
> The protocol has a control message to query the number of devices (grep
> for GetMaxLun in qemu).  LUNs are not allowed to be sparse.  So, with a
> single storage device the LUN must be zero.  With two devices the LUNs
> must be 0,1, with three 0,1,2 etc., you get the idea :)

Yes, Phil explained the same -- I originally missed this part of the
documentation (because the requirement is documented, so the fault is
clearly mine).

However, once I fixed the configuration (so that I'd have LUNs 0 and 1),
edk2 still tripped an assert. Please see my message elsewhere in this
thread; the fixed config case is marked as item (4).

Thanks!
Laszlo

> Maybe usb-bot should check for that and throw an error, I think right
> now we only have the generic scsi code check which will verify the lun
> isn't too big (<= 15) but will not check the non-sparse requirement.
> 
> cheers,
>   Gerd
> 
