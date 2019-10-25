Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC55CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2362084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AU35dW8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2362084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzG1-0005uj-4Y
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzBX-0007QK-9n
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzBU-000570-GB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:59:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzBU-00056e-Bz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alyN4jXVqSyKmj0jBwEI3RO4punOzLtxvYByeaqVo/o=;
 b=AU35dW8EcGZSGgtSeyNvQuthDZI9+mlIcMMR6C5UN/+NHRtYCbCOLRchLvSzhW/FkNR1Xu
 A9XykD7eULI10SJ7JpgRlL/wSN1ZdGNsGGVMVhjZGmKlIdmOeOEd0I79zajmwbOTcE6MLW
 E3oFIG9SERwwmYFiMRI2qW994/COdPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2jTLU8t5M-GmSt1X1rLXnQ-1; Fri, 25 Oct 2019 08:59:11 -0400
Received: by mail-wm1-f71.google.com with SMTP id f2so719572wmf.8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 05:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XyJrTc6Ik/frUBpa6sx59bmDMBJJdvQAfQHmUtwbVp4=;
 b=OLbHtv+H+cAVGcmpbIXH16LXjJ4jv6iLChkvNJN7Aq41Y13nlCaDqCdms1WzwhDdOq
 hM+mNog0plbWYS1zNSgaxNJL3Msx98XcC4Uyr2q0tnElzAIlHheGTb9IJkMoWcBAIHBp
 DLLlzvSCYxWh7uOhIqj24f705sloEeLt53zFL4dyuDT+dPlS2unYxEDp44Ic7MIz5frG
 v+NbPnN+5Y1x/zgGDC26vPq1haLFhVCK1CXUQ7qCEKVwJBwKMWR/H4kHuFDixhUuBccF
 8dGiFufIbGA7W4+t6dvaOoKHKnX6gp46+gSHGUhCDi0rr+w1utZZpdXnLafGhV2v8MxX
 ywZA==
X-Gm-Message-State: APjAAAUCDbAKKD4XyF2vzbBRIc2YAJ0dVBPFF0dqM4PAuONbbnZKyrz5
 iZgSO5esdzpQHXUaxAKnPyj9dEYbvgVo+AbgtMeaoYgrNW/BxpAFjaUmdHI5OiZjTDmUrPoA9Uh
 xgWaNzwIA7Nmbh34=
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr3559258wmc.143.1572008350163; 
 Fri, 25 Oct 2019 05:59:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwOSyf7gDvoFKhyw3Ws/AsGtWloWVEC75ixozpq/lQH/IyDEDDaxgbmlVxiYq2o++AZFbxVAg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr3559240wmc.143.1572008349947; 
 Fri, 25 Oct 2019 05:59:09 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id a2sm2400467wrv.39.2019.10.25.05.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 05:59:09 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] tests/tcg/multiarch/linux-test: Fix error check
 for shmat
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f8c1d27a-439b-e8f4-9009-7c99e322cecd@redhat.com>
Date: Fri, 25 Oct 2019 14:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 2jTLU8t5M-GmSt1X1rLXnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 1:39 PM, Richard Henderson wrote:
> The error indicator for this syscall is -1, not 0.
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/multiarch/linux-test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux=
-test.c
> index fa4243fc04..673d7c8a1c 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -503,8 +503,9 @@ static void test_shm(void)
>  =20
>       shmid =3D chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777)=
);
>       ptr =3D shmat(shmid, NULL, 0);
> -    if (!ptr)
> +    if (ptr =3D=3D (void *)-1) {

Oops.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           error("shmat");
> +    }
>  =20
>       memset(ptr, 0, SHM_SIZE);
>  =20
>=20


