Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F0C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E0722263
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqcFZ2k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E0722263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSj9-0003e2-Fq
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUScG-0005xy-Mg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUScE-0000fj-TF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603104128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Nh+AlzCgv/TTMzdgNVBy/zbjSQKtekNGWyDOqD4uac=;
 b=gqcFZ2k4yx0Hw7aNc4el4wzOgk8AfnVMKGc9mlHIG8I3c4xTC5MCxzIo84WUBpBT0NYs5n
 rhZ4C0JHxKorriEO03ujvmn8IIbq6+R41GCSlUbfLHVJLKJGSoYne5YMVWA0MMhRbRbrLf
 MKFt6cJ4UMSc2zDFqzBuIzZD1VvClKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-BnHWYImzP0mBGq9LTpuUtQ-1; Mon, 19 Oct 2020 06:42:06 -0400
X-MC-Unique: BnHWYImzP0mBGq9LTpuUtQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so7182602wrf.22
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 03:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Nh+AlzCgv/TTMzdgNVBy/zbjSQKtekNGWyDOqD4uac=;
 b=CePZNvlHbV7oe6YkVmYbTz06tJUXR+ehVOaJm2jckurBe9ctMRtOYsXFRoZsSToK1E
 eVA2oGBm6Ljjcc8OJnJoNTZtNJClIIKAp2vNbb5zKR8hdedt+eLfwG2ND2vg5/VQ8qGL
 9CtV6HJmD+AbTosv/veUixMZFCkuZZ8JWoRua1ODjNNSvXOHQEB2KrZirz88fv8oKH4d
 EZs1nNatOQfFabTkrHZH+kUKFuXrlmORxtIklSHdCh4pcyGZi+8eZLs6/DvABofIQ/85
 F6cd+/U2wFkMHDXlRUfiVpxpyYoI3OFjwQwyokZBZaoN/eNUZyOhvu5mBcz8sS5kGICD
 HgAw==
X-Gm-Message-State: AOAM532uziZJUCbl6EFB2oMkvvwiTpIxrU4jgilC42dMlVfAZD22exDp
 RZShFgloXjGcvJDDOVY5Oc59LTitpl4CdFLvofXRHVFM7rw+Z3hmE7Hpfkr2u+RT8zgljy4T+2G
 jNu3TH0RXkbZTdPY=
X-Received: by 2002:a7b:c349:: with SMTP id l9mr2206974wmj.148.1603104125146; 
 Mon, 19 Oct 2020 03:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVR2cqOjwRHx6NirPchlktmR0rllIsUqaftuf17AIxrRkEjpZzNZlVmg5hxx5NJ9QHxCyZRg==
X-Received: by 2002:a7b:c349:: with SMTP id l9mr2206946wmj.148.1603104124969; 
 Mon, 19 Oct 2020 03:42:04 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x15sm18065312wrr.36.2020.10.19.03.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 03:42:04 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ba04f5d-eb4b-214d-3947-b84737748814@redhat.com>
Date: Mon, 19 Oct 2020 12:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019015003.1527746-5-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 3:50 AM, Cleber Rosa wrote:
> The QEMU project has two machines (aarch64 and s390) that can be used

"s390x" =)

> for jobs that do build and run tests.  This introduces those jobs,
> which are a mapping of custom scripts used for the same purpose.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.d/custom-runners.yml | 192 ++++++++++++++++++++++++++++++++
>   1 file changed, 192 insertions(+)


