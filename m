Received: from eggs.gnu.org ([2001:4830:134:3::10]:50312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eozQj-0002v3-Px
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eozQg-0005sc-Jj
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:33:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eozQg-0005oi-8P
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:33:30 -0500
Date: Thu, 22 Feb 2018 17:33:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180222223327.GA25701@flamenco>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519324303-5674-3-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] target/mips: reimplement SC
 instruction emulation and use cmpxchg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Petar Jovanovic <petar.jovanovic@mips.com>, Fam Zheng <famz@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Goran Ferenc <goran.ferenc@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Thu, Feb 22, 2018 at 19:31:39 +0100, Aleksandar Markovic wrote:
> From: Leon Alrae <lean.alrae@imgtec.com>
> 
> Completely rewrite conditional stores handling. Use cmpxchg.
> 
> This eliminates need for separate implementations of SC instruction
> emulation for user and system emulation.
> 
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Tested-by: Emilio G. Cota <cota@braap.org>

Got some stats with qht-bench on mipsel-user -- note that I think
you'd get more meaningful numbers with qht-bench than with
atomic_add-bench, since the latter isn't representative of a useful
workload--rather it's a pathological case unless that doesn't
scale at all unless you increase the range quite a bit.

Also, you might want to add perf numbers to the appropriate commit
log, otherwise they'll be absent from the commit history.

Here are some numbers I just gathered for qht-bench, feel
free to include them in this commit's log:

  mipsel-linux-user tests/qht-bench -d 5 -n 1 -u 20 -g 10000
             Host: AMD Opteron(tm) Processor 6376           
                                                            
  120 +-+-+---------+----------+---------+---------#D-+-+   
      |   +         +          +         +       ## +   |   
      | master ***B***                         ##       |   
  100 +MTTCGv2 ###D###                      ###       +-+   
      |                                   ##            |   
      |                                 ##              |   
   80 +-+                            ###              +-+   
      |                            ##                   |   
      |                        # ##                     |   
   60 +-+                     #D#                     +-+   
      |                    ###                          |   
      |                  ##                             |   
   40 +-+             ###                             +-+   
      |            #D#                                  |   
      |          ##                                     |   
   20 +-+      D#                                     +-+   
      |      ##                                         |   
      |   +##       +          +         +          +   |   
    0 +-+-B****B****B**********B********************B-+-+   
          1         16      Threads      48         64      

  png: https://imgur.com/hTwhw70

Thanks for doing this work!

		Emilio
