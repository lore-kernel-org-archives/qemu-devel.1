Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F45C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D97206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiJ/Svw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D97206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6eW-00037t-D5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj6dr-0002bz-3i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:44:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj6dq-0005Oh-57
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591818245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnjZZRG0wkflNR1WORyD8Iy6jpm5Iq6gcwaR4msTDFw=;
 b=GiJ/Svw8OjHMERbgwI/GCCJaSArjSgYNTGWuxRNabYFQy4fHfyXB+QVK+9ubQdW2nhbBMg
 IZ9bnYlbGbQjx3y9IxMZgBAj9VLTq97h49AE1i/2phyq7kIIK4n8/NBZn0QLA+stVxPfOa
 PFAvodPzU0JvArk7upjJG1ZygGNPOh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-8U1o5u8vOKGvqFNUwGvJiA-1; Wed, 10 Jun 2020 15:44:03 -0400
X-MC-Unique: 8U1o5u8vOKGvqFNUwGvJiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD4D108BD09;
 Wed, 10 Jun 2020 19:44:02 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AD8D7CCF0;
 Wed, 10 Jun 2020 19:43:56 +0000 (UTC)
Subject: Re: [PATCH v8 33/34] qcow2: Assert that expand_zero_clusters_in_l1()
 does not support subclusters
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1591801197.git.berto@igalia.com>
 <19afb93b267b9698edf5e0253458c5db69ef91a2.1591801197.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <abcbfa4c-c70f-3c2e-ec8f-4087b348af26@redhat.com>
Date: Wed, 10 Jun 2020 14:43:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <19afb93b267b9698edf5e0253458c5db69ef91a2.1591801197.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:44:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 10:03 AM, Alberto Garcia wrote:
> This function is only used by qcow2_expand_zero_clusters() to
> downgrade a qcow2 image to a previous version. It is however not
> possible to downgrade an image with extended L2 entries because older
> versions of qcow2 do not have this feature.

Well, it _is_ possible, but it would involve rewriting the entire L1/L2 
tables (including all internal snapshots), as well as causing I/O to COW 
every cluster where not all subclusters are allocated; and doing that 
conversion while remaining crash-consistent requires some thought and a 
temporary extra load on disk space (we can't discard the old table until 
the new one is completely written).

It would be more accurate to merely state that we are not prepared to 
implement it at this time.

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2-cluster.c      | 8 +++++++-
>   tests/qemu-iotests/061     | 6 ++++++
>   tests/qemu-iotests/061.out | 5 +++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 

Whether or not we update the commit message, R-b stands for the code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


