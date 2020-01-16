Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050BC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6602072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hauw4yuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6602072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7Ao-00010A-98
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is7A1-0000U0-Dl
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is79x-0004w0-S5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:34:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is79w-0004v2-Vp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579188852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yn+hxows4B3iSehDfw5JI7Vw8hm2PIEHgcVjdPYCC48=;
 b=hauw4yuh9vd1qO0RNt5eiSn2oLCherHTJr3eX9KY6ZyJ0k7BH8ZJ2MPTlaR2s95Y/l6VUP
 gfawxevC6Ht5QbWBsIMe87wZzu3c0lxK9fD6XIIdZBV7G9byFwzUGw72WDNuUFyN+Msgkq
 Ec9SL/18pzHqZCICLD/XeayaffKherM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-7tQfD1kAN3GNfNGQ8apcYg-1; Thu, 16 Jan 2020 10:34:11 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so9348731wrx.22
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yn+hxows4B3iSehDfw5JI7Vw8hm2PIEHgcVjdPYCC48=;
 b=RJySi74jAHESqFPBB3GrNLsjPZ1DcFzveCXJp3oAKe0JAv6DQLIe4pUTo+CBqMKnIn
 nUYNkW1bAZwFK3go5TyRo3HaaPSyo3F5mmnEDYEJJzUOi9jPG94eek0ANmhlVoT8nYrC
 KRoYqPSB0kah6fyQzwM3vmKiWoNFFc0eQGt243Lk5NNtC0h6aQ5A7xfrjn8YS5Po/FJ6
 XiG/RgkFIz52KjX09+tunr97zgGCYITa/PNXne4b3KjLuLtxEgu1pKPT2ss+PrXoEuXw
 e5rftRyYvPcMR6S71reCknPJQTGo7MbvJ2TWUoz64V0tI4/5zgBhPfIINQLIq6rgguy/
 hi9A==
X-Gm-Message-State: APjAAAW9HPu2cz8c4uobyLubyrFdkFZuuAUfo+3VOcjaG8j0vFUg/HEJ
 1U7TY6xmE+Zwdxsb3frj980//5zWDjUNYv7brqJLfGJH6Mp0RtRRiLUrr9+/7R4eTWvnIA4LPMh
 Zs4OzRH1Slg3vZf4=
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3937647wrn.280.1579188849602; 
 Thu, 16 Jan 2020 07:34:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQyxsiB5YhQiMO1G4kEIKRfBtNwBlofwBSaUYCMecRCh+rJ/T+N87SYItcs/G+L1Xvi6LIgg==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3937624wrn.280.1579188849350; 
 Thu, 16 Jan 2020 07:34:09 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id d10sm30576874wrw.64.2020.01.16.07.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:34:08 -0800 (PST)
Subject: Re: [PATCH] spapr: Fail CAS if option vector table cannot be parsed
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
Date: Thu, 16 Jan 2020 16:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: 7tQfD1kAN3GNfNGQ8apcYg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 1/16/20 4:05 PM, Greg Kurz wrote:
> Most of the option vector helpers have assertions to check their
> arguments aren't null. The guest can provide an arbitrary address
> for the CAS structure that would result in such null arguments.
> Fail CAS with H_PARAMETER instead of aborting QEMU.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr_hcall.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 84e1612595bb..051869ae20ec 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1701,9 +1701,18 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>   
>       /* For the future use: here @ov_table points to the first option vector */
>       ov_table = addr;
> +    if (!ov_table) {
> +        return H_PARAMETER;
> +    }

This doesn't look right to check ov_table, I'd check addr directly instead:

-- >8 --
@@ -1679,12 +1679,16 @@ static target_ulong 
h_client_architecture_support(PowerPCCPU *cpu,

      cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, 
&local_err);
      if (local_err) {
          error_report_err(local_err);
          return H_HARDWARE;
      }
+    if (!addr) {
+        // error_report*()
+        return H_PARAMETER;
+    }

      /* Update CPUs */
      if (cpu->compat_pvr != cas_pvr) {
---

Still I'm not sure it makes sense, because the guest can also set other 
invalid addresses such addr=0x69.

>   
>       ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
> +    if (!ov1_guest) {
> +        return H_PARAMETER;
> +    }

This one is OK (unlikely case where vector 1 isn't present).

>       ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
> +    if (!ov5_guest) {
> +        return H_PARAMETER;
> +    }

This one is OK too (unlikely case where vector 5 isn't present).

>       if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>           error_report("guest requested hash and radix MMU, which is invalid.");
>           exit(EXIT_FAILURE);
> 
> 


