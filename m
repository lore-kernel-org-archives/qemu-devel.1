Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A10C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175E020691
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jO13lW3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175E020691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUo7R-00006w-3X
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUo6K-0007hG-V3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUo6H-00072T-Pr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603186716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ih3MpF1Vyc5Pv3YO23GDQCjq/HmmY5DIbkKaS/6NuUU=;
 b=jO13lW3jpfoORpl5Kysp5tG8WVWOnMOy6E/8ENVHiW+P23GI31GZ3Jeh91AC8vvssiwdrG
 zNu5RhKc8ns0qyfc6AisU72PJJM/e4ZHS+UQZ54ACTvuQofgyf2jQ6YMrC1E6q8yTgkYUJ
 o8ORkFUY2VCl+qYg5aI5YQEQKghWtWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-pmgaNX1lP0m_qNsuLWcMTg-1; Tue, 20 Oct 2020 05:38:33 -0400
X-MC-Unique: pmgaNX1lP0m_qNsuLWcMTg-1
Received: by mail-wr1-f70.google.com with SMTP id m20so567751wrb.21
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 02:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ih3MpF1Vyc5Pv3YO23GDQCjq/HmmY5DIbkKaS/6NuUU=;
 b=oK5GcEcVLqXXoaYtYeuIhuJhRqEbUXZGSKGX/mOt3HBJdQc9RSqkOt7R48RlyrUH4f
 ekk3YkkGyUtLlMEzl+THl7pdhvQ5bIThcLTNuebwkP+XQRIW5fJcO42rlMCE3JQormUq
 MnwsiCymakxoRcKXz+jY3+Rey8qwNGlG5LpzqUJ8YQ4nAVShdvnY0ss3IajPbFv9udp8
 GvKciHPDCd/X90ilF7BaBhHGsn9ypNYHR/fNOof+jUsFliQ/PSnxnDdyfTLfcqZFRDOK
 aS7rbLUXydvWuo4G/chNRg9pa+/jRQetbPsBNt7BShrrAQStUkmecXA4h3exCkTzINH7
 gnDQ==
X-Gm-Message-State: AOAM531avMRgsxJgiEEaCOKCHmMXoCoLiZu6RDPOafZm0RRGkitao4tB
 lZxHRHo7lznfWVuwY6Ib8v5rGurb9Mkp/i2l/6JWZVPHcnNS163lRkWDaOGDYtQ/Kh5KlvI5FVK
 Q3o17F15wdYNS12k=
X-Received: by 2002:a5d:6110:: with SMTP id v16mr2634436wrt.219.1603186711547; 
 Tue, 20 Oct 2020 02:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZsyHAg+PaiDMK9wee+fT+M1mgMj7menyYCrg/QkzhhUzswNHbgBa1Al+is9PR0zBgVyWfRg==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr2634418wrt.219.1603186711285; 
 Tue, 20 Oct 2020 02:38:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 71sm2243859wrm.20.2020.10.20.02.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 02:38:30 -0700 (PDT)
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
Message-ID: <d5ac98d6-0fdb-1bbf-bb29-4e23bc364078@redhat.com>
Date: Tue, 20 Oct 2020 11:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 10/20/20 11:29 AM, Philippe Mathieu-Daudé wrote:
> Hi Olaf,
> 
> On 10/20/20 11:16 AM, Olaf Hering wrote:
>> This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f
>>
>> On Mon, Sep 07, Laszlo Ersek wrote:
>>
>>> In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
>>> 2020-04-16), part of edk2-stable202005, the Brotli compressor /
>>> decompressor source code that edk2 had flattened into BaseTools was
>>> replaced with a git submodule.
>>>
>>> This means we have to initialize edk2's own submodules before building
>>> BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
>>> the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
>>> well.
>>
>>> +++ b/roms/Makefile
>>>   edk2-basetools:
>>> +    cd edk2/BaseTools && git submodule update --init --force
>>>   build-edk2-tools:
>>> +    cd $(edk2_dir)/BaseTools && git submodule update --init --force
>>
>>
>> This change can not possibly be correct.
>>
>> With current qemu.git#master one is forced to have network access to
>> build the roms. This fails with exported (and complete) sources in an
>> offline environment.
> 
> The EDK2 roms are only used for testing, we certainly don't want them
> to be used by distributions. I suppose the question is "why is this
> rule called if tests are not built?".
> 
>> Please revert this patch.

Maybe to clarify the use of this submodule:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@redhat.com>
Date:   Tue Oct 20 11:33:22 2020 +0200

     EDK2 submodule should only be used for testing QEMU

     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.gitmodules b/.gitmodules
index 2bdeeacef88..dd9b5ed03e1 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -47,7 +47,7 @@
         path = tests/fp/berkeley-softfloat-3
         url = https://git.qemu.org/git/berkeley-softfloat-3.git
  [submodule "roms/edk2"]
-       path = roms/edk2
+       path = 
roms/edk2-unsafe-with-all-security-features-disabled-only-usable-for-testing
         url = https://git.qemu.org/git/edk2.git
  [submodule "slirp"]
         path = slirp
diff --git a/MAINTAINERS b/MAINTAINERS
index a7f0acf8663..35f977efbcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2732,7 +2732,7 @@ S: Supported
  F: pc-bios/descriptors/??-edk2-*.json
  F: pc-bios/edk2-*
  F: roms/Makefile.edk2
-F: roms/edk2
+F: 
roms/edk2-unsafe-with-all-security-features-disabled-only-usable-for-testing
  F: roms/edk2-*
  F: tests/data/uefi-boot-images/
  F: tests/uefi-test-tools/
diff --git a/roms/edk2 
b/roms/edk2-unsafe-with-all-security-features-disabled-only-usable-for-testing
similarity index 100%
rename from roms/edk2
rename to 
roms/edk2-unsafe-with-all-security-features-disabled-only-usable-for-testing
---


