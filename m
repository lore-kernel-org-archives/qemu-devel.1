Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA262C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482E215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/Sd8BMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482E215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadRh-0003GE-SN
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iadCi-0000Sn-3U
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iadCf-0004H5-VF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:08:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iadCf-0004EW-P2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W50NDKw7/igDR1REY4LneNCdjwCDw1ilxcviCGfQtC0=;
 b=h/Sd8BMaZ+/OvI3hv485AaHLVKZZVTucxYMsixUthbFqRobjWgua1FXR79SKQPtsuAFx9R
 9073HgeqfvxhG4SYqeDaUpZ8KbPtgE/bYS8VjBmeiYbjpOEgd0/d94NvqvOmHCLiL0uFSp
 0MIZZTfUrN+0yX/w9mm5dSFUx/IOIH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-4BdqDLDqPgK_yoIrde6nHQ-1; Fri, 29 Nov 2019 05:08:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB58DB60;
 Fri, 29 Nov 2019 10:08:40 +0000 (UTC)
Received: from thuth.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6EC05D6D2;
 Fri, 29 Nov 2019 10:08:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] Fix for the s390-ccw bios
Date: Fri, 29 Nov 2019 11:08:33 +0100
Message-Id: <20191129100835.21734-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4BdqDLDqPgK_yoIrde6nHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 1a61a081ac33ae6cb7dd2e38d119a572f416c7f7=
:

  Update version for v4.2.0-rc3 release (2019-11-26 21:52:26 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-11-29

for you to fetch changes up to bf876a688c9319b506d5ff1175ba7189cd933d91:

  pc-bios/s390: Update firmware image with the "fix sclp_get_loadparm_ascii=
" patch (2019-11-29 10:12:33 +0100)

----------------------------------------------------------------
A fix for regression in the s390-ccw bios
----------------------------------------------------------------

... it would be good to still get this into 4.2 if possible!

Claudio Imbrenda (1):
      pc-bios/s390-ccw: fix sclp_get_loadparm_ascii

Thomas Huth (1):
      pc-bios/s390: Update firmware image with the "fix sclp_get_loadparm_a=
scii" patch

 pc-bios/s390-ccw.img     | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/sclp.c  |   2 +-
 pc-bios/s390-netboot.img | Bin 67232 -> 67232 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)


