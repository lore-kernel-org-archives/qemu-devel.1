Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8978C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0EA2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTK2dYgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0EA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVUi-0000vP-PK
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtVTw-0008Lh-7O
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:16:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtVTt-0001am-Q3
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594297008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWak63RFMdGbhBCwiwQ6H0x7zXo9aKhwe4dd4dfHoHU=;
 b=WTK2dYgK/47i0dskPjqyAL9vHrses7hcwmi7XcLBufxs1gYOdfcMwm4CUvn7DubBwv0FVo
 SYGT5RUdATOMjlkGMx8FTUWyd+Qi7tCtFlFXOChjTabtijP6amCNj04502NYTw4+V/mr7J
 X3R9Icf6frem6UASawR/0AvK2WBMqMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-KGaAQBSDN36c9qav8II_6A-1; Thu, 09 Jul 2020 08:16:47 -0400
X-MC-Unique: KGaAQBSDN36c9qav8II_6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0937A800EB6;
 Thu,  9 Jul 2020 12:16:46 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-122.ams2.redhat.com [10.36.114.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E7BE5D9DD;
 Thu,  9 Jul 2020 12:16:45 +0000 (UTC)
Date: Thu, 9 Jul 2020 14:16:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests: Simplify _filter_img_create() a bit
Message-ID: <20200709121643.GB4096@linux.fritz.box>
References: <20200709110205.310942-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709110205.310942-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.07.2020 um 13:02 hat Max Reitz geschrieben:
> Not only is it a bit stupid to try to filter multi-line "Formatting"
> output (because we only need it for a single test, which can easily be
> amended to no longer need it), it is also problematic when there can be
> output after a "Formatting" line that we do not want to filter as if it
> were part of it.
> 
> So rename _filter_img_create to _do_filter_img_create, let it filter
> only a single line, and let _filter_img_create loop over all input
> lines, calling _do_filter_img_create only on those that match
> /^Formatting/ (basically, what _filter_img_create_in_qmp did already).
> (And fix 020 to work with that.)
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Kevin noted that the changes to _filter_img_create broke Eric's patch to
> flush the Formatting line out before a potential error message.  This
> patch should fix it (and the diff stat is negative, so that's nice).

Thanks, this fixed the problem. Applied to the block branch.

Kevin


