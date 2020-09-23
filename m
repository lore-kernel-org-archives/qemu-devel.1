Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC718C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43AD214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CK56MiDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43AD214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL186-00015J-0o
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL12n-0002cN-4R
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL12d-0004Xw-Vt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600853181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=seiEZgVtuLjFkQY1XMT/P2XQKPoPKDPvliAHWED1DSQ=;
 b=CK56MiDgClaulLoh4/0IAxXfyv2o0vNuz7X2QYd2Z8emLMeYnmwoPzGJTKif90cNMI/Y5y
 TBwMFhRqf2vfc9VG28jgakAqABnIsV/f2xQKJtvb0dN3KHPZSHXwshclKNIUz6+wE5Wpur
 qS7KA4jmOLV3aJUDm2uzRYfKCR3FRlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-TjGfVD1CNci6mCeq0f5lnA-1; Wed, 23 Sep 2020 05:26:19 -0400
X-MC-Unique: TjGfVD1CNci6mCeq0f5lnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90911007479
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:26:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5CC460E1C
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:26:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] configure: bugfixes and cleanups for CFLAGS
Date: Wed, 23 Sep 2020 05:26:13 -0400
Message-Id: <20200923092617.1593722-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson is placing -pie after -shared rather than before, and this
causes linking to fail while building the ArchLinux package for
QEMU.

But why is -pie ending up in the flags?  Because LDFLAGS is an
environment variable, and changes to environment variables propagate
when configure does

  LDFLAGS="-pie $LDFLAGS"

This happens without having to export the env. var again.

The solution is to simply rename the CFLAGS and LDFLAGS variables
used for flags that Meson takes care of by itself.  The CFLAGS
variable was previously used for submodules as well, so patches
1 and 2 fix that as well.

I'm keeping Richard's reviewed-by since the changes are pretty
obvious from v1.

v1->v2: include -fno-pie flags as well, since tests/tcg needs them
	handle empty CFLAGS and LDFLAGS too
	place flags in the built-in options section of the cross file

Paolo Bonzini (4):
  configure: cleanup invocation of submodule Make
  configure: cleanup CFLAGS and LDFLAGS for submodules
  configure: do not clobber environment CFLAGS/CXXFLAGS/LDFLAGS
  configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to meson

 Makefile    | 23 +++++++++-------
 configure   | 75 ++++++++++++++++++++++++++++++++++-------------------
 meson.build | 13 +++++++++-
 3 files changed, 74 insertions(+), 37 deletions(-)

-- 
2.26.2


