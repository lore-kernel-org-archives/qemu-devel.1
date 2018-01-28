Received: from eggs.gnu.org ([2001:4830:134:3::10]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eftm2-0004yZ-9h
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 15:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eftlz-00059e-3R
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 15:41:58 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eftly-000580-Ro
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 15:41:55 -0500
Date: Sun, 28 Jan 2018 15:41:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180128204151.GA3787@flamenco>
References: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
	<87a7x26qlv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7x26qlv.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Thu, Jan 25, 2018 at 12:59:56 +0000, Alex Bennée wrote:
> Howard Spoelstra <hsp.cat7@gmail.com> writes:
(snip)
> > Recent tcg optimisations had improved processor and floating point
> > performance considerably, but that gain seems to be more than lost for
> > the floating point performance.
> >
> > Any idea what is causing this?
> 
> Well we expected a little degradation but it's a bit more than I
> expected.

It's pretty bad (almost a 2X mean slowdown) for the three FP workloads
in dbt-bench:

[FWIW before is 52483b067cce, after is 00fc0c00ca9fa26]

                        NBench score; higher is better                         
                Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz                 
                                                                               
  6 +-+-----------+-------------+--------------+-------------+-----------+-+   
    |                       *****                                          |   
    |                       *   *                 softfloat-before         |   
  5 +-+.....................*...*.........******...softfloat-after.......+-+   
    |                       *   *         *    *        ******             |   
    |                       *   *         *    *        *    *             |   
  4 +-+.....................*...*.........*....*........*....*...........+-+   
    |                       *   *         *    *        *    *             |   
  3 +-+......******.........*...*.........*....*........*....*...........+-+   
    |        *    *         *   *#####    *    *####    *    *             |   
    |        *    *         *   *    #    *    *   #    *    *#####        |   
  2 +-+......*....*.........*...*....#....*....*...#....*....*....#......+-+   
    |        *    *         *   *    #    *    *   #    *    *    #        |   
    |        *    *#####    *   *    #    *    *   #    *    *    #        |   
  1 +-+......*....*....#....*...*....#....*....*...#....*....*....#......+-+   
    |        *    *    #    *   *    #    *    *   #    *    *    #        |   
    |        *    *    #    *   *    #    *    *   #    *    *    #        |   
  0 +-+------******#####----*****#####----******####----******#####------+-+   
               FOURIER     NEURAL NET  LU DECOMPOSITION    gmean               


You can obtain the above on your machine (assuming /tmp/softfloat-$branch
corresponds to the before/after x86_64-linux-user binaries) with:

$ time for branch in before after; do cd $DBT_BENCH/nbench && \
	taskset -c 0 /tmp/softfloat-$branch \
	$DBT_BENCH/nbench/nbench -V -C$DBT_BENCH/nbench/FP.DAT \
	| tee $DBT_BENCH/softfloat-$branch.nbench || break && cd -; \
	done

And then plot the results with:
$ ./breakdown.pl --suite=fp --barchart softfloat-before.nbench softfloat-after.nbench \
	| $BARCHART/barchart.pl --extra-gnuplot='set term dumb 80' \
	--extra-gnuplot='set title "NBench score; higher is better\nHost: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz"' \
	--extra-gnuplot="set yrange [0:]" --extra="=norotate" | gnuplot

You'll need both dbt-bench and barchart:
  https://github.com/cota/dbt-bench (clone with --recursive and build nbench first.
    You can also use CROSS_COMPILE there to benchmark other linux-user targets)
  https://github.com/cota/barchart

Hope that helps,

		Emilio
