Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965ADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42E4222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChzciHYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42E4222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnyX-0002b2-N6
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUnx8-00029Q-PB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUnx7-0003nB-4f
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603186147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGi94ZFARnnaQc6ddAB4NiZTwQMEYoc6QqVJFm9QwWE=;
 b=ChzciHYuQH1Bdp4D4Fpa9oqUanK/iaGp83cXbnqytJ0q0ljrIx/r/pf6rj2SKDzjUzYrG6
 wTuHrXY0T98kkhmM1SdIfIFQeb6f67f/hNxn6EfGrklai18WbudVhP21iWJ4E8/qdfi/pG
 OYY6o7h3f6o/P5o4dUBe2xiYzAwlfmQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-QhrtpQLKNwuzCZfMwR7E-Q-1; Tue, 20 Oct 2020 05:29:06 -0400
X-MC-Unique: QhrtpQLKNwuzCZfMwR7E-Q-1
Received: by mail-wr1-f69.google.com with SMTP id 2so565134wrd.14
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 02:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EGi94ZFARnnaQc6ddAB4NiZTwQMEYoc6QqVJFm9QwWE=;
 b=lBKwPNXuKjE/VNw+18EmpE4TEiU4Ro01kqDv+NrphWFNTCKEQ6IN/K2Gbq13KAEbpY
 EhExZyfAQAcUHKkVDrpQEt2EqT3OYIP32C1sQy7K1Jy9E9F6rE1Zv/sR7HKOt/laIPd5
 emct8k1Ms/D5SSAfWTk7F7fg3WyQD8r57qY1YriLRD55i/7TdVbIjQyL7t6YdYNTI0De
 Egh44x2vy78p0qK27rBcSQFqbg/4AqJ+1gjfcYj9IpvQe2rTJzEy5uFjTGogQSvsf4DV
 mjxgZ7Rbr5Qv8+BCsTglQeUsBsFLA31HVywscaqm1MDwf4bIguhAi/pOuFMCuSMxW7ZQ
 SFnQ==
X-Gm-Message-State: AOAM533GwTAsq0289vNsaOMY6JmYQW4DT5+JQq3bqWs14FXdKgSbUn86
 fyCLSzVeYvf6Lt/JtbfuG1OyV59i41s8rqvo9Jx22GQQ5ZdzuFOTAYexkhy0lScKzf85X7h1kzB
 LiqPzbstI0Wl09Vo=
X-Received: by 2002:adf:f584:: with SMTP id f4mr2296186wro.383.1603186144379; 
 Tue, 20 Oct 2020 02:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKnO0W5jpKV+Jd8guFdC+RUiME98KbOLSYB7q7xscerObCLWLYF6wU78Cnr8OgRMfQ4oY8yg==
X-Received: by 2002:adf:f584:: with SMTP id f4mr2296164wro.383.1603186144113; 
 Tue, 20 Oct 2020 02:29:04 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 130sm1930142wmd.18.2020.10.20.02.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 02:29:03 -0700 (PDT)
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
To: Olaf Hering <olaf@aepfle.de>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
References: <20201020091605.GA2301@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
Date: Tue, 20 Oct 2020 11:29:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020091605.GA2301@aepfle.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Olaf,

On 10/20/20 11:16 AM, Olaf Hering wrote:
> This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f
> 
> On Mon, Sep 07, Laszlo Ersek wrote:
> 
>> In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
>> 2020-04-16), part of edk2-stable202005, the Brotli compressor /
>> decompressor source code that edk2 had flattened into BaseTools was
>> replaced with a git submodule.
>>
>> This means we have to initialize edk2's own submodules before building
>> BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
>> the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
>> well.
> 
>> +++ b/roms/Makefile
>>   edk2-basetools:
>> +	cd edk2/BaseTools && git submodule update --init --force
>>   build-edk2-tools:
>> +	cd $(edk2_dir)/BaseTools && git submodule update --init --force
> 
> 
> This change can not possibly be correct.
> 
> With current qemu.git#master one is forced to have network access to
> build the roms. This fails with exported (and complete) sources in an
> offline environment.

The EDK2 roms are only used for testing, we certainly don't want them
to be used by distributions. I suppose the question is "why is this
rule called if tests are not built?".

> Please revert this patch.
> 
> 
> Olaf
> 


