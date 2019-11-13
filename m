Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C6C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D7A206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCfrJlwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D7A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvX0-0006zh-HP
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUvWA-00067A-SI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUvW9-0002Aq-TC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:29:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUvW9-0002Ai-PV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKGyZbJg0/I0Q/CrajYUI1APxv61D4AfhzI+OuF7qz8=;
 b=gCfrJlwE0vFosVgRqMIAfMslODZ45q5BSsc0H9ahI/p7Dc4Cbv8Okpn4cIgyxEx/k7mUpa
 lNqFPwfjtViFj+ERIN/g+YFp/dPycp/7Rj4WC2JW5YNC1wnNUs2qndwtPuz7k8/kdK75OX
 RrrDbtkbA7ytIbv/TjpQFHnr56ziJgQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-48AzjlD_OiWLFNhAVHA7Pg-1; Wed, 13 Nov 2019 11:29:15 -0500
Received: by mail-wr1-f72.google.com with SMTP id e3so1866419wrs.17
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u/rXu4npSADUzhYHYjKN0YF6ZnIEGImKkpYsgTP9dlQ=;
 b=lxz8+XKaPfrFio9GsSy1lTJzAaPRTejnK4qlVVYy+AcZZYYiLiAAAHayxlg/A25j4e
 l5LZuNYsFy0gvph+yzhNAEq2c/0m2C7/jjWDytGzg5TKbcOGFLlJJIQNneqo+KhZxkR/
 oXhjdjkJo5eNBfLC9pGcVPH/rbJdGNIArzI9eETjrq6zHGsX+1qpK3/CCJNYO0M9IcSb
 uuhmyMsi/qIIOSI0FXreHCHUuvdi2qurqva4BAQCZfvIQ2iom0NpLsU3ai+Z/Sjwqxt4
 BmiGE2AyRcxUczSj5uQmsRpzU7e7sEHG7x6DC6/OTMAuclesxZgm3mEkohnAe7No+CAr
 u+wg==
X-Gm-Message-State: APjAAAU7z1Nnf/2URJwNhCPOey9t9o5ARRMLq/97Np69ci7S8zpHb1lN
 0U7OeMIVepIOAGIWQqL37/bWOcnqeMNM9KQbTpSbZiPIFk1hkMG7hN8Xi6EOq2LKd7I54axSZns
 OlBOIBhzfntAbpaw=
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr3574749wru.23.1573662554772; 
 Wed, 13 Nov 2019 08:29:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxk2RoRd/FspltYi7/XeCr7qNIiOQ03Bfm7uR6L28fN+zZfGrulwcFIu6ea5dUVQBNbjUPTSA==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr3574716wru.23.1573662554523; 
 Wed, 13 Nov 2019 08:29:14 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id h140sm3362330wme.22.2019.11.13.08.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:29:13 -0800 (PST)
Subject: Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems from
 MAIN_SOFTMMU_TARGETS
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d58692dc-b94f-cd6a-c3dd-e9c76e68bdee@redhat.com>
Date: Wed, 13 Nov 2019 17:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113115952.775-6-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 48AzjlD_OiWLFNhAVHA7Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 12:59 PM, Alex Benn=C3=A9e wrote:
> The older clangs are still struggling to build and run everything
> withing the 50 minute timeout so lets lighten the load a bit more. We
> still have coverage for GCC and hopefully no obscure 32 bit guest only
> breakages slip through the cracks.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index b9a026c8eeb..c09b6a00143 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,7 +79,7 @@ env:
>       - BASE_CONFIG=3D"--disable-docs --disable-tools"
>       - TEST_CMD=3D"make check V=3D1"
>       # This is broadly a list of "mainline" softmmu targets which have s=
upport across the major distros
> -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,m=
ips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_=
64-softmmu"
> +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softm=
mu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"

Aleksandar, since you mostly test 32-bit MIPS, are you OK we keep=20
mips-softmmu and drop mips64-softmmu here? Another job (acceptance-test)=20
builds the mips64el-softmmu.

>       - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
>       - CCACHE_MAXSIZE=3D1G
>  =20
>=20


