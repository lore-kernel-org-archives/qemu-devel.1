Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16979C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461E420658
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNnMPCiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461E420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxlT-000250-Um
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 13:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUxkV-0001bM-TV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUxkU-0001fq-Kh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:52:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUxkU-0001fW-HA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573671133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkrQ4uR6jhuSB3v157gSTd05TytDCq+nzZQgkEpJnCo=;
 b=fNnMPCiHR+DshdMaUBD6Y5RQikd3aiTBCRn4G+XvtxN48WvfrAj0B9JmeOCK6woKvJgO58
 Arg/lHW9jBYA8+wlDwTUeFxzJpFGQaYnppVX8szrvm3uDZBbePhsVUTK9Z6Cw0v2eNaq6g
 r8E3JCzmrxrS4sOqubdaxvAHYtrNP+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-MoUBNz65NieCiMwCsqVWxw-1; Wed, 13 Nov 2019 13:52:11 -0500
Received: by mail-wr1-f72.google.com with SMTP id w4so2205727wro.10
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 10:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YLvF0OFbSUt088TkcmWLeb/vCQD690MjHpfG2z03PAU=;
 b=QD1GzQzM0r8iyWwjpw8e8oAV1CMU2LZztp9Kg6fs4BSG8L4LKin8UB7FiUY8gnPDSg
 OmPdjX6hWd76CzkIslKrMZzBWwXeCUFKXwGyA3B9ImZMlhWyQUCRbvLvgALzsNeqNBh4
 y0UWRIh9a2YMuPTQBy52Ccx1s+DX4cHsAJEY9dGhC1V5RkEUP2cxS/lmzHEjHW6FF5Za
 yjhiU494Yrl2hu8g/MpoDjQySXwC/WN4giKtEe4FWsTGGOnIZj171LmjxE5cbPeWBaeL
 1y8kUPNHuLODoLwLBNxeRH2T6lWRbZAOUAtNw6lzcN9d6EarLykPmaBSoV2SHY/aLGos
 AJ7w==
X-Gm-Message-State: APjAAAVU9mBoLU4MbPRrjefurfPYWYz/79FNhERGfhZRNbb+bIShOwBJ
 8j7+ADy8VlMCvMOVo1ArHgOpQs/nDJC85g2HDLjOv8l2USNUAOj4elYgC6MbIGmtO6uu9ONDKrZ
 OpKr2L/2NZ+Tc7q0=
X-Received: by 2002:adf:ea88:: with SMTP id s8mr4346374wrm.120.1573671130351; 
 Wed, 13 Nov 2019 10:52:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmvpwCKgPQYWfYA6QHIZQBGrWgqgnfKPKslBjwG/w0aib/R7XSBgo4fZWEwhE7K8bMKWMS9w==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr4346359wrm.120.1573671130167; 
 Wed, 13 Nov 2019 10:52:10 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id q15sm4069025wrr.82.2019.11.13.10.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 10:52:09 -0800 (PST)
Subject: Re: [PATCH v2 1/5] MAINTAINERS: Add a section on UI translation
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb7f75b8-4141-2091-7fe1-ed00934dee39@redhat.com>
Date: Wed, 13 Nov 2019 19:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573652826-23987-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: MoUBNz65NieCiMwCsqVWxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> There should be a person who will quickly evaluate new UI
> translation, and find a way to update existing ones should
> something changes in UI.

I appreciate your trust, but I'm afraid I know next to nothing about=20
po/. I don't use QEMU's GUI myself: mostly command line, and via libvirt=20
from time to time.

These files are about language translations, maybe it is easier to let=20
them unmaintained and have patches go via the trivial tree?

>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 363e72a..fd9ba32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2714,6 +2714,11 @@ M: Daniel P. Berrange <berrange@redhat.com>
>   S: Odd Fixes
>   F: scripts/git-submodule.sh
>  =20
> +UI translations
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +F: po/*.po
> +
>   Sphinx documentation configuration and build machinery
>   M: Peter Maydell <peter.maydell@linaro.org>
>   S: Maintained
>=20


