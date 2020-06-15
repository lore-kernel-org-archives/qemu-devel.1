Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FB5206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXf9rTz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FB5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jko4k-00082B-V7
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jko3q-0007Dp-05
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jko3n-0008RX-C3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592223474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ordz9iO3BG1lbI8AD4sxh2/I2riuv6ylgnUjX3ww8nE=;
 b=IXf9rTz6oQD/Qmr8dkpk2nKyS1VbeAVEqAXrS0Qk4I/SKRffHRSbfmWlFAVBSUh3rIpSur
 xcLRlu8j4V5ireBPsGPEQqInZQqfY5nN953xz7kiEb33/9u9ADFW8pY0KdyAcdXnvoimDM
 UDUvg6CjTHoV0gjcEayDB4GtYh01YZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-GGVT1SySP2qpligXBjgLMg-1; Mon, 15 Jun 2020 08:17:50 -0400
X-MC-Unique: GGVT1SySP2qpligXBjgLMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5972091184;
 Mon, 15 Jun 2020 12:17:21 +0000 (UTC)
Received: from work-vm (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD891992D;
 Mon, 15 Jun 2020 12:17:16 +0000 (UTC)
Date: Mon, 15 Jun 2020 13:17:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH v3 0/4] block: seriously improve savevm performance
Message-ID: <20200615121714.GJ2883@work-vm>
References: <20200611171143.21589-1-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200611171143.21589-1-den@openvz.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis V. Lunev (den@openvz.org) wrote:
> This series do standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>   to QCOW2 image,
> - this buffer is sent to disk asynchronously, allowing several writes to
>   run in parallel.
> 
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations with non-cached operations. It should also be noted that all
> operations are performed into unallocated image blocks, which also suffer
> due to partial writes to such new clusters.

It surprises me a little that you're not benefiting from the buffer
internal to qemu-file.c

Dave

> This patch series is an implementation of idea discussed in the RFC
> posted by Denis Plotnikov
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01925.html
> Results with this series over NVME are better than original code
>                 original     rfc    this
> cached:          1.79s      2.38s   1.27s
> non-cached:      3.29s      1.31s   0.81s
> 
> Changes from v2:
> - code moved from QCOW2 level to generic block level
> - created bdrv_flush_vmstate helper to fix 022, 029 tests
> - added recursive for bs->file in bdrv_co_flush_vmstate (fix 267)
> - fixed blk_save_vmstate helper
> - fixed coroutine wait as Vladimir suggested with waiting fixes from me
> 
> Changes from v1:
> - patchew warning fixed
> - fixed validation that only 1 waiter is allowed in patch 1
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


