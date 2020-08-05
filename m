Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D665C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B84A2311D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiZr+xH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B84A2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3KEo-0003Gr-BK
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3KEC-0002mC-Bz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:17:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3KE6-0008E5-Np
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596637025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSY8qElaGGCZ187SZTc10316fi4nqDOusIytLVTIWGs=;
 b=IiZr+xH2fkFBocJww5SR9vfrtzeiQ3rOEYpS/Le5vgBQ2GJzrkdaKx14SWb+/hAWjqBG47
 DLkxuVeGcCJ9gLT3bQ53geDERgb4iioW2Tj4HX40oQ/ZTnyA6Z/jZPWFAHcbO+dvz1k8Ow
 nt+BTxqln1yV1fA8HLGwZBvlwFd2/p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-7HKhGLKQNZSyNakRlIVRsw-1; Wed, 05 Aug 2020 10:17:01 -0400
X-MC-Unique: 7HKhGLKQNZSyNakRlIVRsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83FE81009440;
 Wed,  5 Aug 2020 14:17:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F05865C1BD;
 Wed,  5 Aug 2020 14:16:58 +0000 (UTC)
Date: Wed, 5 Aug 2020 16:16:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
Message-ID: <20200805141657.GA37318@linux.fritz.box>
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
 <w51imdxb42f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51imdxb42f.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Chengchiwen <chengchiwen@h3c.com>, Tuguoyi <tu.guoyi@h3c.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Gaoliang <liang_gao@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.08.2020 um 15:44 hat Alberto Garcia geschrieben:
> On Wed 05 Aug 2020 11:22:58 AM CEST, Tuguoyi wrote:
> > This patch fix it by casting @i to uint64_t before doing left shift
> > operation
> 
> The patch seems fine and I also think that it's perhaps worth a test
> case (although it only seems to happen with preallocation=falloc or full
> so the test would need to generate very large files).
> 
> But I also wonder if there are other cases where this can happen.
> 
> nb_clusters is an int and there are more cases of
> 
>     nb_clusters << s->cluster_bits
> 
> I can see at least these: handle_alloc(), qcow2_free_any_clusters(),
> qcow2_alloc_cluster_abort().

Actuallyx, handle_alloc() and everything that comes from it should be
fine. It has a uint64_t nb_clusters locally and limits it:

    nb_clusters = MIN(nb_clusters, INT_MAX >> s->cluster_bits);

The problematic request that causes the crash comes actually from
qcow2_co_truncate(). It limits it only to s->l2_slice_size, which can be
larger than that, but will be at most 256k (= 2 MB / sizeof(uint64_t)).

cow_end.offset will get a wraparound then, too. This is harmless because
cow_end.nb_bytes = 0, so the offset will be ignored anyway.

I think the proper fix to be made in the 5.2 release cycle would revert
this one and instead fix the limit in qcow2_co_truncate().

But this one is good enough as a band-aid for 5.1.

Kevin


