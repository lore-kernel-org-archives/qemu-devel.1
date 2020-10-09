Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A497E2225B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQnozE+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A497E2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQoxD-0004Ac-IM
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kQowJ-0003eW-2K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kQowG-0005tp-Dz
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602236625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Hn8empWm22kvuqB081gaunuBvy0+03sumwluMnt6fg=;
 b=BQnozE+wDjv2fgA8NoNhHSMc6Hw4uD5mQlqFpokFjVbu7rkIiChKTEkcun2TACsfdW+8VU
 QTXuLfj/UL0K2kpm6T/QUoVvA/W8VsXDXkuC8XV8pxIeg+N6+arc+ZF0WgSAYyF6m4VGgT
 n+wCcWIrc62vLzYxK5A6INcw9H6a+rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-it5sILZFMR2uPwpz4BT24g-1; Fri, 09 Oct 2020 05:43:41 -0400
X-MC-Unique: it5sILZFMR2uPwpz4BT24g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 023D3425F1;
 Fri,  9 Oct 2020 09:43:40 +0000 (UTC)
Received: from localhost (ovpn-113-15.ams2.redhat.com [10.36.113.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F55876641;
 Fri,  9 Oct 2020 09:43:39 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:43:37 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 1/2] error: Remove NULL checks on error_propagate() calls
 (again)
Message-ID: <20201009094337.GD3335@linux.fritz.box>
References: <20201009064858.323624-1-armbru@redhat.com>
 <20201009064858.323624-2-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201009064858.323624-2-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jfreimann@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jfreimann@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 08:48:57AM +0200, Markus Armbruster wrote:
>Patch created mechanically by rerunning:
>
>    $ spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --use-gitgrep .
>
>Cc: Jens Freimann <jfreimann@redhat.com>
>Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>Cc: Juan Quintela <quintela@redhat.com>
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>Message-Id: <20200722084048.1726105-4-armbru@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
> hw/net/virtio-net.c   | 8 ++------
> migration/colo.c      | 4 +---
> migration/migration.c | 8 ++------
> 3 files changed, 5 insertions(+), 15 deletions(-)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>



