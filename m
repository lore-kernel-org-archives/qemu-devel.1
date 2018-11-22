Received: from eggs.gnu.org ([2001:4830:134:3::10]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPrHE-0002Sk-1k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPrHA-00084f-QF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:52:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPrHA-0007zc-KI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:52:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5114B30832C2
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 15:52:18 +0000 (UTC)
Date: Thu, 22 Nov 2018 15:52:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181122155212.GA2863@work-vm>
References: <20181122133207.29928-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122133207.29928-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] audio/hda: fix guest triggerable assert
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

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Guest writes to a readonly register trigger the assert in
> intel_hda_reg_write().  Add a check and just ignore them.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1628433
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Does make you wonder:
  a) Why the guest was writing to a read-only register
  b) Wth it only did it in the weird combination of
     devices tested.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/audio/intel-hda.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 23a2cf6484..066532713c 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -929,6 +929,10 @@ static void intel_hda_reg_write(IntelHDAState *d, const IntelHDAReg *reg, uint32
>      if (!reg) {
>          return;
>      }
> +    if (!reg->wmask) {
> +        /* read-only register */
> +        return;
> +    }
>  
>      if (d->debug) {
>          time_t now = time(NULL);
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
