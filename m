Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F399C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5EF206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTTdpCkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5EF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTAg-0004Yx-FC
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYT9p-0003Tr-6j
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:33:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYT9o-0006iI-97
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589283187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=humsqq0UQJSXbVwJpOATzrWoKVEJNugwaRhXcYJ/LX4=;
 b=BTTdpCkAKBCUvurGqQPkGNLHirvEp3vTnLKGApVvVwRpSxQMZpA+AZkjdyEdQMbZHkOuEp
 S6RrCblHgeMx43kUocE5yESICpcGEMvSHjIvKcM2nMbWya25D9Gk7pDdMxItZOK6nwxZni
 z4XXWMnR73j96V7yIDVjWocWt+HpmVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-angsQK-eP3-wbzMvmQWB2g-1; Tue, 12 May 2020 07:33:05 -0400
X-MC-Unique: angsQK-eP3-wbzMvmQWB2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B8D872FE2;
 Tue, 12 May 2020 11:33:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39EEA5D9DD;
 Tue, 12 May 2020 11:32:57 +0000 (UTC)
Date: Tue, 12 May 2020 13:32:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [RFC] bdrv_flush: only use fast path when in owned AioContext
Message-ID: <20200512113255.GK5951@linux.fritz.box>
References: <20200511165032.11384-1-s.reiter@proxmox.com>
 <20200512105719.GI5951@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200512105719.GI5951@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.05.2020 um 12:57 hat Kevin Wolf geschrieben:
> Am 11.05.2020 um 18:50 hat Stefan Reiter geschrieben:
> > Just because we're in a coroutine doesn't imply ownership of the context
> > of the flushed drive. In such a case use the slow path which explicitly
> > enters bdrv_flush_co_entry in the correct AioContext.
> > 
> > Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> > ---
> > 
> > We've experienced some lockups in this codepath when taking snapshots of VMs
> > with drives that have IO-Threads enabled (we have an async 'savevm'
> > implementation running from a coroutine).
> > 
> > Currently no reproducer for upstream versions I could find, but in testing this
> > patch fixes all issues we're seeing and I think the logic checks out.
> > 
> > The fast path pattern is repeated a few times in this file, so if this change
> > makes sense, it's probably worth evaluating the other occurences as well.
> 
> What do you mean by "owning" the context? If it's about taking the
> AioContext lock, isn't the problem more with calling bdrv_flush() from
> code that doesn't take the locks?
> 
> Though I think we have some code that doesn't only rely on holding the
> AioContext locks, but that actually depends on running in the right
> thread, so the change looks right anyway.

Well, the idea is right, but the change itself isn't, of course. If
we're already in coroutine context, we must not busy wait with
BDRV_POLL_WHILE(). I'll see if I can put something together after lunch.

Kevin


