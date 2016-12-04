Received: from eggs.gnu.org ([2001:4830:134:3::10]:49633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <3v0n1d3@gmail.com>) id 1cDfdk-0002By-Uu
	for qemu-devel@nongnu.org; Sun, 04 Dec 2016 17:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <3v0n1d3@gmail.com>) id 1cDfdj-00042r-U3
	for qemu-devel@nongnu.org; Sun, 04 Dec 2016 17:52:13 -0500
Received: from mail-yb0-x233.google.com ([2607:f8b0:4002:c09::233]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <3v0n1d3@gmail.com>) id 1cDfdj-00042i-Ol
	for qemu-devel@nongnu.org; Sun, 04 Dec 2016 17:52:11 -0500
Received: by mail-yb0-x233.google.com with SMTP id v78so53332353ybe.3
	for <qemu-devel@nongnu.org>; Sun, 04 Dec 2016 14:52:11 -0800 (PST)
MIME-Version: 1.0
From: Ruslan Habalov <3v0n1d3@gmail.com>
Date: Sun, 4 Dec 2016 23:52:10 +0100
Message-ID: <CAP5jUk10i4P0x99n6+yXvDfR=ExN0jxyvF2_Ur_82N1_JTWgxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Slow qemu guest performance after host is resumed from
 suspended state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi everyone,

I'm having the following qemu issue since about February on Xubuntu.

Steps to reproduce:
1) Boot host and boot qemu guest - everything works perfect
2) Shutdown qemu guest
3) Suspend host and resume host
4) Boot qemu guest again - the guest is now extremely slow

Current system setup:
host: kernel 4.8.0-27-generic (also reproducible with older kernel versions)
qemu guest: Linux or Windows affected (tested both)

I've tried to debug the issue on my own with the following results:
------------------------------------------------------------------------------------------------------------------------------
https://www.evonide.com/images/qemu_problem.png
- This shows "perf top $QEMU_PID" from guest boot to shutdown for three
different scenarios:
  Left: normal guest behavior after fresh boot of host system
  Middle: very slow guest after host was suspended and resumed
  Right: test run with disabled HPET (since I initially assumed some
problems with HPET)

https://www.evonide.com/images/qemu_hpet_investigation.png
- Results of "perf record -g" and "perf report"
  According to stefanha (qemu IRC) this doesn't seem to indicate any error
sources.

https://www.evonide.com/images/qemu_vm_exit_healthy_vs_unhealthy.png
- Results of running: "perf record -a -e kvm:kvm_exit" and "perf
report" from guest boot to shutdown
  - Left: normal situation (after fresh host boot)
  - Right: bad situation    (after suspend and resume on host and boot of
qemu guest)
  There were ~300 out of order events reported by perf for the "bad"
scenario (vs. only 2 for the "good" scenario).
------------------------------------------------------------------------------------------------------------------------------
I was also recommended to check the host timers (e.g. /proc/timer_list).
However, this file has more than 800 lines and I am unsure what to look for.

Please let me know if you need further information on this issue.

Best regards,
Ruslan Habalov (Evonide)
