Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA903C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836B82084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6hHIFyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836B82084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDrQA-0004Hm-QQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:08:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDrOv-0003gd-OW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDrOu-0004pC-M8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:07:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDrOs-0004la-7p
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:06:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c1so2283232wml.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=NJyCLXhDQUhXSKUCvFGvbkuFYEjiCMg2af47TZw/Wj4=;
	b=f6hHIFyl0gZEtf05c0WxX8fa21VhGTG0XyJ9TXoZer3n2Xg4ixToa9iTSJ7dPIUiTp
	Q1Z2fg3aVXXgZkoHxnqpy0oVShRo1qfCxw25JLvZbLZZ6lTugnVduqwgV58FJe8PYpq9
	2gSyUXJ4lB668PmPBZKwPy8BfgqDLj5HYB2JU8lBpZhddSU+pcmpDZoRhT1frpzR7iOt
	uD13bxrMkGzVoiSGTxJzOzSDEk98irlNiUlhcKEeTOATZPfqR1SIT9JxxgMRYEWQliH3
	iIDGMZv9oAlMnCX3TtSIEKb854BII3y9GqU6GB8qyb+zr/sWaXsKYyY/Z1ltpsekHJyq
	sEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=NJyCLXhDQUhXSKUCvFGvbkuFYEjiCMg2af47TZw/Wj4=;
	b=HuaDhqHh5lAON5sXY4CLY5b3fW2yHgrSulg5wx0UKXqIe81cKQbWGBF9MMtJk+gdlU
	0IiZwMmKBp8E+Hf4JRiJTKQSeED8LEniQDd/Ff8KynxKDK/zQ8yJ6Y1Av5n7Y0e3JX12
	reC8rC/xgolEqbfr1uKS9h/ZI3EAIYGrFUwUMM/PRmHQHa4yVL3aW+RpOZFg25wVwQdg
	e6ZyogEbDeoLYgNIEjbGuaJA/qObj2YDgDWfOZyIh29XIC33oZ3ZmagibA+Zuza0QcSl
	8Exm97mPzAxFgH4UD3pLOsANUNJmkfgwZIVLJsqxeNaRk+OUVigf7o9sedtnCTeVAlmv
	vTFA==
X-Gm-Message-State: APjAAAWOmkU5ebVZCGZSvBF9rj2MmeZfP8Fszmr8BDiniKSt6FYBA/Ir
	syVFu3NESeWnD0CafaXxiSFvtVl1uv4I/aOhmZ8=
X-Google-Smtp-Source: APXvYqyDhDAfK9+R0/zmJq7Fmc4oyLJcSVmpRvOXvxTBVMHJ0We4FXJkvq0YuQJv0SMqe6BBmmKB5xMsvROqnoL5Tyk=
X-Received: by 2002:a1c:c504:: with SMTP id v4mr22647832wmf.45.1554818814345; 
	Tue, 09 Apr 2019 07:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-36-marcandre.lureau@redhat.com>
	<20180412144814.GH2704@work-vm>
In-Reply-To: <20180412144814.GH2704@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Apr 2019 16:06:42 +0200
Message-ID:
 <CAJ+F1CLQ=UBWHQnHSZPu2Gtjbbd66DHsF+D-T5rn1dhT0+TCHA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: Re: [Qemu-devel] [PATCH v3 35/38] console: make screendump
 asynchronous
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
	QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409140642.EO7CwDBGBuCr7BSyRf6xTQH7l4QZv00OAlLTZ-aG3BU@z>

Hi

On Thu, Apr 12, 2018 at 4:49 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Make screendump asynchronous to provide correct screendumps.
> >
> > HMP doesn't have async support, so it has to remain synchronous and
> > potentially incorrect to avoid potential races.
> >
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>   Looking at this and the previous pair of patches, I think we'd be
> better if we defined that async commands took a callback function
> pointer and data that they call.
>
>   Here we've got 'graphic_hw_update_done' that explicitly walks qmp
> lists; but I think it's better just to pass graphic_hw_update() the
> completion data together with a callback function and it calls that when
> it's done.

The calling context is in QmpReturn: it will handle further dispatch
on the associated session (it has the associated cb+data, if you
will).

gfx_update_async() doesn't have cb+data to associate the call with a
finish handler. Further down, spice doesn't keep the request "context"
either. All it does is call graphic_hw_update_done() when update is
finished, that's why we walk the list of pending screendumps here.

We could move the pending list of async screendumps down to spice (and
other console renderers), but that would make the code more
complicated & duplicated for no strong reason.

>
> (Also isn't it a little bit of a race, calling graphic_hw_update() and
> *then* adding the entry to the list? Can't it end up calling the _done()
> before we've added it to the list).

Yes, in theory it could. In practice that won't happen today, but we
may change things later and not realize we "broke" screendump. So I
will rearrange the code to add it to the pending list before calling
graphic_hw_update().


>
> Also, do we need a list of outstanding screendumps, or should we just
> have a list of async commands.

We have both, mostly for simplicity and flexibility reasons. If we
removed the outstanding screendump list, we would have to query it
from the session.

Thanks for the review, I'll send an update revision.


--
Marc-Andr=C3=A9 Lureau

