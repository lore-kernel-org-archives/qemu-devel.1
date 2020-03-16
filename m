Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B422C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632A20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNXfGnn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E632A20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuTl-00028G-3X
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtEV-0001uc-KX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtEU-0001dz-Dc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:08:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtEU-0001a9-6A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:08:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id 6so18534773wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=99dn/GuhwAHx2S002190vY0CnNI7zHUp3az7R7L8TFY=;
 b=SNXfGnn1xK7BuGqjlOmsRLybZbnL6/G4lYfntprIlEMiqL9aKfp9cvJ8qid8swothV
 MyMT8ojXC86NwCSylza4bF9oPXy9TOcLeiX3VrPC95zmltsAnJdx+85b2AbXsiI8u9jD
 M5TFHhtX/Rc2MK3znjHGCESydIQSugwD9y3nzAjl6eSPrvxWP1JQhdkbgF8r+otCQ0Yv
 a2h1IL8Gq3il9txBBrsi7uQmcTcRqlRVqNFL2r5R7d/IxrD+cXir0G7U6Ammp9eE7v0M
 WyHEmgb3hT15kMlsLLuH5Y76loKBUmQgpbo7wXhAkE5rpyIHJIZgsLkdFcSIL0a8Ps9v
 luPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=99dn/GuhwAHx2S002190vY0CnNI7zHUp3az7R7L8TFY=;
 b=RCv6S18CW7vsuSjwkWln3jVnYFX19AaWspKq2B69CH0F+dW8UrP1oq5Be0Vk/kpA0x
 J4VUPZrro93twlg628rxvoOE8Uk6LMu8vKqg4Ebix+QXy0BAXC1FEY7n1t92JVePDV7p
 F/3gMBoi9fkRWOsBQiKL9AxyCNUkQcmzoJnIpnOUigX6MgXgR6WoInhTjuG11PyfHRlY
 ZUOxXJGwYrzg6nEq+F6fzHg+frgECM/VIMAbtTb4k9U/h/NcLmmt6+pWtM1fcBPS6vmW
 WvnANHGHoACpuCNvUY6qPinFNraV7LKylyxPN86Ez0KD2vnCR6LhzYTTjknI9o5x0CyO
 iohA==
X-Gm-Message-State: ANhLgQ2W6AxePw4LiilCurrYrRBy6LmuHRQabFT7m3+Ezw/JuRgEoVsv
 zNh5jnSPuiz7iLtv3KWHQukDCXmKzYnXUKRxqMBNb467Mwc=
X-Google-Smtp-Source: ADFU+vsY6bDMIelg9RQTfRctssaH0FJTf5nDOtFgI0so9ofMIlqkzT2h6uOUIK8zOhueHwHeQAJF5H38kF5qvL4wx8c=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr147752wmf.4.1584378533159;
 Mon, 16 Mar 2020 10:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-20-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-20-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:08:41 +0100
Message-ID: <CAJ+F1CLZ-Nh-nkQZcYbKnYTdAw3QkUtb4D=kk5L8SyB+0Bcnuw@mail.gmail.com>
Subject: Re: [PATCH v3 19/34] qapi/schema: Call QAPIDoc.connect_member() in
 just one place
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 4:00 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> The .connect_doc() of classes that have QAPISchemaMember connect them
> to their documentation.  Change them to delegate the actual work to
> new QAPISchemaMember.connect_doc().  Matches the .connect_doc() that
> already exist.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/schema.py | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 033c84c4a0..59e1f5a395 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -252,9 +252,8 @@ class QAPISchemaEnumType(QAPISchemaType):
>      def connect_doc(self, doc=3DNone):
>          super().connect_doc(doc)
>          doc =3D doc or self.doc
> -        if doc:
> -            for m in self.members:
> -                doc.connect_member(m)
> +        for m in self.members:
> +            m.connect_doc(doc)
>
>      def is_implicit(self):
>          # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
> @@ -396,11 +395,10 @@ class QAPISchemaObjectType(QAPISchemaType):
>      def connect_doc(self, doc=3DNone):
>          super().connect_doc(doc)
>          doc =3D doc or self.doc
> -        if doc:
> -            if self.base and self.base.is_implicit():
> -                self.base.connect_doc(doc)
> -            for m in self.local_members:
> -                doc.connect_member(m)
> +        if self.base and self.base.is_implicit():
> +            self.base.connect_doc(doc)
> +        for m in self.local_members:
> +            m.connect_doc(doc)
>
>      @property
>      def ifcond(self):
> @@ -496,9 +494,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
>      def connect_doc(self, doc=3DNone):
>          super().connect_doc(doc)
>          doc =3D doc or self.doc
> -        if doc:
> -            for v in self.variants.variants:
> -                doc.connect_member(v)
> +        for v in self.variants.variants:
> +            v.connect_doc(doc)
>
>      def c_type(self):
>          return c_name(self.name) + pointer_suffix
> @@ -627,6 +624,10 @@ class QAPISchemaMember:
>                  % (self.describe(info), seen[cname].describe(info)))
>          seen[cname] =3D self
>
> +    def connect_doc(self, doc):
> +        if doc:
> +            doc.connect_member(self)
> +
>      def describe(self, info):
>          role =3D self.role
>          defined_in =3D self.defined_in
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

