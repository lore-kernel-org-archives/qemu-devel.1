Received: from eggs.gnu.org ([2001:4830:134:3::10]:43349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E5-B3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-0000zb-4r
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4m-0000xM-Qj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:22 -0400
Message-Id: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 0/7] tcg: parallel code generation (Work in
 Progress)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This is a request for comments as well as a request for help :-)

I've been experimenting with making TCGContext per-thread, so that we can
run most of tcg_gen_code in parallel. I've made some progress,
but haven't yet got it to work.

My guess is that the TCG stack is still global instead of per-vCPU
(it's been global since tmp_buf was removed from CPUState, right?),
but I'm having trouble following that code so most likely I'm wrong.

Any help would be appreciated--please disregard minor nits, I want
to see whether I can make this work to then take measurements
to decide whether this is worth the trouble.

- Patch 1 is a trivial doc fixup, feel free to pick it up

- Patches 2-3 remove *tbs[] to use a binary search tree instead.
  This removes the assumption in tb_find_pc that *tbs[] are ordered
  by tc_ptr, thereby allowing us to generate code regardless of
  its location on the host (as we do after patch 6).

- Patch 4 addresses a reporting issue: ever since we embedded the
  struct TB's in code_gen_buffer (6e3b2bfd6), we have been
  misreporting the size of the generated code. Not a huge deal,
  but I noticed while I was working on this.

- Patches 5-7 make TCGContext per-thread in softmmu. I have put there
  some XXX's to note that I'm aware of those issues, so don't worry
  too much about those--except of course if you have any input on
  what the cause of the race(s) might be.

Thanks,

		Emilio
