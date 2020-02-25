Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE0C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CAA2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPWKqUTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CAA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cI2-0001C2-MX
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6cHS-0000lD-OF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6cHR-0007Ph-0h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:37:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6cHQ-0007PG-Su
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582645071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XE8UNnsV9Eoarg4ySau0eXRnOxV5ueJcMvpyQOjFQc=;
 b=dPWKqUTbc1ivKMRp6QK2qAQPMArhDnorSkKGoefbBFpXLv1QHk00ApneVCYizwlZF1L4cJ
 /XCS5nRjmBFu6vZqE3M4kf9RuSbXZ5VnvA5eRidsk+RdL6TSUbFhmgoUlN4N30SgL51U52
 VwvkyXmRJ97RTEH9ViQfbsymKQT/bWE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-cu5tH7vXPWCn_5RBfoyekw-1; Tue, 25 Feb 2020 10:37:49 -0500
X-MC-Unique: cu5tH7vXPWCn_5RBfoyekw-1
Received: by mail-qt1-f199.google.com with SMTP id t9so15322423qtn.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wyhlgH31IAXjb0UdT0Ng7fQx4pGzpBqDUTAAZEH+5hw=;
 b=GmrVj5BqnmfCMd/RixaVpxb7PO/obuQnWIzOPhsHHLozmMvrT7SE71EEkVDqEhedEU
 W13bhGylO1tWEIrI9CQHq6a3Hly+fyHE/aYaTa5X6JjQ3Ca2r9P5Hrd/T1sUL9WogUWG
 p0jumzLp7jVeSEwmvmbI5rK9xwLZ8DdNdLd5OLnBG2wuXxhfWbtJtuo7DEk0GfrEam+E
 +Amty43ezbjKfILEQMz28nVD3E0uvlOmgww+T/vu67xzbzRCVgZfw9k7hzAEEx2dM++U
 U9YHLr2Hf6Y2tCxqhH0fjqnYEkkskhyUjOAYr7pPxXlSQ7KM/Iwx2le1C87I5+69BKwR
 VxAQ==
X-Gm-Message-State: APjAAAUMrQDP/8+qUFrOJ3GUMj065h+QSJ4Zqb7omLRQ2GYNUMiMK6g/
 /0JlOd5CUaAQgpHJJVTHlxLqhO5OP9zfJOUgW3F2kNC7oXRljQ63QyWHwzfomw6/KbZYB/Abu3+
 ZMzO9dxV0No1HYcg=
X-Received: by 2002:ac8:4d0b:: with SMTP id w11mr52772560qtv.385.1582645069305; 
 Tue, 25 Feb 2020 07:37:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8VRHMT80aqK5HHZToYzIN4XBtd7b4nr8nnqPho3m08EfgxkDnbpUNer5pby5hllJJCYXapQ==
X-Received: by 2002:ac8:4d0b:: with SMTP id w11mr52772535qtv.385.1582645069029; 
 Tue, 25 Feb 2020 07:37:49 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id v10sm7656875qtp.22.2020.02.25.07.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:37:48 -0800 (PST)
Date: Tue, 25 Feb 2020 10:37:47 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 13/13] migration/ram: Tolerate partially changed
 mappings in postcopy code
Message-ID: <20200225153747.GA127720@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-14-david@redhat.com>
 <20200224224949.GE113102@xz-x1>
 <531232dc-33f9-2c37-41a6-ef3899abd11a@redhat.com>
 <20200225142740.GF113102@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200225142740.GF113102@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 09:27:40AM -0500, Peter Xu wrote:
> On Tue, Feb 25, 2020 at 08:44:56AM +0100, David Hildenbrand wrote:
> > On 24.02.20 23:49, Peter Xu wrote:
> > > On Fri, Feb 21, 2020 at 05:42:04PM +0100, David Hildenbrand wrote:
> > >> When we partially change mappings (esp., mmap over parts of an exist=
ing
> > >> mmap like qemu_ram_remap() does) where we have a userfaultfd handler
> > >> registered, the handler will implicitly be unregistered from the par=
ts that
> > >> changed.
> > >>
> > >> Trying to place pages onto mappings where there is no longer a handl=
er
> > >> registered will fail. Let's make sure that any waiter is woken up - =
we
> > >> have to do that manually.
> > >>
> > >> Let's also document how UFFDIO_UNREGISTER will handle this scenario.
> > >>
> > >> This is mainly a preparation for RAM blocks with resizable allcoatio=
ns,
> > >> where the mapping of the invalid RAM range will change. The source w=
ill
> > >> keep sending pages that are outside of the new (shrunk) RAM size. We=
 have
> > >> to treat these pages like they would have been migrated, but can
> > >> essentially simply drop the content (ignore the placement error).
> > >>
> > >> Keep printing a warning on EINVAL, to avoid hiding other (programmin=
g)
> > >> issues. ENOENT is unique.
> > >>
> > >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >> Cc: Juan Quintela <quintela@redhat.com>
> > >> Cc: Peter Xu <peterx@redhat.com>
> > >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> > >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > >> ---
> > >>  migration/postcopy-ram.c | 37 +++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 37 insertions(+)
> > >>
> > >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > >> index c68caf4e42..f023830b9a 100644
> > >> --- a/migration/postcopy-ram.c
> > >> +++ b/migration/postcopy-ram.c
> > >> @@ -506,6 +506,12 @@ static int cleanup_range(RAMBlock *rb, void *op=
aque)
> > >>      range_struct.start =3D (uintptr_t)host_addr;
> > >>      range_struct.len =3D length;
> > >> =20
> > >> +    /*
> > >> +     * In case the mapping was partially changed since we enabled u=
serfault
> > >> +     * (e.g., via qemu_ram_remap()), the userfaultfd handler was al=
ready removed
> > >> +     * for the mappings that changed. Unregistering will, however, =
still work
> > >> +     * and ignore mappings without a registered handler.
> > >> +     */
> > >=20
> > > Ideally we should still only unregister what we have registered.
> > > After all we do have this information because we know what we
> > > registered, we know what has unmapped (in your new resize() hook, whe=
n
> > > postcopy_state=3D=3DRUNNING).
> >=20
> > Not in the case of qemu_ram_remap(). And whatever you propose will
> > require synchronization (see my other mail) and more complicated
> > handling than this. uffd allows you to handle races with mmap changes i=
n
> > a very elegant way (e.g., -ENOENT, or unregisterignoring changed mappin=
gs).
>=20
> All writers to the new postcopy_min_length should have BQL already.
> The only left is the last cleanup_range() where we can take the BQL
> for a while.  However...
>=20
> >=20
> > >=20
> > > An extreme example is when we register with pages in range [A, B),
> > > then shrink it to [A, C), then we mapped something else within [C, B)
> > > (note, with virtio-mem logically B can be very big and C can be very
> > > small, it means [B, C) can cover quite some address space). Then if:
> > >=20
> > >   - [C, B) memory type is not compatible with uffd, or
> >=20
> > That will never happen in the near future. Without resizable allocation=
s:
> > - All memory is either anonymous or from a single fd
> >=20
> > In addition, right now, only anonymous memory can be used for resizable
> > RAM. However, with resizable allocations we could have:
> > - All used_length memory is either anonymous or from a single fd
> > - All remaining memory is either anonymous or from a single fd
> >=20
> > Everything else does not make any sense IMHO and I don't think this is
> > relevant long term. You cannot arbitrarily map things into the
> > used_length part of a RAMBlock. That would contradict to its page_size
> > and its fd. E.g., you would break qemu_ram_remap().
>=20
> ... I think this persuaded me. :) You are right they can still be
> protected until max_length with PROT_NONE.  Would you mind add some of
> the above into the comment above unregister of uffd?

Sorry please ignore the PROT_NONE part.  Maybe just mention something
like "the used_length will either be or larger than the userfaultfd
registered range (with the same memory type), so it will be safe to
unregister for even bigger than what we have registered".  Thanks,

--=20
Peter Xu


