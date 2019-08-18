Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED6C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC642087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFdyZjYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC642087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzKbQ-0001Ri-CB
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 08:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzKa5-0000ne-ID
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzKa4-0003S3-CF
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:46:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzKa4-0003QP-1I
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:46:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id g17so5909609wrr.5
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1pPjYBqSfFQg89Ld6dVuKQx+pLvJBdztHR4jr4QNGzI=;
 b=NFdyZjYeAZNqNaLC48b0zxqT4ew0cYYqgiA7yrp97QLfmtvO+ZgMF10JEnSzxPt27n
 2gTEmdztH2Z2nIfQrAkbPMNuVh1fIWw9RCjeFBkdCdquJik5n8PLsyHocdtWCV27JyVQ
 QX9hzgFLel3K5xlO29rrs0/AnLhkf1tkhEiNMcC6IJ+uHdc1AHkK4VAfGxoH270aoFiW
 jhPmktd1panEyPf1lhzi30D5LtUGZkTzN5K9ND0UGMARBYZKgYMda93vbqZyFk62bHGC
 6VyaP9AJ0HTezxkZgWUZ8C1eitZedl/FAJbdS4/uRxX4kDPgbeWwcccZjtnmQKty3WVJ
 PLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1pPjYBqSfFQg89Ld6dVuKQx+pLvJBdztHR4jr4QNGzI=;
 b=eC97KipX3mQnwzBVKggTcj/i9l/Efk8umuyWcY9ZKZE2QaQ4IIdWtDKHHp784kxn0i
 3efayx+sevgtBDDcuC5NTZS9/LOGe7IAmFeoFRjvn0hbiANJT/ZVWqW/ab1qTylHMk55
 KNYrPzwo2PCT3Hos6Kx3gkwSS1xqhktgAf1hFmgi5CLkiRsYHil/OhscVsx9arVF7lXF
 ftC2bqXl3BpfYvKQgbSQx30d6WWuEDRZDz6PvqR2/nYIzB6GD62F0zfw3I93DK5k5O4d
 iNGrAJN7V+hMFEgLwnJ90pKABevb/QsHnQLD6g1GQ/qBjONLjuBv5YFMJKc1OiZY+Esb
 zU9Q==
X-Gm-Message-State: APjAAAVNGw4KlzQh4aKj8RgaE9y26zZwAhZdsPBoTvgY6VNySpkAndIN
 JeDm+CnuBRE8vE16xXh18GTj2g==
X-Google-Smtp-Source: APXvYqxRKFMqLQ6mapF4AYE2P66DlsLoG3YnAiriMHGTZEIR3kbgRt+Iz9YK8++iYKEOelm0ymJakA==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr21186547wrn.197.1566132402599; 
 Sun, 18 Aug 2019 05:46:42 -0700 (PDT)
Received: from [172.16.53.135] ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id o16sm13231720wrp.23.2019.08.18.05.46.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 05:46:41 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565941122698.46462@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0a8ecb15-e03d-c6fd-e9bd-38b4abc7b316@linaro.org>
Date: Sun, 18 Aug 2019 13:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565941122698.46462@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: Re: [Qemu-devel] [PATCH v7 38/42] memory: Single byte swap along
 the I/O path
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

On 8/16/19 8:38 AM, tony.nguyen@bt.com wrote:
> +static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
>  {
> +    if ((op & MO_BSWAP) != mr->ops->endianness) {
> +        switch (op & MO_SIZE) {

You'll want to use devend_memop() here, as previously discussed.

> @@ -2331,7 +2322,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
>      }
> 
>      if (size) {
> -        adjust_endianness(mr, &mrfd.data, size);
> +        adjust_endianness(mr, &mrfd.data, size_memop(size));
>      }
>      memory_region_transaction_begin();
>      for (i = 0; i < mr->ioeventfd_nb; ++i) {
> @@ -2366,7 +2357,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
>      unsigned i;
> 
>      if (size) {
> -        adjust_endianness(mr, &mrfd.data, size);
> +        adjust_endianness(mr, &mrfd.data, size_memop(size));
>      }
>      memory_region_transaction_begin();
>      for (i = 0; i < mr->ioeventfd_nb; ++i) {

To preserve behaviour it would appear that these need MO_TE.


r~

