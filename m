Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2FC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA1520656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv963tQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA1520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WmU-0001zN-NT
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Wlc-00016p-0C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6WlY-0001dg-HG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:44:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6WlY-0001dN-CY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582623876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnSnCf77cP3jtgdk2KT6BnmYVBo/sB+FVKJkMdJbm9o=;
 b=Vv963tQh0zI6Bexc98ZCclB5VLxDhu4f+nQJpL5CosnR6VhVMPJZcjFLreDLtJE9o3Pp5n
 yU1KbU7HVZ1r6xGoOkkMgaY6Jft3Jc+Vk/Vcg0kiPaet6UacdADhxLBjBu+qLwj1GMtq25
 k6n9Q6GOdF0wHui292ea/q72G9zORcM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Xc7mOuJuMYaDgB8_FJuRow-1; Tue, 25 Feb 2020 04:44:34 -0500
X-MC-Unique: Xc7mOuJuMYaDgB8_FJuRow-1
Received: by mail-ed1-f69.google.com with SMTP id d21so8711992edy.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SnSnCf77cP3jtgdk2KT6BnmYVBo/sB+FVKJkMdJbm9o=;
 b=VZ6eGtFQkeLSbMH8x0r0YNfIGe8MgvB3I2UveEM5Ori3+Zd3WjKnGnOTwdwCyaKdja
 6qIRbeg+RnQGNbcvm/nvM2nlF8v4ahNitnK/YC+tpruWcPEA+IKOn/vWqrmV2u9oOlHd
 ftmXXRXNOr32DumKEACW9Yz4rNoqnjN+n+saE2/lgkOMwPxcjPVhQUyDK5mB4+repyk7
 elhEENBaIyutw0aNE54YYp5f+7FqyF9eeFPPETVfGH4wrGhGfybpgRfZbfMgSwn+2O3m
 RA3Gc027mxcvK98urwkkGPEPdNNMamccPcImXigaJreJAnKiCvPlG4izKK3Vb5HJDQtP
 gEtQ==
X-Gm-Message-State: APjAAAXu2fs5dAGzDvtgp0lOk8SwrFe+DoniqfsXH5miCMueJoTO1/PO
 Soa6zbff316mz+Dp7wX/dD/8yF9LNHy8GIBogesBSBJOvnzk/R87YJMNM+USRUaS1eaPIe5EDpB
 JAMZGZR1/CT2g1QA=
X-Received: by 2002:a17:906:af66:: with SMTP id
 os6mr52289538ejb.87.1582623873233; 
 Tue, 25 Feb 2020 01:44:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1j3qmMGbEn0DBqhR0XHQr3EK4UGnbl98vBHWK24uCtlqz/KmUdpC+scgj86+1Nf8ao0vnng==
X-Received: by 2002:a17:906:af66:: with SMTP id
 os6mr52289516ejb.87.1582623872951; 
 Tue, 25 Feb 2020 01:44:32 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q8sm92773edc.59.2020.02.25.01.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:44:32 -0800 (PST)
Subject: Re: [PATCH 13/13] monitor/hmp-cmds: Remove redundant statement in
 hmp_rocker_of_dpa_groups()
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
 <20200225020937.25028-14-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f4c5308-4a6f-fe1f-3832-f1c762b4c4c2@redhat.com>
Date: Tue, 25 Feb 2020 10:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225020937.25028-14-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 3:09 AM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> Clang static code analyzer show warning:
> monitor/hmp-cmds.c:2867:17: warning: Value stored to 'set' is never read
>                  set = true;
>                  ^     ~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> ---
>   monitor/hmp-cmds.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 53bc3f76c4..84f94647cd 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -2864,7 +2864,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict)
>   
>           if (group->has_set_eth_dst) {
>               if (!set) {
> -                set = true;
>                   monitor_printf(mon, " set");
>               }
>               monitor_printf(mon, " dst %s", group->set_eth_dst);
> 

Can you move the 'set' declaration to the for() statement and also 
remove the last "set = false;"?


