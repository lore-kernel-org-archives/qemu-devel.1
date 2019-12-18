Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C9A2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFJniQKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C9A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfMO-0005F5-TX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1ihfLO-0004ef-AH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1ihfLN-0005Q0-2b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:50:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1ihfLK-000571-AM; Wed, 18 Dec 2019 14:50:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so3572141wro.9;
 Wed, 18 Dec 2019 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=IpZCed3Z6EscQnpsDfxPN13qvLHAnUW41C9UkoTf4aQ=;
 b=cFJniQKJ3eOC47ZPSIvre61jGvSaWxAEyTVsvkt+UkjjrF3YLGKz6WvkK504AX6/50
 kSd/aEyYYJPsBioBcxqpqUxQUNDL/XZ60kqn57bpcjpFNuADpYZmcLOS7uojCI/B6QnL
 UPSIDhIG3ETTlB/0pXksbxH5BAtT8Oa4ywjtnyomXhwYLYbYuur0Fpvs0mgQGo7qrf81
 ToYqJwyTI6ma0iX0A1wrImLRrEoLGj5cqX4WWJOLgJAm3kmtJr3LhZetpfuU0zpiBKT3
 fg9pgy2a9VydxyAkFvF690xd6PkLjF77IKeHFVvSk+bPe4LVlkhhAIBp2R6vb9SXP5TT
 0olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IpZCed3Z6EscQnpsDfxPN13qvLHAnUW41C9UkoTf4aQ=;
 b=UeDM6ABElah5Tebq/vUWja8qeX98VRvUEXxWyGxYloA8zpWPtH2ZDTdzDbHqiB3IBZ
 evGI3T/JR4b8xpErRVjq3b5ZU+AOmzQANCrzgRbf+25yQUVjVyhXks90hep9M9b3jo5C
 s3GKThAl0pVsIRvGHfC4B8AjFDjA7gfHP1rsslzkW9vWDBzL5b1YBtDwGTTsUlT+toOL
 yw/ftMnHyKR76MFdkqscY9/x6PdLk2zt3rV7wyafBkTD8dpojLOAdDuDzvh6Bhbbdb8j
 eZN8DdGzu3FBV9WogWyCGTE/W6d620IzGZGO/FshtwSgkWBaf7vEC0seD89DozXlEwzp
 yw9A==
X-Gm-Message-State: APjAAAV02e8/uyL6Xj7WZkdxVIf9bDzLhOqVIT6Cs6x9pZtXaMpVzZ8V
 gFSM+dm4EjP3tCi2mEcvT2AMKATD
X-Google-Smtp-Source: APXvYqyPCUUQg6tEGxYpIAgVHAioOtmuED4tBExk98veqHVcQu2oLqARQHMLTtOpCYfjfjeRW7MKyA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr4710186wrp.292.1576698643876; 
 Wed, 18 Dec 2019 11:50:43 -0800 (PST)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id h17sm3814160wrs.18.2019.12.18.11.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:50:43 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Update Yuval Shaia's email address
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20191126102637.2038-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <df5ed556-f636-0d8e-5882-89560e90e884@gmail.com>
Date: Wed, 18 Dec 2019 21:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126102637.2038-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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



On 11/26/19 12:26 PM, Yuval Shaia wrote:
> Use gmail account for maintainer tasks.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..4297b54fcb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2640,7 +2640,7 @@ F: tests/test-replication.c
>   F: docs/block-replication.txt
>   
>   PVRDMA
> -M: Yuval Shaia <yuval.shaia@oracle.com>
> +M: Yuval Shaia <yuval.shaia.ml@gmail.com>
>   M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>   S: Maintained
>   F: hw/rdma/*

Hi,

Can someone grab this patch ?

Thanks,
Marcel


