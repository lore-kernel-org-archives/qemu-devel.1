Received: from eggs.gnu.org ([2001:4830:134:3::10]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSN8-0000Ab-8p
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSN4-0004CV-A3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQSN4-0004CD-5C
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:38 -0400
Date: Wed, 6 Jun 2018 14:56:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180606065629.GC7815@xz-mi>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-4-peterx@redhat.com>
	<CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
	<20180605142655.GI9216@xz-mi>
	<CAFEAcA_AT7a2KiXGKpvaJFwpkkn8x2uNuOgjPXAm=rgjFLCMWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_AT7a2KiXGKpvaJFwpkkn8x2uNuOgjPXAm=rgjFLCMWg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 3/3] memory: introduce
 IOMMU_NOTIFIER_USER_[UN]SET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On Tue, Jun 05, 2018 at 03:42:11PM +0100, Peter Maydell wrote:
> On 5 June 2018 at 15:26, Peter Xu <peterx@redhat.com> wrote:
> > So we have a requirement that we want to send an invalidation for
> > either (1) unspecified, or (2) secure=1.  We can't do that with a
> > single MemTxAttrs.
> >
> > Could we just notify twice?  One with unspecified=1 and one with
> > secure=1?  Is this (reduce the calls to notify functions) the major
> > reason we introduce this IOMMU index idea into the memory API (besides
> > "avoid possible programming error" you mentioned in IRC discussion)?
> 
> How would you handle "this changes mappings for txattrs where
> unspecified == 0 && secure == 0" ?

Let's forget this patch.  I was confused about the problem behind when
I wrote this up...  Now I know a bit more.  It's related to how we can
send a notification covers multiple contexts. Let's assume we still
only support MAP and UNMAP in the notifiers. But let's assume
IOMMUTLBEntry has MemTxAttrs field.

If so, for "this changes mappings for txattrs where unspecified == 0
&& secure == 0", we just send one notify with attrs.unspecified=0 and
attrs.secure=0.  Meanwhile in the notifier hook you can parse the
attrs to see whether that's what you need, and skip if not.

Will that work?

> 
> How does the notifier registering API say what it's interested in?
> In the exec.c code that deals with sending TCG transactions
> through IOMMUs, if I have to register a notifier for every
> possible TCG transaction attribute I ever see, that's a lot
> of unnecessary notifiers.

Again, let's assume this patch does not exist.  Then only one notifier
is needed to be registered with UNMAP notify, and in the hook function
it can detect whether it has (attrs.unspecified==0 &&
attrs.unsecure==0).

> 
> > Again, I think the more critical question would be whether we can pass
> > in MemTxAttrs into translate(), and whether we can avoid introducing
> > this IOMMU index idea into the memory API layer... For example, would
> > it add complexity to other architectures without much benefit?
> 
> I think the fundamental difference in our points of view here
> is that I see the IOMMU index as *reducing* complexity, not
> adding it. Yes, it is an extra level of indirection, but I
> think it helps us express a useful concept.

Yes.  And again, I'm also worrying about what we should do when we
want to pass requester ID into translate() too if we have this extra
layer.

> The patches you've
> sent here seem to me to be adding extra complexity to the
> notifier API and the core code which isn't required in
> the patch set that I sent.

Again I didn't really understand the problem behind before.  Now I
don't think it's important on whether we'll need to introduce new
notifier flags, I wanted to know whether we can avoid introducing
IOMMU index into memory API. Let's just ignore this patch.  Sorry for
that confusion.

Regards,

-- 
Peter Xu
