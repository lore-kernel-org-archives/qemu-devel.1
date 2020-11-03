Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E8AC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4EB2080C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="T4qFOP+S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="U05t/zVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4EB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZt2V-000151-AG
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kZt0Y-0007N4-Vu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:53:43 -0500
Received: from relay2.mymailcheap.com ([217.182.113.132]:58065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kZt0W-0005vJ-7I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:53:42 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 04DF03ECDA;
 Tue,  3 Nov 2020 10:53:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 4BB5E2A0F9;
 Tue,  3 Nov 2020 04:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1604397215;
 bh=j3Cq75HMLZ8GbXz1cdvbXUiXdr/N4IwsSsV7Z1vbr6A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=T4qFOP+SB0dGqevTABGqNWJLdC7jOJDJ7jiwN2GkKHKyLvikJX9C2tE5GVYXrp+Rm
 KYraYWo1EqqTqWLAvCBuWRMPqIn9P72EsFL59YxmlFezY73T/FQtO+v0YczLuMWJ+J
 VBnCls3346sKf4k3lYiIYsKvu1IzXLRSSOqDxvrY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dRrUEQnvfQC; Tue,  3 Nov 2020 04:53:34 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Tue,  3 Nov 2020 04:53:33 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 9339140B53;
 Tue,  3 Nov 2020 09:53:32 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="U05t/zVF"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [113.52.132.214])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id C793C40B53;
 Tue,  3 Nov 2020 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1604397198;
 bh=j3Cq75HMLZ8GbXz1cdvbXUiXdr/N4IwsSsV7Z1vbr6A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=U05t/zVF26/iHb5a4ofr1fBzQglOJ9oAE+MazqAKXgiXvRJ1RMNZdolKP1PU7uTpJ
 ZMKWJOGlNTG9ZkB7BTV4NYuUsO2FOP7iu3mhbROnt0X1tGtQbDJuTtGxiPvU4V+rlT
 T/Ks1PjVr0Oi9XKTGK01RSd77An49Hayb2mwTmT8=
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: AlexChen <alex.chen@huawei.com>, chenhc@lemote.com
References: <5FA12391.8090400@huawei.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <ad70d1f3-ba98-3977-f2ac-a14d03c7e7ba@flygoat.com>
Date: Tue, 3 Nov 2020 17:53:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5FA12391.8090400@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9339140B53
X-Spamd-Result: default: False [2.90 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_XBL(3.00)[113.52.132.214:received];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_SPF_SOFTFAIL(0.00)[~all]; RCPT_COUNT_FIVE(0.00)[5];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.113.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay2.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:53:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhengchuan@huawei.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



ÔÚ 2020/11/3 17:32, AlexChen Ð´µÀ:
> According to the loongson spec
> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
> that the ISR size of per CORE is 8, so here we need to divide
> (addr - R_PERCORE_ISR(0)) by 8, not 4.
Hi Alex

Thanks!

That was my fault.. Per Core ISA is rarely used by kernel..

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
Btw:
How can you discover this by robot?
Huawei owns real artifical intelligence technology lol :-£©


- Jiaxun
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> ---
>   hw/intc/loongson_liointc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
> index 30fb375b72..fbbfb57ee9 100644
> --- a/hw/intc/loongson_liointc.c
> +++ b/hw/intc/loongson_liointc.c
> @@ -130,7 +130,7 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
>
>       if (addr >= R_PERCORE_ISR(0) &&
>           addr < R_PERCORE_ISR(NUM_CORES)) {
> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>           r = p->per_core_isr[core];
>           goto out;
>       }
> @@ -173,7 +173,7 @@ liointc_write(void *opaque, hwaddr addr,
>
>       if (addr >= R_PERCORE_ISR(0) &&
>           addr < R_PERCORE_ISR(NUM_CORES)) {
> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>           p->per_core_isr[core] = value;
>           goto out;
>       }

