Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E280520782
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXBGn0KC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E280520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQog4-0004WM-RV
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQoef-0003dL-Ir
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQoed-0003CI-8I
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602235533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMkzlX1CmQp1e2+4e8IVaa0Zsk40E6Ue6vhbWlyIgOI=;
 b=IXBGn0KCgknB2MUOLolvo25Qd24auLocpMJQzu5xtYYuLBk1VwtYfojUuIyVqajwQ8llqv
 uG9TQIMqsEPSnXUhOGTep/vaWD1eGQO25OtGwASLtAvCHjJ4iBLqyjynRQfv/BC7MoL4KA
 sIVr8qiy8Zmnvr+Tpf/8sBReAIEGk3c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-uqZkk_yjPd-WsdIXS4Uodw-1; Fri, 09 Oct 2020 05:25:31 -0400
X-MC-Unique: uqZkk_yjPd-WsdIXS4Uodw-1
Received: by mail-wm1-f71.google.com with SMTP id g125so3994295wme.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 02:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zMkzlX1CmQp1e2+4e8IVaa0Zsk40E6Ue6vhbWlyIgOI=;
 b=J0TYfoxSDw9qQgGIMp8zYgAucC2cxTNFqhcWQby6tWMxHO4ilRHxWIXbaJMDA2mdIZ
 QxpdHekS/xEWvXdltlc4kxu16S3kLm7/4T+TzrY+IcZ32zux3SrKU2CwusaUmI1m7y4B
 B934svB7qHc1eHrgEy6xum5qx/fDSW8lxQNkz5XQQvsrjBRHvRnJYF5VCIxRWh6FAkw7
 qMOFuobh1ctrXYrSfVr594F/1CwCn+B7xk18MW8BVdKi3s/m590uqp+hMCbJtdgVFz6w
 NG34sGGijQSx5oqZzkG0sngxl1TitNWXqtj2d509eu8kLo43TsipRZnOukw0ENH3R2mQ
 9+oA==
X-Gm-Message-State: AOAM533pCGta/hSZutQClAlJVNtNfivKhRB9JRT+dWrEA5TA7eCsaTt3
 3yM6Pc7tXk+umF0+txom9bY4yepZmUnH4qUTb4Pnx/QeBUzp6FjiMeFmNNJ4qSJHKcvq4EliWzZ
 Eq/CjlLK2f0aVMbo=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr13644951wrs.406.1602235530641; 
 Fri, 09 Oct 2020 02:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcvBiacHedykNL8HAKOvyrfUj8UEpwJHaKg/FjIcbcsmpxGLaXVZeo2PJFGQ2xhDmLHKGEGg==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr13644929wrs.406.1602235530454; 
 Fri, 09 Oct 2020 02:25:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 4sm11769122wrn.48.2020.10.09.02.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 02:25:29 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <061f1bde-db0e-bc34-dae0-161606092bb0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a7b7018-6cb9-73bc-5305-d00fa0098bb2@redhat.com>
Date: Fri, 9 Oct 2020 11:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <061f1bde-db0e-bc34-dae0-161606092bb0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex Bennee <alex.bennee@linaro.org>, Claudio Fontana <cfontana@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 9:21 AM, Thomas Huth wrote:
> On 08/10/2020 20.24, Paolo Bonzini wrote:
>>
>>
>> Il gio 8 ott 2020, 20:05 Richard Henderson <richard.henderson@linaro.org
>> <mailto:richard.henderson@linaro.org>> ha scritto:
>>
>>      Ah, TARGET_DIRS isn't being pruned anymore when a target is disabled for
>>      lack
>>      of accelerator.
>>
>>      Paolo, side effect of 8a19980e3f ("configure: move accelerator logic to
>>      meson")?  I guess we should move the setting of TARGET_DIRS to meson as
>>      well.
>>
>>
>> TARGET_DIRS is pruned by Meson, I didn't add any back propagation to make
>> because it is not really needed; qemu-iotests only every uses the "host
>> architecture" QEMU binary (see tests/qemu-iotests/common.config),
>> check-block + --target-list has never worked.
> 
> I haven't tried since the meson conversion, but at least a couple of months
> ago, it was perfectly fine to run configure with
> --target-list=tricore-softmmu and then to run "make check-block" afterwards.
> 
> That qemu_arch setting from tests/qemu-iotests/common.config is just used
> for the preferred binary, but if it is not available,
> tests/qemu-iotests/check falls back to any other qemu-system-xxx binary that
> it can find.

I wonder if this is why the migration acceptance tests aren't run
anymore.


