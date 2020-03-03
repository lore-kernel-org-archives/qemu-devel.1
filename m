Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 23:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B322072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 23:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igHDifEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B322072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9HBb-0004GH-6H
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 18:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9HAn-0003al-GU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9HAl-0006Wb-IS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:42:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9HAl-0006Vk-8d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583278918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gK22+5lDsvE9EJC6leYT5lwhaxnAtRzOaEtP2fdoCXg=;
 b=igHDifExpksli8Rv8r46Z8CkGF5b2UPSvCYdhsylUwO3XUDVLCGUphskoyYuHHeHx35lYF
 JgGUrodNf70u4SFLMsxr33liiscjTyP4APTtjmRHC335ID7PItnaa/SdGuBkS8/iCTcM1m
 GJAiht5VW0BQwLBqgNXNiwg/ASrn5Ws=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-cerbOw88PASJInWaQoG8cg-1; Tue, 03 Mar 2020 18:41:54 -0500
X-MC-Unique: cerbOw88PASJInWaQoG8cg-1
Received: by mail-wm1-f70.google.com with SMTP id r19so108824wmh.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 15:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gK22+5lDsvE9EJC6leYT5lwhaxnAtRzOaEtP2fdoCXg=;
 b=JPc9mxPOc0wxCbXcB3+WINi+Qj0JjbSVREylsUCiyoEO7udmqLVhTgEpkWgebcj+WN
 dE3B5PcpHhjPJIBsDXEhMaHY1+sNEkYLyf8nYNQrqtrpVCjDT8aBclnOuqb44VMdb/50
 UphxVSlN7EUZBDv7/5GCF6qbUNHrLGoBuJdVCniRcAkOlGpgKGAdLMnoRkX6jyWO8bwT
 FqiI75yCvC2WfkyLPis33UAGj+47jbJNIhjEKFks/ZbLMdGNrPUvMMUHSqtcyOIXdFFy
 JTDrskE/MFXs25o/JermGAI2NKv4TZdvwafyNPjuacimMV2ZNWQM45X4uHczU/7zs6va
 n8Lg==
X-Gm-Message-State: ANhLgQ1Dq7R9SsuZYTXK78+1X1/ZKAb3rjPHfq4UcFBgomLqpuoTTPYM
 GRlQrtqXD492jEWGjoYnE/k565dDTC1X/9rVwDdxa/9BqzXcSBBFOLalpC+zc7yk4dY0V6O3f7r
 MnyPCzyE+bhM5dTA=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr452112wrw.6.1583278913516;
 Tue, 03 Mar 2020 15:41:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtwiBSWqNziveWkRBVTGBGkpVoc4Zd8MNfg1xNP4SbDQp6D9UmEEMHi4k2w/zzA+n674zM41A==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr452092wrw.6.1583278913228;
 Tue, 03 Mar 2020 15:41:53 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p1sm2186608wrf.82.2020.03.03.15.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 15:41:52 -0800 (PST)
Subject: Re: [PATCH] Fixed integer overflow in e1000e
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200303182925.39419-1-andrew@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51cc9068-1ff5-a42a-dab5-788bf495f6d7@redhat.com>
Date: Wed, 4 Mar 2020 00:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303182925.39419-1-andrew@daynix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Jason Wang <jasowang@redhat.com>, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

Please Cc all the maintainers:

   ./scripts/get_maintainer.pl -f hw/net/e1000e.c
   Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:e1000e)
   Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)
   qemu-devel@nongnu.org (open list:All patches CC here)

On 3/3/20 7:29 PM, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1737400

The BZ backtrace lists e1000e_tx_pkt_send() which you fixes,
but you also fixes e1000e_start_recv(). Good.

Please include the BZ backtrace.

> Fixed setting max_queue_num if there are no peers in NICConf. qemu_new_nic() creates NICState with 1 NetClientState(index 0) without peers, set max_queue_num to 0 - It prevents undefined behavior and possible crashes, especially during pcie hotplug.
> 

Please add:

Cc: qemu-stable@nongnu.org
Fixes: 6f3fbe4ed06
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1737400

> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index a91dbdca3c..f2cc1552c5 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
>       s->nic = qemu_new_nic(&net_e1000e_info, &s->conf,
>           object_get_typename(OBJECT(s)), dev->id, s);
>   
> -    s->core.max_queue_num = s->conf.peers.queues - 1;
> +    s->core.max_queue_num = s->conf.peers.queues ? s->conf.peers.queues - 1 : 0;
>   
>       trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
>       memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac));
> 


