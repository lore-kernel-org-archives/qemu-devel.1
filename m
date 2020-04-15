Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9ECC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D491C20732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXJM4Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D491C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOpPW-0003av-2z
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 17:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOpOd-0002py-OI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOpOb-0004AE-Rh
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:16:35 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jOpOb-0004A4-Kl
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:16:33 -0400
Received: by mail-il1-x141.google.com with SMTP id z13so4813745ilp.11
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IWnKsxxGslXZL0Odtn92YircC50Gqke4qnDr6wIZK5s=;
 b=RAXJM4Jb9STqgeiDjqSvrIWXj8P8rOICNHjk2AjGiycJmd92GOCGsh/Da47U+cV5IS
 mrbljjT8tKTVndn5EAR2h0dUbPVRSAsmzFaQS889MA4sULpknULUK+21n2EyQdiYmkO4
 Y0fGrvGHDCejMD/9y8mMcguqicvDgppsCa21czHY6Ny6ltpX+aox0L1X6j5cYIFa4TVV
 /tyGmM61dEHEteZMvLTZQLX8ebp8YoqcJIRLmYdomJ24jVTwbMzEUDFQu/6JOQw8MC/7
 5/S8prtZFH7qsGKigWDOpEuXLcGvIDSz07Lg8vq3iTXo2RobWTycjdJ8fXbF7mznn5EL
 DSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IWnKsxxGslXZL0Odtn92YircC50Gqke4qnDr6wIZK5s=;
 b=UabbFWu9AIx+j4FvX69lhRuUDQGqPknUG+Rcs56XxjN3T4frFsQJjNhpF+mroC0y2Y
 bZR2iRzvdIceXtwKhCN/kKXpEFVQqmGpq6m/ysLDNXaVCIhbhpVjdJ7j+f3ThARjD2W+
 S4k2fRu/O9bzQOUJ8BcUWLRo2K30huMbxOb6QC/GG4WSAujNZ/wSzz0BgMeLvoHQZm1M
 lqaoZA5xLtVyIlaVYfviiiv4IGZmK4DNTvW/CJbVdSVPmodRSaniaXhlil55EHHs1gVx
 vS6srwSulx7TyStYb49AruVFxchRl8MREi0mKcNwnUgHJcctOpcaQIzYUhNZiPpr+noE
 9cKw==
X-Gm-Message-State: AGi0Pub8wHnHLZ1nAwgVdILE2L/QZqlJFhKKAJH5Jq3azBF7Bq6hbpBu
 NOPl8p34OmqxO9vJ0xGtqPm/1EaajFLXP6B89m4=
X-Google-Smtp-Source: APiQypK5mBoHkkByUJYvw1I5F+MgFpxI4byZtHqNzXIxJCV1XVq4tzpj04doIzLGJywZfrrbhqrKTPDrhzKDcjgFJV8=
X-Received: by 2002:a92:584b:: with SMTP id m72mr7369557ilb.95.1586985392386; 
 Wed, 15 Apr 2020 14:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
In-Reply-To: <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 14:16:21 -0700
Message-ID: <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Wang,
 Wei W" <wei.w.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 12:46 PM David Hildenbrand <dhildenb@redhat.com> wr=
ote:
>
>
>
> > Am 15.04.2020 um 21:29 schrieb Alexander Duyck <alexander.duyck@gmail.c=
om>:
> >
> > =EF=BB=BFOn Wed, Apr 15, 2020 at 11:17 AM David Hildenbrand <david@redh=
at.com> wrote:
> >>
> >>>
> >>> The comment above explains the "why". Basically poisoning a page will
> >>> dirty it. So why hint a page as free when that will drop it back into
> >>> the guest and result in it being dirtied again. What you end up with
> >>> is all the pages that were temporarily placed in the balloon are dirt=
y
> >>> after the hinting report is finished at which point you made things
> >>> worse instead of helping to improve them.
> >>
> >> Let me think this through. What happens on free page hinting is that
> >>
> >> a) we tell the guest that migration starts
> >> b) it allocates pages (alloc_pages()), sends them to us and adds them =
to
> >>   a list
> >> b) we exclude these pages on migration
> >> c) we tell the guest that migration is over
> >> d) the guest frees all allocated pages
> >>
> >> The "issue" with VIRTIO_BALLOON_F_PAGE_POISON is, that in d), the gues=
t
> >> will fill all pages again with a pattern (or zero).
> >
> > They should have already been filled with the poison pattern before we
> > got to d). A bigger worry is that we at some point in the future
> > update the kernel so that d) doesn't trigger re-poisoning, in which
> > case the pages won't be marked as dirty, we will have skipped the
> > migration, and we have no idea what will be in the pages at the end.
> >
> >> AFAIKs, it's either
> >>
> >> 1) Not performing free page hinting, migrating pages filled with a
> >> poison value (or zero).
> >> 2) Performing free page hinting, not migrating pages filled with a
> >> poison value (or zero), letting only the guest fill them again.
> >>
> >> I have the feeling, that 2) is still better for migration, because we
> >> don't migrate useless pages and let the guest reconstruct the content?
> >> (having a poison value of zero might be debatable)
> >>
> >> Can you tell me what I am missing? :)
> >
> > The goal of the free page hinting was to reduce the number of pages
> > that have to be migrated, in the second case you point out is is
> > basically deferring it and will make the post-copy quite more
> > expensive since all of the free memory will be pushed to the post-copy
> > which I would think would be undesirable since it means the VM would
> > have to be down for a greater amount of time with the poisoning
> > enabled.
>
> Postcopy is a very good point, bought!
>
> But (what you wrote above) it sounds like that this is really what we *ha=
ve to* do, not an optimization. I=E2=80=98ll double check the spec tomorrow=
 (hopefully it was documented). We should rephrase the comment then.

Do you have a link to the spec that I could look at? I am not hopeful
that this will be listed there since the poison side of QEMU was never
implemented. The flag is only here because it was copied over in the
kernel header.

> I could imagine that we also have to care about ordinary page inflation/d=
eflation when handling page poisoning. (Iow, don=E2=80=98t inflate/deflate =
if set for now).

The problem is this was broken from the start for that. The issue is
that the poison feature was wrapped up within the page hinting
feature. So as a result enabling it for a VM that doesn't recognize
the feature independently would likely leave the poison value
uninitialized and flagging as though a value of 0 is used. In addition
the original poison checking wasn't making sure that the page wasn't
init_on_free which has the same effect as page poisoning but isn't
page poisoning.

> >
> > The worst case scenario would be one in which the VM was suspended for
> > migration while there were still pages in the balloon that needed to
> > be drained. In such a case you would have them in an indeterminate
> > state since the last page poisoning for them might have been ignored
> > since they were marked as "free", so they are just going to be
> > whatever value they were if they had been migrated at all.
> >
> >>>
> >>>>
> >>>>> +        return;
> >>>>> +    }
> >>>>> +
> >>>>>     if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
> >>>>>         s->free_page_report_cmd_id =3D
> >>>>>                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> >>>>
> >>>> We should rename all "free_page_report" stuff we can to
> >>>> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
> >>>> side :) ) before adding free page reporting .
> >>>>
> >>>> (looking at the virtio-balloon linux header, it's also confusing but
> >>>> we're stuck with that - maybe we should add better comments)
> >>>
> >>> Are we stuck? Couldn't we just convert it to an anonymous union with
> >>> free_page_hint_cmd_id and then use that where needed?
> >>
> >> Saw your patch already :)
> >>
> >>>
> >>>>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(Virt=
IOBalloon *s)
> >>>>>     if (s->qemu_4_0_config_size) {
> >>>>>         return sizeof(struct virtio_balloon_config);
> >>>>>     }
> >>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
) {
> >>>>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
 ||
> >>>>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
> >>>>>         return sizeof(struct virtio_balloon_config);
> >>>>>     }
> >>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
> >>>>> -        return offsetof(struct virtio_balloon_config, poison_val);
> >>>>> -    }
> >>>>
> >>>> I am not sure this change is completely sane. Why is that necessary =
at all?
> >>>
> >>> The poison_val is stored at the end of the structure and is required
> >>> in order to make free page hinting to work. What this change is doing
> >>
> >> Required to make it work? In the kernel,
> >>
> >> commit 2e991629bcf55a43681aec1ee096eeb03cf81709
> >> Author: Wei Wang <wei.w.wang@intel.com>
> >> Date:   Mon Aug 27 09:32:19 2018 +0800
> >>
> >>    virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> >>
> >> was merged after
> >>
> >> commit 86a559787e6f5cf662c081363f64a20cad654195
> >> Author: Wei Wang <wei.w.wang@intel.com>
> >> Date:   Mon Aug 27 09:32:17 2018 +0800
> >>
> >>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >>
> >> So I assume it's perfectly fine to not have it.
> >>
> >> I'd say it's the responsibility of the guest to *not* use
> >> VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
> >> without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
> >> into the foot.
> >
> > Based on the timing I am guessing the page poisoning was in the same
> > patch set as the free page hinting since there is only 2 seconds
> > between when the two are merged. If I recall the page poisoning logic
> > was added after the issue was pointed out that it needed to address
> > it.
> >
>
> Yeah, but any other OS implementing this, not caring about page poisoning=
 wouldn=E2=80=98t need it. Maybe there is something in the spec.
>
> Mental note: we=E2=80=98ll have to migrate the poison value if not alread=
y done (writing on my mobile).

Right. We need to make sure any poison or init on free is migrated
over to the destination before we can say we are going to skip the
migration. If anything what I probably ought to look into would be if
we could change the code so that if we have a hint the page is unused,
poison is enabled, and the value is 0 we just ship over a 0 page
instead of giving up on hinting entirely.

