Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97434C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203DA206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU2dkgiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203DA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoYw-00068f-73
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jkoYJ-0005UY-M4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:49:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jkoYH-0005h2-H2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592225363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfG3WVRbg7cxH2MKYIbYBTQJVxgJVT42S0QeT/YXXjw=;
 b=LU2dkgiPWMBSK40lkdrR2S/qCELA4/EoGfRxydK0MJ1jUAcKqY2BkeVQr6wf8fB6iU78qf
 4TOMHfTylzj85VL1fnyipPVOub4jKjMCk01kqNAEyPfJDb12ig0sxgWKAjt2cZ4poUqTu9
 IDFto7Y9NFrdwhqCMC2z4cXoCCaoGtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-3O9BOnXTMt6wEGVuTW5hfw-1; Mon, 15 Jun 2020 08:49:22 -0400
X-MC-Unique: 3O9BOnXTMt6wEGVuTW5hfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E3280330D;
 Mon, 15 Jun 2020 12:49:20 +0000 (UTC)
Received: from work-vm (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2075F10013D6;
 Mon, 15 Jun 2020 12:49:15 +0000 (UTC)
Date: Mon, 15 Jun 2020 13:49:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH v3 0/4] block: seriously improve savevm performance
Message-ID: <20200615124913.GL2883@work-vm>
References: <20200611171143.21589-1-den@openvz.org>
 <20200615121714.GJ2883@work-vm>
 <6931b77c-73ad-010a-daf3-8c7c99c20d10@openvz.org>
MIME-Version: 1.0
In-Reply-To: <6931b77c-73ad-010a-daf3-8c7c99c20d10@openvz.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis V. Lunev (den@openvz.org) wrote:
> On 6/15/20 3:17 PM, Dr. David Alan Gilbert wrote:
> > * Denis V. Lunev (den@openvz.org) wrote:
> >> This series do standard basic things:
> >> - it creates intermediate buffer for all writes from QEMU migration code
> >>   to QCOW2 image,
> >> - this buffer is sent to disk asynchronously, allowing several writes to
> >>   run in parallel.
> >>
> >> In general, migration code is fantastically inefficent (by observation),
> >> buffers are not aligned and sent with arbitrary pieces, a lot of time
> >> less than 100 bytes at a chunk, which results in read-modify-write
> >> operations with non-cached operations. It should also be noted that all
> >> operations are performed into unallocated image blocks, which also suffer
> >> due to partial writes to such new clusters.
> > It surprises me a little that you're not benefiting from the buffer
> > internal to qemu-file.c
> >
> > Dave
> There are a lot of problems with this buffer:
> 
> Flushes to block driver state are performed in the abstract places,
> pushing
>   a) small IO
>   b) non-aligned IO both to
>        1) page size
>        2) cluster size
> It should also be noted that buffer in QEMU file is quite small and
> all IO operations with it are synchronous. IO, like ethernet, wants
> good queues.

Yeh, for ethernet we immediately get the kernels buffer so it's not too
bad; and I guess the async page writes are easier as well.

Dave

> The difference is on the table.
> 
> Den
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


