Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28F6218FD
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pm0ASyo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28F6218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNzr-0004VC-7j
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNw3-0007Me-DG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNw1-00062J-9J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:07 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvNw1-0005yl-3R
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id m9so41210064pls.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YOHdOx7/Stz8Tdbo6EdPl4datS5Q3j4t5VdIxcMP+xM=;
 b=Pm0ASyo6gkiTF1odBo/wLrQ9b3UHH+oZYk7XYC9NpzMYsKNFRl52Mu4JBUmbB+BDUC
 kugOta70MyufphqLT2e2rAFQlAMXXx/T62QwK4Lw14rDNpI1qgpWJDlfCh16Bp6y9Xel
 mJXUOrkRGAipCUzXVV/qLiOQXqU0vb99giE+3bio6CSDCZhWKUAVmaCeI0UxJJKXjC+4
 vzIDp/gid/yWVx5jKdm6f4cv+zKGh7V2mpFEm3RFp89koj4WSK+bjzIPfZPscO8D7spO
 Im60t3LUpqFn9Bs+C2BATyFHuRB00RprI8qgwMoyfcTuEdki6RVRyD9HwdrAJ5I1yEZ+
 ZO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YOHdOx7/Stz8Tdbo6EdPl4datS5Q3j4t5VdIxcMP+xM=;
 b=svK8kgUtTiHehMnU3CoOAKRQpmzzlzADMYADqE6l7wQpIb26CPq1jCdoYjJqO3tdXW
 Ou3TYq4V4eMTch/23g8ehab0a6pRlT2V74kagdperGaTUaVdGbKj0wmnbS23d9idk4LH
 EE8LNGMN2BVR8hRsGVIHnbKwOxbKV6eb/yNwR6SMhM0UjkMhyrS5T4mlecxaAVwzWyIN
 Z0+oVI9R/z8jSgXIS3wHw2eiPCz6LeNVAR/LmslIdjAopB6ZL7ctmWn+JR9ICBz/fkNw
 5eKyCEcVF9xZ1UYz/XVehmLm0/uRJSsCXi0X+q9miOKTSbAk5ww2riD6asyH4VKI5dzY
 fYPg==
X-Gm-Message-State: APjAAAXUZMESo2gxygklwZTR40+4TblQQyiE19HKyborENq/wqL5AFVV
 u8+bTrcSSlt2/5ZYY+KVcpUxMw==
X-Google-Smtp-Source: APXvYqxZDmuQ1/uBp64/WjLXtTgxvrI6W4xVriZ8CSJVCoy0a/msLNTPxIMU/toN0D9wtJfEhe90IA==
X-Received: by 2002:a62:64d4:: with SMTP id y203mr9807270pfb.91.1565191977649; 
 Wed, 07 Aug 2019 08:32:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 131sm112852110pfx.57.2019.08.07.08.32.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:32:56 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166562774.65589@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b1ac6757-94aa-2358-2802-4cb3a3aef1d2@linaro.org>
Date: Wed, 7 Aug 2019 08:32:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166562774.65589@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v6 10/26] cputlb: Access MemoryRegion with
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
> The memory_region_dispatch_{read|write} operand "unsigned size" is
> being converted into a "MemOp op".
> 
> Convert interfaces by using no-op size_memop.
> 
> After all interfaces are converted, size_memop will be implemented
> and the memory_region_dispatch_{read|write} operand "unsigned size"
> will be converted into a "MemOp op".
> 
> As size_memop is a no-op, this patch does not change any behaviour.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  accel/tcg/cputlb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


