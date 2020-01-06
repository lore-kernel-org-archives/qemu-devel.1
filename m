Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584AC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53D62072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTjCdhwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXml-00050P-8u
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ioXeD-0000KT-Eb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ioXeC-0001R3-86
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:02:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ioXeC-0001QO-4g
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578337359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDOMXL6PYZvhiE1pNTv2byexo5Awps+MRrX/h+L1UoM=;
 b=UTjCdhwcn1XncOB2iKzZOqZX7Px7L+wsm/7EHVX24QHknbKv0A5f4k8Ns/ZiL3bjjdvRen
 qAeL/gkaFWNATGfez3TyRSpYtpiAWI8ZwlEMCCH7xhrPH5QET/LjfrNKhWnw0b6dT+32Ii
 GuM3143xyHPx7VzRFCChO+KiZAZ5IBc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-szPeLtVpMz2MVqcdou5ZKQ-1; Mon, 06 Jan 2020 14:02:38 -0500
Received: by mail-ot1-f69.google.com with SMTP id i22so21666507otr.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 11:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eDOMXL6PYZvhiE1pNTv2byexo5Awps+MRrX/h+L1UoM=;
 b=ugJ9HvlpgAmbk5XQL+HKYA5vGDJrIonupoD54IPEFmbJhoFIAIF+eqDxIXKakT6CCu
 eg0wmKtPd9WAYtsml1SGRIS9dPaW59wXMvTtANnmCsm1yFzl9ExZNBBsXVGirBW+udDY
 EOk7EUBY3gOt5TC+euYJ9IpL8mABwhb3CoJvVf6OnaNadVhnzaAT42lmeYLZhNr5SLLB
 EM9ud/G84OHZysESAn0StGQtu/FNddhL1Ce0pDIotEL1Y4eb+sBCrrGqiMqngo8Rw2RD
 WkWYU4vO93NyUPK9wGkAMd75Y5EMUuOBKMTX+33wR8wNSdlWpqYUhN1PMDFwCSQ/Fi1+
 ZxXg==
X-Gm-Message-State: APjAAAXVSX6bYydRuO38LkSH25OPfoM6xXZrkpJ2Bmn3j2C/WLejwaCH
 ceKL524tz5k9rhcYd8IYh6949pT2Gavzvf+SJ0Mi4imeR/59dvmBsyv/it7RWXHJWKG2pcDec0g
 YBalg1/7CeljyPeH5brUP+IkPgLJ38e0=
X-Received: by 2002:aca:6042:: with SMTP id u63mr6346953oib.76.1578337357435; 
 Mon, 06 Jan 2020 11:02:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2bBsKNI1FS4EWyh3vQWNa48xPTe0xrAsNRmnVqFTFWPs8dS07I3CtfwcBZPqJ+VTA0CZx2yT6PTecEQPKplo=
X-Received: by 2002:aca:6042:: with SMTP id u63mr6346942oib.76.1578337357250; 
 Mon, 06 Jan 2020 11:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-9-danielhb413@gmail.com>
In-Reply-To: <20200106182425.20312-9-danielhb413@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 6 Jan 2020 23:02:24 +0400
Message-ID: <CAMxuvaw=b2qy4LqJvQqRz+3pzB5OHtaaHmxfHSU99xYjzmet7Q@mail.gmail.com>
Subject: Re: [PATCH v1 08/59] chardev/char-mux.c: remove 'send_char' label
To: Daniel Henrique Barboza <danielhb413@gmail.com>
X-MC-Unique: szPeLtVpMz2MVqcdou5ZKQ-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 10:25 PM Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-mux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 200c62a0d0..edbaaf5cbf 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -140,7 +140,7 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d,=
 int ch)
>      if (d->term_got_escape) {
>          d->term_got_escape =3D 0;
>          if (ch =3D=3D term_escape_char) {
> -            goto send_char;
> +            return 1;
>          }
>          switch (ch) {
>          case '?':
> @@ -174,7 +174,6 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d,=
 int ch)
>      } else if (ch =3D=3D term_escape_char) {
>          d->term_got_escape =3D 1;
>      } else {
> -    send_char:
>          return 1;
>      }
>      return 0;
> --
> 2.24.1
>


