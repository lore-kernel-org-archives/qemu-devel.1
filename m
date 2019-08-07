Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6986DC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392E321E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSGMVc3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392E321E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOjg-0001FK-DT
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOj3-0000BB-AG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOj2-0005G3-1R
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:23:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvOj1-0005EM-Op
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:23:43 -0400
Received: by mail-pl1-x633.google.com with SMTP id a93so41494552pla.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4apiCbiHeuX0AenKySgOMQa0zMkcp3aC9oI0N5dnMd0=;
 b=fSGMVc3CoPP+9MOYEXHyAwcORIXCCmaq7Nv6zcjo7HCIoK9K5iXXo+aVsOLWsfAE63
 kxNtr2NbOaya47/3XOLszH+MtxslXA6ls+xJcJTAd8kgM10Aof4+kB0N8rd7Jky78pTX
 HXhKVXiH6fLv841k26QbqIfg37n4iX1yfuNbu/2R6YSEzZAd18uOTawnvnSMe+dQEEzE
 2WT+b7XLe9VSEDwMZXM250ASOtxmEKs8q746H9gWQlgNXv9pqNItEhJtRMHZaEL04Tfk
 VJNrU4jXaJpGUZnBE+pY8Kt3VcZA5MPmNrXfb/PprwGqWrd/BOMWXua3bLTFF5FOiomg
 xDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4apiCbiHeuX0AenKySgOMQa0zMkcp3aC9oI0N5dnMd0=;
 b=mlBZ5jDlbnLN6T3E8mI6YdzH8mHrTdiDUe1HvEYdwFKnVwW5AG+a8Ptw5GuWs9i8P3
 lbFrdWQPW4D6/Ob+9+ByAcHdCQYRtZ2B3r9ovqoSJHEbSLjTLGz5ro4ETkINob2mvScw
 Dvo8XmnOKcf4ajWPpc7NTCRrBJ/e01NbP8Kwq6gyQOvwGFzIZdJn1iNti4gnDK+TDtDY
 zfHBsPf0TSRCVwiTnUPZ5AUnX6iZBR72n7ABi4bF4hrN4MwAkZdx3vCrm4//fgTMSEiy
 lfpx7OPCNlCLKJNm9kyyYQzUOlqz2RJosUZI+CfO2gVG3wUQkRcJTg0Ne+OT5RkEcesX
 UkPA==
X-Gm-Message-State: APjAAAX9UOe/axyrsZLPKrecpReYnM4ajbkli2vFzrqXrYlb+sbUKZGs
 hkZhJ5fo+nsSsOt0zP3iLeb0WA==
X-Google-Smtp-Source: APXvYqwDnK8/bYyxH+UVEZz17ysgwghpMF9hOWob3p6ybRQ0JVOaW65tPejEu01/JP+CoD/QM4ciOQ==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr8342553pgk.10.1565195022628; 
 Wed, 07 Aug 2019 09:23:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i124sm171005832pfe.61.2019.08.07.09.23.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 09:23:41 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166709139.77390@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3de18435-b9fd-24d1-1352-d1086ea224a1@linaro.org>
Date: Wed, 7 Aug 2019 09:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166709139.77390@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: Re: [Qemu-devel] [PATCH v6 17/26] exec: Replace device_endian with
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

On 8/7/19 1:31 AM, tony.nguyen@bt.com wrote:
> Simplify endianness comparisons with consistent use of the more
> expressive MemOp.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


