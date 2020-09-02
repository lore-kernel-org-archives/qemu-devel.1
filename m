Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F30C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5402071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIFD/bF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5402071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOns-0008OE-AZ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDOmq-0007PA-BY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:10:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDOmo-0001pD-OF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599037833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtFVuKEm+cJB+bi4RK613ocfmYZ65puVr1muhdgeOuY=;
 b=hIFD/bF2NNLg1DHJficiUF2JNWau7VRzr8cWS+ri60Z9oNsenHdIJmNAwIKDynkhcNVvxd
 vUq9uNC0PXL52cEU80BgZmhGIKeC6EY/v2ZZOf/43IRWYywK9Wqqp75KtRuM2tDQV9mdgc
 9AmzJqPbwQbkmb4s3vGuiTyOHjIWHXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-fnbhYqe-NQC89wdHuKVAag-1; Wed, 02 Sep 2020 05:10:32 -0400
X-MC-Unique: fnbhYqe-NQC89wdHuKVAag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4B9800C78;
 Wed,  2 Sep 2020 09:10:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-85.ams2.redhat.com [10.36.113.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2AB15C1C4;
 Wed,  2 Sep 2020 09:10:29 +0000 (UTC)
Date: Wed, 2 Sep 2020 11:10:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v8 35/43] blockdev: Fix active commit choice
Message-ID: <20200902091028.GB5765@linux.fritz.box>
References: <20200901143424.884735-1-mreitz@redhat.com>
 <20200901143424.884735-36-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901143424.884735-36-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.09.2020 um 16:34 hat Max Reitz geschrieben:
> We have to perform an active commit whenever the top node has a parent
> that has taken the WRITE permission on it.
> 
> This means that block-commit's @backing-file parameter is longer allowed

s/longer/no longer/

> for such nodes, and that users will have to issue a block-job-complete
> command.  Neither should pose a problem in practice, because this case
> was basically just broken until now.
> 
> (Since this commit already touches block-commit's documentation, it also
> moves up the chunk explaining general block-commit behavior that for
> some reason was situated under @backing-file.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Kevin


