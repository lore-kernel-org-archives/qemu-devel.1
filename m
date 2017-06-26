Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7k-0007hA-HP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7h-0005Mj-AF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPc7g-0005Lz-Vw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 26 Jun 2017 18:04:34 -0400
Message-Id: <1498514681-3059-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v9 0/7] trace: Optimize per-vCPU TCG tracing
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

v8: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02335.html

Changes from v8:

- Rebased on top of the current tracing tree -- the one that includes
  Lluis' fix (2c321e3c486).
- Added Lluis' R-b tag.
- Added perf numbers in the commit log of the last patch (tl;dr: no overhead).

Thanks,

		Emilio

PS. How to quickly get some linux-user perf numbers:

I used dbt-bench[1] for a before/after comparison. I added a script to that
repo (breakdown.pl, see below) to make it play well with barchart[2].
Obtaining a comparison bar chart is quite simple:

1. Generate one dbt-bench output file per QEMU checkout, e.g.:
  $ git checkout orig && make
  [ orig == "before"; new == "after" ]
  $ ./dbt-bench.pl /path/to/qemu/build/qemu-x86_64 > orig.out
  [ then do the same with orig-disabled, new, etc.]
  [...]
  $ ls *.out
  new-disabled.out  new.out  orig-enabled.out  orig.out

2. Call dbt-bench's breakdown.pl script with the --barchart option, then
  pipe the output to barchart, and finally pipe to gnuplot:
  $ ./breakdown.pl --barchart orig.out orig-enabled.out new.out new-disabled.out \
    | ../barchart/barchart.pl --extra-gnuplot='set term dumb 140 30' \
         --extra-gnuplot='set title "NBench score; higher is better"' \
    | gnuplot

Note that barchart is just a front-end for gnuplot >=5, so any valid term will
work (e.g. 'set term pngcairo size 1200,500').

[1] https://github.com/cota/dbt-bench
[2] https://github.com/cota/barchart
