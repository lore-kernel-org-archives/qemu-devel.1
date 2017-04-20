Received: from eggs.gnu.org ([2001:4830:134:3::10]:55002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1d18Vh-0000LB-Eo
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1d18Ve-0000Lw-5T
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:36:21 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anonym@riseup.net>) id 1d18Vd-0000LC-UX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:36:18 -0400
References: <20170117190056.1195-1-anonym@riseup.net>
	<20170117190056.1195-2-anonym@riseup.net>
From: anonym <anonym@riseup.net>
Message-ID: <9b6090d8-4aec-351c-a733-12a6f5b5457c@riseup.net>
Date: Thu, 20 Apr 2017 09:35:00 +0000
MIME-Version: 1.0
In-Reply-To: <20170117190056.1195-2-anonym@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] xhci: bump the link TRB cycle detection
 limit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi, list!

I guess you can take this as a ping for this patch submission. We'd very much like this to be dealt with soon, so the fix can land into Debian Stretch before it is released, otherwise some of us will have to work around this issue for the next two years. :/

Hi, Gerd!

You are the author of QEMU commit 05f43d4 which fixed CVE-2016-8576, which I believe introduced the regression described below. Do you think my patch's approach is safe and makes sense?

At the moment this issue is causing trouble for Tails [1] since its installer hits this bug, which affects both users of QEMU + Tails, and our automated QA infrastructure, which uses QEMU.

Cheers!

[1] https://tails.boum.org/

anonym@riseup.net:
> From: anonym <anonym@riseup.net>
> 
> While formatting partitions (on virtual USB drives and the nec-xhci
> virtual USB controller) to EXT4, I have observed errors like these:
> 
>     kernel: sd 8:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_ABORT
>     driverbyte=DRIVER_OK
>     kernel: sd 8:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 00 66 49 86
>     00 08 00 00
>     kernel: blk_update_request: I/O error, dev sda, sector 6703494
>     kernel: Buffer I/O error on dev dm-0, logical block 1573254, lost
>     async page write
> 
> Raising TRB_LINK_LIMIT fixes the limit, but the new value was
> admittedly arbitrarily chosen.
> 
> Regarding cycle detection in general, allowing at most 4 levels of
> links seems pretty low. This bump should be safe: a high number only
> means that we get a performance hit when encountering cycles but then
> we should have a fatal error any way; a low number instead means that
> we'll incorrectly identify cycles and abort operations that otherwise
> would succeed, like in the case above.
> 
> Signed-off-by: anonym <anonym@riseup.net>
> ---
>  hw/usb/hcd-xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 4acf0c6dd8..d14ce126a2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -53,7 +53,7 @@
>   * to the specs when it gets them */
>  #define ER_FULL_HACK
>  
> -#define TRB_LINK_LIMIT  4
> +#define TRB_LINK_LIMIT  32
>  
>  #define LEN_CAP         0x40
>  #define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
> 
