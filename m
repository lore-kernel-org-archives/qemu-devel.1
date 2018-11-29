Received: from eggs.gnu.org ([2001:4830:134:3::10]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSTps-0006pv-H7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSTpr-0000Db-MZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:27:00 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSTpr-0000Bt-Fi
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:26:59 -0500
Received: by mail-pg1-x542.google.com with SMTP id v28so1493822pgk.10
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 13:26:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Nov 2018 13:26:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181129212652.GA15917@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
	<31f86e38-b4fe-f55d-73d9-d74a6f6eb80c@ilande.co.uk>
	<20181129190035.GA6064@roeck-us.net>
	<d0daadc8-e862-b8a0-26ac-634a326c0935@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0daadc8-e862-b8a0-26ac-634a326c0935@ilande.co.uk>
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

On Thu, Nov 29, 2018 at 07:33:15PM +0000, Mark Cave-Ayland wrote:
> On 29/11/2018 19:00, Guenter Roeck wrote:
> 
> >> Thanks for the patch. I just gave it a quick test, and unfortunately my NextSTEP ISO
> >> still hangs in the same place on boot :(
> >>
> > Too bad. Is it "same place" as with the first version of the patch, or
> > "same place" as in upstream qemu ? That might be important, as the two patch
> > versions behave differently (one caches RSTAT/RINTR/RSEQ, one defers command
> > complete handling).
> 
> I'd say same place as in upstream QEMU, although again the exact location does vary
> so I have to keep running it several times to get a feel for whether or not it is in
> improvement.
> 
> >> Not sure if it helps, but attached is a simple trace backend log from "-trace 'esp*'"
> >> from startup all the way to the point where the kernel hangs on boot whilst
> >> enumerating the SCSI bus (it does seem to hang at random points in the bus
> >> enumeration process).
> >>
> > This is interesting; yours seems to be a different problem. I don't see any
> > command_complete_deferred traces in your log. I also don't see any suspicious
> > activity between esp_raise_irq and esp_lower_irq.
> > 
> > Can you try tracing in singlethreaded mode ? Maybe that can help us finding
> > the difference.
> 
> Attached are the "-trace 'esp*' -trace 'scsi*'" outputs for a bad (normal) boot and
> good (single threaded) boot for comparison.
> 

This is really weird. The "bad" log just stops. Up to that point, the "good"
log is virtually identical (liteally up to line 83602 in both logs). Is it
possible that there is some qemu-internal race condition that has nothing
to do with esp itself, one that causes qemu to lock up ?

Thanks,
Guenter
