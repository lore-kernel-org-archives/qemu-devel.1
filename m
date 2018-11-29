Received: from eggs.gnu.org ([2001:4830:134:3::10]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSRee-0006pc-FD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSRec-0004Wo-LS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:07:16 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSRea-0004Vt-Ma
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:07:14 -0500
Received: by mail-pl1-x642.google.com with SMTP id x21-v6so1496849pln.9
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:07:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Nov 2018 11:07:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181129190709.GB6064@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
	<be4173c3-353b-1bd7-b937-b0d39a7bba26@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4173c3-353b-1bd7-b937-b0d39a7bba26@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Thu, Nov 29, 2018 at 06:34:54PM +0000, Mark Cave-Ayland wrote:
> On 29/11/2018 17:38, Guenter Roeck wrote:
> 
> > Can you try the attached patch ? It is a bit cleaner than the first version,
> > and works for me as well.
> > 
> > Note that this isn't perfect. Specifically, I see differences in handling
> > STAT_TC. The controller specification is a bit ambiguous in that regard,
> > but comparing the qemu code with real controller behavior shows that the
> > real controller does not reset STAT_TC when reading the interrupt status
> > register. That doesn't seem to matter for Linux, but it may influence
> > other guests.
> 
> I've now completed a boot test of all my SPARC32 OpenBIOS CDROM images with this
> patch, and whilst it doesn't solve my NextSTEP issue, I don't see any obvious
> regressions.
> 
> Note that NetBSD SPARC32 tends to spit out the occasional "!TC on data xfer" message
> to the console during periods of disk access, however that is something that has
> always happened and isn't something new introduced by this patch.
> 

That may be because reading the interrupt status resets the TC bit.
As mentioned above, I think it shouldn't do that. Just a wild guess, but
it might be worth a try. Can you remove "s->rregs[ESP_RSTAT] &= ~STAT_TC;"
from the ESP_RINTR case in esp_reg_read() and see what happens ?

[That may expose situations where STAT_TC _should_ be cleared but isn't,
 so we may hit other problems when doing that.]

Thanks,
Guenter
