Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQDAP-0006vV-SA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQDAO-0006zN-TC
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:42:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQDAO-0006yz-NB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:42:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id h79-v6so2274219oig.13
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:42:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605142655.GI9216@xz-mi>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-4-peterx@redhat.com>
	<CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
	<20180605142655.GI9216@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 15:42:11 +0100
Message-ID: <CAFEAcA_AT7a2KiXGKpvaJFwpkkn8x2uNuOgjPXAm=rgjFLCMWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On 5 June 2018 at 15:26, Peter Xu <peterx@redhat.com> wrote:
> So we have a requirement that we want to send an invalidation for
> either (1) unspecified, or (2) secure=1.  We can't do that with a
> single MemTxAttrs.
>
> Could we just notify twice?  One with unspecified=1 and one with
> secure=1?  Is this (reduce the calls to notify functions) the major
> reason we introduce this IOMMU index idea into the memory API (besides
> "avoid possible programming error" you mentioned in IRC discussion)?

How would you handle "this changes mappings for txattrs where
unspecified == 0 && secure == 0" ?

How does the notifier registering API say what it's interested in?
In the exec.c code that deals with sending TCG transactions
through IOMMUs, if I have to register a notifier for every
possible TCG transaction attribute I ever see, that's a lot
of unnecessary notifiers.

> Again, I think the more critical question would be whether we can pass
> in MemTxAttrs into translate(), and whether we can avoid introducing
> this IOMMU index idea into the memory API layer... For example, would
> it add complexity to other architectures without much benefit?

I think the fundamental difference in our points of view here
is that I see the IOMMU index as *reducing* complexity, not
adding it. Yes, it is an extra level of indirection, but I
think it helps us express a useful concept. The patches you've
sent here seem to me to be adding extra complexity to the
notifier API and the core code which isn't required in
the patch set that I sent.

thanks
-- PMM
