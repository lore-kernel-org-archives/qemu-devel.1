Received: from eggs.gnu.org ([2001:4830:134:3::10]:58234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG9Z3-0000x8-1e
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG9Z0-0007eY-Px
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:40 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG9Yt-0007bi-PL
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:34 -0400
Received: by mail-oi1-x231.google.com with SMTP id 22-v6so2260717oiz.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 14:22:20 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 22:21:58 +0100
Message-ID: <CAFEAcA-7Vizmx55kNSXDCdozb+-eQ+jNr_6jSr11POatt1oZ1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] template for a script for running an ad-hoc QEMU image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In a conversation this week I mentioned the scripts I use for running
ad-hoc QEMU guest images that I have. The idea here is just that
by making sure that whenever I get a test image I set it up to be
run in the same way, I don't have the problem of trying to remember
how to run the guest if I come back to it after six months.
Here's an example -- I generally just copy-paste-and-edit an older
script when I get a new test image.

============
#!/bin/sh -e
TESTDIR="$(cd "$(dirname "$0")"; pwd)"
QEMU="$@"

${QEMU} -M lm3s6965evb -kernel "${TESTDIR}"/qs_ek-lm3s6965.bin
============

I put each guest image in its own directory, and the script is
always named "runme" and is executable. Then any test can be run with
path/to/test/runme path/to/qemu-system-whatever

There's no magic here but there are a couple of nice nuances here:
 * the rune at the top sets TESTDIR to the directory containing the
   script, regardless of what the current working directory is when
   you run the script; references to kernels, disk files, etc should
   then all use $TESTDIR rather than being absolute or relative paths
 * the use of $@ means you can also do

path/to/test/runme gdb --args path/to/qemu-system-whatever
path/to/test/runme valgrind path/to/qemu-system-whatever

and other similar things.

This doesn't fix any of the problems of using ad-hoc human-run
images for testing, but at least it makes them all be runnable in
the same way, reducing the barrier to randomly running one of them.

thanks
-- PMM
