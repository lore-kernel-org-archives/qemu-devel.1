Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB43C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE4B2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjGA4MXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE4B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqCE-0006IU-KV
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hxqBH-0005WJ-Cr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxqBG-000719-1q
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:06:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxqBF-00070i-Q5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:06:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so110559569wrm.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=md3rpQXbTuAOv0p/UbpuLpcqckT8i/0EbGVxOrmwMJE=;
 b=BjGA4MXXi46Mi/Q/kv9HVvdabMh3ljoCiEtccRO71IUS+QAkkX8+IfJYEZVGzQdfOE
 AnWvQ64ahkWhkX9kOztrG9mmA1ss7onXt88vNLGxscg4xSgU0fsjkkpuL6SJuxPpfun8
 dDHpAIVeS2kqA9Ki8+INE4J1tILY7xUspaWj5C9Fr/39BFsUNwTZ1nR9EDaZI9dlqs35
 MKizj5bC4NTmcrwszYccuWpm/Jm2iTolEQ3SQfxgZjc80nmcduLaTgnpR0U/i4sZI1q+
 UdaugicJfVE4BLeYyhFB6LxFIcgKK7e74gB0VVt+L2THAA0Cqx4R8a7GRmi1iQoIGPZP
 gRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=md3rpQXbTuAOv0p/UbpuLpcqckT8i/0EbGVxOrmwMJE=;
 b=LgCd57AOregXj/nxNowxekOX0s3GfuSNvbhYS4/53CvZaJAuiudEW0qja7zb0qwb+2
 3tT0LSCM953lebXYiUCfxX+YveREoYtLp6C0J7Y66JP5fp0Mv9RYGscQx4RGemy0SAPI
 OwKTkv8cV2G9xvRvaLKDaSCqZwocF96CbwSNC/BeB1uiHoLmDb70RwqnNsIrOLto8erL
 iEpp6fdnhVoVYjDjROQruvzXNiBthH3xFpDKdmgtOsi9SF060TXtq0uzQgqYcu0rV0CT
 DPyCmC4PdAIiSZdYMAYAqViWEqZN9jroH6FEgHsZIPzBEN07lT3aGOYhzKkzQLLK/GBi
 SC/w==
X-Gm-Message-State: APjAAAVc5CR9C4RV3a05QMVgwIlTh60Y4g2EuJJZ8nFd2uAc/rUE6r5C
 fFCRtQEHJjIkUHlD2Y1ny/TIZg==
X-Google-Smtp-Source: APXvYqyZXjvRLCktd+rzbx8Kj7ox3JyaMbnDAeJdeFeIALzU1xwMKNg5zpw55bpdPlfHrqwgcMZMDg==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr26521746wrq.208.1565777216290; 
 Wed, 14 Aug 2019 03:06:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p10sm4291943wma.8.2019.08.14.03.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 03:06:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 272251FF87;
 Wed, 14 Aug 2019 11:06:55 +0100 (BST)
References: <20190814072355.15333-1-david@redhat.com>
 <20190814072355.15333-4-david@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190814072355.15333-4-david@redhat.com>
Date: Wed, 14 Aug 2019 11:06:55 +0100
Message-ID: <87wofgm56o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2 3/6] s390x/tcg: Flush the TLB of
 all CPUs on SSKE and RRBE
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> Whenever we modify a storage key, we shuld flush the TLBs of all CPUs,
> so the MMU fault handling code can properly consider the changed storage
> key (to e.g., properly set the reference and change bit on the next
> accesses).
>
> These functions are barely used in modern Linux guests, so the performance
> implications are neglectable for now.
>
> This is a preparation for better reference and change bit handling for
> TCG, which will require more MMU changes.
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 29d9eaa5b7..ed54265e03 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1815,6 +1815,8 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, =
uint64_t r2)
>
>      key =3D (uint8_t) r1;
>      skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
> +    /* TODO: Flush only entries with this target address */
> +    tlb_flush_all_cpus_synced(env_cpu(env));

Doesn't:

  tlb_flush_page_all_cpus_synced(env_cpu(env), addr & TARGET_PAGE_MASK);

do what you want here?

>  }
>
>  /* reset reference bit extended */
> @@ -1843,6 +1845,8 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t =
r2)
>      if (skeyclass->set_skeys(ss, r2 / TARGET_PAGE_SIZE, 1, &key)) {
>          return 0;
>      }
> +    /* TODO: Flush only entries with this target address */
> +    tlb_flush_all_cpus_synced(env_cpu(env));
>
>      /*
>       * cc


--
Alex Benn=C3=A9e

