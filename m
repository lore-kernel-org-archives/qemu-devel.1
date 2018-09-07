Received: from eggs.gnu.org ([2001:4830:134:3::10]:33507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyIxd-0005gj-7o
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyIxZ-000057-RH
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:46:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fyIxQ-0007tt-Jm
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:46:06 -0400
Date: Fri, 7 Sep 2018 11:45:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180907154545.GA1963@flamenco>
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-3-cota@braap.org> <87in3hz7hb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in3hz7hb.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] qht: add qht_iter_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Fri, Sep 07, 2018 at 15:51:12 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This currently has no users, but the use case is so common that I
> > think we must support it.
> >
> > Note that without the appended we cannot safely remove a set of
> > elements; a 2-step approach (i.e. qht_iter first, keep track of
> > the to-be-deleted elements, and then a bunch of qht_remove calls)
> > would be racy, since between the iteration and the removals other
> > threads might insert additional elements.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  include/qemu/qht.h | 19 ++++++++++++
> >  util/qht.c         | 74 +++++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 85 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/qemu/qht.h b/include/qemu/qht.h
> > index 1fb9116fa0..91bc9b00cf 100644
> > --- a/include/qemu/qht.h
> > +++ b/include/qemu/qht.h
> > @@ -44,6 +44,8 @@ struct qht_stats {
> >
> >  typedef bool (*qht_lookup_func_t)(const void *obj, const void *userp);
> >  typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
> > +typedef bool (*qht_iter_bool_func_t)(struct qht *ht, void *p, uint32_t h,
> > +                                     void *up);
> >
> >  #define QHT_MODE_AUTO_RESIZE 0x1 /* auto-resize when heavily loaded */
> >
> > @@ -178,9 +180,26 @@ bool qht_resize(struct qht *ht, size_t n_elems);
> >   *
> >   * Each time it is called, user-provided @func is passed a pointer-hash pair,
> >   * plus @userp.
> > + *
> > + * Note: @ht cannot be accessed from @func
> 
> I'm confused by this comment. If @ht cannot be accessed (or shouldn't be
> accessed) from @func then why are we passing it?

We could probably do without. My original thinking was to pass the *ht
to tell the iter function which ht his k-v pair comes from.
But that's not a common use case, so we should remove it to
simplify the interface.

I think the comment is important right now; note that we can't even
perform a lookup from the callback without deadlock.

So I'll take your R-b for this patch and remove the *ht in
another patch.

Thanks,

		Emilio
