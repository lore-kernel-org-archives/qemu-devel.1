Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077D9207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAOVdhZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077D9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9Jg-0006G3-Cg
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD8tp-0007a9-Mg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD8to-0006YR-HA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:08:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34043)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD8to-0006XZ-Cq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569424092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/Bb2yKVS9GnjYR4U8Dx7CG0Um6Pa+fxPjJJLez580Vs=;
 b=MAOVdhZZaSqAVbXzuKKHBuULlOntMrQ3eimfWHoYbfX9iHsfsyvUm6XZWYLb3COfsemam3
 Xnm0qr3vb9AutAHGyEEfKnet64enroYotzjum/3kC9L2TZGJoPLXPpndDViXsOkYzKA/wa
 fEC9D4t5W/CagcY/wjDYxTVMAwMZHx0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-CUhEYi20NrWxbhPwwZ89uA-1; Wed, 25 Sep 2019 11:08:07 -0400
Received: by mail-wr1-f71.google.com with SMTP id a4so2504261wrg.8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wo8S0ucTgf9Od7exNv6OK8BOXZMOwr4fXqJSYzE4pmM=;
 b=geXRy64q/cHxJRx7rhe96IAu72qEhxs2Rv8uLuAvitkuAo1PAnXPXC9T9vdDrPxFTD
 ybBEIFl6gLEMqOLD1kKv2me3mtPo59W/oxx6p4K87O4mO0XgbSoGOm+MJjwrcggGG+sT
 VSq41BdeKhZCnkXarsklYvoxq+Gi6bNpMIpcXO7JBQzwdsRI/Ms+YFnHNadNmTDULGBv
 kIN8TIXEu7IFM2eIRxDTE6s1Ynd6wtTbpc0V8NzeHUlOc99dYnrknQDOI3kLK40LDKw0
 YhezUT1SsvDodiS4zyKIkQgTGdHWLjZGUun1bsOkf+d/fFjeReC4T9K7PJLUAkfWJvhJ
 +p4A==
X-Gm-Message-State: APjAAAUEpi1F2c2ZvdsiNQ92NIct9+8IN9hNpcniSLus+PNs+oTezTLq
 8k+S/aGOwN2+z5D7fKiq6RcpvM/9dwt9wC0Br6p31qtVOLApCARDFeYNevfGI6iHr0YjhGW4xsF
 1rId/KmaXFjc4v8Y=
X-Received: by 2002:a7b:c761:: with SMTP id x1mr8431914wmk.47.1569424086016;
 Wed, 25 Sep 2019 08:08:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyE1WV4NuRmT1R1R9YHpj9NKm0gW/TWJh+IAxgjddPnxVRzkClET3dGfSGv+78pFiWLr24uYw==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr8431899wmk.47.1569424085874;
 Wed, 25 Sep 2019 08:08:05 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id d9sm8982723wrc.44.2019.09.25.08.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 08:08:05 -0700 (PDT)
Subject: Re: [PATCH v2 03/20] target/mips: Clean up kvm_mips.h
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <561b9c7a-285a-af10-c1fd-edacd51b3811@redhat.com>
Date: Wed, 25 Sep 2019 17:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569415572-19635-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: CUhEYi20NrWxbhPwwZ89uA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/kvm_mips.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
> index ae957f3..1e40147 100644
> --- a/target/mips/kvm_mips.h
> +++ b/target/mips/kvm_mips.h
> @@ -7,7 +7,7 @@
>   *
>   * Copyright (C) 2012-2014 Imagination Technologies Ltd.
>   * Authors: Sanjay Lal <sanjayl@kymasys.com>
> -*/
> + */
> =20
>  #ifndef KVM_MIPS_H
>  #define KVM_MIPS_H
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


