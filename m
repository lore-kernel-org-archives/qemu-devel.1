Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2044C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAB820848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV8waHTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAB820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSg9h-0004lp-2G
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSg7L-0003EG-DA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSg7J-0007Wz-IH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602679372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BB0DH3IlqPAwK56khGbPsoOfz6T0CcE/uTlI4hD3MgY=;
 b=gV8waHTSpWxO1XULCjRggk+8uElC3PTjngcQTE3BSN95yMsazLSckM2LmsVrsJI5VSKqLE
 L3gTuYuTfa7pwStcJeApxpdGh4CEObmtUJySXUDgIYOcjOxVXB0NC9zCqcL+zPzBU6Lru2
 5j3Mpottq96dWXqr6N+B6hMbInORPF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-ImVL5t1CMLaFvaxMLQZRUQ-1; Wed, 14 Oct 2020 08:42:51 -0400
X-MC-Unique: ImVL5t1CMLaFvaxMLQZRUQ-1
Received: by mail-wr1-f70.google.com with SMTP id a15so1236428wrx.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BB0DH3IlqPAwK56khGbPsoOfz6T0CcE/uTlI4hD3MgY=;
 b=KjFgliV5p299KLfJ7+4GBFUC2/yx9i61GsOBvoWQIQG0Ybf/a/vAwfVu1Cvfw4RtXj
 bmcgpaFb+u+79KSj8VMDhgJhNG5rznvOYsVki7+fbSahhgqb02QQZzqMWYOKIeuYIifS
 w+0sJOEE51Nu1PK7ySDl5J5N6dJ56IAvLQiNmdZQMThV6E3Wfr1NQxAK2oeEv0cqRKjs
 Jc/umVVQ37LsHr+Bnlbem8AYn5PUvsWjQKbiAJKTYvpdM7XN6DpFzopGXcM9N4EoU6OL
 f+Zdm7sHQ/4S/wVQjpGKGP+h54yvr1WRpGwdaY4IUr/olKqknv+UIXbU+svcrmh8XAep
 BciQ==
X-Gm-Message-State: AOAM531Iy8HE1sAVzc2nfJwaAZo65pBdkwpL0mNUurPLWnoNARVCAWc4
 3SaTn7PEbVZZlP6YMc3T0rNSKDqNW399OrUji4USDJK0mEEa+PI8ahvhGbhr8aYNRi6+4+cRK4O
 rk+BMgwvKBfKuQlY=
X-Received: by 2002:adf:f903:: with SMTP id b3mr5515603wrr.142.1602679370039; 
 Wed, 14 Oct 2020 05:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR6A8tlFSxuRrkieih24Vj+dVjJM1iNcbNQbOsG4jeD1A+y8zyRi21vLms06h017fA2nlJzQ==
X-Received: by 2002:adf:f903:: with SMTP id b3mr5515586wrr.142.1602679369872; 
 Wed, 14 Oct 2020 05:42:49 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q6sm3725249wma.0.2020.10.14.05.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 05:42:49 -0700 (PDT)
Subject: Re: [PATCH 0/9] util/vfio-helpers: Improve debugging experience
To: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
References: <20201014115253.25276-1-philmd@redhat.com>
 <9d08c9ab6310a5f0c796c4d98d1c51f071802369.camel@euphon.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81d80fdd-e2f2-db5c-f358-e28eeb291c82@redhat.com>
Date: Wed, 14 Oct 2020 14:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9d08c9ab6310a5f0c796c4d98d1c51f071802369.camel@euphon.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 2:34 PM, Fam Zheng wrote:
> On Wed, 2020-10-14 at 13:52 +0200, Philippe Mathieu-Daudé wrote:
>> A bunch of boring patches that have been proven helpful
>> while debugging.
>>
>> Philippe Mathieu-Daudé (9):
>>    util/vfio-helpers: Improve reporting unsupported IOMMU type
>>    util/vfio-helpers: Trace PCI I/O config accesses
>>    util/vfio-helpers: Trace PCI BAR region info
>>    util/vfio-helpers: Trace where BARs are mapped
>>    util/vfio-helpers: Improve DMA trace events
>>    util/vfio-helpers: Convert vfio_dump_mapping to trace events
>>    util/vfio-helpers: Let qemu_vfio_dma_map() propagate Error
>>    util/vfio-helpers: Let qemu_vfio_do_mapping() propagate Error
>>    util/vfio-helpers: Let qemu_vfio_verify_mappings() use
>> error_report()
>>
>>   include/qemu/vfio-helpers.h |  2 +-
>>   block/nvme.c                | 14 ++++----
>>   util/vfio-helpers.c         | 66 +++++++++++++++++++++------------
>> ----
>>   util/trace-events           | 10 ++++--
>>   4 files changed, 54 insertions(+), 38 deletions(-)
>>
>> -- 
>> 2.26.2
>>
>>
>>
> 
> Modular the g_strdup_printf() memleak I pointed out:
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>

Thanks!


