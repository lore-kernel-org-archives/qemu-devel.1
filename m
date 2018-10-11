Received: from eggs.gnu.org ([2001:4830:134:3::10]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAa39-00064I-H8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAa38-00075i-FS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:26:43 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gAa38-00074w-7l
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:26:42 -0400
Received: by mail-lj1-x244.google.com with SMTP id j17-v6so8049502lja.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:26:42 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 11 Oct 2018 18:23:16 +0600
Message-Id: <4088cc0a4affe3d68a3280013370fc9027fa6ccc.1539259394.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
References: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
References: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 1/4] vl: improve/fix documentation related to
 RTC function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Documentation describing -rtc option updated to better match current implementation and highlight some important specifics.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 qemu-options.hx | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f139459..4a9c065 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3458,25 +3458,29 @@ HXCOMM Silently ignored for compatibility
 DEF("clock", HAS_ARG, QEMU_OPTION_clock, "", QEMU_ARCH_ALL)
 
 DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
-    "-rtc [base=utc|localtime|date][,clock=host|rt|vm][,driftfix=none|slew]\n" \
+    "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew]\n" \
     "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -rtc [base=utc|localtime|@var{date}][,clock=host|vm][,driftfix=none|slew]
+@item -rtc [base=utc|localtime|@var{datetime}][,clock=host|rt|vm][,driftfix=none|slew]
 @findex -rtc
 Specify @option{base} as @code{utc} or @code{localtime} to let the RTC start at the current
 UTC or local time, respectively. @code{localtime} is required for correct date in
-MS-DOS or Windows. To start at a specific point in time, provide @var{date} in the
+MS-DOS or Windows. To start at a specific point in time, provide @var{datetime} in the
 format @code{2006-06-17T16:01:21} or @code{2006-06-17}. The default base is UTC.
 
 By default the RTC is driven by the host system time. This allows using of the
 RTC as accurate reference clock inside the guest, specifically if the host
 time is smoothly following an accurate external reference clock, e.g. via NTP.
 If you want to isolate the guest time from the host, you can set @option{clock}
-to @code{rt} instead.  To even prevent it from progressing during suspension,
-you can set it to @code{vm}.
+to @code{rt} instead, which provides host monotonic clock if host support it.
+To even prevent it from progressing during suspension, you can set it to
+@code{vm} (virtual clock). Virtual clock is the clock seen by guest,
+In icount mode of emulation its (long term) speed will be different from
+any host clock, when icount configured to non-auto value or virtual cpu sleeping
+is off, and no synchronization algorithm is active.
 
 Enable @option{driftfix} (i386 targets only) if you experience time drift problems,
 specifically with Windows' ACPI HAL. This option will try to figure out how
-- 
2.7.4
