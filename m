Received: from eggs.gnu.org ([2001:4830:134:3::10]:43110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXbwx-0004q6-AG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXbws-0000CU-Ca
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:30:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXbwr-0000CE-U9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:30:38 -0400
Date: Tue, 18 Jul 2017 19:30:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718233035.GA10731@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
	<92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
	<20170718002700.GA7414@flamenco>
	<5382470b-120c-1cdd-32f3-d246d75059d2@twiddle.net>
	<20170718045458.GB12960@flamenco>
	<b0eb3da8-14a3-fae2-b4c9-72696fece97b@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0eb3da8-14a3-fae2-b4c9-72696fece97b@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
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

On Mon, Jul 17, 2017 at 19:29:57 -1000, Richard Henderson wrote:
> On 07/17/2017 06:54 PM, Emilio G. Cota wrote:
> >What threw me off was that in lookup_tb_ptr we're not checking tb->invalid,
> >and that biased me into thinking that it's not needed. But I should have
> >tried harder. Also, that's a bug, and yet another reason to have tb_lookup,
> >so that we fix these things at once in one place.
> 
> Yes, me as well.  Quite right we need only one copy of this code.
> 
> >>         (tb->flags & (CF_HASH_MASK | CF_INVALID)) == cf_mask
> >>
> >>So that we continue to check CF_INVALID each time we lookup a TB, but now we
> >>get it for free as a part of the other flags check.
> >
> >With the annoying atomic_read thrown in there :-) but yes, will do.
> 
> Yes of course.  ;-)

Gaah, we'll need to update all readers of tb->cflags, of which we have
plenty (~145, mostly in target code) to avoid C11 undefined behaviour
and make Paolo happy.

Should I do those updates in the same patch where tb->invalid is brought
over to cflags? Alternatives: have a later patch where all readers
are converted to atomic_read, or keep tb->invalid as a separate field (we
could use that 4-byte hole in struct tb_tc..)

		E.
