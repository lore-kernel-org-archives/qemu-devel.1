Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78115C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD1E20855
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlRy++5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD1E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWia5-0006Y3-Eh
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiYh-0005sR-K8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiYd-0005y6-9H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:03:18 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWiYa-0005u3-1k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:03:12 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so14728758otr.13
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kup+OjCW82IEaimKWKBPzaRe659Et8pbAD30ottMu8o=;
 b=KlRy++5IN8/ITrMOf28Zpi4o0LqKmUY8CMxprP1+L9tjaNA/wwy4EJPU52M/0xIMLE
 hCgr8y4GjXJyebzHiEQSz+CdiqB037e4tKsbHfEzjstyb/OMoz5nIlHKIWfRLFTwh6pt
 TmcYA6X6M7cV7S3uOKdtWPPFg2SwEku1B8+rpYqsZ9DQKGKP/UzFhTTu4bddGMwlwOvh
 N06PBR6SzbIKbGlyOROosRzF1rni/oHIKP4y3y0Y/gOAi9Sg13TEgrdD4zdynCicLm7C
 07Yv0c5J7wyXTq+WJNCRhls+PtB3MPntTDJWMAP/lRPHEdkYIyS4M6add9ocQEpPOjj7
 7lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kup+OjCW82IEaimKWKBPzaRe659Et8pbAD30ottMu8o=;
 b=q8kPM0po42p3CERa0QoxPungzJP5QqZKVSksiGvGWXNZyQWgD/bspmYpsGUfvtNiBk
 eFO+ttdmhMfjrV8Au1KkbrfR4Pxn86I86IvHVuHzO6FNflxm4T1pYPqhAy6qR/eDTjsi
 P+p9q5oxO1H+Plv3h1OAMXA8PQA10/iWPYOA0CBmBh4oiNTiVUwr6uyXb8cFxNSXudT/
 uLP1uhtUECCM/hQs8UeCBEBt3kSrygWY4VwDh4ocz4bRYJehvZzk57+MGr+kowF6uYzn
 YDphEN63r/AHUgvi3+4OODJfvARzSGkQDjHQ7IwaqNHXvqBfIHQUPRzcs9LM+sLQOyEg
 XgVQ==
X-Gm-Message-State: APjAAAUiyj88GFeHSVF+LfVDY9uLme1HJUwLkdnZh4wBRWraqHRal1II
 gC1xXl/UVWGC3VnyCS0FtsqqLpQ+FKOr600F84jDfw==
X-Google-Smtp-Source: APXvYqyEI2D/LRl/bjobiMHF5n80oVS6JCk+YkyJMxw8k/w9DKkyWn+JFvT4mLY+FBCbg4Mw8Qg5jrcfs+NzhEQxFhY=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr22878561otn.135.1574089390518; 
 Mon, 18 Nov 2019 07:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-16-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-16-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:02:58 +0000
Message-ID: <CAFEAcA97SUwPxcZq-5BQyPgb7geBsgu46dpc1zTj4gBGZ2WwAQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/33] serial-mm: add endianness property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Add a qdev property for endianness, so memory region setup can be done
> in realize.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 2 ++
>  include/hw/char/serial.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index c28cfc94fd..2f7667c30c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1081,6 +1081,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_spac=
e,
>      qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
>      qdev_prop_set_chr(DEVICE(s), "chardev", chr);
>      qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> +    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
>
>      qdev_init_nofail(DEVICE(s));
>      qdev_init_nofail(DEVICE(self));
> @@ -1102,6 +1103,7 @@ static void serial_mm_instance_init(Object *o)
>
>  static Property serial_mm_properties[] =3D {
>      DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
> +    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_=
ENDIAN),

Again, a brief comment documenting the property here would be nice.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 759c85976d..2d0802a909 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -86,6 +86,7 @@ typedef struct SerialMM {
>      SerialState serial;
>
>      uint8_t regshift;
> +    uint8_t endianness;
>  } SerialMM;

(The type-checking on the property-setting macros doesn't let
us define this as 'enum device_endian'.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

