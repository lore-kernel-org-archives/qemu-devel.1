Received: from eggs.gnu.org ([2001:4830:134:3::10]:45175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enIBu-0002D8-Qp
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 01:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enIBq-0003Ss-Qf
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 01:11:14 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1enIBq-0003S8-JO
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 01:11:10 -0500
Date: Sun, 18 Feb 2018 01:11:09 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180218061109.GA25007@flamenco>
References: <1518917557-12063-1-git-send-email-cota@braap.org>
	<1518917557-12063-2-git-send-email-cota@braap.org>
	<20180218031046.GA2836@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218031046.GA2836@lianli.shorne-pla.net>
Subject: Re: [Qemu-devel] [PATCH 1/2] target/openrisc: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Sun, Feb 18, 2018 at 12:10:46 +0900, Stafford Horne wrote:
> On Sat, Feb 17, 2018 at 08:32:36PM -0500, Emilio G. Cota wrote:
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> This looks ok to me, and thanks for testing.  However, I am not so familiar with
> the DisasContextBase.  Is this something new?

The work on having a generic translation loop started a while ago,
picking up steam in June'17 -- look for "Generic translation framework"
threads on the mailing list.

The goal is to have a single loop (accel/tcg/translator.c) to
translate from target code to TCG IR. Apart from reducing code
duplication, this will eventually ease things like inserting
instrumentation, which will have a single injection point
instead of having to patch all targets' translation loops.

Transitioning to the generic translation loop typically
involves three steps:
1- Use of DisasJumpType to mark the exits from the translation loop
2- Use of DisasContextBase to keep track of some state that applies
   to all targets (e.g. num_insns, program counter)
3- Conversion to TranslatorOps, which is a set of function pointers
   called from translator_loop in accel/tcg/translator.c.

You can see an example of 1-3 for Alpha in commits 3de811c, c5f8065
and 99a92b9, respectively.

Quite a few targets have already been converted (you can see which
ones with "git grep '^\s*translator_loop('"); I'm in the
process of converting the remaining ones as long as I can test
them with a boot image (I've been spamming the list with
conversion patches the last few days).

> It would be good to have a commit message to say what it is any why we are
> making the change?

I considered it, but didn't want to annoy everyone by sending the
same explanation many times (once for each converted target).
The purpose and value of this consolidation work
is well-known among people who follow TCG-related threads on
the mailing list (as I said above this work has been ongoing
for a while), so I think it's reasonable to keep the commit
message empty.

I figured some people would have to be filled in though (like
yourself), and that's why I just wrote the above; now
I can point to this message if this happens again :-)

Hope the background I gave above helps; please let me know
if anything is unclear.

Thanks,

		Emilio
