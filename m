Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E8820739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="at/4bcdY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lhU/q1wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E8820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsFT6-0005JH-1i
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 20:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jsFS8-0004sp-O9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 20:57:49 -0400
Received: from relay2.mymailcheap.com ([217.182.113.132]:59331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jsFS4-0003yg-Ov
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 20:57:48 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 78DA93EDBF;
 Mon,  6 Jul 2020 02:57:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id A43512A352;
 Sun,  5 Jul 2020 20:57:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593997061;
 bh=NH/AWT+lrS2S1oz5+jfk/Rw5tTb8U7/FtX73idutGyw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=at/4bcdY8AnXfSrF67KfNamcD+7GVrcD16VwCFJxVuPWsYMBnRcCO7yTuNmGVrpXT
 wYdXxTMFKC08ckMYpdjna2nbDej0kfW2d6T9Cw+l3fz1bDWwfubee1sVU9Wlt54enu
 oGBKeSnM/M1UN6+fyGkkiRJUOlYRLNJ9tMgcGMKo=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rK9Fg7xJY5kY; Sun,  5 Jul 2020 20:57:40 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Sun,  5 Jul 2020 20:57:40 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 9E1DA4165E;
 Mon,  6 Jul 2020 00:57:37 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="lhU/q1wy"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (ec2-18-163-238-147.ap-east-1.compute.amazonaws.com
 [18.163.238.147])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7B2904165E;
 Mon,  6 Jul 2020 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1593997053;
 bh=NH/AWT+lrS2S1oz5+jfk/Rw5tTb8U7/FtX73idutGyw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lhU/q1wytOr3O+3LDgKyuQYOjbm0/RLu5JZLlNAol8zf9j8lrBa/IPUsoluQ/G04H
 nA/CcEYY89rBtuzDfzxBUSLcp2qfRv2ePygHd8UfCDfTu4bJuqWiX6vpUWu+2UnmKx
 bGhT6zFFOIv8wbDErbAXY6srncgrS8knv4WEAhuM=
Subject: Re: [PATCH v2 1/1] disas: mips: Add Loongson 2F disassembler
To: Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
 <20200703104409.6986-2-stefan.brankovic@syrmia.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <ecc36507-f08d-990c-a792-8e926762f09e@flygoat.com>
Date: Mon, 6 Jul 2020 08:57:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703104409.6986-2-stefan.brankovic@syrmia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E1DA4165E
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_SEVEN(0.00)[7];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,syrmia.com,lemote.com,redhat.com];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.113.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay2.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 20:57:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 stefan.brankovic@syrmia.com, aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/7/3 18:44, Stefan Brankovic 写道:
> Add disassembler for Loongson 2F instruction set.
>
> Testing is done by comparing qemu disassembly output, obtained by
> using -d in_asm command line option, with appropriate objdump output.
>
> This disassembler is written as a generic disassembler that can be
> integrated into other projects. In this case, it is integrated into
> QEMU. One of initial key requirements was that it uses C++ as its
> language.
>
> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>

Hi Stefan,

A biref review on the instruction format among some simple test show that
it's working as expected.

Good job!

But I'd agree with Aleksandar's idea, this patch still needs some polishing
on code-style.

Thanks.

> ---
>   MAINTAINERS             |    1 +
>   configure               |    1 +
>   disas/Makefile.objs     |    1 +
>   disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++
>   disas/loongson2f.h      | 2562 ++++++++++++
>   include/disas/dis-asm.h |    1 +
>   include/exec/poison.h   |    1 +
>   target/mips/cpu.c       |    4 +
>   8 files changed, 10725 insertions(+)
>   create mode 100644 disas/loongson2f.cpp
>   create mode 100644 disas/loongson2f.h
>

