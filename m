Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2818C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F522076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr1gdy1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F522076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEuD-0004O7-85
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNEmR-0005Xs-7Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNEmN-0007oj-KT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601382645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGnkF71KSv5iXOs4S3nbhTkBEFPmIHH6v8wNz/uMnxI=;
 b=Yr1gdy1QLEwG6fvLtLaq+BAPYvAn/0+8iKPDsMh7lkED8IpFJwOYSBWlgL6YmiRJCWnzY/
 ygnrdRYo4s+x08BpQ7DdaAikxj6qQclQNX6Hb1HFTc5G80eGCJ/zG+iIG8ydAemsyedyoS
 xJMrBMD/ZEI+0ktDciYZ81bQfUnERfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Oe9bK5kHNEysNCRFTtIuIQ-1; Tue, 29 Sep 2020 08:30:39 -0400
X-MC-Unique: Oe9bK5kHNEysNCRFTtIuIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD388015C3;
 Tue, 29 Sep 2020 12:30:38 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 439366198C;
 Tue, 29 Sep 2020 12:30:37 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] migration/dirtyrate: present dirty rate only when
 querying the rate has completed
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 dgilbert@redhat.com, berrange@redhat.com
References: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
 <1601350938-128320-3-git-send-email-zhengchuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1d8f5826-65fd-b2e9-9dc8-dc17f36a0105@redhat.com>
Date: Tue, 29 Sep 2020 07:30:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601350938-128320-3-git-send-email-zhengchuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, david.edmondson@oracle.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 10:42 PM, Chuan Zheng wrote:
> Make dirty_rate field optional, present dirty rate only when querying
> the rate has completed.
> The qmp results is shown as follow:
> @unstarted:
> {"return":{"status":"unstarted","start-time":0,"calc-time":0},"id":"libvirt-12"}
> @measuring:
> {"return":{"status":"measuring","start-time":102931,"calc-time":1},"id":"libvirt-85"}
> @measured:
> {"return":{"status":"measured","dirty-rate":4,"start-time":150146,"calc-time":1},"id":"libvirt-15"}

The "id":"libvirt-..." obviously come from different libvirt sessions, 
since they are in non-monotonic order.  Not a show-stopper, since it is 
only a commit comment.

> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   migration/dirtyrate.c | 3 +--
>   qapi/migration.json   | 8 +++-----
>   2 files changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


