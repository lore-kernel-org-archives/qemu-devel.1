Received: from eggs.gnu.org ([2001:4830:134:3::10]:59394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlo7-000619-1O
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlo2-00038m-3U
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:27:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAlo1-00038a-VE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:27:38 -0400
Date: Mon, 23 Apr 2018 20:27:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180424002736.GC8651@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-12-git-send-email-cota@braap.org>
	<f053c3b2-771e-a3d6-7226-6c046ad8c134@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f053c3b2-771e-a3d6-7226-6c046ad8c134@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 11/17] translate-all: add page_locked
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 13, 2018 at 17:31:20 -1000, Richard Henderson wrote:
> On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> > +#ifdef CONFIG_DEBUG_TCG
> > +
> > +struct page_lock_debug {
> > +    const PageDesc *pd;
> > +    QLIST_ENTRY(page_lock_debug) entry;
> > +};
> > +
> > +static __thread QLIST_HEAD(, page_lock_debug) page_lock_debug_head;
> > +
> > +static struct page_lock_debug *get_page_lock_debug(const PageDesc *pd)
> > +{
> > +    struct page_lock_debug *pld;
> > +
> > +    QLIST_FOREACH(pld, &page_lock_debug_head, entry) {
> > +        if (pld->pd == pd) {
> > +            return pld;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> 
> Why do you need a separate data structure for this?

The alternative would be to:
- reuse page_collection, but in some cases we lock pages without
  page_collection
- Expand PageDesc with a bool, but that state would be global
  and not per-thread, which could hide actual bugs (e.g. we
  could see that the bool is set and not assert, despite
  the bool having been set by another thread).

I figured a per-thread list would be appropriate here,
since it doesn't have the problems of the above solutions,
and is simple--and slow, which is why it's under DEBUG_TCG.

Thanks,

		Emilio 
