Received: from eggs.gnu.org ([2001:4830:134:3::10]:41029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mattator@gmail.com>) id 1e539t-0002Up-9J
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mattator@gmail.com>) id 1e539r-0005O2-Qv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:14:17 -0400
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:46192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mattator@gmail.com>) id 1e539r-0005Mn-M4
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:14:15 -0400
Received: by mail-yw0-x236.google.com with SMTP id t71so2515995ywc.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 22:14:14 -0700 (PDT)
MIME-Version: 1.0
From: Matt <mattator@gmail.com>
Date: Thu, 19 Oct 2017 14:14:12 +0900
Message-ID: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Running Qemu in discrete time/step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hajime Tazaki <tazaki@wide.ad.jp>

Hi,

[Qemu is evoked starting in paragraph 3]
I am interested in increasing the ease of
debugging/reproducibility/validity of network simulations.
Discrete time simulations is the solution that appeals the most to me
because then the final results of the simulation don't depend on the
CPU anymore; another slower computer should reach the same results as
your fast computer. The "perfect" reproducibility aspect makes
debuging a lot easier in my experience too (Especially true for kernel
stacks); indeed rerunning a simulation will exert the same code paths.

I've been using with some success [DCE] (Direct Code Execution) which
allows to run real applications (iperf/vlc) over the linux kernel
compiled as a library (aka "libOS" see
https://lwn.net/Articles/637658/).
The network between the kernels is simulated by [ns-3] (the discrete
time Network Simulator 3). Overall using DCE allows me to reach every
previously mentioned point; every scenario is perfectly reproducible
which proved invaluable when I worked on linux kernel aspects. I
believe its results are also quite credible in some scenarii
(https://hal.inria.fr/hal-00880870/file/con013-hal.pdf).

DCE looks pretty good except it's really a nightmare to maintain. It
partially reimplements glibc so that real applications can run on top
of ns3 (through a hackish gcc extension that breaks clang and gcc old
linker) and the interface to replace the ns3 TCP model with the linux
stack is also hard to maintain.
Thus I've been looking at running Qemu in discrete time and interface
it  with ns3 (since both are FOSS I am familiar with).

- VMSimint does nearly that, it runs Qemu in discrete time but
interface it with a JAVA simulator
http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools_2014_40209.pdf
(with the code http://www.ikr.uni-stuttgart.de/Content/IKRSimLib/Download/)
- http://web.ornl.gov/~nutarojj/adevs/ does sthg similar too

My questions would be:
1/ do you know of any other related work ?
2/ I believe there is interest from the research side but would it be
possible to merge either approach or a similar one (adevs patch
doesn't seem too big ~500 lines), would that be of interest for the
Qemu comminity too ?
3/ if yes to 2. How to proceed, which one would be favorite ? if no,
what should be improved ? or would that be a definitive no ?

Best regards

Matt

[ns3] https://www.nsnam.org/ns-3-27/
[DCE] https://www.nsnam.org/overview/projects/direct-code-execution/
more details in https://hal.inria.fr/hal-00880870/file/con013-hal.pdf
