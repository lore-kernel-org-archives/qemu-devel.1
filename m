Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C75DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA432245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv0ikgxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA432245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrnh-0001UT-B8
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icrkp-000733-5Q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icrki-00052C-0u
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:05:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icrkh-000504-Dp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575554705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrLOjqRJEOMRhQ9wY5J+pof9or9Bev2i1+87m8yPU78=;
 b=bv0ikgxjHovZUCk/dF7VbrSMW6YgRhA9I0QbEKidL03tonCtIQ64kHvRm417oKPsY38/D2
 zNXIT2l2DYdw1/+RiYqoVk4SPfHb8xhIeixkaMlHzu1mST8+B33QsF+KrnbDzZggs8wq9m
 KFhUgwOT/Be7QdV8jG5aMPCDvES0rd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-JTm5SuTNNMGAYpEHe_m6fg-1; Thu, 05 Dec 2019 09:05:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F7B801E7E;
 Thu,  5 Dec 2019 14:05:01 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1792A1D1;
 Thu,  5 Dec 2019 14:04:59 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] block/nbd: extract the common cleanup code
To: Stefano Garzarella <sgarzare@redhat.com>, pannengyuan@huawei.com
References: <1575517528-44312-1-git-send-email-pannengyuan@huawei.com>
 <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
 <20191205094259.r4qb4jxcrom76x7f@steredhat>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d5ff2791-0171-404b-3c19-69159921586b@redhat.com>
Date: Thu, 5 Dec 2019 08:04:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205094259.r4qb4jxcrom76x7f@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JTm5SuTNNMGAYpEHe_m6fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 3:42 AM, Stefano Garzarella wrote:
> Hi Pan,
> 
> On Thu, Dec 05, 2019 at 11:45:27AM +0800, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> The BDRVNBDState cleanup code is common in two places, add
>> nbd_clear_bdrvstate() function to do these cleanups.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I only suggested this change, so I think is better to change it in:
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Concur. I'll make that change while queuing this series through my NBD 
tree for 5.0.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


