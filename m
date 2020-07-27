Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E28C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3320719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emhkCV8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzysK-0005HE-Ms
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jzyrf-0004Sg-Ec
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:52:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jzyrd-0007ck-Sc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595839925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JE8bRvRZ2LbS6XY2YQrOa+bXwl7Kz2kCEMdKbjINl4I=;
 b=emhkCV8/X3wnwGF9AdwbhfNDzttfC8GZNKXFIPNg/B0vHaMgvBV2RVpFOrSvOYkVBb7d1B
 q7aEhMNLqTGkn0hlo3DRkJ3yO9WllVOgrgfDV//jsp9AiuefV8Z6QBu59UNJYynnGd7Zzz
 5OV4Udfmmrz2k1yA7In2xtbKy4jqpfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-sVstTrNtMoGcV5y6efZnLA-1; Mon, 27 Jul 2020 04:52:03 -0400
X-MC-Unique: sVstTrNtMoGcV5y6efZnLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1A680046F
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:52:02 +0000 (UTC)
Received: from [10.72.12.200] (ovpn-12-200.pek2.redhat.com [10.72.12.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C32160F96;
 Mon, 27 Jul 2020 08:51:54 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
To: Cornelia Huck <cohuck@redhat.com>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727104404.35d7225c.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce0c43f7-52e2-b8cd-1a3d-1e1f6562418e@redhat.com>
Date: Mon, 27 Jul 2020 16:51:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727104404.35d7225c.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/27 下午4:44, Cornelia Huck wrote:
> On Mon, 27 Jul 2020 15:43:28 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> typo in subject: s/accesing/accessing/
>
>> We try to get config from peer unconditionally which may lead NULL
> s/lead/lead to a/
>
>> pointer dereference. Add a check before trying to access the config.
>>
>> Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
>> Cc: Cindy Lu <lulu@redhat.com>
>> Tested-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>


Applied with the above fixed.

Thanks


