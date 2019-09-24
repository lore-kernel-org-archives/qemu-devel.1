Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF105C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74922207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8y+S+yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74922207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtqn-00067c-F9
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtXV-0000Py-KZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtXU-0006y0-Gl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:44:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtXU-0006vQ-Am
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:44:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so2052419pgk.10
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vpml+l3Q31fmKGJ0erkiNaIc4lx0gBxK0scD23YXKkk=;
 b=l8y+S+yYiEMf11+XfAqyFE+8Pp7g6pJfQ8ihwk+t/kZ6b2FKqWk5EDaiVnCcWr9XMc
 bZ4AS9Ef6lx4z5Q+Kf/wBSHvrGMVKKNhgGDE6AXhjLAXE0GRC4wK2MDfGLSXTyp7vxR5
 1HYF3pnmltFJGzqWX/n4oQg1yw1P8B3nKT1IT+ciwRf8FNHW6xhn/cEedae4vwlrPdzM
 so0UPFEdRQ1Ij5rS4ThWqqM34RUeHCh+jQQTq1/WP+GWVfGjBXYfhXi1Ws+O0Uti97Da
 c6vBmVZxPvQtJ10eDTfn0aT1/YvWcOJ0TEfW/+4eX7pK1Hzufw1qM5TSIxCzLtQjMlm7
 CFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vpml+l3Q31fmKGJ0erkiNaIc4lx0gBxK0scD23YXKkk=;
 b=mR09QLTZidE9nDmzElTssffLdhU0FjIU6RS6+4epgTGPNLmI/VnLxOs3MJ0J38tQw7
 OE+XnbTcb2lcIV9V66/sBHZPutladiPT2rbtosJCpcOQJNAOY4Sj86WQFRKKwpZr0GV8
 jUTnSToZCBdvRu6Ka5MzXS28EsHLIJ/On8mpMxbeqrSClFzWabf+BdFZ/JxRBgQN77ne
 5EjN1MaWFAzHyAGm4HlHT7m8L0XUHPxBs7DfAUGtzuM2Ru0A3R+cW3bwas81p1CfJX3d
 BokyF5VxaYg3p9Rslrq+09Hw40k3Pxcl03eTT5y2vAivQzeuirhIStN0dyljoZ7Awot8
 o1uw==
X-Gm-Message-State: APjAAAXVHwg538G3+f3m4+OjfapGwhlNBn9UKa5S+1XKsv0yfnkpEc4P
 VuprWNpzoGREpYAsEnTPy6m66n6244c=
X-Google-Smtp-Source: APXvYqw302nrE01PFXpWKXYXcz2Ewt1L+A/zcrvQFGw3qV8Pez8JAKrnyCBYlI5jb+g/etXGAC5RLg==
X-Received: by 2002:aa7:920d:: with SMTP id 13mr5723152pfo.17.1569361577460;
 Tue, 24 Sep 2019 14:46:17 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id a8sm3139105pfo.118.2019.09.24.14.46.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:46:16 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/ppc: use existing VsrD() macro to eliminate
 HI_IDX and LO_IDX from dfp_helper.c
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8a6dcdda-97b6-16f6-a95b-0c53d1e2d215@linaro.org>
Date: Tue, 24 Sep 2019 14:46:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> Switch over all accesses to the decimal numbers held in struct PPC_DFP from
> using HI_IDX and LO_IDX to using the VsrD() macro instead. Not only does this
> allow the compiler to ensure that the various dfp_* functions are being passed
> a ppc_vsr_t rather than an arbitrary uint64_t pointer, but also allows the
> host endian-specific HI_IDX and LO_IDX to be completely removed from
> dfp_helper.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 70 ++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)

Ho hum, vs patch 5 that was me not realizing how many different places really
want to manipulate a 128-bit value.  Do go ahead and keep ppc_vsr_t for now.

It does look like we might be well served by using Int128 at some point, so
that these operations can expand to int128_t on appropriate hw so that the
compiler can DTRT with these.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

