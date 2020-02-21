Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A11C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E01A24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWfCEG+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01A24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j57VM-0000uU-Mw
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j57Uo-0000SX-6P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j57Ul-0007yy-KK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:33:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j57Ul-0007xo-Bp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582288405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwtQ0LjF1BRP/QoTuIcSLbiZ0CgMfP2udOucfLPN3eE=;
 b=fWfCEG+QvOKidyVHYHMcTNPUdrsGKMJg8JLZre65WYVhERaqyKos2Pvt+X6cZDNKwki8AF
 icN4Gef0cvmuYvqUXrSJgZKUvJhItlVgE8Yr19utWEIprI3rqTWhO/gBIaggyGyEIXP/Ee
 OtqG2i+4x6r3cqQr/ZqdV79BrHfD7BU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-3R-R7E32OouktDemBNk6JQ-1; Fri, 21 Feb 2020 07:33:20 -0500
X-MC-Unique: 3R-R7E32OouktDemBNk6JQ-1
Received: by mail-wr1-f71.google.com with SMTP id l1so970827wrt.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 04:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YwtQ0LjF1BRP/QoTuIcSLbiZ0CgMfP2udOucfLPN3eE=;
 b=sghLifVzkIWI72Er99+jCgTFRavJztW6FDKm/nVe/4jCug+0kopLS5soAArKqB4vY+
 enWPhUpm2xmyZDcktuit3u5wtsHgC+5t2EcCe1M+2r8cuAMz7TRa3XF1W3x/e53h7RmD
 4+9oK+6Pbe4dwJ5882Cjk17wVuqyVEzaNWLFTRcqDZNKSsZGjt+tY4UnwxMrqMJWbjrg
 Ze5GTa7oHbr5u0XzRdQcHZZwG1ITmCEetum+GvvQJQRMc/gJyF5hy1LyNN1LVHPVidMy
 FBdxtmzeuOj10dR3a29NfKqTKXDqwJTh0Lb0e3rsGpYSvqlOBuvioCMZ7zZJa3m8M0sG
 XObA==
X-Gm-Message-State: APjAAAV9iAyHcG0pslxhFugLCCOgkPhZ8hBhdV84ViC95f4vW2OZZDud
 j2hiqBjcg0OQhjRDrO53xIvT7tlST9xxMhj/p/ZdUini0BG2bZ5xpD/y9P7CMoeUfQuCt3m5cAY
 Hozi18xyh3p1OC3o=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr47984603wrp.321.1582288398964; 
 Fri, 21 Feb 2020 04:33:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYHUQi9AKVcV16I8YcHMApWsux9UX66bCSc8RvPgaxTwiP/qhALIEWyRR8SoVHv0YSgfbOTg==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr47984575wrp.321.1582288398677; 
 Fri, 21 Feb 2020 04:33:18 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t10sm3437039wmi.40.2020.02.21.04.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 04:33:18 -0800 (PST)
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: Changbin Du <changbin.du@gmail.com>, Luc Michel <luc.michel@greensocs.com>
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
 <20200221115104.x3af4cfjin553jun@mail.google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d50a811f-ea55-c6cb-f144-8279b2867c72@redhat.com>
Date: Fri, 21 Feb 2020 13:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221115104.x3af4cfjin553jun@mail.google.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 12:51 PM, Changbin Du wrote:
> On Thu, Feb 20, 2020 at 10:24:37PM +0100, Luc Michel wrote:
>> I'm curious, I never experienced this behaviour from GDB. What GDB and
>> QEMU versions are you using?
>>
>> On my side (GDB 9.1), even without 'vContSupported+' in the 'qSupported'
>> answer, GDB sends a 'vCont?' packet on the first stepi:
>>
>> 0x00000000 in ?? ()
>> (gdb) si
>> Sending packet: $m0,4#fd...Ack
>> Packet received: 00000000
>> Sending packet: $vCont?#49...Ack
>> Packet received: vCont;c;C;s;S
>> Packet vCont (verbose-resume) is supported
>> Sending packet: $vCont;s:p1.1;c:p1.-1#f7...Ack
>> Packet received: T05thread:p01.01;
>>
>> Your second issue (wrong PC value) should be investigated though. Does
>> it happen on QEMU vanilla? Do you have a way to reproduce this bug?
>>
> Just confirmed this issue. This is an endianness problem for gdb. I was
> debugging an big-endian elf and my host cpu is little-endian. QEMU gdbstub
> always uses host cpu endian but gdb client treats it as big-endian by
> inspecting elf info.

I'm using Debian gdb-multiarch, and indeed use cross-endianess (I always 
set arch/endian explicitly). This might be why I hit this too.

> 
> I can mannually set it to little-endian but it is painful. The gdb complains
> abount invalid opcode error in debuginfo.
> 
> I also noticed that someoneelse has already tried to resolve this issue.
> https://patchwork.kernel.org/patch/9528947/
> 
>> Anyway after re-reading the GDB remote protocol documentation, I think
>> your patch is right, the feature should be advertised.
>>
>> However I think your commit message needs some modifications. This fix
>> is not specific to ARM or TCG, but to the gdbstub itself. You also
>> mention this bug you have with PC, which is not related to the bug you
>> are fixing here. Could you rewrite it in a more generic way? You simply
>> need to emphasis the effect of advertising the 'vContSupported+' feature
>> on GDB.
>>
>> Thanks.
>>
>> -- 
>> Luc
> 


