Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFAC2220A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVbhOPfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFAC2220A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvSJ-0004W1-N5
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvEt-00084Z-R7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:50:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvEq-0007b0-Gn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600354219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/0QcecuJGq8/KSPhMXpTHS7wdP+36lNVEd2ZRAlatc=;
 b=iVbhOPfRInT+1PsXuuEVQ4+rLdz4ETtV04EBU0xsKX8/WTVtPacLAbseJBgv0ATsu8+1Kl
 nk5Qmc+hPNDFh10lLcUQGfvN5s5RtYMsAsc0pGqP/m5n/hpAxZAPuFPk0y6nRWerkEhceZ
 kkK0vRernah6WTKinoKE8brUdA+yGKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-KEU75yaEO6qxnNfkMJJhQA-1; Thu, 17 Sep 2020 10:50:17 -0400
X-MC-Unique: KEU75yaEO6qxnNfkMJJhQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 358D98D6BA1;
 Thu, 17 Sep 2020 14:50:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D18755766;
 Thu, 17 Sep 2020 14:50:14 +0000 (UTC)
Subject: Re: [PATCH v2 04/10] disas: Clean up CPUDebug initialization
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-5-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1eb5fb1b-4341-88e9-16b1-f9db78eceadb@redhat.com>
Date: Thu, 17 Sep 2020 16:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914230210.2185860-5-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:24:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 01.02, Richard Henderson wrote:
> Rename several functions, dropping "generic" and making "host"
> vs "target" clearer.  Make a bunch of functions static that are
> not used outside this file. Replace INIT_DISASSEMBLE_INFO with
> a trio of functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/disas/dis-asm.h |  60 --------
>  disas.c                 | 326 ++++++++++++++++++----------------------
>  2 files changed, 148 insertions(+), 238 deletions(-)
> 
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 9856bf7921..d2418c977e 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -461,67 +461,7 @@ int print_insn_riscv32          (bfd_vma, disassemble_info*);
>  int print_insn_riscv64          (bfd_vma, disassemble_info*);
>  int print_insn_rx(bfd_vma, disassemble_info *);
>  
> -#if 0
> -/* Fetch the disassembler for a given BFD, if that support is available.  */
> -disassembler_ftype disassembler(bfd *);
> -#endif
> -
>  

By the way, while you're at it, could you please also remove the form
feed character in this file here? ... that looks really confusing in my
e-mail client otherwise.

 Thanks,
  Thomas


