Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06554C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB6B2065C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9rrLbqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB6B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JfB-0007CB-26
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3JeG-0006O8-FB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:40:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3JeD-0003lT-VU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596634800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j09PPiOHa6Ey85gKlAuEqHp2BrLWt46v2HqKTGCudCY=;
 b=A9rrLbqBsyrRv+2qc3Hb6czRMakRlCj928pMAmJHRUdfPxWtd4nfVB0DG6AoUytM11hOJg
 INBtF9mKLOOYquxWG/sdqPAuB/aKLRwKr6gQp11JsMfGys+ea6wXQFewX6SLtL/+hnYInQ
 x2/SGwejWX/1ifdFFD49NL3ogQB5nKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-ZPXC7n1wNC2Xry6qwOFZNw-1; Wed, 05 Aug 2020 09:39:58 -0400
X-MC-Unique: ZPXC7n1wNC2Xry6qwOFZNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20F1919057A9;
 Wed,  5 Aug 2020 13:39:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C0A712C5;
 Wed,  5 Aug 2020 13:39:54 +0000 (UTC)
Date: Wed, 5 Aug 2020 15:39:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Tuguoyi <tu.guoyi@h3c.com>
Subject: Re: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
Message-ID: <20200805133953.GC4679@linux.fritz.box>
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
MIME-Version: 1.0
In-Reply-To: <81ba90fe0c014f269621c283269b42ad@h3c.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Chengchiwen <chengchiwen@h3c.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Gaoliang <liang_gao@h3c.com>,
 Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.08.2020 um 11:22 hat Tuguoyi geschrieben:
> When calculating the offset, the result of left shift operation will be promoted
> to type int64 automatically because the left operand of + operator is uint64_t.
> but the result after integer promotion may be produce an error value for us and
> trigger the following asserting error.
> 
> For example, consider i=0x2000, cluster_bits=18, the result of left shift
> operation will be 0x80000000. Cause argument i is of signed integer type,
> the result is automatically promoted to 0xffffffff80000000 which is not
> we expected
> 
> The way to trigger the assertion error:
>   qemu-img create -f qcow2 -o preallocation=full,cluster_size=256k tmpdisk 10G
> 
> This patch fix it by casting @i to uint64_t before doing left shift operation
> 
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


