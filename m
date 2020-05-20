Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7DFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE0F2072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1N+mWex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE0F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ4m-0007so-GL
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbQ2O-0003u1-8Y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:49:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbQ2M-0003FY-V7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589986177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFfaF4cdAmLHdNpjzjWuUnIrxNi3+JP/HgQpXG1wINc=;
 b=Y1N+mWexH6Lfu3DMzXW2QKtMuUyPBnY9OReQZpC96ZCpsYwxWGsjh/vh3wAFYZQOq09yq3
 tLO9L7Gc9/3bOirzK7lk7NYlzaGCPqLsHAq/IxjcbRyVPjVew0U46maX9Bo56gOhSbrL0U
 BHMvRzlG+VxKOUTQoUa1ZhV+F5+6Lb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-03c1PbZ_PPirPKehGYORjQ-1; Wed, 20 May 2020 10:49:35 -0400
X-MC-Unique: 03c1PbZ_PPirPKehGYORjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55019835B40;
 Wed, 20 May 2020 14:49:34 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13DC570461;
 Wed, 20 May 2020 14:49:29 +0000 (UTC)
Date: Wed, 20 May 2020 16:49:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2] block: Factor out bdrv_run_co()
Message-ID: <20200520144928.GC5192@linux.fritz.box>
References: <20200519175650.31506-1-vsementsov@virtuozzo.com>
 <20200520140500.GB5192@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200520140500.GB5192@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.05.2020 um 16:05 hat Kevin Wolf geschrieben:
> Am 19.05.2020 um 19:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > We have a few bdrv_*() functions that can either spawn a new coroutine
> > and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
> > alreeady running in a coroutine. All of them duplicate basically the
> > same code.
> > 
> > Factor the common code into a new function bdrv_run_co().
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >    [Factor out bdrv_run_co_entry too]
> > ---
> > 
> > Hi!
> > 
> > I'm a bit lost on rebasing "block/io: safer inc/dec in_flight sections"
> > (is it needed or not?), so, I decided to send just this one patch:
> > 
> > I suggest to go a bit further, and refactor that bdrv_run_co don't need
> > additional *ret argument neither NOT_DONE logic.
> 
> Hm, this approach adds another indirection and bdrv_pread/pwrite still
> seems to be on some hot paths. But maybe this is just the right
> motivation to clean up qcow2 a bit and use explicit bdrv_co_*() where it
> is possible. I might take a look later.

Still not easily possible it seems. We can add a few coroutine_fn
markers here and there (and probably should do that), but the
interesting I/O is in the Qcow2Cache, which is used from basically
everywhere.

Kevin


