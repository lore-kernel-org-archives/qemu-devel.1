Received: from eggs.gnu.org ([2001:4830:134:3::10]:51543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwW4t-0003fK-9B
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwW4q-0006xx-2j
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dwW4p-0006xG-S0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:48 -0400
Date: Fri, 22 Sep 2017 16:40:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170922204018.GA23631@flamenco>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
	<CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Pranith Kumar <bobby.prani+qemu@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

Hi Richard,

Are you planning to get this patchset merged in this window? If so, I can
give it a respin on top of the current master.

Anyway, before doing so we should fix the issue around CF_COUNT_MASK that
Pranith reported:

On Wed, Aug 30, 2017 at 10:43:28 -0400, Pranith Kumar wrote:
> On Tue, Aug 29, 2017 at 5:16 PM, Emilio G. Cota <cota@braap.org> wrote:
> > On Sun, Aug 27, 2017 at 18:15:50 -0400, Pranith Kumar wrote:
> >> Hi Emilio,
> >>
> >> On Fri, Jul 21, 2017 at 1:59 AM, Emilio G. Cota <cota@braap.org> wrote:
> >> > This will enable us to decouple code translation from the value
> >> > of parallel_cpus at any given time. It will also help us minimize
> >> > TB flushes when generating code via EXCP_ATOMIC.
> >> >
> >> > Note that the declaration of parallel_cpus is brought to exec-all.h
> >> > to be able to define there the "curr_cflags" inline.
> >> >
> >> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> >>
> >> I was testing a winxp image today and I bisected a infinite loop to
> >> this commit. The loop happens both with and without mttcg, so I think
> >> it has got to do with something else.
> >
> > Can you test the below? It lets me boot ubuntu, otherwise it reliably
> > chokes on a 'rep movsb' *very* early (doesn't even get to grub).
> >
> > This discusson on v2 might be relevant (I added CF_COUNT_MASK as a
> > result of it, but it seems I have to revisit that):
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06456.html
> >
> > Anyway let me know if this fixes it for you. Thanks for testing!
> >
> 
> Yes, this fixes the issue for me.

My quick-fix is just not to check those bits, but as you pointed out during
v3's review the whole thing is a little bit fragile if we don't check them.

Should we just go with the CF_NOCHAIN flag that you proposed? If so, do you
want me to give that approach a go, or you prefer to do it yourself?

Thanks,

		Emilio
