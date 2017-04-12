Received: from eggs.gnu.org ([2001:4830:134:3::10]:41199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-00082S-QG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uw-0006QE-HK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:20 -0400
Message-Id: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 00/10] TCG optimizations for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Hi all,

This series is aimed at 2.10 or beyond. Its goal is to improve
TCG performance by optimizing:

1- Cross-page direct jumps (softmmu only, obviously). Patches 1-4.
2- Indirect branches (softmmu and user-mode). Patches 5-9.
3- tb_jmp_cache hashing in user-mode. Patch 10.

I decided to work on this after reading this paper [1] (code at [2]),
which among other optimizations it proposes solutions for 1 and 2.
I followed the same overall scheme they follow, that is to use helpers
to check whether the target vaddr is valid, and if so, jump to its
corresponding translated code (host address) without having to go back
to the exec loop. My implementation differs from that in the paper
in that it uses tb_jmp_cache instead of adding more caches,
which is simpler and probably more resilient in environments
where TLB invalidations are frequent (in the paper they acknowledge
that they limited background processes to a minimum, which isn't
realistic).

These changes require modifications on the targets and, for optimization
number 2, a new TCG opcode to jump to a host address contained in a register.

For now I only implemented this for the i386 and arm targets, and
the i386 TCG backend. Other targets/backends can easily opt-in.

The 3rd optimization is implemented in the last patch: it improves
tb_jmp_cache hashing for user-mode by removing the requirement of
being able to clear parts of the cache given a page number, since this
requirement only applies to softmmu.

The series applies cleanly on top of 95b31d709ba34.

The commit logs include many measurements, performed using SPECint06 and
NBench from dbt-bench[3].

Feedback welcome! Thanks,

		Emilio

[1] "Optimizing Control Transfer and Memory Virtualization
in Full System Emulators", Ding-Yong Hong, Chun-Chen Hsu, Cheng-Yi Chou,
Wei-Chung Hsu, Pangfeng Liu, Jan-Jan Wu. ACM TACO, Jan. 2016.
  http://www.iis.sinica.edu.tw/page/library/TechReport/tr2015/tr15002.pdf

[2] https://github.com/tkhsu/quick-android-emulator/tree/quick-qemu

[3] https://github.com/cota/dbt-bench
