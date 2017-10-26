Received: from eggs.gnu.org ([2001:4830:134:3::10]:51400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7XH3-0007o1-NB
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7XGz-0006EB-0W
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:47:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e7XGy-0006Do-QX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:47:52 -0400
Date: Wed, 25 Oct 2017 21:47:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171026014750.GA5446@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171018224518.GA28532@flamenco>
	<5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
	<20171019201149.GA15218@flamenco>
	<64241d68-b526-3dc1-a264-fa9e6d634527@redhat.com>
	<20171021023410.GA27478@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171021023410.GA27478@flamenco>
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

I have given a respin to the tb_lock branch on top of master.
Turns out the freezes I was getting were due to the magic we used
to rely on (e.g. for icount). Works now!

The branch is here:
  https://github.com/cota/qemu/tree/tb-lock

Boot-tested on ppc64, aarch64 and alpha smp guests (<=64) with MTTCG.

A couple of questions:

- Does anyone remember what work remains to be done to safely enable
  MTTCG for i386? I just forced it on: without the tb lock removal
  I booted an 8-core guest, but without tb_lock the guest kernel
  dies pretty quickly. So I guess there's still work to do.

- In user-mode without tb_lock, should I worry about fork happening
  while any of the newly-introduced locks are held? For instance,
  tb->jmp_lock (introduced in "translate-all: protect TB jumps with
  a per-destination-TB lock"), or tcg_region_tree's lock.

Thanks,

		Emilio
