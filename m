Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6573C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23C020709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqcbjWxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23C020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybIM-0003hn-1c
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHl-0003DA-V4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHk-0005Ou-8q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7LHWROqjZnKMbclNUPrma6/FcR/4VBkWfKYmDvJlMZo=;
 b=bqcbjWxwK4P7pYKlsP4ohRhq1+uZgsL1QGq4cNK5Z+WSeh/R/fbqhT7S9unQGCFdXtckNW
 xUpIvtKAKO1uAYI6yNnP15fNOq19JkpKdfLWYLAlyeL3uM3Qf3MCBUC5rcnR8nyz7diMAE
 rCML3YYFuzXv9PISUJ1/18PkSpnWwUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-ZC9nhLYBPXqjiCFlVDF7bw-1; Thu, 23 Jul 2020 09:29:17 -0400
X-MC-Unique: ZC9nhLYBPXqjiCFlVDF7bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30C45100CCD2;
 Thu, 23 Jul 2020 13:29:16 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A71E5D9D3;
 Thu, 23 Jul 2020 13:29:05 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] trace: Add a trace backend for the recorder library
Date: Thu, 23 Jul 2020 15:29:01 +0200
Message-Id: <20200723132903.1980743-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recorder library implements low-cost always-on tracing, with three=0D
usage models:=0D
=0D
1. Flight recorder: Dump information on recent events in case of crash=0D
2. Tracing: Individual traces can be enabled using environment variables=0D
3. Real-time graphing / control, using the recorder_scope application=0D
=0D
This short series introduces a new "recorder" back-end which connects=0D
to the recorder. Traces using the recorder are intentionally "always on",=
=0D
because the recorder library is primarily designed to record=0D
information for later playback in case of crash, tracing being only a=0D
secondary capability.=0D
=0D
An example is given of how the recorder can also be used separately=0D
from generated traces. The example uses locking, which can make sense=0D
for both post-mortem and real-time graphing.=0D
=0D
Changes in v3:=0D
* Address coding style issues (C++ comments, wrong include, etc)=0D
* Fix args type for HMP command (for now, still a single command)=0D
* Add basic help for HMP command=0D
* Use pkg-config for recorder information. This requires recorder=0D
  1.0.10 or later.=0D
=0D
Changes in v4:=0D
* Rebased on current master=0D
* Fix GPL v2-only license=0D
* Remove confusing #ifdef around #include "trace/recorder.h"=0D
* Added myself as a reviewer for trace subsystem=0D
=0D
Later patches wil address larger topics that were discussed that=0D
would impact other tracing mechanisms, as well as GitHub / GitLab=0D
build tests.=0D
=0D
Christophe de Dinechin (2):=0D
  trace: Add support for recorder back-end=0D
  trace: Example of non-tracing recorder use=0D
=0D
 MAINTAINERS                           |  1 +=0D
 configure                             | 14 ++++++++=0D
 hmp-commands.hx                       | 23 +++++++++++-=0D
 monitor/misc.c                        | 25 +++++++++++++=0D
 scripts/tracetool/backend/recorder.py | 52 +++++++++++++++++++++++++++=0D
 trace/Makefile.objs                   |  1 +=0D
 trace/control.c                       |  5 +++=0D
 trace/recorder.c                      | 27 ++++++++++++++=0D
 trace/recorder.h                      | 32 +++++++++++++++++=0D
 util/module.c                         |  6 ++++=0D
 util/qemu-thread-common.h             |  7 ++++=0D
 11 files changed, 192 insertions(+), 1 deletion(-)=0D
 create mode 100644 scripts/tracetool/backend/recorder.py=0D
 create mode 100644 trace/recorder.c=0D
 create mode 100644 trace/recorder.h=0D
=0D
--=20=0D
2.26.2=0D
=0D


