Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1038C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A95820730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYTKZ05U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A95820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytc9-000747-Mz
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iytbF-0006Wm-AZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iytbC-0001kG-1k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:30:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iytbB-0001cO-Pz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580805020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0uLEQrzB6ntki5PcUAW9CpQiUejHzhvQgZdb9aKa/o=;
 b=EYTKZ05UFM+fcQMh8Ya0ljnj1kJCkbD4JLnlREa666fs5cNvJlRe/WrI5Yzov0JV2YAJzq
 bWAAVaFNwjz53pUzzZfL6UBBfSJDkumW24tnziNM5laE+EzOgAVR/6osvIJC1fBQBIvYdx
 eGxmYrjAdRS0jFxda4VVNDIpGU+uUOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-tKx0-27oPLmd8dDMSbyoVA-1; Tue, 04 Feb 2020 03:30:19 -0500
Received: by mail-wm1-f71.google.com with SMTP id g26so1005329wmk.6
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 00:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/0uLEQrzB6ntki5PcUAW9CpQiUejHzhvQgZdb9aKa/o=;
 b=A+62gfwbO4rajtMatkni0CAkUK+XTzDcDbXESf00ad8ItNyBIVLjGCvxHEm0cWCHSD
 Q46Eok5uIk5Ue3MCZK2cB4DKK3+FuhbVXWthxSfiuM7aw0tnOofVGIFO0MnWz8NyCYxq
 ddFOP+QpOBVgF0g+lslN0NAGJegqQM+joIlaSPS1/vIuLzuYYayEOzvYV6/zzKSTRZkr
 kT7cCdEvPDnzR+ig9G6LNXJqOvFi2A9DH1+/JBkSE+qZfSsV1PoNRtRiEDzRJwyKDpZD
 VMDnqnGS9lK+rZA9CipBognOSeucWQG4EoTLRa7eV/7vNbJj+tK2ZxSAI21kMX4G0Fi4
 u4/w==
X-Gm-Message-State: APjAAAXVRu34Lwl5GPSSUByW8O3Pwx7INAm06tNLU8Fpqs5ExJOo4pSC
 ppUxSguSHYXac9LyuGvifLxPYiXLNUU/B7D7pw23M7a0gltwF3rL8OAwxFbHEyu0AUOg/ozSBhd
 IGyq1OgmsguLcX1c=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3937529wmi.112.1580805018095; 
 Tue, 04 Feb 2020 00:30:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqytLggFZA9a97emJNFVdU2mujdvWl0Wp+0tpfZsTv25oW4DmfzLNFe+N3QoB+gMKpcJDvkI6Q==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3937487wmi.112.1580805017763; 
 Tue, 04 Feb 2020 00:30:17 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id o189sm2889984wme.1.2020.02.04.00.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 00:30:17 -0800 (PST)
Subject: Re: [PULL 3/3] target/mips: Separate FPU-related helpers into their
 own file
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
References: <764d-5e392600-1-7d355c00@99977617>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88648c41-8825-6063-acb3-9f27f07c011e@redhat.com>
Date: Tue, 4 Feb 2020 09:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <764d-5e392600-1-7d355c00@99977617>
Content-Language: en-US
X-MC-Unique: tKx0-27oPLmd8dDMSbyoVA-1
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 9:06 AM, Aleksandar Markovic wrote:
>  > > For clarity and easier maintenence, create 
> target/mips/fpu_helper.c, and
>  > > move all FPU-related content form target/mips/op_helper.c to that file.
>  > >
>  > > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>  > > Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>  > > Message-Id: 
> <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
>  > > ---
>  > > target/mips/Makefile.objs | 2 +-
>  > > target/mips/fpu_helper.c | 1911 
> +++++++++++++++++++++++++++++++++++++++++++++
>  > > target/mips/op_helper.c | 1877 
> --------------------------------------------
>  > > 3 files changed, 1912 insertions(+), 1878 deletions(-)
>  > > create mode 100644 target/mips/fpu_helper.c
>  > >
>  > > diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
>  > > index 3ca2bde..91eb691 100644
>  > > --- a/target/mips/Makefile.objs
>  > > +++ b/target/mips/Makefile.objs
>  > > @@ -1,5 +1,5 @@
>  > > obj-y += translate.o cpu.o gdbstub.o helper.o
>  > > -obj-y += op_helper.o cp0_helper.o
>  > > +obj-y += op_helper.o cp0_helper.o fpu_helper.o
>  > > obj-y += dsp_helper.o lmi_helper.o msa_helper.o
>  > > obj-$(CONFIG_SOFTMMU) += mips-semi.o
>  > > obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
>  > > diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
>  > > new file mode 100644
>  > > index 0000000..0d5769e
>  > > --- /dev/null
>  > > +++ b/target/mips/fpu_helper.c
>  > > @@ -0,0 +1,1911 @@
>  > > +/*
>  > > + * Helpers for emulation of CP0-related MIPS instructions.
>  >
>  > Isn't it "FPU"?
>  >
> 
> Damn, I did the change, but forgot to do "commit --amend", and that 
> passed unnoticed during the rest of procedure.
> 
> I just sent PULL v2.

This was not a big deal, we could have updated the comment with another 
patch. I was just wondering. Thanks for caring to send a quick v2!


