Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209A1206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="S8bCx18P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="u7/Qad2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kMQ-0007jt-Ln
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k3kHa-0002Kg-Jm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:06:26 -0400
Received: from relay4.mymailcheap.com ([137.74.199.117]:46104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1k3kHY-0006j3-0B
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:06:26 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id A31583F1D0;
 Thu,  6 Aug 2020 20:06:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id D6FF22A3B8;
 Thu,  6 Aug 2020 14:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1596737178;
 bh=tygRSWLTZyPHUQMJTO9PPy0l1yqt/0tgvdgD+i80CgE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=S8bCx18PSzgosbQ+5vIxbO3kwnI8N7yglir0mP+nFWlVmZ2h0PijYE+yDCpVUdMw8
 +cAGh/5+X0irM4lCCH0uAwg/uN6ryzP+rc5IehIaD7A7fGliRQ2XkI/qTCkev6MPZd
 Wz7W4k70Rn0BJXcM7TRYEM84dlSF5G2omB0PB248=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oit9pm0lhWpt; Thu,  6 Aug 2020 14:06:16 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu,  6 Aug 2020 14:06:16 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id CDF1E41330;
 Thu,  6 Aug 2020 18:06:12 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="u7/Qad2z"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [203.86.239.91])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 54EC9419D2;
 Thu,  6 Aug 2020 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1596736903;
 bh=tygRSWLTZyPHUQMJTO9PPy0l1yqt/0tgvdgD+i80CgE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=u7/Qad2zO8TwrTDH3pOIq38ohPI12qlOVVmH6GMM9X3MhjMtTOF9UIHQKkBRKj/cC
 H/jLKBmzEvvFmOGF2B0A4Jzxjod9zcjeMrWCbHmHlOatakNtiLKLGvxy0kB5fRQd++
 2kgY+t9qu7yZrpE+SttmEyerwkbZXH2iw8YXZmUo=
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806122612.17167-1-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
Date: Fri, 7 Aug 2020 02:01:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806122612.17167-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: CDF1E41330
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 RCPT_COUNT_FIVE(0.00)[6];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,lemote.com,aurel32.net,syrmia.com];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=137.74.199.117;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay4.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 14:06:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
> Instead of ignoring the other cache operations, report them as
> unimplemented.

Hmm, I don't think we have anything to do with Invalidate/Writeback etc. 
opcodes
in QEMU. Why do we log this?

Thanks.

- Jiaxun

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/mips/op_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 9552b280e0..7f87e57c8e 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1583,6 +1583,8 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
>           /* Index Load Tag */
>           memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
>                                       MO_64, MEMTXATTRS_UNSPECIFIED);
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "cache %u\n", op);
>       }
>   #endif
>   }

