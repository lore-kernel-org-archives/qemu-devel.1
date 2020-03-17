Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BDC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683F5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/huaabQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683F5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8Of-0004GV-Fn
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8Ny-0003ne-V8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8Nx-0007P3-J4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:19:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8Nx-0007M9-EI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584436780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+5eD9iy2AhNSwNN7eWQAyXjCcfesMWZUS8MRElj/m8=;
 b=N/huaabQOgpgKGlhvv9+GqIGP8YAPdWiBK+Mm7SeUOTxCRL1W9B4xKMes7wVAAyk3i0dtS
 TdWcJXugqSxQ5SNvcZTVF5w7aFNslAtEsGXWkmb72bTthSRfryY2wDCIsqjSaeoSJw9GsC
 wiF5fvZIfQx+GB+eYAdAAj9yjkTtE+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-EP-_LvZBMsqgL06urLblAg-1; Tue, 17 Mar 2020 05:19:37 -0400
X-MC-Unique: EP-_LvZBMsqgL06urLblAg-1
Received: by mail-wm1-f72.google.com with SMTP id 20so5501508wmk.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nhoFl6x3SqA2NNDhjhe6Zdi5T9mkk0HewZl6AQxhCGk=;
 b=g7NeuBk5ZinOelBYLoe1tdDOpbCsEZzGnyBUnyoupcOH3TSkjESYnqTJqS+a4ZZ2Jc
 WVxLo7MbTNZvtIDD4CXAPbz9QdPHAgIbl5PUSC/yrgOhsuLd/T7492XlpeySCbScYLbe
 lP7kUOAn27C3I7q2lbDSe0aC5rEv8BTi3oCMAaT2Xt7NrQAuOzGPvnvx9f4nY5J6BM84
 lo/4tX6v+sFWDSOBduerceqI8Jm/K6LaE5sEJPMIeBMqut1BVZ7hp7GRjpZZgtCA/6Mx
 H+zHNyxlQm+o37wx1uOzXelcTohdB0uozwhld3SyJW1ls+EZaDhJ8zZEKT/sIQr8Wq2/
 wo3Q==
X-Gm-Message-State: ANhLgQ2AFgOR900Zd+qRpu0JTr87v0hDGrE4Bea3qvH9sbw3xeeGLWog
 lZqArcEwUcMCMLdt1pP1+rxxOLgLKYBy0UrpgTOZFCu3HUsnFkNSp2dy8Jrb6mRqz6b05eBVqr9
 rN4CVV390hmRMu2Q=
X-Received: by 2002:a05:600c:2f10:: with SMTP id
 r16mr4267452wmn.92.1584436775966; 
 Tue, 17 Mar 2020 02:19:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunMKy7Vf2xVjMl2Pqzg0NlOIvTTDrCa+X+usuHApfW6ZenI7/zIZ89s6cnzI1meTnh50hpAA==
X-Received: by 2002:a05:600c:2f10:: with SMTP id
 r16mr4267429wmn.92.1584436775691; 
 Tue, 17 Mar 2020 02:19:35 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x5sm3675489wrv.67.2020.03.17.02.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:19:35 -0700 (PDT)
Subject: Re: [PATCH] Enable strace for TARGET_NR_llseek
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1584391940-29281-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f61c50e4-4d71-2260-c3aa-555d7bf300b5@redhat.com>
Date: Tue, 17 Mar 2020 10:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584391940-29281-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:52 PM, Taylor Simpson wrote:
> linux-user/syscall.c handles the case where TARGET_NR_llseek (one undersc=
ore)
> is defined and TARGET_NR__llseek (two underscores)
>      /* Newer kernel ports have llseek() instead of _llseek() */
>      #if defined(TARGET_NR_llseek) && !defined(TARGET_NR__llseek)
>      #define TARGET_NR__llseek TARGET_NR_llseek
>      #endif
>=20
> Unfortunately, strace will print "Unknown syscall" in this case.  This pa=
tch
> fixes that problem.
>=20
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   linux-user/strace.c    | 2 +-
>   linux-user/strace.list | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f7130b..4bcc00b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1667,7 +1667,7 @@ print_linkat(const struct syscallname *name,
>   }
>   #endif
>  =20
> -#ifdef TARGET_NR__llseek
> +#ifdef defined(TARGET_NR__llseek) || defined(TARGET_NR_llseek)
>   static void
>   print__llseek(const struct syscallname *name,
>       abi_long arg0, abi_long arg1, abi_long arg2,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d49a1e9..5a01e95 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -503,6 +503,9 @@
>   #ifdef TARGET_NR__llseek
>   { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
>   #endif
> +#ifdef TARGET_NR_llseek
> +{ TARGET_NR_llseek, "_llseek" , NULL, print__llseek, NULL },
> +#endif
>   #ifdef TARGET_NR_lock
>   { TARGET_NR_lock, "lock" , NULL, NULL, NULL },
>   #endif
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


