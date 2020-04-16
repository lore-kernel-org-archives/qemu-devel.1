Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059BC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13BA21927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZvD1nWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13BA21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5b4-0008SR-3A
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jP5aG-00080n-PS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jP5aC-0004VU-Td
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:33:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jP5aB-0004U9-AQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587047613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRZ6lQ8vyJLmkXXUJyAMVsMFzVJxEfB4teBH9sz2yhk=;
 b=BZvD1nWX6FhQR9tXqjkhQ585Xf3l+zXplj1Q4bcCAl++KFTf28YSU6+CZSm2VSBZqqj8Tn
 r4mROBGjAOzD1+BD2mhVTVEXrIlBMtAitC35ceFF76+1+lmNhCLy/urKc6+FN9vY0I2Q0x
 cGq4WUHWps8U8eWigLgI/+GK6m/o+a0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-eSGtF6mKMCWw9lhVEOeqlw-1; Thu, 16 Apr 2020 10:33:30 -0400
X-MC-Unique: eSGtF6mKMCWw9lhVEOeqlw-1
Received: by mail-wm1-f72.google.com with SMTP id h6so1481257wmi.7
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 07:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ax/bK5HHXko1b7p4MmWJ8O+yr8Utx3gI1PfqPzFg8+8=;
 b=AgSMDtCFBgiDvwEM9jurCw7dIuSWbz2qkrYxNYBp2Trhu4BuhV54qSM3GbrNZRWVAr
 3SD9OsuOo/oHvQWIX75zE6AyAKli8pG1wZCXE1fEM7hRqaVF7hnB7XyEBFPv9QBJlw2b
 nBf8FnBq50SIDQnORqvL9OY6pNW6BaVGuplx2yXEiDHfKyXN0SW5AVRo1bjB6GN6W0UO
 7xEEn41HwQBpA7sC3O+3V6R6JKxlI1/2RjgDCo2yB4x4jzbbzfxn/4jrVO4RK0SmuBjS
 iXPb/KX2yrgeNMPkWrscLQlIKVpJgMCOzIl8jSMk9dW8DNkKd01c0/jYSFkN7GdjVGCx
 rXWw==
X-Gm-Message-State: AGi0PubykBjGNboEFD8r1urlEielYisDAaJXIk3kt6SrJjvFPTfQ0TZ2
 H2sUW5csQ0oLFbRukJ1bxyo6OPq7MCKTvpOCcltGFGL6LbDTWaTAh++G2LTA/ZE8UDbRm3ILJrG
 8y37DnhqRCWJRexs=
X-Received: by 2002:a1c:3986:: with SMTP id g128mr5110627wma.8.1587047609213; 
 Thu, 16 Apr 2020 07:33:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3B7UXYmJTwl/YgJVq4/JgFmVU8b0sorT0kwgy2jAhHnJcmeZaMYjz3UUaDsmiN1IHUR2KQg==
X-Received: by 2002:a1c:3986:: with SMTP id g128mr5110591wma.8.1587047608764; 
 Thu, 16 Apr 2020 07:33:28 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id f187sm4284903wme.9.2020.04.16.07.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 07:33:28 -0700 (PDT)
Date: Thu, 16 Apr 2020 10:33:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Message-ID: <20200416102229-mutt-send-email-mst@kernel.org>
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, "Wang,
 Wei W" <wei.w.wang@intel.com>, David Hildenbrand <dhildenb@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 10:18:49AM +0200, David Hildenbrand wrote:
> >>
> >> Postcopy is a very good point, bought!
> >>
> >> But (what you wrote above) it sounds like that this is really what we =
*have to* do, not an optimization. I=E2=80=98ll double check the spec tomor=
row (hopefully it was documented). We should rephrase the comment then.
> >=20
> > Do you have a link to the spec that I could look at? I am not hopeful
> > that this will be listed there since the poison side of QEMU was never
> > implemented. The flag is only here because it was copied over in the
> > kernel header.
>=20
> Introducing a feature without
>=20
> a) specification what it does
> b) implementation (of both sides) showing what has to be done
> c) any kind of documentation of what needs to be done
>=20
> just horrible.
>=20
> The latest-greatest spec lives in
>=20
> https://github.com/oasis-tcs/virtio-spec.git
>=20
> I can't spot any signs of free page hinting/page poisioning. :(

Right. I merged the hinting support in Linux on the hope that
spec and qemu upstream will surface later. It seemed so
since IIRC there were some drafts (even though I don't
have any links to hand). Unfortunately neither happened.



> We should document our result of page poisoning, free page hinting, and
> free page reporting there as well. I hope you'll have time for the latter=
.
>=20
> -------------------------------------------------------------------------
> Semantics of VIRTIO_BALLOON_F_PAGE_POISON
> -------------------------------------------------------------------------
>=20
> "The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
> guest is using page poisoning. Guest writes to the poison_val config
> field to tell host about the page poisoning value that is in use."
> -> Very little information, no signs about what has to be done.

I think it's an informational field. Knowing that free pages
are full of a specific pattern can be handy for the hypervisor
for a variety of reasons. E.g. compression/deduplication?


> "Let the hypervisor know that we are expecting a specific value to be
> written back in balloon pages."



> -> Okay, that talks about "balloon pages", which would include right now
> -- pages "inflated" and then "deflated" using free page hinting
> -- pages "inflated" and then "deflated" using oridnary inflate/deflate
>    queue

ATM, in this case driver calls "free" and that fills page with the
poison value.

> -- pages "inflated" using free page reporting and automatically
>    "deflated" on access
>=20
> So VIRTIO_BALLOON_F_PAGE_POISON really means "whenever the guest
> deflates a page (either explicitly, or implicitly with free page
> reporting), it is filled with "poison_val".

It might be a valid optimization to allow driver to skip
poisoning of freed pages in this case.

> And I would add
>=20
> "However, if the inflated page was not filled with "poison_val" when
> inflating, it's not predictable if the original page or a page filled
> with "poison_val" is returned."
>=20
> Which would cover the "we did not discard the page in the hypervisor, so
> the original page is still there".
>=20
>=20
> We should also document what is expected to happen if "poison_val" is
> suddenly changed by the guest at one point in time again. (e.g., not
> supported, unexpected things can happen, etc.)

Right. I think we should require that this can only be changed
before features have been negotiated.
That is the only point where hypervisor can still fail
gracefully (i.e. fail FEATURES_OK).


> Also, we might have to
> document that a device reset resets the poison_val to 0. (not sure if
> that's really necessary)

Probably yes, for things like kexec.

> -------------------------------------------------------------------------
> What we have to do in the guest/Linux:
> -------------------------------------------------------------------------
>=20
> A guest which relies on this (esp., free page reporting in Linux only,
> right?), has to not use/advertise VIRTIO_BALLOON_F_REPORTING *in case
> VIRTIO_BALLOON_F_PAGE_POISON is not provided* by the host. AFAIKS,
> ordinary inflation/deflation and free page hinting does currently not
> care, as we go via free_page(), so that is currently fine AFAIKs.
>=20
> -------------------------------------------------------------------------
> What we have to do in the hypervisor/QEMU:
> -------------------------------------------------------------------------
>=20
> With VIRTIO_BALLOON_F_PAGE_POISON, we could provide free page reporting
> easily IFF "page_val"=3D=3D0. However, as you said, it will currently be
> expensive in case of postcopy, as the guest still zeroes out all pages.
> Document that properly.
>=20
> With VIRTIO_BALLOON_F_PAGE_POISON, don't inflate any pages right now
> (not discarding anything), OR fill the pages with poison_val when
> deflating. I guess the latter would be better - even if current Linux
> does not need it, it's what we are expected to do AFAIKS.
>=20
> With VIRTIO_BALLOON_F_PAGE_POISON and page_val !=3D 0, discard all free
> page reporting attempts. (=3D=3D what your patch #3 does). Document that
> properly.
>=20
>=20
> Makes sense? See below for guest migration thingies.
>=20
> >=20
> >> I could imagine that we also have to care about ordinary page inflatio=
n/deflation when handling page poisoning. (Iow, don=E2=80=98t inflate/defla=
te if set for now).
> >=20
> > The problem is this was broken from the start for that. The issue is
> > that the poison feature was wrapped up within the page hinting
> > feature. So as a result enabling it for a VM that doesn't recognize
> > the feature independently would likely leave the poison value
> > uninitialized and flagging as though a value of 0 is used. In addition
> > the original poison checking wasn't making sure that the page wasn't
> > init_on_free which has the same effect as page poisoning but isn't
> > page poisoning.
>=20
> If the guest agrees to have VIRTIO_BALLOON_F_PAGE_POISON but does not
> initialize poison_val, then it's a guest bug, I wouldn't worry about
> that for now.
>=20
> >=20
> >>>
> >>> The worst case scenario would be one in which the VM was suspended fo=
r
> >>> migration while there were still pages in the balloon that needed to
> >>> be drained. In such a case you would have them in an indeterminate
> >>> state since the last page poisoning for them might have been ignored
> >>> since they were marked as "free", so they are just going to be
> >>> whatever value they were if they had been migrated at all.
> >>>
> >>>>>
> >>>>>>
> >>>>>>> +        return;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>>     if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
> >>>>>>>         s->free_page_report_cmd_id =3D
> >>>>>>>                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN=
;
> >>>>>>
> >>>>>> We should rename all "free_page_report" stuff we can to
> >>>>>> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on =
my
> >>>>>> side :) ) before adding free page reporting .
> >>>>>>
> >>>>>> (looking at the virtio-balloon linux header, it's also confusing b=
ut
> >>>>>> we're stuck with that - maybe we should add better comments)
> >>>>>
> >>>>> Are we stuck? Couldn't we just convert it to an anonymous union wit=
h
> >>>>> free_page_hint_cmd_id and then use that where needed?
> >>>>
> >>>> Saw your patch already :)
> >>>>
> >>>>>
> >>>>>>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(Vi=
rtIOBalloon *s)
> >>>>>>>     if (s->qemu_4_0_config_size) {
> >>>>>>>         return sizeof(struct virtio_balloon_config);
> >>>>>>>     }
> >>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISO=
N)) {
> >>>>>>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISO=
N) ||
> >>>>>>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_=
HINT)) {
> >>>>>>>         return sizeof(struct virtio_balloon_config);
> >>>>>>>     }
> >>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_=
HINT)) {
> >>>>>>> -        return offsetof(struct virtio_balloon_config, poison_val=
);
> >>>>>>> -    }
> >>>>>>
> >>>>>> I am not sure this change is completely sane. Why is that necessar=
y at all?
> >>>>>
> >>>>> The poison_val is stored at the end of the structure and is require=
d
> >>>>> in order to make free page hinting to work. What this change is doi=
ng
> >>>>
> >>>> Required to make it work? In the kernel,
> >>>>
> >>>> commit 2e991629bcf55a43681aec1ee096eeb03cf81709
> >>>> Author: Wei Wang <wei.w.wang@intel.com>
> >>>> Date:   Mon Aug 27 09:32:19 2018 +0800
> >>>>
> >>>>    virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> >>>>
> >>>> was merged after
> >>>>
> >>>> commit 86a559787e6f5cf662c081363f64a20cad654195
> >>>> Author: Wei Wang <wei.w.wang@intel.com>
> >>>> Date:   Mon Aug 27 09:32:17 2018 +0800
> >>>>
> >>>>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >>>>
> >>>> So I assume it's perfectly fine to not have it.
> >>>>
> >>>> I'd say it's the responsibility of the guest to *not* use
> >>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
> >>>> without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
> >>>> into the foot.
> >>>
> >>> Based on the timing I am guessing the page poisoning was in the same
> >>> patch set as the free page hinting since there is only 2 seconds
> >>> between when the two are merged. If I recall the page poisoning logic
> >>> was added after the issue was pointed out that it needed to address
> >>> it.
> >>>
> >>
> >> Yeah, but any other OS implementing this, not caring about page poison=
ing wouldn=E2=80=98t need it. Maybe there is something in the spec.
> >>
> >> Mental note: we=E2=80=98ll have to migrate the poison value if not alr=
eady done (writing on my mobile).
> >=20
> > Right. We need to make sure any poison or init on free is migrated
> > over to the destination before we can say we are going to skip the
> > migration. If anything what I probably ought to look into would be if
> > we could change the code so that if we have a hint the page is unused,
> > poison is enabled, and the value is 0 we just ship over a 0 page
> > instead of giving up on hinting entirely.
> >=20
>=20
> Yeah, we have to migrate poison_val from source to destination. Also, we
> should worry about us losing the page poisoning feature when migrating
> from source to destination.
>=20
> Thinking about it, it might make sense to completely decouple page
> poisoning here. Assign it a separate property (as you did), default
> enable it, but disable it via QEMU compat machines.
>=20
> Then, we won't lose the feature when migrating.
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


