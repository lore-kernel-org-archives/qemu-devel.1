Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16276C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B2720738
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHTZ4BzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B2720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUBT-00029H-3N
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgUAd-0001BN-Hx
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:15:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgUAc-0000Wg-Ra
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591193706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Af1BKRCO+CSFVnhQO9eXoYzC4wS8VUfCEDsy9BuCjB8=;
 b=ZHTZ4BzB4xyhEJpAdSJpRvW1La7o9gcO1PEZD/nmQtz2Q8fvWQc/pf+Vo9L/rJ8rF0geSX
 LFUws7PEzpOf6pykrjyOAzxClgQ0ZDw+PMn6MxxnhVMlYvsbenjD0Xc4QYWtQlsX2GKjAs
 7TDDGzZ7wM+KRekAnq92eg7hzXz6Q+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-t_aQ9VF7N3yyOuERCi79tw-1; Wed, 03 Jun 2020 10:14:56 -0400
X-MC-Unique: t_aQ9VF7N3yyOuERCi79tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB67C8C8C76;
 Wed,  3 Jun 2020 14:14:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-187.ams2.redhat.com [10.36.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3DBE7B5F8;
 Wed,  3 Jun 2020 14:14:26 +0000 (UTC)
Date: Wed, 3 Jun 2020 16:14:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 0/2] virtio-blk: Avoid processing requests on the main
 context on restart
Message-ID: <20200603141425.GE5127@linux.fritz.box>
References: <20200603093240.40489-1-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200603093240.40489-1-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.06.2020 um 11:32 hat Sergio Lopez geschrieben:
> On restart, we were scheduling a BH to process queued requests, which
> would run before starting up the data plane, leading to those requests
> being assigned and started on coroutines on the main context.
> 
> This could cause requests to be wrongly processed in parallel from
> different threads (the main thread and the iothread managing the data
> plane), potentially leading to multiple issues.
> 
> Fixes https://bugzilla.redhat.com/show_bug.cgi?id=1812765
> 
> See "virtio-blk: Disable request queuing while switching contexts" for
> previous discussion:
> 
>  - https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00304.html

Thanks, applied to the block branch.

Kevin


