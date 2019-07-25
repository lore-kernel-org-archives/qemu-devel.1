Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9732C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF1C229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GX1nDeta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF1C229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqi0N-0008B5-Tt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqi0A-0007Sb-6U
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqi09-0006ye-2O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:58:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqi08-0006xj-QP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:58:00 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so52499118otl.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrvQJHhbgxkTfVbg9JKYbdlPyaIOvl90pvGXP3Jzbgk=;
 b=GX1nDetatmNCIBdmRL638ibfMja/6Mv4BkyLI/P8fLhSn3DHelryc8tp5wviTefEga
 RbHoE0WNWoSk7zTvKs+GhfpFP/HcLHYCe0Hnovoz3bKeq48bXAiPlCQsdSIb3L53umt0
 pMU8dFEwBFORmHsFk4MkvoCuCYRANlLekqbphzpbmRJwxOVKwVPLtKEEpjtgM4vcqX/M
 /6CrELeD2bp0doZcsHWAJhHZ4OSelYt/qGjFWL2V9m9U+CExaZ1WSMqITnhrlBNx4RX6
 w4LGhQEF+atBNbHEdl4Pu+2StWHK/u0KX2Jd5CPyn5VwV8hC94DdoNaZwvZi+KdtjD3a
 pifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrvQJHhbgxkTfVbg9JKYbdlPyaIOvl90pvGXP3Jzbgk=;
 b=lRDpb/ORu2fXXojMrcXlzKicnLxqujsFInrltcp3X6o/cUHKiyU9MUTK9IgsJowQXc
 kDCD1Ub8111MMdXnkryP0D/oBDXR52syqTw8UDQuNnkMTMmQai/kAsfqMn8ZxgVjSj9a
 OoaX8F5pXoD/lpCcNv96kLBnIVgHjDzhQ8zpnvAr0WX8ygJ+uAz79/t2zr334CQEXvNu
 sKG0FEFZT9ZnoEUjJ63NYhIHk7SIv3e96jOY7GvpF+uC4ob3LRfLk6FPQ3mplQ+ggJs0
 rfiQxLNpUyAJee9ng0wQdihXCh7rcDFvBMDM2W1KWVKydvoKJhjPQsFGx5oIWgewqcHf
 MDTw==
X-Gm-Message-State: APjAAAV4BlvJ1H3b45YM51aLPCprQaWm3+MlvHJ8q6BPHAW0O91EDovN
 PslUswrHSAGQuOwL9z4uegDD/Rlr9As2cs2w2LWux8Ohglg=
X-Google-Smtp-Source: APXvYqx+3yOnjf/Mn+8h9eG1mGNtdgDRQwpE6TGKMTkzMsNbbbSomvW+CJw0rrGzgvdQgz8GfJJj1Z8KXusqrI9y6DE=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr7769782oti.91.1564077480022; 
 Thu, 25 Jul 2019 10:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-3-peter.maydell@linaro.org>
 <20190725172712.GM2656@work-vm>
In-Reply-To: <20190725172712.GM2656@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 18:57:49 +0100
Message-ID: <CAFEAcA-jGvNS4N4qobLekHYdV82qSUWVQOvTRQbrpcCRF0Yvwg@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] vmstate.h: Type check
 VMSTATE_STRUCT_VARRAY macros
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 18:27, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > The VMSTATE_STRUCT_VARRAY_UINT32 macro is intended to handle
> > migrating a field which is an array of structs, but where instead of
> > migrating the entire array we only migrate a variable number of
> > elements of it.
> >
> > The VMSTATE_STRUCT_VARRAY_POINTER_UINT32 macro is intended to handle
> > migrating a field which is of pointer type, and points to a
> > dynamically allocated array of structs of variable size.
> >
> > We weren't actually checking that the field passed to
> > VMSTATE_STRUCT_VARRAY_UINT32 really is an array, with the result that
> > accidentally using it where the _POINTER_ macro was intended would
> > compile but silently corrupt memory on migration.
> >
> > Add type-checking that enforces that the field passed in is
> > really of the right array type. This applies to all the VMSTATE
> > macros which use flags including VMS_VARRAY_* but not VMS_POINTER.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> > ---
> >  include/migration/vmstate.h | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index ca68584eba4..2df333c3612 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -227,8 +227,19 @@ extern const VMStateInfo vmstate_info_bitmap;
> >  extern const VMStateInfo vmstate_info_qtailq;
> >
> >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> > +/* Check that t2 is an array of t1 of size n */
> >  #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
>
> I'd have to admit I don't understand why that does what you say;
> I'd expected something to index a t2 pointer with [n].

Note that this is just a comment describing what the existing
macro does, as a way to distinguish its job from that of the
new macro I'm adding.

What happens here is that t2 is a type like "foo [32]", ie
it is an array type already. t1 is the base 'foo' type; so the macro
is checking that t1[n] matches t2, where n is passed in to us
and must match the declared array size of the field (32 in
my example). (In C the size of the array is carried around as
part of its type, and must match on both sides of the expression;
so if you pass in the name of an array field that's the wrong size the
type check will fail, which is what we want.)

> However, for the rest of it, from migration I'm happy:
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> given it's just fixing an ARM bug, and given it'll blow up straight away
> I think it's OK for 4.1; the only risk is if we find a compiler we don't
> like.

thanks
-- PMM

