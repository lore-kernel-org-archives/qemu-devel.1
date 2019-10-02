Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AACC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C30120700
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq5zvmaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcVn-0002Ju-Nb
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFcUx-0001mN-QL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFcUw-0001dF-17
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:08:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFcUv-0001ck-Od
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570014524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=k4e75Gh2jQ67Fs0hO6kK7qNkv9aMDy+Rx2EXO0iCfos=;
 b=iq5zvmaNq7DIiIo1i3x61sl+BKek9uAOM4ZJRYzU5fmTbATRBG1gE//TJl83V0XLPQkI2S
 slNeWtBlmCbzt3cFSbCW303BfF1m4rW+Tu0CEvdiu+pPma37fm3/uX3VeQlX7pzyhd1nEo
 NXPgOYfDMC1Xn0WuHR4bdzoe5dcXj6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-OJTDFijNNOCMxJZlWOPYtA-1; Wed, 02 Oct 2019 07:08:43 -0400
Received: by mail-wm1-f72.google.com with SMTP id a189so592685wma.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 04:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=70g/Ck0p6jhZWAvgA9ll9LQIBA2/iWGacFd81/4MQWA=;
 b=N3JpnxSw8hWqhQ7L54I3zx9VsbotQR5373LbNjwd9pUuXixK06yxOgmUBuOZVQmmiP
 z0bwTsQkTxuQLXOPSyAuhE0QvuuhDG+8Wn/0UXjNYOwMDMOtEYBTEDtixd4BJ1T/GkPR
 H/zBKYJzweUGyhILZ0xUik4vXhY84TLFwHsXmlTBjdQIlPgY20IcBUYx04cbPvgU5QDU
 wc4cI6VxD1zovEHvQa0n2BX+jgBlDN2TBuh30wKa8LzlxDQKl0gNn9Vn6F+ocJdyBvkb
 5PXP9ANBfoQzRPRtHAG+0/ErgwK7Q763TOm/F+KPJ7MDDX2YL3FlI76zWq6NT7QhiCGx
 luqQ==
X-Gm-Message-State: APjAAAWJ9wzk6D+WsRPvDt/StcFdmHG7PoiT+1r/OMosyU3qtrwpbBhL
 a0AxUqMRb2qktfC+4rMDqdJcR6wc7Nay9pt9cWVXfM8fjQGGcPfWTvgnqAJmOrBBQODck20qiOk
 SakyZHWGq8Fg5mrs=
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr2520859wmd.104.1570014522202; 
 Wed, 02 Oct 2019 04:08:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXMT0J/K3/CgHdeV3FJxAjZahVRw8pyOQpbv2IPzJBmxQ0udKA/IghRA6G2o3ojTYpnjgKsw==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr2520840wmd.104.1570014521931; 
 Wed, 02 Oct 2019 04:08:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dd94:29a5:6c08:c3b5?
 ([2001:b07:6468:f312:dd94:29a5:6c08:c3b5])
 by smtp.gmail.com with ESMTPSA id r2sm24020786wrm.3.2019.10.02.04.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 04:08:41 -0700 (PDT)
Subject: Re: [PATCH] accel/kvm: ensure ret always set
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191002102212.6100-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <05d59eb3-1693-d5f4-0f6d-9642fd46c32a@redhat.com>
Date: Wed, 2 Oct 2019 13:08:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002102212.6100-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: OJTDFijNNOCMxJZlWOPYtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 12:22, Alex Benn=C3=A9e wrote:
> Some of the cross compilers rightly complain there are cases where ret
> may not be set. 0 seems to be the reasonable default unless particular
> slot explicitly returns -1.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  accel/kvm/kvm-all.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index aabe097c41..d2d96d73e8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryListener=
 *kml,
>      KVMState *s =3D kvm_state;
>      uint64_t start, size, offset, count;
>      KVMSlot *mem;
> -    int ret, i;
> +    int ret =3D 0, i;
> =20
>      if (!s->manual_dirty_log_protect) {
>          /* No need to do explicit clear */
> -        return 0;
> +        return ret;
>      }
> =20
>      start =3D section->offset_within_address_space;
> @@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *=
kml,
> =20
>      if (!size) {
>          /* Nothing more we can do... */
> -        return 0;
> +        return ret;
>      }
> =20
>      kvm_slots_lock(kml);
>=20

Queued, thanks.

Paolo


