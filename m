Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE015C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B983206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhUJB6pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B983206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZDs-0005dl-Qc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZCY-0003xT-3i
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:12:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZCX-0007ER-Cp
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589544748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8NRaxicxip2as7beCnux/SqH8VCzBaL3OCV1iVai6Pc=;
 b=UhUJB6pFzBolaittDIHiNHuK+DPylO7uEgRw28MC3FvM5o2Zcz70AcWzQWSGqh/X3eyQ6q
 EKGlxrhn2E5wWxMsVD3CUcT9pPOYTGdEJr/sUU/FFSJ4ZlifG5l46/+W7FbqHSxcFPCY3F
 4MhnLsN6Dy1/1jj0mG9vAnLdRgetugw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-pGNfJ54WNQO08mx_IC6AvA-1; Fri, 15 May 2020 08:12:23 -0400
X-MC-Unique: pGNfJ54WNQO08mx_IC6AvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED15D107ACF2;
 Fri, 15 May 2020 12:12:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B756272A5;
 Fri, 15 May 2020 12:12:19 +0000 (UTC)
Date: Fri, 15 May 2020 14:12:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH] replication: Avoid blk_make_empty() on read-only child
Message-ID: <20200515121217.GH93011@linux.fritz.box>
References: <20200515120318.188831-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515120318.188831-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: wencongyang2@huawei.com, xiechanglong.d@gmail.com, lukasstraub2@web.de,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.05.2020 um 14:03 hat Kevin Wolf geschrieben:
> This is just a bandaid to keep tests/test-replication working after
> bdrv_make_empty() starts to assert that we're not trying to call it on a
> read-only child.
> 
> For the real solution in the future, replication should not steal the
> BdrvChild from its backing file (this is never correct to do!), but
> instead have its own child node references, with the appropriate
> permissions.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I'll commit this patch for now so the brokenness of the replication
driver won't stop my pull request, but this is really not how things
should work.

Can someone who is interested in replication have a look at the real
solution, please? It's not trivial enough for me to fix it without
learning a lot about using replication first.

Essentially, the problem is that you can't just copy the BdrvChild from
bs->backing like replication_start() does, but you need to use
bdrv_attach_child() to attach the respective node directly to bs, too.
This gives you the opportunity to request the write permissions you need
for bdrv_make_empty().

However, it seems that during replication_start(), the backing file
isn't writable yet (which is not surprising, backing files are supposed
to be read-only), so my attempt to request write permissions right there
failed. So it seems we need to figure out where the backing file becomes
writable and then take write permissions after this point. Or make it
writable earlier. I don't understand enough about the whole setup to
figure out where this should happen, which is why I'm asking you.

Kevin


