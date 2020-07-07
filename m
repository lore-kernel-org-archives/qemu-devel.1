Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1C820771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHQfgtdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1C820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspS6-0006ZK-F4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jspQ7-00044r-LK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jspQ1-0006Xw-Nz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kkdd5WxWnfg/Oh1aqGLvBAJQFCHT+eU+NCadzFTGxdg=;
 b=XHQfgtdwJM7/N9Rzbwqyi+UTdzdjqI5VjFjyd9RQkOeHE9s3Bjszrg9l6ihSUYmqX/J74/
 fFiFGhS/0oTJ1E9TnyveYZPKxwexH4JJc2grtN4P3shHHt83G0clCgGKrL4lNJtyDNBA/T
 PfIzc7ae6cdPCptR4QQlulzlxRaRmf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-6Qa76LluMVOo5mREqdlTKw-1; Tue, 07 Jul 2020 11:21:59 -0400
X-MC-Unique: 6Qa76LluMVOo5mREqdlTKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C301940953;
 Tue,  7 Jul 2020 15:21:52 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4013A2B580;
 Tue,  7 Jul 2020 15:21:49 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:21:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qemu-img map: Don't limit block status request size
Message-ID: <20200707152147.GC7002@linux.fritz.box>
References: <20200707144629.51235-1-kwolf@redhat.com>
 <9f74d8dc-9c4e-d519-9dd7-0895ece3de17@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9f74d8dc-9c4e-d519-9dd7-0895ece3de17@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.07.2020 um 16:54 hat Eric Blake geschrieben:
> On 7/7/20 9:46 AM, Kevin Wolf wrote:
> > Limiting each loop iteration of qemu-img map to 1 GB was arbitrary from
> > the beginning, though it only cut the maximum in half then because the
> > interface a signed 32 bit byte count. These days, bdrv_block_status()
> > supports a 64 bit byte count, so the arbitrary limit is even worse.
> > 
> > On file-posix, bdrv_block_status() eventually maps to SEEK_HOLE and
> > SEEK_DATA, which don't support a limit, but always do all of the work
> > necessary to find the start of the next hole/data. Much of this work may
> > be repeated if we don't use this information fully, but query with an
> > only slightly larger offset in the next loop iteration. Therefore, if
> > bdrv_block_status() is called in a loop, it should always pass the
> > full number of bytes that the whole loop is interested in.
> > 
> > This removes the arbitrary limit and speeds up 'qemu-img map'
> > significantly on heavily fragmented images.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qemu-img.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Do you want this in 5.1?  It seems like a nice optimization.

I guess now that I have your R-b, I can sneak both patches in for soft
freeze. :-)

Kevin


