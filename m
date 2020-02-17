Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EA7C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483052064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8ogr/E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483052064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cg7-0005RP-AN
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cfR-0004ug-QQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cfQ-0003mm-Sf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:26:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cfQ-0003mN-OA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581931576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1Sx6Wz8mhn6ovU7IbwR8f1l2yu4PPCiq4jU3IODgJ0=;
 b=W8ogr/E/JjpVc6J+w7xyWYLsi+fYRPCyfS7Zx77vC/CVTedfdFZ73x278CjHI2cSW8kZMa
 xMhszOth+3heXwOd9pvvUdnJZ3EhG37QxAJ1ARbxDanSeojqutBKWDOMAYPPS7ci0Bd/eA
 tk+0Ee8cb0IyKTNEEi+t8666Qkd7hhU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-6FKayafWPLyzb1Vy8q4u2Q-1; Mon, 17 Feb 2020 04:26:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so8599319wrq.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S1Sx6Wz8mhn6ovU7IbwR8f1l2yu4PPCiq4jU3IODgJ0=;
 b=Kux17sVE4Cz+5KAWapX9ko1KyV8HKuqrSuc0ZDh7P6HNJgdOTxs/xyO92XA/dpDBpW
 2QUSu0DD+3OLwlRcqtW9BKhB2VJFURN6vJDHh0RHoVxNS9JvABGbqL8AWqaPwSuDJKze
 O4B1NaZP5foJN1gyScukyU68GNpocMEXfM2g5gMvdUFjVu0UWyTwminjtgjMHm7zyLma
 ndkYxO+Jmk+6fjvezP3KZpPHwT7JrYJtCaSuLuH6Oybxr4tt4C8/6kN0lFNbPrqxdKyw
 uE+92AfNiMNEkXFNGgNKpZdRVDWTOmvCkBm6+OIvZiJLpF9FxpvEHoug6tdOFHgfwdZ3
 asxQ==
X-Gm-Message-State: APjAAAUPEdBMzYbHcDk+X3hSCZhFRu1mCbJEBRVuyMiMiteHFwens+Lo
 b5UVGj0H9l1Pn2zViCWVFtVtHQa8ISSgTPcTh4f2arnp61OlGvZjzLLdpAImnFPq/qKQWatqH1e
 alDMxnVQijGHi5B4=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr22043049wrs.217.1581931573215; 
 Mon, 17 Feb 2020 01:26:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyj65GWdmmFOznBAObvLGugqWUcyq4WwB6MelFCTMjtQh6arDMM7t3rex6+Nk7B4Ag7pxKBjw==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr22043002wrs.217.1581931572844; 
 Mon, 17 Feb 2020 01:26:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r6sm27393wrq.92.2020.02.17.01.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 01:26:12 -0800 (PST)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
Date: Mon, 17 Feb 2020 10:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217021217.95766-1-aik@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: 6FKayafWPLyzb1Vy8q4u2Q-1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexey,

On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
> The following changes since commit 05943fb4ca41f626078014c0327781815c6584c5:
> 
>    ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +1100)
> 
> are available in the Git repository at:
> 
>    git@github.com:aik/qemu.git tags/qemu-slof-20200217
> 
> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac2:
> 
>    pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
> 
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>        pseries: Update SLOF firmware image
> 
>   pc-bios/README   |   2 +-
>   pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>   roms/SLOF        |   2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)

I only received the cover, not the patch, have you posted it?

I noticed on your repository you included a 'git shortlog' output in the 
commit description, thanks for that detail, much appreciated!

Regards,

Phil.


