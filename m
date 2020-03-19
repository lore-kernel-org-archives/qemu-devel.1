Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C1CC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89EF2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgYIU+Zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89EF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyhM-0002tU-VC
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEygF-00018R-9A
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEygE-0002Q4-26
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:10:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEygD-0002P8-UV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584637801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0AD3md2JrKuoXzgHTQ6a6blYLaLqpMNpIstDJfJZ2A=;
 b=WgYIU+Zf07VjIhjN9n7kGR4zPhfk2Pa8B5cK+uRr9pu3tWHzglG8NcH2IIYTD9LRMYWspN
 5bACtV7pXAU/QCXydFDQ0d3CeFpeStnQPrwraOZ5UCfHS6frSGbVGog2pT/zD/uS5V57g4
 57nvp/0RA3EU3wdN4mfEv1pIu80UTnM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-iGfnPdJbPN6-oMNRgYcMBg-1; Thu, 19 Mar 2020 13:09:59 -0400
X-MC-Unique: iGfnPdJbPN6-oMNRgYcMBg-1
Received: by mail-ed1-f70.google.com with SMTP id b7so2574824edz.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=itBaS7TTJpDr6mA42Crb/kFQ0RZRvY5MneNOmacld7U=;
 b=ULFQbXAsAy1rMMlf6Av1RvssOcQmTRa6lxz9wLf2DauMukXsEErmXM8txKXKSK+Zz5
 j/Q6Ye6Yv2Rx+EKcz8VYsZKPf14PWr2JvDHP0Fk8/C3zRsEOmaP4BR0ZTiNB02cK2sn7
 4rc/cjv7gLcljD3txMBDPPAQblOSOlAsdsYuX9I2O84inmbK7X5B4tmdH9MfvKJt01G8
 XvVK2q1Xg/DG9b1N3n8ebMaoeDR3uE4nwhx5GlGfSfUhbypAoAf80HN3CWGUj+CUNTwO
 EMSq6Oi5n2i5gox9fPcArztGSqh1b7QkF7bKAW3HZ5+x3zzZVLJ3gn8SrZBi5GXzf6Ag
 RXYA==
X-Gm-Message-State: ANhLgQ1pdX76eD56/+k8+sRIk0bZHRNMEBtwwE2n+fWKlscIukJNfxoA
 CsdF6H4LdQgsB7Wq1KXgwKw3j6a48SLbMSm9Cm8ff+pLYP6xCzwkRuLa04bJCirHgNrVf6PiO0X
 C9sYeKvh1be/2PIA=
X-Received: by 2002:a50:e041:: with SMTP id g1mr3920675edl.118.1584637797948; 
 Thu, 19 Mar 2020 10:09:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuv/w4KLaobmd1S8C+GPx3zHqyPigMMA31mYRDgoSwpWvdbRrxsCiHJ1QQBXg4J+2wjdU+UYQ==
X-Received: by 2002:a50:e041:: with SMTP id g1mr3920654edl.118.1584637797713; 
 Thu, 19 Mar 2020 10:09:57 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id dj4sm2313edb.91.2020.03.19.10.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 10:09:56 -0700 (PDT)
Subject: Re: [PATCH v1] configure: record sphinx output
To: Olaf Hering <olaf@aepfle.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20200319143954.25694-1-olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64f7658b-556d-6bbc-b486-487f3822f64d@redhat.com>
Date: Thu, 19 Mar 2020 18:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319143954.25694-1-olaf@aepfle.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 3:39 PM, Olaf Hering wrote:
> If configure fails to run due to errors in the expected sphinx
> environment no helpful message is recorded. Write all of the output to
> config.log to assist with debugging.
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 12dbb0c76b..55086b0280 100755
> --- a/configure
> +++ b/configure
> @@ -4908,7 +4908,7 @@ has_sphinx_build() {
>       # sphinx-build doesn't exist at all or if it is too old.
>       mkdir -p "$TMPDIR1/sphinx"
>       touch "$TMPDIR1/sphinx/index.rst"
> -    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$T=
MPDIR1/sphinx/out" >/dev/null 2>&1
> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$T=
MPDIR1/sphinx/out" >> config.log 2>&1
>   }
>  =20
>   # Check if tools are available to build documentation.
>=20
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


