Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB2C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 08:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907102177B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBpqhUNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907102177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWFEa-0003Qm-GE
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 04:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWFD1-0002be-SH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 04:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWFD0-00083t-7Y
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 04:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603529248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jpz5R6niG/Xy4PfAtgd5iIEgkqdkdPYRi3O3l6qD/WQ=;
 b=PBpqhUNM3Ds67RqTAUUtyUks0UqXowfRRKv5+RjWCTdxu9mxV5Hculgia7yAmX+ywgyx+P
 Bt9Hsx6gsl2cankB/SA/jG167o42NpcWzLGGSu0aBh6m93Uh6Qs7bvfCf7SRO/TQEAJYiH
 GIh+FHsAcCoR+qy+m87lAa9xB3b2DAg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-PlCeo6VxNNadsxdSi6-DBg-1; Sat, 24 Oct 2020 04:47:25 -0400
X-MC-Unique: PlCeo6VxNNadsxdSi6-DBg-1
Received: by mail-wr1-f71.google.com with SMTP id i1so1674730wrb.18
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 01:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jpz5R6niG/Xy4PfAtgd5iIEgkqdkdPYRi3O3l6qD/WQ=;
 b=R8kRZF9/FnWq1mjFjPwIrNtsWvn1ew4BcnDMfIJInYQEHKZ5I741oU7ETXwHAaRBSK
 NbpKLdMTvnSg2tWINhoUaPkIRNZ/pzw32PpMG8LEQOvE+gE+AqFRPU0d6BeLWj2kYpWF
 9GLOEiJyOzygWnsniB735DfcaxbbvVTDz21qJLshCzIs8B9klbuBIdNoow+zeb1mJYN0
 DQL4zl0TR2eygBX7v7Fj5vW14BoRglYtDxxBER8o9lF0+2DYX6nuGRU+qdz//y73f9nj
 KefCEcKdqrrVgWB7tnG3gY3Q5CGDjoztG7tY6Vc/svtPpA4hmZMXeXemyjUWQlNAF2VT
 w7Kw==
X-Gm-Message-State: AOAM530g95IgxbCHiMFOVFblCwgL/zwk57BBBY+rf/kFCbYZG8bpkTjX
 0smlunjctnCRDTUrLIyjou73L4V9DNjTExvVFuoEIQPSd7/GBNhuZo3IWIx4Cwwq5bYN8M4Tv/h
 4sIzJQ2FTJXXklJE=
X-Received: by 2002:a5d:684d:: with SMTP id o13mr7047907wrw.302.1603529243752; 
 Sat, 24 Oct 2020 01:47:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRkJD7PYFUiMNeIGqIkRFRIkJ1qDYdFQqmLuagADpO1YCIwMCB3inXV6kudBxaDUV/eToVYg==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr7047877wrw.302.1603529243461; 
 Sat, 24 Oct 2020 01:47:23 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m1sm7814828wme.48.2020.10.24.01.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 01:47:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>, Cleber Rosa <crosa@redhat.com>
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
 <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
 <CAEUhbmXX9RH12_EuUd-HmipOFMWH1_2gvCjL_RRqXiOqvzzU=Q@mail.gmail.com>
 <fca4287e-37fb-dda0-784f-a053f0ad0cbc@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fb749d0-f935-c21d-349e-b7231bb31324@redhat.com>
Date: Sat, 24 Oct 2020 10:47:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <fca4287e-37fb-dda0-784f-a053f0ad0cbc@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:26:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/20 09:34, Philippe Mathieu-Daudé wrote:
>>
>> Oops, I took it for granted that the `make check-acceptance` will
>> automatically rebuild the QEMU binary, which is not the case. Should
>> we enforce the rebuild before testing in Makefiles?
> 
> Well I'm not sure, because I don't want to have to rebuild all
> targets before rerunning a single test, but this is a Meson issue
> that could be fixed soon. I'll let Cleber/Paolo decide.

It's actually Makefile since check-acceptance is not meson-ified.  If
you want to add the dependency just write

                $(filter qemu-system-%, $(ninja-targets))

Paolo

> Does that mean I can add your "Tested-by: Bin Meng
> <bin.meng@windriver.com>" to the test patches btw?


