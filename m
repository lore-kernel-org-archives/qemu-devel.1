Received: from eggs.gnu.org ([208.118.235.92]:42437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gdBvF-0006F1-W5
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gdBez-0007tc-Rk
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:16:04 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:44522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ptsneves@gmail.com>) id 1gdBew-0007nA-19
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:15:59 -0500
Received: by mail-lf1-x129.google.com with SMTP id z13so15883961lfe.11
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 02:15:57 -0800 (PST)
Received: from localhost.localdomain (user-5-173-160-150.play-internet.pl.
	[5.173.160.150]) by smtp.gmail.com with ESMTPSA id
	c203sm8364209lfe.95.2018.12.29.02.15.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 29 Dec 2018 02:15:55 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
Date: Sat, 29 Dec 2018 11:15:50 +0100
Message-Id: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
Subject: [Qemu-devel] [PATCH] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all.
I am trying to get qemu to spawn a pty terminal in a location
which I control without needing to retrieve information of the PTY device
a-posteriori from qemu. To this end i inspired myself in the functionality
of socat, which allows PTY terminals to be spawned in a location
specified by a command line argument. The way socat does is a
bit cheating: It requests the PTY terminal the same way that qemu
does, through openpty, and creates a symlink between the path
specified by the user and the kernel given virtual terminal device.

In the following patch i was able to implement this functionality
successfully and it works as intended. The problem is that for some
reason when I send Ctrl-a-x through the pty the finalize method of
the pty char dev does not get called, thus not removing the symlink.
The finalize only is called when there is an error in the creation of
the symlink like for example when the symlink already exists.

This leads to a dangling symlink when qemu closes and the PTY is released.
Is there a better way to guarantee that my unlink of the symlink is
called when qemu closes? Am i not familiar with qemu code development
so if i am doing something terrible please let me know.
