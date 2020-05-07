Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920ACC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555C020659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMWqnoei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555C020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiqS-0002jW-Ey
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWipp-00027x-PV
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:53:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWipo-0006hU-W0
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588866796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSZddnsp8jEPx7h0z/Hz/dIZF58ZoUoXvhBYlewlvOE=;
 b=eMWqnoeiD6F1GZtd4reJZeXgsiaptW/DOdeZ/DUOmYcR0nVj+3pXiwcuB0bLN3gnuvtI9Q
 OsXgt+ES0uT4kEGAMIPifxEVIg8jb6CgcYh2BbnfOhpVcmjNMQ398JLPRdKXh3IXS6krK3
 H4mwAOQi9hBV/tcZR4RRUwc0u4Taeho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-vOcIRJQ6O0iJPFmIdHcmNQ-1; Thu, 07 May 2020 11:53:05 -0400
X-MC-Unique: vOcIRJQ6O0iJPFmIdHcmNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 969B08018A5;
 Thu,  7 May 2020 15:53:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E7D75D9DC;
 Thu,  7 May 2020 15:53:02 +0000 (UTC)
Date: Thu, 7 May 2020 17:53:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 5/5] block/block-copy: use aio-task-pool API
Message-ID: <20200507155300.GG6019@linux.fritz.box>
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
 <20200429130847.28124-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200429130847.28124-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.04.2020 um 15:08 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Run block_copy iterations in parallel in aio tasks.
>=20
> Changes:
>   - BlockCopyTask becomes aio task structure. Add zeroes field to pass
>     it to block_copy_do_copy
>   - add call state - it's a state of one call of block_copy(), shared
>     between parallel tasks. For now used only to keep information about
>     first error: is it read or not.
>   - convert block_copy_dirty_clusters to aio-task loop.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> @@ -519,6 +591,7 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
>          }
>          if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>              block_copy_task_end(task, 0);
> +            g_free(task);
>              progress_set_remaining(s->progress,
>                                     bdrv_get_dirty_count(s->copy_bitmap) =
+
>                                     s->in_flight_bytes);
>              trace_block_copy_skip_range(s, task->offset, task->bytes);
>              offset =3D task_end(task);
>              bytes =3D end - offset;

Coverity found this use after free for task. Please fix.

Kevin


