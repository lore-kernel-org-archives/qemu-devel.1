Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F116A21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i93jK2k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F116A21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvO2B-000098-34
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvO1S-0007m9-8p
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvO1R-0001cr-0P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:38:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvO1Q-0001bR-OU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:38:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id c2so41353079plz.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PftTEUkCoQGe362ZEZQRYX9sDZAzdQEMj7x8oh2NOcM=;
 b=i93jK2k/eEXh/s5xW1NmBkmQdMpYgRueUNEoEdJA6BS31ztY69Nyq37PzB8JWgF/lB
 N2QggwEh+vXbE8yDZPdhbPCNs0FbqBNCaZg+W6bSfQYwPvAobo5VaiN/W5YbNrMvxcD1
 hv+UI9zNGPrqr5SBmpb9h3Vw2jWsRSwKHReaK94/BuxPBGUg0+4921bA++dX8FzcktRa
 owHMylkON/p9jPIv0+CHmH8QDPZHix4j35wdxNDV6Z4vJAcRX3VANUvcgnh4qsslStCu
 o85HUpzh9lFKIsWqFwfELJx1tnvDB9unjbM51K9ehFFBvtfGg5d+N/pBvBa/srZCdjLH
 u6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PftTEUkCoQGe362ZEZQRYX9sDZAzdQEMj7x8oh2NOcM=;
 b=ooElo1Rx/q4zB1hE5I1SHgA0P5130buxGHf0Su4d5s/FmA7moqeMYzrlaNWdfcfhE5
 JPoU/nQS8J0k2sX9AqfQSWwL8rDIWgwzQQnK2i+r284WCun97yc1VjuYnK3AhJG1LPbv
 XaUcLtMt86WAAxPNCNfqPb8YfDm2qb+x8haOL8oUu/gJKPDY7v1NOv8nRX9bQjWBgkr7
 vkMRju7ooY1SqcOMeq70+V3Llwa2AyXWFjilnwEde+ZvZM90t+RI3oe6KQF3ebDJ2gMi
 jP9UuGBcXXTEPzMgbI97qYchb14INPBQds0Cry/e15ADh7s/vZfgwBPe4xRdCf/eINOo
 8OZA==
X-Gm-Message-State: APjAAAVWbBEuhmi82plEfEWu7ofxOpjubJ7Guj07/uhoBdDpTonzy0XN
 D1u8brm3tInTLRX0VZ0v8+mTzg==
X-Google-Smtp-Source: APXvYqxnVZu0/r8eCA+v13Jb+SQhfMD4VTKhziLeLvCX8Oeim2Ryxf4eL+v3g8JSdPwsPbUuCoe+zw==
X-Received: by 2002:a17:902:7894:: with SMTP id
 q20mr2067641pll.339.1565192318272; 
 Wed, 07 Aug 2019 08:38:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f88sm316107pjg.5.2019.08.07.08.38.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:38:36 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166587275.42474@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <652ad19a-ad54-7854-7d3e-03f1032cba7e@linaro.org>
Date: Wed, 7 Aug 2019 08:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166587275.42474@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v6 11/26] memory: Access MemoryRegion with
 MemOp
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, imammedo@redhat.com, sagark@eecs.berkeley.edu,
 david@redhat.com, jasowang@redhat.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, laurent@vivier.eu, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, pbonzini@redhat.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 pburton@wavecomp.com, marex@denx.de, robh@kernel.org, hare@suse.com,
 sstabellini@kernel.org, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 mst@redhat.com, magnus.damm@gmail.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mreitz@redhat.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 rth@twiddle.net, philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, sw@weilnetz.de, alistair@alistair23.me, chouteau@adacore.com,
 b.galvani@gmail.com, eric.auger@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, yuval.shaia@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, shorne@gmail.com,
 sundeep.lkml@gmail.com, jsnow@redhat.com, david@gibson.dropbear.id.au,
 kwolf@redhat.com, crwulff@gmail.com, qemu-riscv@nongnu.org,
 xiaoguangrong.eric@gmail.com, i.mitsyanko@gmail.com, lersek@redhat.com,
 cohuck@redhat.com, alex.williamson@redhat.com, Andrew.Baumann@microsoft.com,
 jcd@tribudubois.net, andrew@aj.id.au, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, jan.kiszka@web.de,
 stefanb@linux.ibm.com, andrew.smirnov@gmail.com, aurelien@aurel32.net,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 1:29 AM, tony.nguyen@bt.com wrote:
> Convert memory_region_dispatch_{read|write} operand "unsigned size"
> into a "MemOp op".
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  include/exec/memop.h  | 18 +++++++++++++-----
>  include/exec/memory.h |  9 +++++----
>  memory.c              |  7 +++++--
>  3 files changed, 23 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +/* MemOp to size in bytes.  */
> +static inline unsigned memop_size(MemOp op)
> +{
> +    return 1 << ((op) & MO_SIZE);
> +}

s/(op)/op/

This is no longer a macro requiring such things.


r~

