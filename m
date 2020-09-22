Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2EDC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE5120BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJaEUOHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE5120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeUJ-0008D9-Um
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKeBb-0000JZ-4r
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKeBQ-0002qB-GQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600765315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MwSbaCO5klUP+gJV6vtmK8uvJG6O1yVoQRR+DZMrduA=;
 b=cJaEUOHQL2N0BMJ2hQ/fRCPWmX0QsFAySTOPxt7JqfE5ciTpX/mBF18ZugBOnPT70lXE+a
 nEvWH4Lgw2bRDuZ+OizTtt4gV6LN3sjjc1bnPfDiZke4IQYT9Jtmj2dOa39HnKEJpsdeEZ
 Z/JK7gULnXVaRvPjPB6ettWHCX4C9S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-n01JyaViO-OTPql1T1-hig-1; Tue, 22 Sep 2020 05:01:51 -0400
X-MC-Unique: n01JyaViO-OTPql1T1-hig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C34425D7;
 Tue, 22 Sep 2020 09:01:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-64.ams2.redhat.com
 [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED01E5C1DC;
 Tue, 22 Sep 2020 09:01:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] block: future of sheepdog storage driver ?
Date: Tue, 22 Sep 2020 10:01:46 +0100
Message-Id: <20200922090147.1993705-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Liu Yuan <namei.unix@gmail.com>, sheepdog@lists.wpkg.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2 years back I proposed dropping the sheepdog mailing list from the=0D
MAINTAINERS file, but somehow the patch never got picked up:=0D
=0D
  https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html=0D
=0D
So here I am with the same patch again.=0D
=0D
I further looked at the sheepdog project though, and I'm wondering=0D
if we actually want to keep the sheepdog storage driver at all.=0D
=0D
This thread from a little over a year ago:=0D
=0D
  http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html=0D
=0D
clearly states that sheepdog is no longer actively developed. The only=0D
mentioned users are some companies who are said to have it for legacy=0D
reasons with plans to replace it by Ceph. There is talk about cutting=0D
out existing features to turn it into a simple demo of how to write a=0D
distributed block service. There is no evidence of anyone working on=0D
that idea.=0D
=0D
  https://github.com/sheepdog/sheepdog/commits/master=0D
=0D
No real commits to git since Jan 2018 and that's just dealing with=0D
technical debt.=0D
=0D
There is essentially no activity on the mailing list aside from=0D
patches to QEMU that get CC'd due to our MAINTAINERS entry, if and=0D
when someone processes the moderator queue.=0D
=0D
Fedora packages for sheepdog failed to build from upstream source=0D
because of the more strict linker that no longer merges duplicate=0D
global symbols. So we patch it to add the missing "extern" annotations.=0D
Upstream source remains broken for everyone else.=0D
=0D
AFAIK, none of our containers or VMs include the sheepdog server=0D
packages, so we have no testing coverage for it in CI that I see.=0D
=0D
Does someone have a compelling reason for QEMU to keep supporting=0D
this driver, other than the fact that it already exists ?=0D
=0D
If not, it looks like a candidate for deprecating in QEMU with a=0D
view to later removing it.=0D
=0D
Daniel P. Berrang=C3=A9 (1):=0D
  block: drop moderated sheepdog mailing list from MAINTAINERS file=0D
=0D
 MAINTAINERS | 1 -=0D
 1 file changed, 1 deletion(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


