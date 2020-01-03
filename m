Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B9C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89311222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfzyIjyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89311222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHsL-0001v5-L1
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 03:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1inHrj-0001Tx-N6
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1inHrh-0002CF-Hj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:59:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1inHrh-0002BV-E9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578038364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzre4wv+9aoZo/g6ZEYK7zc8Om6hoIx2/Bc4F3oG/jY=;
 b=MfzyIjyGm1cpkD0SNcEelbphjJwT7gLdYozw3SYXNTdDFTAdyeomCOmqNZ9OgoloiYFwKI
 v2yFztr95CIVwuXZYoT7unn/4nXRtufNCj9j1lw6QLLK9ujhEw03QMS0EQgPgky5yG9LM4
 w7wDQPKwHYrMIRVJ6XZxtX4vqj9YItQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-12DLfPEIPi2NsnY95-638A-1; Fri, 03 Jan 2020 02:59:21 -0500
Received: by mail-oi1-f200.google.com with SMTP id 21so14240952oiy.15
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 23:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jzre4wv+9aoZo/g6ZEYK7zc8Om6hoIx2/Bc4F3oG/jY=;
 b=KVhtCrrGoVHQMszg2wzw636ox4rkVplEEIAiikd7ENp7Sb9eq4huOV7D8tuXw4+GGo
 wW9lGJt4+6DYmIZ8MU460l3gjD8ik2VhkRTP7W6Fr1p9IJYihoCPDkjk8WLECZe8f2G7
 CPTmrnxIOksmnPw4VsmPr3wSUKUrSgo41xL1W5+Je1sthdWWsrqPYQkR+5lh2Vr/JdkM
 8z34MJGyDU3Vmd2nu7waukCEitqz88g4re5cgYXOWEJzu2ASrYeVBK4DZ7Iss6oVJFhA
 1CjyPcIgiNkK1L9Q3W0FvQUAUWywMQs6yD72T+s1jiyWhrMawBRyqfA+YcxzcjK9ysMW
 wT6A==
X-Gm-Message-State: APjAAAUOcL2Mic71+Z9g+xLVb9/g3Uv9mNf2uzJqf0Wc+C57LPcCqJ1C
 qz+GDHwpdbgX7pj48gh2X2wn7v7pu5wFsrT9c2WNa5B3WHxy4ddHah1Mrf4ipZBMmTvs7zOLjjX
 fZ2Be2v1491kIZoWhmtE0RbY2w9GJIIE=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr62858403otl.368.1578038361161; 
 Thu, 02 Jan 2020 23:59:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwD14uD1QIvNE7oonGT8945dtanj1hbZ+dAe08JMsmuUNjTvMr08EMsuDFdRvjaZivfZAEZW+8OLqi0HSoU3o=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr62858391otl.368.1578038360987; 
 Thu, 02 Jan 2020 23:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-2-marcandre.lureau@redhat.com>
 <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
In-Reply-To: <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 3 Jan 2020 11:59:10 +0400
Message-ID: <CAMxuvaw8m4gM5PUTYQR6NhbdL5xiBS+Tnqo=vhWJTycmQBSV2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc: use QEMU_IS_ALIGNED
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: 12DLfPEIPi2NsnY95-638A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 3, 2020 at 11:43 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/3/20 8:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   exec.c    | 4 ++--
> >   roms/SLOF | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/exec.c b/exec.c
> > index d4b769d0d4..1feda49ca1 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3895,7 +3895,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_=
t start, size_t length)
> >
> >       uint8_t *host_startaddr =3D rb->host + start;
> >
> > -    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
> > +    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
> >           error_report("ram_block_discard_range: Unaligned start addres=
s: %p",
> >                        host_startaddr);
> >           goto err;
> > @@ -3903,7 +3903,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_=
t start, size_t length)
> >
> >       if ((start + length) <=3D rb->used_length) {
> >           bool need_madvise, need_fallocate;
> > -        if (length & (rb->page_size - 1)) {
> > +        if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
> >               error_report("ram_block_discard_range: Unaligned length: =
%zx",
> >                            length);
> >               goto err;
> > diff --git a/roms/SLOF b/roms/SLOF
> > index 9546892a80..8ebf2f55e1 160000
> > --- a/roms/SLOF
> > +++ b/roms/SLOF
> > @@ -1 +1 @@
> > -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
> > +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98
>
> Without the SLOF submodule update:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

oops, I think I should submit a git config proposal, for git commit -a
to exclude submodules, or warn loudly...

Or perhaps I should stop using -a.


