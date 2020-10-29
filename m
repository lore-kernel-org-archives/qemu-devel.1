Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683FA206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1BvkI3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683FA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9KC-0006fq-BN
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY9Ie-0005QV-0b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY9Ic-00016I-DS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603983189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KvfJlWgdHs+P7pJhQvNrLbxapi1XCfq6Rb/iIPVqtA=;
 b=b1BvkI3q7E+fMfERE4YWVks8bU0CbSTYIQkG9MhzZSqU7ehgD9Hjyx03VrvCEO14H/uVlU
 JH9ke+wUmoeU5QJ8IA6AXAal4ph53S4QN/hEbz50fMpmZYqKUbUMmhXFWlyGxQo9mbzIfo
 SSGio4nZdaoCvNRYyMXh+GyN/J98GuM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-vslN1YPJMMGo5j_SThaIwA-1; Thu, 29 Oct 2020 10:53:07 -0400
X-MC-Unique: vslN1YPJMMGo5j_SThaIwA-1
Received: by mail-ed1-f72.google.com with SMTP id b16so1275020edn.6
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1KvfJlWgdHs+P7pJhQvNrLbxapi1XCfq6Rb/iIPVqtA=;
 b=LK9x7ztmbqNfxiYZK2K3+v7R9jOsBOlQHLBvZMVyVQqqdZe1nxosHiHnEk9XLy5FTM
 kea1kzHwKaWx7HCoxVcSFC+a52sG2YRo2spw8ioTlEiOU+ZTzreenMJLFyARDifa3/U6
 D5nKKf5/qgLo1seuQSjZdw4veLhR7vA1H21lu5Ms+rTZ6hjNX97ZB0gZcNVf1z/042KJ
 1CLF7+qL8+T7m0X4ZgHGDMiB+IdF8kCqzQxGg3+yW/E69J7R9JHxNjsOTqdGnutu+o+n
 pwCgD0AeglN4dVuCGs9q3XDS99xZPUi2MA2Kz2Nd6huAkC2e0UT5mMH0XWfEih7RlzSi
 XecQ==
X-Gm-Message-State: AOAM53154fVrog/J6PJaTW+GwZVRBRrC7+4gyu9GqTObL2koD6ORRQ12
 hDXOV1pebfWumE0slsP+MiMyT4OCoquxMfkgP0yfBNCnoMawNk8OcjBzAYQgvDqeezSJRhJmIFg
 sLw/rVk8YCnsycVc=
X-Received: by 2002:aa7:d4c6:: with SMTP id t6mr4222899edr.372.1603983185320; 
 Thu, 29 Oct 2020 07:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOddx+KL4rDm+6aGlu8wQtQ+DZQLCpQdGMKVTRRUmpPfnojWgT1Vh8RM4udhJUl5k1FvV/Kw==
X-Received: by 2002:aa7:d4c6:: with SMTP id t6mr4222877edr.372.1603983185158; 
 Thu, 29 Oct 2020 07:53:05 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s25sm1565179ejc.29.2020.10.29.07.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 07:53:04 -0700 (PDT)
Subject: Re: [PATCH] hw/hyperv/vmbus.c : Don't use '#' flag of printf format
To: jokenzhang <zhangxinhao1@huawei.com>, qemu-devel@nongnu.org
References: <20201029134933.1138718-1-zhangxinhao1@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e117e456-dcd2-2716-1562-530965f78d71@redhat.com>
Date: Thu, 29 Oct 2020 15:53:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029134933.1138718-1-zhangxinhao1@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: alex.chen@huawei.com, pbonzini@redhat.com, arilou@gmail.com,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 2:49 PM, jokenzhang wrote:
> Fix code style. Don't use '#' flag of printf format ('%#') in
> format strings, use '0x' prefix instead
> 
> Signed-off-by: jokenzhang <zhangxinhao1@huawei.com>
> Signed-off-by: Kai Deng <dengkai1@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> ---
>  hw/hyperv/vmbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


