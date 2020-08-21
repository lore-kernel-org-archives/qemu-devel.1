Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CC320738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba2xzDpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CC320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8v6u-0001eP-EH
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8v6F-00013f-KK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 20:40:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8v6D-0004Af-E6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 20:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597970404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWucZRXYoAQPu/DGJVgoknduJu7tTepG8SzwG7/zmic=;
 b=ba2xzDpqR6vAgsnGZTpExIM3pNnbyK5es0V7du/lVzQkkTFiRpN00ITusMcRE/Ie7pdMVs
 /3zauN6ooFGxsb6PsExzP3ngp4yb9v96HruEmQVVanndG9u3qBL5LuzXil3y+POpK+T/CR
 rmusjibJU5RgEeTntWSNxL4JJCIX9MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-8g345EgAPXiQFp036xArOA-1; Thu, 20 Aug 2020 20:40:01 -0400
X-MC-Unique: 8g345EgAPXiQFp036xArOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 207D58030C3;
 Fri, 21 Aug 2020 00:40:00 +0000 (UTC)
Received: from [10.3.114.63] (ovpn-114-63.phx2.redhat.com [10.3.114.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F52D756CA;
 Fri, 21 Aug 2020 00:39:59 +0000 (UTC)
Subject: Re: [PATCH v5 3/3] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200820150725.68687-1-mreitz@redhat.com>
 <20200820150725.68687-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a556bce6-e9ed-bb3d-b792-d2606083fc90@redhat.com>
Date: Thu, 20 Aug 2020 19:39:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820150725.68687-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 20:40:04
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 10:07 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/300     | 595 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/300.out |   5 +
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 601 insertions(+)
>   create mode 100755 tests/qemu-iotests/300
>   create mode 100644 tests/qemu-iotests/300.out
> 

The changes in patch 1 helped; the test completes for me in 11 s. 
Minimal differences to v4, and the switch to discard is nice.

Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

I've gone ahead and queued this on my bitmaps tree with testing on top 
of Paolo's meson conversion; I'm prepared to send a pull request once 
that lands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


