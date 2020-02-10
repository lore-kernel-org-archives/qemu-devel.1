Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AABC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D6D20838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6JCMC71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D6D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1AUq-0003bN-8A
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 09:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ATr-0002y2-0O
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ATp-00059m-SU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:56:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ATp-00058q-Ni
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581346569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCynNpJZ12JMhECWRB0qk0TNkQMf9R4/mQ6YvtcOWt4=;
 b=Q6JCMC71PueZ7/fkpqH+L618lEU5jJYic7u3vVUvvZHp+f+w0lQdpSbeAuufpdefVn7GGJ
 4y0a5FKujmS04fRLIHanqLMHdmkvCLUgBzS6XGN1oRR7BvmYJxYbUooGnvHbHi+KhJrSiy
 gED8Y+PyRK4S9oh9bCMyPyFdSHEtIn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-petSFY9_PP2h-RuDw0Yjyg-1; Mon, 10 Feb 2020 09:56:07 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so3291404wmi.7
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 06:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mCynNpJZ12JMhECWRB0qk0TNkQMf9R4/mQ6YvtcOWt4=;
 b=iqe1Ow9q3zsZRd+NgW8lUOSmGL/wNhsyA8+QLC2DAZHgzQPQJkjMPLnHKcv8gxTl97
 +wln6nOmRkcW9aqd40wNiLaRgBv0oAQuqrxxBjoQJ2wDvOqcQF2BxxdiG0N8tinuvr+t
 8pKOOURZUYQ3WKxZIUQkl5oN9uToL15yR6R5zJoQqeXFk5YSw9Ao3ME2haGVsaAEX8NC
 wvCii7clvnWvp8J0KbpuzcfDMobL3r3HRnEetTASm2qz1EJAoGUbSAd7b6slH9BJACNI
 C5QV0tLhhXAgdo3w4HBRc1xeV4HdVi19yE9QXZ6T+L2jQnZeiDDzkSfrJ/Pt3OtKc08Q
 ByfQ==
X-Gm-Message-State: APjAAAVX4XwJtHObx86WeYsE2uhmkGqjI1nJT2dS+Niq84sZu8jZoUT+
 VbBoeYnhuiFCnNTbxG2je8yTBavG7AniQ+O0eL/lOhg3OamXdf5XmjDtubqpnKqRlnOCxbq3Pbs
 uR8xtamy1k4tlWlI=
X-Received: by 2002:a5d:6089:: with SMTP id w9mr2312353wrt.94.1581346565707;
 Mon, 10 Feb 2020 06:56:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbmZA/FGIdlm5fzAdDXMQ6PiZXS+5nRzNVOEMSQcyb9uCfre3wFt496NsG6AMHpAcHcDEkDw==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr2312333wrt.94.1581346565498;
 Mon, 10 Feb 2020 06:56:05 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n10sm943880wrt.14.2020.02.10.06.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 06:56:05 -0800 (PST)
Subject: Re: [PATCH] q800: fix coverity warning CID 1412799
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200210132252.381343-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b2dd523-7420-97a1-2223-15bba139ce7a@redhat.com>
Date: Mon, 10 Feb 2020 15:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210132252.381343-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: petSFY9_PP2h-RuDw0Yjyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 2:22 PM, Laurent Vivier wrote:
> Check the return value of blk_write() and log an error if any
> 

Fixes: Coverity CID 1412799 (Error handling issues)

> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/misc/mac_via.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index b7d0012794..81343301b1 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -30,6 +30,7 @@
>   #include "hw/qdev-properties.h"
>   #include "sysemu/block-backend.h"
>   #include "trace.h"
> +#include "qemu/log.h"
>   
>   /*
>    * VIAs: There are two in every machine,
> @@ -381,8 +382,10 @@ static void via2_irq_request(void *opaque, int irq, int level)
>   static void pram_update(MacVIAState *m)
>   {
>       if (m->blk) {
> -        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
> -                   sizeof(m->mos6522_via1.PRAM), 0);
> +        if (blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
> +                       sizeof(m->mos6522_via1.PRAM), 0) < 0) {
> +            qemu_log("pram_update: cannot write to file\n");
> +        }
>       }
>   }
>   
> 


