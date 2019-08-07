Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18DC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB5122293
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRHlOVER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB5122293
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOAz-0006sz-Py
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOA8-0005Gh-TP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOA6-0007ho-RB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:47:40 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvOA6-0007gw-Jc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:47:38 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so41388844plz.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N5Bp3ItJAXMZdVduIZ4v6R1Z3VWXw1mBqjlslk24EpM=;
 b=DRHlOVERoqejgaH+XVNqMExp9Yi5VP74jjZRFO+Yd3nUrcgwbzUd2bl4qdA/VhiQRW
 9vqatYvv+CBBoJN6xUFds9wG4DoNUaNYP6c7Z0LC+cNzPDCIg1NxpPZmwuquEFX7axUl
 mDd3RpSio5xbh+nvn/n4kgvn6Kt+bKcsgWsi4Vy7/uJ3uIGCVQRmu48WzLIW7q/N4Mju
 Eddaf93rlbpUI5Xgu/y/Q2LNYx8NuOxjlsbmrISMtcHKS01x/3OxUEN3+0rz4W/tnxRQ
 trSLeuGrIcIA9QloY/1wflMPAseDOM/Dsm43xfJck4jbuYlEjn/nbRu6tx7Ekp0YOkw1
 /6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N5Bp3ItJAXMZdVduIZ4v6R1Z3VWXw1mBqjlslk24EpM=;
 b=CMYE+8G5q/C0SlnqInRWd6sjtv3JRy3/7ORWbwLK32H//8keEs7M16H42IoAc2+KT7
 pkRZpXHJE9g0NythiTMC5kOerZq/7Hc+CkCkpvGqBHSwUz3NDR2yjO6l8+OZErLfaaMe
 cz3Jdgc7TqTzne9wNq0HtVkKJLEtvgWBYMU9Ev5qd93kTmDsc4O6z8MOxVGrQqxZ0PDb
 Exg9HJwq8p3n7FQm5LBy+k4mn0bAe6GOK6KuDGpi8briPsrxZY9b6qLdXyvpvtfHGBU1
 Wh1pkUsFp1SlKuNm2pKkveKsc10vh6CYT1lXbn8G45VB0KVkvfOtT0NcFCjteXiJVcAM
 vOrw==
X-Gm-Message-State: APjAAAUux48HOwT3kJOXALOVnsaaHWf4W7RISWb0pP7rsWd1UpcQoVJ8
 LakIlEXV9n5rE+u7fbHpi8bgRw==
X-Google-Smtp-Source: APXvYqyy2WcqvpYE99wqqW2WE5wx1J+xpxofJfHqFYLpjpHSmNvDWfUsRgUrJZGdGyfCyhIHXUgQkQ==
X-Received: by 2002:a17:902:8d97:: with SMTP id
 v23mr8562456plo.157.1565192857454; 
 Wed, 07 Aug 2019 08:47:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 64sm93650185pfe.128.2019.08.07.08.47.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:47:36 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166604452.72353@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <96720b42-741f-5161-3344-c146fe184de3@linaro.org>
Date: Wed, 7 Aug 2019 08:47:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166604452.72353@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v6 12/26] hw/s390x: Hard code size with
 MO_{8|16|32|64}
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

On 8/7/19 1:30 AM, tony.nguyen@bt.com wrote:
> Temporarily no-op size_memop was introduced to aid the conversion of
> memory_region_dispatch_{read|write} operand "unsigned size" into
> "MemOp op".
> 
> Now size_memop is implemented, again hard coded size but with
> MO_{8|16|32|64}. This is more expressive and avoid size_memop calls.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/s390x/s390-pci-inst.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



