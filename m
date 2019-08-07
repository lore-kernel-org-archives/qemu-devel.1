Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83955C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5D7222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0bRoBWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5D7222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOju-0001tV-Kl
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOjM-0000km-C0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOjL-0005bx-C4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvOjL-0005ah-47
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id m9so41408124pls.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aYYfm+vIRRwS8+uBU3AWzg+SbxWwC9WZ5LnrTr11tTs=;
 b=y0bRoBWsit3vYVWoy2IIyQk2NlSE9Whdckg2ww8rJWfzkOyqG34pue44La9x5ZZXWM
 qrQe/8ZUXeINHn01gTY+5T2q4i8qP8tGe/+c7uVc1nZntD7ApW8gWrsaOHVqaigbYFXq
 zz7aLv6I2zYmeG5Jv/EtpA7A2X1U5ftBtkok6NKqk/4GZgVsklw8N6uD0f3eETNB86xK
 Slx0/+AvvMaK9/r3UPLrfytNDzazCOsPMzugsLRpTNma7avbpR0/5ZnWL0IPFj1rAD9i
 uSTrIk9RTgXOESR9qRVIFIsh1YOgv9PGBfO3EBPtzIVvFbU87YFURq+XJmUikprQhf70
 axPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aYYfm+vIRRwS8+uBU3AWzg+SbxWwC9WZ5LnrTr11tTs=;
 b=Pieoa7CQgUFALVidRrI+fsnuY38BTzavaN0eUI1/N2XqT3U8ZutIqt55bBqQhX3WBF
 YUARDOaGj39bzyeBNRbKAcVkoFbu2ry0QY6stQgDZJWIDbZ75rzHI0eV5AFEmww01np1
 7bZ0AQcHqyxTWuTyoPXoq4U651kmRD9q6sggE4WGmwa6eswI7qGpe/XAF38InkGkwI72
 47qnLRVp2gqQtfjJeFfQCP+AVO5Pl47AgawDfFGMvFOFcB7p+nYx5UYBKTuFHRNTsTZo
 D6odR0Ik8Oo+qb/d1BLC1PH7vhWX5YzahBHfB7DhA2vU7AXYswkvaTOVxIc7wHG9lHXS
 Czuw==
X-Gm-Message-State: APjAAAWZr8gOpKU+1YyToc4q/wXvi3y9Czo1aTM0KorrMRuRqCBWtZkq
 n+0D5n2yUpcqHRn3VBxOZmjQ+A==
X-Google-Smtp-Source: APXvYqzGXsQ8gfFJWMfJ6Wvw945mfh1EAHw+jqqHuUYS5VC5Evf2TyBzsxToaNuHhVuyolzFfmcvtA==
X-Received: by 2002:a63:e901:: with SMTP id i1mr8256677pgh.451.1565195042061; 
 Wed, 07 Aug 2019 09:24:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j5sm107874000pfi.104.2019.08.07.09.23.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 09:24:01 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166747494.26346@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5afaa158-e9a4-96c5-841a-e4ffc041b35d@linaro.org>
Date: Wed, 7 Aug 2019 09:23:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166747494.26346@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v6 18/26] exec: Delete device_endian
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

On 8/7/19 1:32 AM, tony.nguyen@bt.com wrote:
> device_endian has been made redundant by MemOp.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  include/exec/cpu-common.h | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


