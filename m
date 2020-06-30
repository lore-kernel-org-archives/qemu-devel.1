Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDFF2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGpsMjL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDFF2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHin-00048j-RR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jqHhm-0002e0-Dz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:57:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jqHhk-0003FB-Sl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593529067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1yfQKn6GEwqzNUZ58K70N0BMEJc6w6x0PkNaCMeo3A=;
 b=DGpsMjL+ayBRUwY+8yGWYcvbxZJlMYSJDrTRadINTwrGqneq3KjVTIVbhcfwhWD8H+9ABi
 3VA603Pkg/HHzdHQsuwjhMSUnCPeXllpLXOvQWWpV6AKG4Kx4PkQ6t3rEOj8wzi+6og6+a
 fHtebJrHRq3yXmjWz0c/pkUSHvUgHPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-V2WzYmbKMSimGuLAYyXooA-1; Tue, 30 Jun 2020 10:57:45 -0400
X-MC-Unique: V2WzYmbKMSimGuLAYyXooA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A39B9185B384;
 Tue, 30 Jun 2020 14:57:43 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-211.ams2.redhat.com
 [10.36.114.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D38D6741A6;
 Tue, 30 Jun 2020 14:57:38 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] net: tap: check file descriptor can be used
Date: Tue, 30 Jun 2020 16:57:35 +0200
Message-Id: <20200630145737.232095-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: Add patch from Daniel to check the fd can be used=0D
=0D
    I have updated Daniel's patch not to check for EINVAL on TUNGETIFF=0D
    as I think we can avoid this special case because TUNGETIFF=0D
    is available since kernel v2.6.27 (October 2008)=0D
    Moreover I think the code was wrong as it was checking with -EINVAL and=
=0D
    not EINVAL.=0D
=0D
Daniel P. Berrang=EF=BF=BD=EF=BF=BD (1):=0D
  net: detect errors from probing vnet hdr flag for TAP devices=0D
=0D
Laurent Vivier (1):=0D
  net: tap: check if the file descriptor is valid before using it=0D
=0D
 include/qemu/sockets.h |  1 +=0D
 net/tap-bsd.c          |  2 +-=0D
 net/tap-linux.c        |  8 +++++---=0D
 net/tap-solaris.c      |  2 +-=0D
 net/tap-stub.c         |  2 +-=0D
 net/tap.c              | 38 +++++++++++++++++++++++++++++++++-----=0D
 net/tap_int.h          |  2 +-=0D
 util/oslib-posix.c     |  5 +++++=0D
 util/oslib-win32.c     |  6 ++++++=0D
 9 files changed, 54 insertions(+), 12 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


