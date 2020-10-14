Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991CA20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a15Q4BTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991CA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbjM-00056m-8e
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSbhk-0004Vr-DF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSbhi-000551-RT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602662410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zd2Qt3FSVgUSo4k/VbT8yUTRGJTsE+UdYE7wWf1M6/o=;
 b=a15Q4BTjNQii1Gxk7/vaza8jomZVdPRE0qoZaFg1oD2ni/69vPm5eOqpm3KBH9L6nyRgq8
 +cxAiTMMzEYcfzJyv7i3Mvey3KhgpH9PtyLuFmu/bxGzJLeTiwnSPz8iOHJAZNt48kEK65
 1350Nn3gUM7VpzKOZ7iPU2OvUID6xNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-VKqUDtuQOwClyT0imZQHSw-1; Wed, 14 Oct 2020 04:00:08 -0400
X-MC-Unique: VKqUDtuQOwClyT0imZQHSw-1
Received: by mail-wm1-f70.google.com with SMTP id g71so343714wmg.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 01:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zd2Qt3FSVgUSo4k/VbT8yUTRGJTsE+UdYE7wWf1M6/o=;
 b=ucZAFU8VBzbECJv1ay0RkcSVmeTq5AxFsLUlYIETXdzO9rKEBLoI6J7xCBEZe2lQGD
 r7XE2xP8l8ViCq7ZiONnwegKkQLy5UUCkmWD3wgFTMzha/GTJQLHLibRZgzdf1P7+Fm/
 T/MgRsFVqJzDwXRxHaXkbKkwVpszOE+ZRNl3IibZJ34KM1okwP3PMQek51/xzw4aCZh8
 J2Btf0tZmmnk9T6CCbyDluG8khJ9OLYgm4jjBsLlU/KOqJ36emmBsiX1A/5oXpNxBAhl
 CRWzmRGUjaNaH3QDBBfskHJ7YRNW32tRctm7RuJPpnFarLWJkVNiofEHySQmBogcSKyu
 DZ5g==
X-Gm-Message-State: AOAM533uIeyg939DtUPAgcLlPwr/1rb62GnRmUtqtPpKnfy8khORXn8w
 FVrGCL8djsgX7du6DqhDho7sjagHyPk9a8vdVUAUb/ghepnSRq81dIOC9JZY+cj2iwSxAePqXaD
 7MKT4lNCPSsdT0r8=
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr3861768wrw.315.1602662406782; 
 Wed, 14 Oct 2020 01:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydJblIxf7P1qF65zzA2E3/85dBBX/gxc+RtwaiGgqnqIxyybuPs8hOxHIF37/YPaXff6Gxbg==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr3861740wrw.315.1602662406606; 
 Wed, 14 Oct 2020 01:00:06 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u63sm2554501wmb.13.2020.10.14.01.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 01:00:05 -0700 (PDT)
Subject: Re: [RFC v1 0/2] tcg-cpus: split into 3 tcg variants
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014073605.6155-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad2b402f-c67e-ab07-98b3-95d929be8527@redhat.com>
Date: Wed, 14 Oct 2020 10:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014073605.6155-1-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:36 AM, Claudio Fontana wrote:
> The purpose of this series is to split the tcg-cpus into
> 3 variants:
> 
> tcg_cpus_mttcg    (multithreaded tcg vcpus)
> tcg_cpus_rr       (single threaded round robin vcpus)
> tcg_cpus_icount   (same as RR, but using icount)

Good idea!


