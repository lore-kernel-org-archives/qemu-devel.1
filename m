Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6814720835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7Wtqlis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6814720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je0Kw-0003xW-J4
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je0Jt-0003Hv-9v
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:58:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je0Jq-0008NZ-Pk
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590602301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3PgqNyZ78y/7rR+Bt0L455cKG/Yt6kEKLnM9X8+Vzo=;
 b=I7Wtqlisd+3hOc/hwps7SWCT02N7EC/fuXelcrHhmvTqhhmAhGhIsZxqKU0mMSUyBDegxN
 mgq6aGYNIZBN4ahU2o7siNHuiaJR/aVd0fVQ4APl34yBTLr51zhgKJTm0YSdbTF6RPgmeg
 O99o5cRLwg0iicFn+DCT0mLUZWw9W+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-dvu-gze3Mi-lzYcwhc0tGg-1; Wed, 27 May 2020 13:58:15 -0400
X-MC-Unique: dvu-gze3Mi-lzYcwhc0tGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 944D6107ACCA;
 Wed, 27 May 2020 17:58:12 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E8879C46;
 Wed, 27 May 2020 17:58:10 +0000 (UTC)
Subject: Re: [PATCH v7 28/32] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <e037ed54599e7bf4d76bf8cd8db1904a20ffc6dd.1590429901.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <467e4184-2cee-a9e9-9cf0-ee6050ea4319@redhat.com>
Date: Wed, 27 May 2020 12:58:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e037ed54599e7bf4d76bf8cd8db1904a20ffc6dd.1590429901.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/25/20 1:08 PM, Alberto Garcia wrote:
> This works now at the subcluster level and pwrite_zeroes_alignment is
> updated accordingly.
> 
> qcow2_cluster_zeroize() is turned into qcow2_subcluster_zeroize() with
> the following changes:
> 
>     - The request can now be subcluster-aligned.
> 
>     - The cluster-aligned body of the request is still zeroized using
>       zero_in_l2_slice() as before.
> 
>     - The subcluster-aligned head and tail of the request are zeroized
>       with the new zero_l2_subclusters() function.
> 
> There is just one thing to take into account for a possible future
> improvement: compressed clusters cannot be partially zeroized so
> zero_l2_subclusters() on the head or the tail can return -ENOTSUP.
> This makes the caller repeat the *complete* request and write actual
> zeroes to disk. This is sub-optimal because
> 
>     1) if the head area was compressed we would still be able to use
>        the fast path for the body and possibly the tail.
> 
>     2) if the tail area was compressed we are writing zeroes to the
>        head and the body areas, which are already zeroized.

Is this true?  The block layer tries hard to break zero requests up so 
that any non-cluster-aligned requests do not cross cluster boundaries. 
In practice, that means that when you have an unaligned request, the 
head and tail cluster will be the same cluster, and there is no body in 
play, so that returning -ENOTSUP is correct because there really is no 
other work to do and repeating the entire request (which is less than a 
cluster in length) is the right approach.

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h         |  4 +--
>   block/qcow2-cluster.c | 80 +++++++++++++++++++++++++++++++++++++++----
>   block/qcow2.c         | 27 ++++++++-------
>   3 files changed, 90 insertions(+), 21 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


