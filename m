Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC5C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 09:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21952173B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4moUhMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21952173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzHGu-0000G1-UE
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 05:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzHFt-00081C-0C
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 05:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzHFo-0003mp-Lw
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 05:13:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzHFo-0003m0-9r
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 05:13:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so5609423wrd.7
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=08ykHv62/kAXNcraKtHpxP/q/+jI+lbPhBDJ0nAr1BU=;
 b=c4moUhMktTQM2REJR3Kcvd9R3Y3KbtNUkR2Xkmm19hB5a7iUHB9KfzaHvOOwR7fOQ4
 PdCVC/1lHi09tEPQJN52Tj3oxl4vtX6SFjQHt51h5dQQLuNOsivYsti+z4orzwNOUXZe
 T+WEI3E1iPcWB4sOHtD1K7IReWiE3Oc/KfYqFaLuUck5j8jnHRsLcdGXn9/0XoV6K8sD
 9p1wj8n4iSAV+rOGUX5RBK7kMAD/HVgDjrIQRUBc16/ADf2e52ozi9QrVChaun7K/Z15
 7mVZz5iifK7lius9LzxXoBM3OUa1tsFtsyMKjrLbC4CxDliOx8150Jy9eq4+/XEteiFM
 XsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=08ykHv62/kAXNcraKtHpxP/q/+jI+lbPhBDJ0nAr1BU=;
 b=C1oLIJli1z644UEUg6QgsZjRTM9emFV/mXS0M9A4y1jOqY61svcfmCq+J646IyKDig
 q+GxjNrywC3sSX5IDBX3kD3+AwTgUb3/2pkWlUA8oJ8hJqLiHp0DSmYesZ5hhi0a5iw7
 BGhaODAfe2yCy7f7p2XNcImTX3oF8jge2jrCzHqWEjZuj1VSntw0V+y3g6bfMRKZ4OnD
 mvET80spLHq7W5FWC8VaCPLYX7Q0qSYrzRSB2ZDqLort8poXK2OOTt5BvuvFA8dJvCgH
 oHz1UIma4xqXuBz/txs1uZvCXaiOsXJ8xIl+e7FJw6Ozo1kGoiQajYay4/kHYWP7hz27
 WViw==
X-Gm-Message-State: APjAAAXNNqsJ5GeA+l0xVm0TASDTTfDegZVtE16c6GADBhKg848eyoD7
 ceKV//0wanUXZYxhlbNiHy4NrA==
X-Google-Smtp-Source: APXvYqx8mpO+txpXVJos3FkBAMd7w2U/VbzwDL8sGtDlgK3w1mDE1haj1s2PxyiYa+Ysj6ypriit0Q==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr20563632wrj.66.1566119614901; 
 Sun, 18 Aug 2019 02:13:34 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id k9sm9410852wrq.15.2019.08.18.02.13.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 02:13:33 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b53bdb6b-278e-7359-8cfb-48d8d07adc1f@linaro.org>
Date: Sun, 18 Aug 2019 10:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
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
 cohuck@redhat.com, sagark@eecs.berkeley.edu, david@redhat.com,
 jasowang@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 i.mitsyanko@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com,
 frederic.konrad@adacore.com, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 xiaoguangrong.eric@gmail.com, peter.chubb@nicta.com.au, philmd@redhat.com,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 jcd@tribudubois.net, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, lersek@redhat.com, green@moxielogic.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, marex@denx.de, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 pbonzini@redhat.com, andrew@aj.id.au, claudio.fontana@suse.com,
 crwulff@gmail.com, laurent@vivier.eu, Andrew.Baumann@microsoft.com,
 sundeep.lkml@gmail.com, andrew.smirnov@gmail.com, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 aurelien@aurel32.net, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 7:28 AM, tony.nguyen@bt.com wrote:
> Tony Nguyen (42):
>   configure: Define TARGET_ALIGNED_ONLY in configure
>   tcg: TCGMemOp is now accelerator independent MemOp
>   memory: Introduce size_memop
>   target/mips: Access MemoryRegion with MemOp
>   hw/s390x: Access MemoryRegion with MemOp
>   hw/intc/armv7m_nic: Access MemoryRegion with MemOp
>   hw/virtio: Access MemoryRegion with MemOp
>   hw/vfio: Access MemoryRegion with MemOp
>   exec: Access MemoryRegion with MemOp
>   cputlb: Access MemoryRegion with MemOp
>   memory: Access MemoryRegion with MemOp
>   hw/s390x: Hard code size with MO_{8|16|32|64}
>   target/mips: Hard code size with MO_{8|16|32|64}
>   exec: Hard code size with MO_{8|16|32|64}

I have queued these 14 patches to tcg-next:

  https://github.com/rth7680/qemu/tree/tcg-next

I agree with the downthread conversation with Phil that the middle device
patches should be split out to a different series.

I have some questions on some of the last few patches, and I don't know how
they would interact cherry-picking from those, so I've left them for now.

I had some trouble applying your patches, as they're encoded quoted-printable,
and "git am" doesn't like that.  If possible, please use "git send-email" to
post your next patch set.


r~

