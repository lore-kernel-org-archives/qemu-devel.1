Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7203C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B138821BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9hc/ZPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B138821BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNUW-0006mt-2I
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNTo-0005K8-Ps
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNTn-0007j1-Gb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:03:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvNTn-0007hh-8s
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:03:55 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so41094866pls.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zC4jFiOofa0R83ZDHoyfyBvXAp+7d+Y13pRmYlC0riM=;
 b=m9hc/ZPvf0oKc2ofnxDXra2HBXylt4M9/iWEUE7A5+da5UzFcS1Z34iSyHOVMpgboZ
 /zuam3ye+iOLSDNyFXcXzCUY8t+9fHGeYqEYkwBXawuqvSSKS8sGizofeh5fhFc/+9T3
 gIj6f2kpuUao/ZW7UIO1wQ0fARYx41FxM3/++1o6dxqc67PoB6Qqt6Dp2ZxjF/eH0lxb
 OK+rLmcul5O7v32jpHVyLKV76RdtM+OvM4r/CcbUtL0k33qf7zDlg9AFBWhZ96Rnl337
 m2W6aRjhJreJhSDt9gG+YToZ+oArpXUp/c74GgjRbP4ERag95UU5rT52M3BbogifA7FL
 itOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zC4jFiOofa0R83ZDHoyfyBvXAp+7d+Y13pRmYlC0riM=;
 b=bO/ANEBtSQ8I5ZAhQ1gzV07WhYXPYv6Y2cDcjznbFMIEULa2iUypPZ77TrZDMzF/wm
 XXR3YpfMsKbj4dWtQcT4AaJ+9IX3qN16JUuSbWhJV98AZzT28MPHi/ps1oE0UW2LeNLh
 vD91VwOUAQ9huchJVYKuDypfnkU1WMBSMeFhZapIYDrOLU1i0k/S1fHMZvFQQpoUSbcB
 atzvUEdntYEmSbtZBoYV2ghRoqxusmKu9o+WzbTP8pMrg0KhByEgzZKxECI8UM3+E9JR
 qG5L+JEVjt+IVUSgz3c+yq8fDSdUZ/vOJ3GUiuPmI37sLqs0p2sgELcfmF8rh6+EAYKr
 rNRA==
X-Gm-Message-State: APjAAAVeMY1PU9lT/awvuRuSsBeISXLniIb3qV6sxVZErYY/dEHttta6
 bLP++7d/G4uFaqWV0S63DXb8DQ==
X-Google-Smtp-Source: APXvYqyAOIfGUzAREqA7EGLNEB0s/1IU1ofPjQgwemIv4dsGo32q9YA/L1lnNFbdY00miSOuTPKNbQ==
X-Received: by 2002:a62:ac11:: with SMTP id v17mr9765690pfe.236.1565190234054; 
 Wed, 07 Aug 2019 08:03:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a128sm104461852pfb.185.2019.08.07.08.03.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:03:53 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, tony.nguyen@bt.com,
 qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166771281.2734@bt.com> <efbf3560-76d3-62ba-0f8f-3e8ca8686f1d@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b0906e2-0d51-7de4-c99e-8d2e1af62efe@linaro.org>
Date: Wed, 7 Aug 2019 08:03:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <efbf3560-76d3-62ba-0f8f-3e8ca8686f1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v6 19/26] exec: Delete DEVICE_HOST_ENDIAN
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
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 marex@denx.de, robh@kernel.org, hare@suse.com, sstabellini@kernel.org,
 berto@igalia.com, proljc@gmail.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de, mst@redhat.com,
 magnus.damm@gmail.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, rth@twiddle.net,
 philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
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

On 8/7/19 3:22 AM, Paolo Bonzini wrote:
> On 07/08/19 10:32, tony.nguyen@bt.com wrote:
>> +#if defined(HOST_WORDS_BIGENDIAN)
>> +    .endianness = MO_BE,
>> +#else
>> +    .endianness = MO_LE,
>> +#endif
> 
> Host endianness is just 0, isn't it?

Yes.  Just leaving a comment to that effect here for the one use is probably
sufficient.


r~

