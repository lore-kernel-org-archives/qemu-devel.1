Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B86C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C254C20838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIu9pLSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C254C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeQu-0001eb-1X
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeQD-0001G4-Vx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeQC-0003hM-NV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:18:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeQC-0003gx-Jv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580746680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GR/rGBh0+nNfBpLAW5jhrYVMZqL0xLO1XW2huKobivI=;
 b=AIu9pLSpqehKHBkqKN8mLZzZqcWUeLVCuInqDOujUWrScb/rFrFsWpyf9qm8Blsqgk30Rx
 0ZttW7+7TGEg/6ARPCIIbCQv+XPKaKVjYRlwqLwMAZg8g9dmdvoD0INgiWH6UrX2Lgny6c
 EQRLV1HI3Kz4hcu2Pa8b9J7dy8yOpIo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-zaK1opYnO_K8hLsLOFcGSw-1; Mon, 03 Feb 2020 11:17:44 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so4224101wma.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GR/rGBh0+nNfBpLAW5jhrYVMZqL0xLO1XW2huKobivI=;
 b=Clturt70nvMFIlB+ZdCBLSl9oGZnz1Nvnfa6bH3Z8FsEIU0iN82+z55jMAtNurrsXo
 7ZrdZfcdbezqkfa6H8fzkTFU2iC4VmfVmPWSi4zh/EfZkxpUQc1PWqfOmK7ywR8wqOL7
 UjztvBWUzAREgI3E5gWxnP9pz99nXvHKQeb2pBukBS+IKSvvGmVw1LXk9iMLZvt4zEls
 OcKyTt5G9ArcehVE48UXEaQ07a0Yjrhs7uLLCNk+7V0U0rAWbG0Dcu9bnFFklt/+rilO
 JtYRfi/VeJzBCQ7dXnRNXZnidPMa2LLgEh2qMpVSedp68dcuqZTWQCO43BvokGKMX7I8
 EbYA==
X-Gm-Message-State: APjAAAUZS6A8MlZYJiPE+gf3k9P5AFpjvUST+EI4Ker9gqQ93AXMhapU
 dRZ7r9cxeoFVHQwEWTacwrzS+8wiq9IVaI1wHu0uP9YEogjry0czt6JYtVhtgCycRM6yoHtx+/i
 XiEDaevj1uEG2HaA=
X-Received: by 2002:a1c:bb82:: with SMTP id
 l124mr26394796wmf.176.1580746663065; 
 Mon, 03 Feb 2020 08:17:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzL+2VMbVqK/x+9bPeze3zyXLZsBLrsQ9fRqHP1udSX6zJknr/gyuZyfozH8ZqW/0+FL3Z+dw==
X-Received: by 2002:a1c:bb82:: with SMTP id
 l124mr26394736wmf.176.1580746662070; 
 Mon, 03 Feb 2020 08:17:42 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id a5sm24003986wmb.37.2020.02.03.08.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:17:41 -0800 (PST)
Subject: Re: [PATCH 2/2] target mips: Separate FPU-related helpers into their
 own file
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580745443-24650-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc4b3b75-8ad4-3205-1ea2-dd0577a879c0@redhat.com>
Date: Mon, 3 Feb 2020 17:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: zaK1opYnO_K8hLsLOFcGSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: aleksandar.rikalo@rt-rk.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 4:57 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> For clarity and easier maintenence, create target/mips/fpu_helper.c, and
> move all fpu-related content form target/mips/op_helper.c to that file.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/Makefile.objs |    2 +-
>   target/mips/fpu_helper.c  | 1911 +++++++++++++++++++++++++++++++++++++++++++++
>   target/mips/op_helper.c   | 1877 --------------------------------------------
>   3 files changed, 1912 insertions(+), 1878 deletions(-)
>   create mode 100644 target/mips/fpu_helper.c
> 
> diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
> index 3ca2bde..91eb691 100644
> --- a/target/mips/Makefile.objs
> +++ b/target/mips/Makefile.objs
> @@ -1,5 +1,5 @@
>   obj-y += translate.o cpu.o gdbstub.o helper.o
> -obj-y += op_helper.o cp0_helper.o
> +obj-y += op_helper.o cp0_helper.o fpu_helper.o
>   obj-y += dsp_helper.o lmi_helper.o msa_helper.o
>   obj-$(CONFIG_SOFTMMU) += mips-semi.o
>   obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> new file mode 100644
> index 0000000..0d5769e
> --- /dev/null
> +++ b/target/mips/fpu_helper.c
> @@ -0,0 +1,1911 @@
> +/*
> + *  Helpers for emulation of CP0-related MIPS instructions.

"FPU-related"? (no need to repost).

> + *
> + *  Copyright (C) 2004-2005  Jocelyn Mayer
> + *  Copyright (C) 2020  Wave Computing, Inc.
> + *  Copyright (C) 2020  Aleksandar Markovic <amarkovic@wavecomp.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */


