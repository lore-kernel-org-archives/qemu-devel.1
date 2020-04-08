Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F53C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC4A20730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEPU1xSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC4A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM5nZ-0004Ko-5D
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jM5ks-0002oz-Be
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jM5kl-0000qV-DW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:08:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jM5kl-0000oJ-3Z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586333286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ela0vKdFzjhC5nmoyH40WrnFKyFG8cxlzndK8e65Nl0=;
 b=aEPU1xSuaxMx1rSzPE7b1YKrxXq+kL810HltI5cGljXUopOyc//WcWz3El63OgClGSvTH9
 Iak/cCkxeFnBwHpzVzyCV3+IlV1VN+FBuQ8vvh99b3AQr2iNpjtyF71MuXZLySpWEV5b+K
 iBlGY3Kn088JBAqH56nsGPwql2tpeqc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-DyiRb7zfOiuDFcLpXWS_zw-1; Wed, 08 Apr 2020 04:08:03 -0400
X-MC-Unique: DyiRb7zfOiuDFcLpXWS_zw-1
Received: by mail-ed1-f71.google.com with SMTP id b100so5986759edf.15
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 01:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ela0vKdFzjhC5nmoyH40WrnFKyFG8cxlzndK8e65Nl0=;
 b=rwqtnM7ygcLoyzcFfvBmnS7Q5ZHpNS/fJl1K5tqLzAhQCAbmggcoe0cOPNasdnHp5S
 usA08bBZhO/FagSh91lMsN0I5mTdbXQwbAgqW1qqKxu9OohDtKElTkJLOXlxbaKOyQux
 FOwMOpwLbbTu2GFJ4pHNf9wriHcKBogNMVsTYHvn0qbDQlg7g0XzqRkZmuOfuESvICNl
 VqsAbzti0Z+ElZ94wZltbkALS2BnYt6FeE38S9STIfotVrwl3PnuMUh4CCluJRaAsuk9
 8Kr2QCGPJpJuArEQTCgkfJW/xkEdNwvPmx3+6H6Fynm5/k8QpwwzW9rKkuHEkl85vuhx
 CuDg==
X-Gm-Message-State: AGi0PuZdoRlcd99RZ1onUSxb9NFbSn9a1yCF0VaGQAtklxfp/rR2vkMI
 gsXgd5hIhmCq9x2S7JrCbJlIiV8Z8owfY0OLv//yyvQyNwUnoZEFRfs68TI+sGn7U1tIFsmqjZZ
 UsMPFq1MF7hlNtFk=
X-Received: by 2002:a50:ee0c:: with SMTP id g12mr1621927eds.214.1586333282500; 
 Wed, 08 Apr 2020 01:08:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypK90QXu8nupHggHfB9VTcjzz/EXHVz65eweH/HKSk9tQwVna8As1+tt6Sx+OFuhlhhPYfdq4w==
X-Received: by 2002:a50:ee0c:: with SMTP id g12mr1621907eds.214.1586333282155; 
 Wed, 08 Apr 2020 01:08:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s8sm1027349eju.62.2020.04.08.01.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 01:08:01 -0700 (PDT)
Subject: Re: [PATCH] When updating the PFLASH file contents, we should check
 for a possible failure of blk_pwrite(). Similar to 3a68829 commit
To: Mansour Ahmadi <mansourweb@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <20200408003552.58095-1-mansourweb@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34044154-1982-6f43-d124-bc4bc3924136@redhat.com>
Date: Wed, 8 Apr 2020 10:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408003552.58095-1-mansourweb@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mansour,

On 4/8/20 2:35 AM, Mansour Ahmadi wrote:
> Signed-off-by: Mansour Ahmadi <mansourweb@gmail.com>
> ---
>   hw/block/pflash_cfi01.c | 6 +++++-
>   hw/block/pflash_cfi02.c | 6 +++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 24f3bce7ef..31319cfd07 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -399,13 +399,17 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
>                             int size)
>   {
>       int offset_end;
> +    int ret;
>       if (pfl->blk) {
>           offset_end = offset + size;
>           /* widen to sector boundaries */
>           offset = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>           offset_end = QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> +        ret = blk_pwrite(pfl->blk, offset, pfl->storage + offset,
>                      offset_end - offset, 0);
> +	if (ret < 0) {
> +            error_report("Could not update PFLASH: %s", strerror(-ret));

Thanks for your patch. Note that it doesn't compile:

hw/block/pflash_cfi01.c:411:6: error: implicit declaration of function 
'error_report' [-Werror=implicit-function-declaration]
       error_report("Could not update PFLASH: %s", strerror(-ret));
       ^

Better than reporting the error is to set the error flag in the status 
register.

> +        }
>       }
>   }
>   
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 12f18d401a..fee5b3497c 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -393,13 +393,17 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>   static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
>   {
>       int offset_end;
> +    int ret;
>       if (pfl->blk) {
>           offset_end = offset + size;
>           /* widen to sector boundaries */
>           offset = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>           offset_end = QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> +        ret = blk_pwrite(pfl->blk, offset, pfl->storage + offset,
>                      offset_end - offset, 0);
> +	if (ret < 0) {
> +	    error_report("Could not update PFLASH: %s", strerror(-ret));
> +        }

Similar comments (does not compile, set error status register).

>       }
>   }
>   
> 


