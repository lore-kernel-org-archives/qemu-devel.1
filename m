Received: from eggs.gnu.org ([2001:4830:134:3::10]:37720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fGtFN-00038X-Tw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fGtFK-0002GK-QI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:37:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fGtFK-0002G7-Ld
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:37:06 -0400
Date: Thu, 10 May 2018 17:37:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180510213705.GB7868@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-13-git-send-email-cota@braap.org>
	<565c5fac-2494-c30a-84c2-3bb1bb9c11b3@linaro.org>
	<20180424003115.GD8651@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424003115.GD8651@flamenco>
Subject: Re: [Qemu-devel] [PATCH v2 12/17] translate-all: add
 page_collection assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mon, Apr 23, 2018 at 20:31:15 -0400, Emilio G. Cota wrote:
> On Fri, Apr 13, 2018 at 17:42:45 -1000, Richard Henderson wrote:
> > On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> > > +static __thread bool page_collection_locked;
> > > +
> > > +void assert_page_collection_locked(bool val)
> > > +{
> > > +    tcg_debug_assert(page_collection_locked == val);
> > > +}
> > > +
> > > +static inline void set_page_collection_locked(bool val)
> > > +{
> > > +    page_collection_locked = val;
> > > +}
> > > +
> > 
> > This seems fairly fragile to me.
> > 
> > (1) Do you ever do assert_page_collection_locked(true)?
> 
> No.
> 
> > You don't appear to do so, and it's somewhat confusing.
> 
> You're right. I think in testing I was using it, but now it
> might make more sense to not take any arguments.
> 
> > (2) Why does do_page_entry_lock set "locked" and not page_collection_lock?
> 
> page_collection_lock calls page_entry_lock and page_trylock_add,
> both of which end up calling do_page_entry_lock.

I've simplified this is in v3 to rely on the per-thread
hash map of locked pages.

		E.
