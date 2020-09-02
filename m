Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182AF2078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4hUqgu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182AF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPwU-0002oP-AM
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDPvt-00024H-Ds
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDPvr-00034S-PA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2RBCZ5boBDY8MPR73IcY0hTtFjI+E2pht7T9cjCQsU=;
 b=N4hUqgu+MnkEub74BvAbrX78FI/Jfeu/GFLdrvjUSqniGN6P+oQepbUDUk+qy8+PPku8ik
 JzcJAwezXV4tXkMnLKYoNF9DOu6DmNHGCOOyIHRcpe/JYv4uugDVirir1ApjhTL1UcVFcV
 HPIBTXQuX2pTZCBi+Co0IJ5VxGY8llk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-cfFwsjb3PH-QgtySv8hU_Q-1; Wed, 02 Sep 2020 06:23:41 -0400
X-MC-Unique: cfFwsjb3PH-QgtySv8hU_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134EA10ABDB4;
 Wed,  2 Sep 2020 10:23:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-85.ams2.redhat.com [10.36.113.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D18255C1C4;
 Wed,  2 Sep 2020 10:23:38 +0000 (UTC)
Date: Wed, 2 Sep 2020 12:23:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v8 00/43] block: Deal with filters
Message-ID: <20200902102337.GC5765@linux.fritz.box>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.09.2020 um 16:33 hat Max Reitz geschrieben:
> v6: https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
> v7: https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg01357.html
> 
> Branch: https://github.com/XanClic/qemu.git child-access-functions-v8
> Branch: https://git.xanclic.moe/XanClic/qemu.git child-access-functions-v8
> 
> 
> Hi,
> 
> In v8, there is not too much that has changed in respect to v7.  I tried
> to address all of your comments and hope I got it right.  I also hope I
> got the R-bs right.

Thanks, fixed up the typo in the commit message of patch 35 and applied
to the block branch.

Kevin


