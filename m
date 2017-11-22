Received: from eggs.gnu.org ([2001:4830:134:3::10]:43548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHSlC-0007FY-HG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHSl8-0003e0-S2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:00:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eHSl8-0003dg-ME
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:00:02 -0500
Date: Wed, 22 Nov 2017 10:59:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171122105957.GC2443@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] postcopy test under load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

Hi Peter,
  I was trying to reproduce the occasional travis postcopy
test case failures you were seeing; I can reproduce them but
only with tcg - which makes me wonder if the problem is in
the test or actually in tcg.

My test is:

export QTEST_QEMU_BINARY=wherever/try/x86_64-softmmu/qemu-system-x86_64
cd whereever/try
for NUM in $(seq 1 100)
do
  echo 'while true; do ./tests/migration-test || break; done' | taskset 2 bash &
done


so all of the instances are pinned to one core using taskset.

I had 100 instances of kvm running overnight (x86-64) and didn't
hit any problems.
30 instances of tcg hit the problem in 5 minutes (x86-64 on x86-64).

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
