Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394392222F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOj8Iuvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394392222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn7t-0005xO-5g
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUn6M-0003UQ-Jn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUn6K-0000lu-OI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyhKBy6pP8AvqUTYQWJUwu8uDYbcDAWVVcKvmck2xwo=;
 b=KOj8IuvvsydRKMgK3FhrpNZn5Q1SiVgH85zP5UlN1cE1IpBelWhC481d1CSwLS7hAMZz2r
 isXsFMlkgpX30vjY5zAWT1koBg4eJTC5KQVVp5AWxt7SsA6zd/gPuTci7xlUZ5/kKaCa+J
 zK/JQcMABRKeHT1HZILaq7bSOD7OjH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-X2jW6HnzO7OCbSgsqvRwhQ-1; Tue, 20 Oct 2020 04:34:32 -0400
X-MC-Unique: X2jW6HnzO7OCbSgsqvRwhQ-1
Received: by mail-wr1-f72.google.com with SMTP id 2so508230wrd.14
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 01:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uyhKBy6pP8AvqUTYQWJUwu8uDYbcDAWVVcKvmck2xwo=;
 b=VYLPe9k2VDVT2qBWXaO1nsLnjERfj7TBikWemvMbCOAb5f9ElhI8EquuqBKReD7ayE
 rN1sVZslgexnDphP0ymIploLL75vtdyxxZ/vHPjYte3NiYSU/MD9MZHuZFHox+skql35
 Px4zA+dvcpvylABS/qcGshs4ld13nJVItrpUb0YT6HRn4k1076n+7ZN5ecPwtpeEYYIP
 SHvIOCrD5zkGE3K1Wy/7hMmq64TFalSAvAlsZuJIdS0lY9qzIvf/K1xmM2xXnFN6TTf0
 5um9IBnAV2/AAPWIb6WM2WR6vK6DSEvOunHccktHgxn609Gp2P5QfLfhqIntBB6MuEBR
 Ukgg==
X-Gm-Message-State: AOAM533HHJ0SzzRjuCRwE8w8rAHWAYs+X4VWwXV0HlDnXsyXPg2sdafq
 tKvjVYAtGwYkIOkxrJSsUsGcoQ6JRocMld5tZDoJ0ssaRC4SV7l2eXHy62Rf7GeaZx4OwvwBoiD
 WILe2cbzOiEn6Iqo=
X-Received: by 2002:a1c:e082:: with SMTP id x124mr1670199wmg.60.1603182871471; 
 Tue, 20 Oct 2020 01:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWY1WazRvOKIEHzBIi+Sc8vzWPsTsUeeQzMNJM8vuTI2ZW7KYHaBnnS0UkEHOKdHkhMaYg8Q==
X-Received: by 2002:a1c:e082:: with SMTP id x124mr1670165wmg.60.1603182871158; 
 Tue, 20 Oct 2020 01:34:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h4sm1904891wrv.11.2020.10.20.01.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:34:30 -0700 (PDT)
Subject: Re: [PATCH v4] migration: using trace_ to replace DPRINTF
To: Bihong Yu <yubihong@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1603182706-2421-1-git-send-email-yubihong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d67e4a48-dfc4-28cf-e99e-9462ed0a6e41@redhat.com>
Date: Tue, 20 Oct 2020 10:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603182706-2421-1-git-send-email-yubihong@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: alex.chen@huawei.com, zhengchuan@huawei.com, wanghao232@huawei.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 10:31 AM, Bihong Yu wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> ---
>   migration/block.c      | 36 ++++++++++++++++++------------------
>   migration/page_cache.c | 13 +++----------
>   migration/trace-events | 13 +++++++++++++
>   3 files changed, 34 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


