Received: from eggs.gnu.org ([2001:4830:134:3::10]:47010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDDcD-00011n-Te
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDDcC-0008Pe-UJ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:29:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDDcC-0008PQ-Nu
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:29:00 -0400
Date: Tue, 23 May 2017 19:28:58 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523172858.aqvgqlrwrwu6jk2o@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
	<d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-23 08:54, Richard Henderson wrote:
> On 05/23/2017 03:48 AM, Aurelien Jarno wrote:
> > On 2017-05-22 20:02, Richard Henderson wrote:
> > > Previously, helper_ex would construct the insn and then implement
> > > the insn via direct calls other helpers.  This was sufficient to
> > > boot Linux but that is all.
> > > 
> > > It is easy enough to go the whole nine yards by stashing state for
> > > EXECUTE within the cpu, and then relying on a new TB to be created
> > > that properly and completely interprets the insn.
> > > 
> > > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > > ---
> > >   target/s390x/cpu.h         |   4 +-
> > >   target/s390x/helper.h      |   2 +-
> > >   target/s390x/insn-data.def |   4 +-
> > >   target/s390x/machine.c     |  19 +++++++
> > >   target/s390x/mem_helper.c  | 136 +++++++++++----------------------------------
> > >   target/s390x/translate.c   | 124 +++++++++++++++++++++++++----------------
> > >   6 files changed, 133 insertions(+), 156 deletions(-)
> > 
> > This looks good on the principle, and finally removes a big hack. That
> > said it prevent my test system to boot. I haven't investigated why yet.
> 
> Hmm.  I've not got a complete environment -- merely booting a kernel up to
> the point it fails to find a rootfs.  Which did find several problems with
> my first attempts at this, but wouldn't have exercised paging.  I'll try
> again to get a full install working...
> 
> I wonder if I needed to adjust s390_cpu_handle_mmu_fault (and its myriad
> subroutines) to handle setting ILEN correctly.
> 
> There might be a simpler fix though.  Currently I advance the PC and
> remember the ilen of the EX(RL).  Maybe better to *not* advance the PC so as
> to have the original EX(RL) right there for ILEN_LATER and ILEN_LATER_INC to
> operate on.
> 
> Something like this, as a delta patch.

Unfortunately it doesn't work. So far I have no real idea what could be
the root cause of the issue. I have just determined that up to the crash,
only a very limited set of instructions are being executed. They are the
4 bytes long versions of MVC, CLC, XC, TR.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
