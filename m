Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B68214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyIotfjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B68214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2AJ-0004xU-UA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1if29I-0003xi-Nd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1if29H-0005y5-8y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:35:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1if29G-0005wQ-Vw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:35:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so1344084wmb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 05:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dObC/ldH7VaIPtRu9YnCdcmBagtXjD2FNR8jddEdLoQ=;
 b=pyIotfjVi5ich7sRdXOY2CXyq7P5MecccyuvvCmRijsDEyL5IE9b20UJfdEcJTsJCh
 3OEIS/7wUtZ3F0onIEicQdVT9SOqGcA1KjjHKFhYtKARihOj/ZDbHDDlvruPZui2ZleE
 pznOcn4B24aKHIuGr6lFb3o0iyrVucbdL1RH3hvWrpjQEl9x+ltwAJxcqc6UAif7vIr0
 tHCmr71S6tL3YghCpRdDuaj0BktXOj+CAzU92qzNezXflJvOkxj/7Lnns4rG7yQYYrDk
 wqkejQLFYXqaW40RnmxYC1SAWwCKmmCqbG2c7LuN6BP3wKfwKW1kIdVt3pE0zRgxtEx/
 EJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dObC/ldH7VaIPtRu9YnCdcmBagtXjD2FNR8jddEdLoQ=;
 b=Fyz2fKZjxSTMeDrPRIsq9uUL3qhQl0yhN0Y3/sl83Csdus2kTLlWSc/Ia+CJeJqNFQ
 gyWHS/v2g+78GtRh8XlSpzskEm3GfjDwS01teX0OHttmIt6anOjFIm0l9Q2o/SxVY+O1
 H4YqYPU4ICxhmVQaUvsZ6clEChe8JCr1i0QSzN1z9flmPsLHX8TKD6axoAa8JlYUgWM1
 mmvlZ0WmoIAEcAVLN1bhU1HMnUIJA2Q1rNRaGDK4aBpg/3dvdHwMARLa47yTihqgVYbf
 F6sSC6PxXzwYNJXYYvq2m313kMWMdxV9FpJTV9u7M6GrSzydWyypcRIAL2RU4pLyOr10
 V+Kg==
X-Gm-Message-State: APjAAAWMfyGn/V2f17qYl4HMnhhrRcWZphZn6aE3P0PL3ReL7wDEW0+J
 E4R9I58GkZ5chZef/3TMVlnGcLf8rs349LaNW5Y=
X-Google-Smtp-Source: APXvYqwP9aQh5fsvQ/EK00IScHVGJgM/SwzVXsJ4GxEio0MfnXKX8zseae08Oid/dSEQUux0PMFDr73rPT7iWTgfIeg=
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr4028277wme.42.1576071325707; 
 Wed, 11 Dec 2019 05:35:25 -0800 (PST)
MIME-Version: 1.0
References: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
In-Reply-To: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Dec 2019 17:35:13 +0400
Message-ID: <CAJ+F1C+QEi-3S=yZjQxm+hiHixoNzWsg6qkxsyUirsE7DZpQVQ@mail.gmail.com>
Subject: Re: [PATCH] object: Improve documentation of interfaces
To: Greg Kurz <groug@kaod.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 5:33 PM Greg Kurz <groug@kaod.org> wrote:
>
> QOM interfaces allow a limited form of multiple inheritance, at the
> condition of being stateless. That is, they cannot be instantiated
> and a pointer to an interface shouldn't be dereferenceable in any way.
> This is achieved by making the QOM instance type an incomplete type,
> which is, as mentioned by Markus Armbruster, the closest you can get
> to abstract class in C.
>
> Incomplete types are widely used to hide implementation details, but
> people usually expect to find at least one place where the type is
> fully defined. The fact that it doesn't happen with QOM interfaces is
> quite disturbing, especially since it isn't documented anywhere as
> recently discussed in this thread:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html
>
> Amend the documentation in the object.h header file to provide more
> details about why and how to implement QOM interfaces using incomplete
> types.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/qom/object.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77fd6..5cf98d2c4350 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances a=
re
>   * similar to normal types except for the fact that are only defined by
> - * their classes and never carry any state.  You can dynamically cast an=
 object
> - * to one of its #Interface types and vice versa.
> + * their classes and never carry any state.  As a consequence, a pointer=
 to
> + * an interface instance should always be of incomplete type in order to=
 be
> + * sure it cannot be dereferenced.  That is, you should define the
> + * 'typedef struct SomethingIf SomethingIf' so that you can pass around
> + * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { .=
.. }'.
> + * The only things you can validly do with a 'SomethingIf *' are to pass=
 it as
> + * an argument to a method on its corresponding SomethingIfClass, or to
> + * dynamically cast it to an object that implements the interface.
>   *
>   * # Methods #
>   *
>
>


--=20
Marc-Andr=C3=A9 Lureau

