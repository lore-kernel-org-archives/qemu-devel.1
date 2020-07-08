Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC219C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B318206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz+XUlOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B318206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIET-0006Qb-QP
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtHiA-0000IC-0c
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtHi7-0002uA-A8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6BDL9lkZeKP3GOcD5qC3DzyQCp45D/LNw1KvyIz6F8=;
 b=Nz+XUlOHbYM0jk5Ee6QXMFCvIHqy3xYn+1DCNx7laaaVAS8M8bZV3U3zHgib+1gEd1OGEq
 TW/VvhgN4Q8eJ0uE4KFCOy4yppsnmo85nq93LRDKWwSwRj+v/rai2PMXrmXX2MkSOlDKDG
 M2EYv7HDVqdTu7YuMGqfXQMjKBL0hX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-5z_pEntMMyGCQ0NZ9mTN9w-1; Wed, 08 Jul 2020 08:33:31 -0400
X-MC-Unique: 5z_pEntMMyGCQ0NZ9mTN9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC3519057AC;
 Wed,  8 Jul 2020 12:33:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A853878479;
 Wed,  8 Jul 2020 12:33:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CD23DB17; Wed,  8 Jul 2020 14:33:29 +0200 (CEST)
Date: Wed, 8 Jul 2020 14:33:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v8 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
Message-ID: <20200708123329.udy3k7ewtbcztjin@sirius.home.kraxel.org>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
 <20200608094030.670121-12-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200608094030.670121-12-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 12:40:27PM +0300, Maxim Levitsky wrote:
> blockdev-amend will be used similiar to blockdev-create
> to allow on the fly changes of the structure of the format based block devices.

This one breaks the build:

In file included from /home/kraxel/projects/qemu/include/block/throttle-groups.h:29,
                 from /home/kraxel/projects/qemu/include/sysemu/block-backend.h:17,
                 from /home/kraxel/projects/qemu/qemu-img.c:46:
/home/kraxel/projects/qemu/include/block/block_int.h:154:39: error: unknown type name ‘BlockdevAmendOptions’; did you mean ‘BlockdevAioOptions’?
                                       BlockdevAmendOptions *opts,
                                       ^~~~~~~~~~~~~~~~~~~~
                                       BlockdevAioOptions
make: *** [/home/kraxel/projects/qemu/rules.mak:69: qemu-img.o] Error 1

take care,
  Gerd


