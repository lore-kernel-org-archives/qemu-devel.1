Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC0C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEE62068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA5bYEk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEE62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJeG-00089x-El
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieJce-000760-9F
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieJcb-0000eH-Dj
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:02:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieJcb-0000dz-AY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575900164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5d9jXrlFC7Yd4zt9Gpz+qI/lOWsodtPB15vXKla1o4=;
 b=hA5bYEk+NWaUpFFX0q9H9HLBlbMCDO7FPhk62wSoNTynRb3V8iUABSMNF85CSe/oP8N8B1
 3vgtxLBtfRCM3g9KWW0vPUZw0MxQuGFzSwvWfHvZ/IXENUGd8O7utFa4ms+IiYYdTZeyqv
 /5N3co+wS1zxD7IIvjk4BIhNhPx9ht4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-nanD4qDKM2-93pX2xiazmQ-1; Mon, 09 Dec 2019 09:02:42 -0500
Received: by mail-wm1-f72.google.com with SMTP id l13so3881084wmj.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 06:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q5d9jXrlFC7Yd4zt9Gpz+qI/lOWsodtPB15vXKla1o4=;
 b=BLIsmRMYIW8f8LNU3coVH4Fi4kjOv84dOCmS86wD4oxGy1qrjFGpF76IvS7qEjpCS1
 wqcXhQIvGPDMyP5Qnk1ojzZdeO+1xEll93kX8m/Cybe3HE1HEGU8O4zNhJFcWfgLN6on
 3flFLXavX0FeQwlSOTFXdA4GEI/lvhqgHwLaXPdIzzjbSBZyfljKqihGIRWKA4G8dBpB
 kQCyGe/fMvqh7zDgdDj7rlR/jW8NOZhjZpt05TM0SfoXusq5VZMlIbdz9KK6K1AwZlSY
 e0FmQuHkAhCJSNhULX1GZpTf5Zbk6c6V+nt+pR5cnCmR36IckI3go+wlyZxzEk9VCu+7
 htlg==
X-Gm-Message-State: APjAAAVgoVnsbjWu3OX/0q7g8yUmGwL1OBjtDnXf1RUJRDiyEUVLm+kk
 eMPaI94Qs8lV73o5glKgMVYvxtwn+a/dAhzj7vYQBkoOVfEXfWQwI3zimVPS+xmz/OyeTH1TmGT
 BDZRQ60Fwl/DocBA=
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2294615wra.36.1575900160926;
 Mon, 09 Dec 2019 06:02:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwR02stc6haswT3gP7pNOduTrh4yPe2ZFaUXV8Lv4h3wGtqM4VdsS2Q0+5JWrCGA5xTpun5cw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2294590wra.36.1575900160674;
 Mon, 09 Dec 2019 06:02:40 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id y20sm13399757wmi.25.2019.12.09.06.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 06:02:40 -0800 (PST)
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
Date: Mon, 9 Dec 2019 15:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: nanD4qDKM2-93pX2xiazmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 2:28 PM, Greg Kurz wrote:
> PPCVirtualHypervisor is an interface instance. It should never be
> dereferenced. Drop the dummy type definition for extra safety, which
> is the common practice with QOM interfaces.

This "common practice" is also referenced in commit 00ed3da9b5:

     xics: Minor fixes for XICSFabric interface

     Interface instances should never be directly dereferenced.  So, the 
common
     practice is to make them incomplete types to make sure no-one does 
that.
     XICSFrabric, however, had a dummy type which is less safe.

     We were also using OBJECT_CHECK() where we should have been using
     INTERFACE_CHECK().

This indeed follow the changes from commit aa1b35b975d8:

     qom: make interface types abstract

     Interfaces don't have instance, let's make the interface type really
     abstract to avoid confusion.

Now I can't find guidelines for this. If you don't know about it and use 
'git-grep', it is very confusing to see we use structures we never define.

Can we document this use please?

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   target/ppc/cpu.h |    4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e3e82327b723..ab7d07d66047 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1220,10 +1220,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
>   PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
>   PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
>   
> -struct PPCVirtualHypervisor {
> -    Object parent;
> -};
> -
>   struct PPCVirtualHypervisorClass {
>       InterfaceClass parent;
>       void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> 
> 


