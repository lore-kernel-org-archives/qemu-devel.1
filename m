Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E058AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A946820833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br29y0ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibi4q-00022H-Om
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibi37-0001V5-E2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibi36-0005dG-3P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:31:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26733
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibi35-0005cN-VT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575279076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/hoD+0u+dDjYhVpXJbZdoLaLC87tWFi3qSZzrNOkxw=;
 b=br29y0ks35M+nen2B6oFbnEmB/QZsGzHxU4EgtvQGSz/xHxT4FIT/MR2xUKw6wtFJbah3+
 4Hb/YRD5YpLE1c1fQYyqFGqg8ZmGXqrfSLe/ZVb6Hsw5Ph1J0o+corXU3Mxo6KjEY0WrBJ
 k3QrIljZBZTgyn9N/BV4ogroFmTd+HQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-jg4menEkM8OC5RAnKtYAsg-1; Mon, 02 Dec 2019 04:31:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so20102991wrs.17
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 01:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o/hoD+0u+dDjYhVpXJbZdoLaLC87tWFi3qSZzrNOkxw=;
 b=IO5mhaQMqxoDuxZpxQsuXvef+sm9fRlhda4CfuON9E7HWmpVv7ACmozp4LDk3QibWM
 TPyUKProoqmZd5iDra+nEcUnil46Tv3WOMkKsqBE8oUpJ0lFZCG9PJDMwEuwcjs0Htya
 6ap5KzpGh/5T5xUyZleGMc8UHx0p3Lr0zgga7n5zJoHtVI+1b7FV6dNJEi8O8ArrDf8p
 ORMESABhEbYuLv+WBTHMOXk9pnIhSpLW88vqJbBcZbkX1uwL01d9lTgAPkcmLU+imsOV
 3oBDrrLfnPqkNpSYAgX3vXLg1Vul3Q5SpIiuSDmUlwFkHtZ4D8u1dbrsoQvzulQHJN0y
 SarQ==
X-Gm-Message-State: APjAAAUJupAe9Sko6MNZRZJvRqS0/ui6fUx72IqXu2jxbYE5Hgihmo2s
 LGPetNWOAnAdzDhIOwcJcZpDh7OSG78BFY7WbB1ve5TwjmTJAYR2KffYJ4inZqBetrr3/UIPHKD
 82bforuI3uS10ueQ=
X-Received: by 2002:a5d:4386:: with SMTP id i6mr16291134wrq.63.1575279073718; 
 Mon, 02 Dec 2019 01:31:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5myrgbwNLl5pT3XXiiksqesBdjxCxjdGPzI1YpHFrNJuwwlDLnrK8Sv65GeOFtay6Kohtvg==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr16291105wrq.63.1575279073477; 
 Mon, 02 Dec 2019 01:31:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id b63sm22032882wmb.40.2019.12.02.01.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 01:31:12 -0800 (PST)
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To: "Longpeng (Mike)" <longpeng2@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
Date: Mon, 2 Dec 2019 10:31:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
Content-Language: en-US
X-MC-Unique: jg4menEkM8OC5RAnKtYAsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Gonglei <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>,
 "Longpeng\(Mike\)" <longpeng.mike@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/19 10:10, Longpeng (Mike) wrote:
> 
> Suppose there're two VMs: VM1 is bind to node-0 and calling vfio_pin_map_dma(),
> VM2 is a migrate incoming VM which bind to node-1. We found the vm_start( QEMU
> function) of VM2 will take too long occasionally, the reason is as follow.

Which part of vfio_pin_map_dma is running?  There is already a
cond_resched in vfio_iommu_map.  Perhaps you could add one to
vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the number of
pages that it returns.

Paolo


