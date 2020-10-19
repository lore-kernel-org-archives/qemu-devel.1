Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B5222276
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT3S294Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B5222276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXuE-00011q-I1
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUXkB-0000DA-9R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUXk8-0002aU-Rk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603123839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bXf/sm3rbvlVxPMd+9TZ7dJFZQs3mg1cwfZooT8UbaQ=;
 b=FT3S294ZZntMn+e4rSX2iuntbEWHve0TIVDcfdi6BnlwOoYcushdKPoEgzqbcS1jk67X/y
 rp3DAg/owQIEbaTH+ttmToD+zgNCaA+0cWs0T8C04AxWHvYOF4ZSptOb11eCw0QjFpr/H7
 5s0ZrfwSjbUxAUwknI+bYjRwGIkqVzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-SKma8qENNRicNjuHZn0aiQ-1; Mon, 19 Oct 2020 12:10:36 -0400
X-MC-Unique: SKma8qENNRicNjuHZn0aiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B3A610055B6;
 Mon, 19 Oct 2020 16:10:34 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-121.ams2.redhat.com [10.36.114.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 219841A837;
 Mon, 19 Oct 2020 16:10:27 +0000 (UTC)
Date: Mon, 19 Oct 2020 18:10:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 02/13] block: use return status of bdrv_append()
Message-ID: <20201019161026.GF6508@merkur.fritz.box>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
 <20201016171057.6182-3-vsementsov@virtuozzo.com>
 <20201019121302.GD6508@merkur.fritz.box>
 <87v9f62p8o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87v9f62p8o.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, berto@igalia.com,
 stefanha@redhat.com, qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.10.2020 um 17:45 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 16.10.2020 um 19:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> Now bdrv_append returns status and we can drop all the local_err things
> >> around it.
> >> 
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> Reviewed-by: Alberto Garcia <berto@igalia.com>
> >> ---
> >>  block.c                     |  5 +----
> >>  block/backup-top.c          | 20 ++++++++------------
> >>  block/commit.c              |  5 +----
> >>  block/mirror.c              |  6 ++----
> >>  blockdev.c                  |  4 +---
> >>  tests/test-bdrv-graph-mod.c |  6 +++---
> >>  6 files changed, 16 insertions(+), 30 deletions(-)
> >> 
> >> diff --git a/block.c b/block.c
> >> index b05fbff42d..7b6818c681 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -3161,7 +3161,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
> >>      int64_t total_size;
> >>      QemuOpts *opts = NULL;
> >>      BlockDriverState *bs_snapshot = NULL;
> >> -    Error *local_err = NULL;
> >>      int ret;
> >>  
> >>      /* if snapshot, we create a temporary backing file and open it
> >> @@ -3208,9 +3207,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
> >>       * order to be able to return one, we have to increase
> >>       * bs_snapshot's refcount here */
> >>      bdrv_ref(bs_snapshot);
> >> -    bdrv_append(bs_snapshot, bs, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> +    if (bdrv_append(bs_snapshot, bs, errp) < 0) {
> >
> > We generally avoid calling functions with side effects inside a
> > comparison. Let's use the usual pattern:
> >
> >     ret = bdrv_append(bs_snapshot, bs, errp);
> >     if (ret < 0) {
> >         ...
> >     }
> 
> I'd also advice against buring side effects too deep, but calling a
> function in a failure-checking conditional is pretty benign.  It's also
> common:
> 
>     $ git-grep 'if ([a-z].*) < 0) {'
> 
> coughs up several hundred instances.
> 
> That said, there is none in block.c.  Local consistency matters.

Actually, after looking at the rest of the series, I also need to be a
bit more specific: We do have boolean if (!foo()), it's just the
negative errno ones that aren't very common in the block layer.

And the reason why it's not very common is probably that 0/-errno is
very common in the block layer and a check for < 0 just throws the
specific errno away. We had a lot of such code, which was wrong because
it lost information instead of passing the real error to the caller.
I guess this is the real origin of the block layer habits to avoid it.

Kevin


