Received: from eggs.gnu.org ([209.51.188.92]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwiq-0003lg-RB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwip-0007UF-VI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDwip-0007Tb-Nr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id m10so16757160otp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190409151830.6024-1-peter.maydell@linaro.org>
	<87ef6byye5.fsf@trasno.org>
In-Reply-To: <87ef6byye5.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 02:47:45 +0700
Message-ID: <CAFEAcA87-z9Su8qYOJoG9nVXnAYShwKBrDEpP+55WK5SVrnq=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix
 use-after-free in multifd_recv_unfill_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 9 Apr 2019 at 22:42, Juan Quintela <quintela@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Coverity points out (CID 1400442) that in this code:
> >
> >     if (packet->pages_alloc > p->pages->allocated) {
> >         multifd_pages_clear(p->pages);
> >         multifd_pages_init(packet->pages_alloc);
> >     }
> >
> > we free p->pages in multifd_pages_clear() but continue to
> > use it in the following code. We also leak memory, because
> > multifd_pages_init() returns the pointer to a new MultiFDPages_t
> > struct but we are ignoring its return value.
> >
> > Fix both of these bugs by adding the missing assignment of
> > the newly created struct to p->pages.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> ouch,
>
> good catch.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks for the quick review. Applied to master for rc3.

-- PMM
