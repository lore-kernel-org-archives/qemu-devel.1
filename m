Received: from eggs.gnu.org ([2001:4830:134:3::10]:48811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSRYM-00042p-KE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSRYK-00005V-J0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:00:46 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSRYG-0008Vs-R6
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:00:42 -0500
Received: by mail-pl1-x643.google.com with SMTP id z23so1506588plo.0
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:00:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Nov 2018 11:00:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181129190035.GA6064@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
	<31f86e38-b4fe-f55d-73d9-d74a6f6eb80c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31f86e38-b4fe-f55d-73d9-d74a6f6eb80c@ilande.co.uk>
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

On Thu, Nov 29, 2018 at 06:07:05PM +0000, Mark Cave-Ayland wrote:
> On 29/11/2018 17:38, Guenter Roeck wrote:
> 
> >> This patch is very interesting, as I have a long-running regression trying to boot
> >> NextSTEP 3.3 on qemu-system-sparc which I eventually bisected down to the commit that
> >> turned on iothread by default in QEMU.
> >>
> >> The symptom is that ESP SCSI requests hang/timeout before the kernel is able to get
> >> to the userspace installer: however if you launch QEMU with "taskset –cpu-list 1
> >> qemu-system-sparc ..." then it works and you can complete the installation.
> >>
> >> So certainly this suggests that there is a race condition still present in ESP
> >> somewhere. I've given this patch a spin, and in a few quick tests here I was able to
> >> consistently get further in kernel boot, but it still doesn't completely solve issue
> >> for me :/
> >>
> > 
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
> Hi Guenter,
> 
> Thanks for the patch. I just gave it a quick test, and unfortunately my NextSTEP ISO
> still hangs in the same place on boot :(
> 
Too bad. Is it "same place" as with the first version of the patch, or
"same place" as in upstream qemu ? That might be important, as the two patch
versions behave differently (one caches RSTAT/RINTR/RSEQ, one defers command
complete handling).

> Not sure if it helps, but attached is a simple trace backend log from "-trace 'esp*'"
> from startup all the way to the point where the kernel hangs on boot whilst
> enumerating the SCSI bus (it does seem to hang at random points in the bus
> enumeration process).
> 
This is interesting; yours seems to be a different problem. I don't see any
command_complete_deferred traces in your log. I also don't see any suspicious
activity between esp_raise_irq and esp_lower_irq.

Can you try tracing in singlethreaded mode ? Maybe that can help us finding
the difference.

Thanks,
Guenter
