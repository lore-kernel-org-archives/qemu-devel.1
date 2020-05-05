Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72292C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC0B206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH9KWOUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC0B206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuVq-0004kU-CF
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVuVC-0003v4-FC
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:08:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVuVB-0000em-SX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588673316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMc/O8FmCNFMUjI9z0D4+9L3Ma6V4gil8ZAbz6LKSEw=;
 b=fH9KWOUyxoJXoxZSd+0yNHt5NnwxmbF1EYtWWVEyBEv2JPR/wjYFUS6dR6O2IkGzVo1sRo
 1AyiE+ticHxkWd0i8mrHWWDnoQEfpwRnP+Ytjk7AVDCZrqq5A3PxoeI5NIn0gUXqUiIJRB
 4Ct3eWW/RiDpFkYQ3E9izmh2LOELySE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348--pkG2PzgOcK902CzQLYE9g-1; Tue, 05 May 2020 06:08:35 -0400
X-MC-Unique: -pkG2PzgOcK902CzQLYE9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C81F80183C;
 Tue,  5 May 2020 10:08:34 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0C596249A;
 Tue,  5 May 2020 10:08:31 +0000 (UTC)
Date: Tue, 5 May 2020 12:08:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] backup: Make sure that source and target size match
Message-ID: <20200505100827.GI5759@linux.fritz.box>
References: <20200430142755.315494-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430142755.315494-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 16:27 hat Kevin Wolf geschrieben:
> v2:
> - Fixed iotest 283
> - Corrected commit message for patch 3 [Vladimir]
> - Fixed permissions for the source node, too
> - Refactored the test case to avoid some duplication [Vladimir]

Thanks for the review, applied to the block branch.

Kevin


