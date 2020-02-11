Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D8BC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD4F20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcTzQr9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD4F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1WmF-0004GQ-Jq
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j1Wlb-0003fV-Tc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j1Wla-0002cp-Er
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:43:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j1Wla-0002ce-Aj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581432237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Dm8yZ2czQFGm0IoMtfw733Ltb9lhpwVi3xdSGCntNs=;
 b=GcTzQr9AUBUdCHwzpkPmcC7FcHVQcrlcBhwcVZtuspgjBs9QpCOk5PFES4UThrREnEkRhn
 +JdjQsogDE+TisyY30fvzaClb0dIyWIOvOiaxw9jfOFGWhEeaMSa7MnY2fK3I+S5WB7pUe
 mks3kdZjcFNgA6htANZnaFsF+qMV7WI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-m8B6B7VxO7-YdBEAvE-OIg-1; Tue, 11 Feb 2020 09:43:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id d15so6996401wru.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 06:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7Dm8yZ2czQFGm0IoMtfw733Ltb9lhpwVi3xdSGCntNs=;
 b=jQ72s1Rph3iQIlYUJcw1kTM6CyFoPLEDGcWJia+GZacZYN1SYFnpw854x+Q7alW5ci
 fQTM7wyv2kkP8vQBy2iW66R4E6K4kn40v/S047psPxU8a7AVdwIYhX8daF5jXc+hKFF/
 3xcI3/0cG/kziAfKMxgUKORXmcNregB1pHl1N9R8Y4LnaSBIGxQktB1DVf6v4w7s+k7x
 tMazS4KK61q1Xx7rU+obpx3jvwKQmn4RGcFjjLj47ZRKN2UzRrSC7Ha0TwQP55M8O2X2
 M4jttw6RM2am37bSp9ZDz9Z3Kn9OxQdE3PXLJY2pIxfbg2MnRNFzpd74MLE7Scmd6IRC
 QPrw==
X-Gm-Message-State: APjAAAXwhTzoppG2aTWaXha+fbSlIKWU27YOYzncx4DZb1mK6mcc7PnR
 jZwyZCjTDjgmu6xnxg8JPrCicS3JfE7GOrh0xSIAAidE8Mk7XR5K7BefHBYYUJ7ezHZkuSKD8xQ
 tLaiCxKh41Vo6uFgD2t2nibWTis77SIw=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr8675548wrp.17.1581432218422;
 Tue, 11 Feb 2020 06:43:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeAbs+05ONikP3Q+hRb0Dwm3+jZlSmmLqWUlMYwLL2gLaDsSHoYdVf+ySA9QqDP/61tFR+trjE9ILx1nJ1aTs=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr8675530wrp.17.1581432218222;
 Tue, 11 Feb 2020 06:43:38 -0800 (PST)
MIME-Version: 1.0
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-56-git-send-email-tsimpson@quicinc.com>
 <fd38e134-8314-f206-9a04-0e41119105f6@redhat.com>
 <BYAPR02MB48865F7264F3F5B2D8735385DE180@BYAPR02MB4886.namprd02.prod.outlook.com>
 <0541dc03-b3f8-8612-9921-e1df9546ce87@redhat.com>
In-Reply-To: <0541dc03-b3f8-8612-9921-e1df9546ce87@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 11 Feb 2020 15:43:26 +0100
Message-ID: <CAP+75-UX=6n4Y7tWN+cfoZmgmeoc2X-=mpkCD6_tj5+UDMuzKA@mail.gmail.com>
Subject: Re: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
X-MC-Unique: m8B6B7VxO7-YdBEAvE-OIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 3:40 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 2/11/20 3:35 PM, Taylor Simpson wrote:
> > Hi Philippe,
> >
> > Thanks for all your feedback.  I' get your comments addressed soon.
> >
> > I'm sorry you had trouble applying this patch.
>
> No problem.
>
> > The target/hexagon/imported/encode.def should have been created by patc=
h 17.  Did you apply that one?
>
> Ah, I haven't received patch #17, and can't find it on the list.

Oops I was looking at incorrect list =3D)

Here it is:
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02526.html

And patchew received it...
https://patchew.org/QEMU/1581381644-13678-1-git-send-email-tsimpson@quicinc=
.com/

>
> >
> > Taylor
> >
> >
> >
> >> -----Original Message-----
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Sent: Tuesday, February 11, 2020 1:02 AM
> >> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
> >> Cc: richard.henderson@linaro.org; laurent@vivier.eu; riku.voipio@iki.f=
i;
> >> aleksandar.m.mail@gmail.com
> >> Subject: Re: [RFC PATCH 55/66] Hexagon HVX import instruction encoding=
s
> >>
> >>> +#define EXTNAME mmvec
> >>> +#include "mmvec/encode_ext.def"
> >>> +#undef EXTNAME
> >>> diff --git a/target/hexagon/imported/encode.def
> >> b/target/hexagon/imported/encode.def
> >>> index 33c3396..d1b3510 100644
> >>> --- a/target/hexagon/imported/encode.def
> >>> +++ b/target/hexagon/imported/encode.def
> >>> @@ -71,6 +71,7 @@
> >>>
> >>>    #include "encode_pp.def"
> >>>    #include "encode_subinsn.def"
> >>> +#include "allextenc.def"
> >>>
> >>>    #ifdef __SELF_DEF_FIELD32
> >>>    #undef __SELF_DEF_FIELD32
> >>
> >> I had a problem applying this one:
> >>
> >> Applying: Hexagon HVX import instruction encodings
> >> error: target/hexagon/imported/encode.def: does not exist in index
> >> Patch failed at 0054 Hexagon HVX import instruction encodings
> >> hint: Use 'git am --show-current-patch' to see the failed patch
> >> When you have resolved this problem, run "git am --continue".
> >> If you prefer to skip this patch, run "git am --skip" instead.
> >> To restore the original branch and stop patching, run "git am --abort"=
.
> >>
> >> Resolved by doing:
> >>
> >> (review/hexagon|AM 54/65)$ touch target/hexagon/imported/encode.def
> >> (review/hexagon|AM 54/65)$ git add target/hexagon/imported/encode.def
> >> (review/hexagon|AM 54/65)$ git am --continue
> >> Applying: Hexagon HVX import instruction encodings
> >> Applying: Hexagon HVX import semantics
> >> ...
> >


