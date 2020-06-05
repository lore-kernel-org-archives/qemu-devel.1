Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13105C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCBE2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="RIwYDM1A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hGOsRDZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCBE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8JT-0001iz-5n
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jh8Ir-0001HF-AW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:06:17 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132]:35093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jh8In-0006vJ-T6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:06:16 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 3A4653F1C5;
 Fri,  5 Jun 2020 05:06:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 18D142A39E;
 Fri,  5 Jun 2020 05:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1591347971;
 bh=nfpeJWIuoOXJN/cD19Pht+CN5fULAH3X3eYQ5N+5pD4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RIwYDM1AZnU6dF0h5zsbMczx9NKzvqrTQ/Tw+0SYpSBaGglFFWPewI261uQTyoHvX
 F4pOGXbg4q5r2InL7WrtZfjPLd5+8AGYBtulAgT0qVCRvpg6A74TDacGvY+qMOmPvJ
 gqhT+7PoUg+pcfcAb3H0tEf1cKCyg+rTkhA6wfwE=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_ec6TqiOujG; Fri,  5 Jun 2020 05:06:09 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Fri,  5 Jun 2020 05:06:09 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id EF68840FC0;
 Fri,  5 Jun 2020 09:06:06 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="hGOsRDZk"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost (unknown [60.177.191.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3C463403D9;
 Fri,  5 Jun 2020 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1591347955;
 bh=nfpeJWIuoOXJN/cD19Pht+CN5fULAH3X3eYQ5N+5pD4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hGOsRDZk8Bu2RSoknllcSFJpcyHbQydY/KOITYDk1Qyi2Bsf5mno5d0Nz1yPGuCZg
 q3dT9KuN42o8IbAOSmxHkdzHTKkSlokdrcuq9StOB6sXCVZfmWaIarNwuLP+rcBfek
 2HkzmtNlq0oVXKOMO3qbTStQys1oVwauoRHI4TSk=
Date: Fri, 5 Jun 2020 17:05:45 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support
 (with KVM)
Message-ID: <20200605170545.0000676c@flygoat.com>
In-Reply-To: <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF68840FC0
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]; ML_SERVERS(-3.10)[148.251.23.173];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[flygoat.com:+];
 RCPT_COUNT_SEVEN(0.00)[8];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 RECEIVED_SPAMHAUS_PBL(0.00)[60.177.191.23:received];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 FREEMAIL_CC(0.00)[gmail.com,amsat.org,nongnu.org,lemote.com,rt-rk.com,aurel32.net];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=149.56.97.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 05:06:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MIME_CHARSET_FARAWAY=2.45,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Huacai Chen <chenhuacai@gmail.com>,
 Philippe =?GB18030?B?TWF0aGlldS1EYXVkqKY=?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 10:38:36 +0200
Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:

> уто, 2. јун 2020. у 04:38 Huacai Chen <zltjiangshi@gmail.com> је
> написао/ла:
> >
> > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and
> > Loongson-3B R1/R2.  
> 
> Hi, Huacai,
> 
> The documents you kindly provided contain some valuable info on
> Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I
> couldn't find detailed instruction-by-instruction specifications.
> 
> In fact, I don't need all the details right now, but some form of
> overview of instructions sets of Loongson-3A R1/R2/R3/R4 and
> Loongson-3B R1/R2. Could you please provide textual description
> (one of two paragraph) of supported instructions for each of these
> models:
> 

Hi Aleksandar,

I'm going to explain this according to the names of vendor specified
ASEs name in GCC & Binutils.

There are some instruction that not covered by public documents, that's
out of our scope so I'm not going to talk them.

Firstly, there are some ASEs not being upstreamed yet:
 - Loongson-AMO (Atomic Opreations, Looks like RISC-V)
 - Loongson-EXT3 (Loongson Extention 3)
 - Loongson-CSR (Core Status Registers, instructions to read some
   private core register, including something called "stable-counter"
   (TSC like timer) and CPUCFG(something like cpuid in x86))

 - MIPS-MSA-Ctypto (Including AES, SHA, MD5 stuff)
 - MIPS MSA2 (256-bit MSA instructions)

And there is a ASE that only being used in kernel so not even being
mentioned in toolchain.
 - Loongson-SPW (LWPTE, LDPTE used to help with pagetable walking)

ALl these processors have mips64r2 as baseline.

> * Loongson-3A R1
Loongson-MMI, Loongson-EXT

> * Loongson-3A R2
Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, DSP, DSPr2

> * Loongson-3A R3
Same as R2. This revision mainly focus on bugfix and improve clock
speed.

> * Loongson-3A R4
Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, Loongson-AMO,
Loongson-EXT3, Loongson-CSR, MSA Crypto, MSA2

This processor even support hardware unaligned accessing.

> * Loongson-3B R1
> * Loongson-3B R2
Loongson-3B R1 and R2 are mostly identical with Loongson-3A R1, the
difference is it have 8-cores in a package. It was designed for HPC so
there are some domain specific SIMD instructions, but they're not
available to public.

And a new family member of Loongson64:
Loongson-2K (R1):
Loongson-MMI, Loongson-EXT, Looongson-EXT2, MSA.

> 
> (what is the base instructuin set; the difference to the previous
> model; what SIMD extension (LMI/MSA) is supported other specifics
> around supported instructions)
> 
> Based on your answer I may bring forward some suggestions on the
> improvement of v4 of this series.
> 
> Truly yours,
> Aleksandar
> 

Thank a lot.

- Jiaxun

