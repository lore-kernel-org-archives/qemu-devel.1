Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FF620791
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+ZtfCEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FF620791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorCz-0004Ul-0U
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorCC-0003XS-BA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:27:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorC9-0002xT-Rq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593188835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BdszDYFtdtc+CvOS8OsCmXauBVhbE0tlpQzVr7wTTZ8=;
 b=Q+ZtfCEb3q5oyBEgOjk6jqCDUkIbBAM3Z3mHN4pnVfFgLpH+gNXlpmbyAlaKaeXVF3sw7H
 2mJs8eHXYl3KpKQEx1nWdKd0mnYYT8dxH07odI0GzEfctvJ+gOUgxJzzCpsLH0S3F4o4jH
 HC7/Y9zBuiTCalupBSG6ZLgZNmnxmDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386--5r2PmB7Oiq1l8_VIm6jVA-1; Fri, 26 Jun 2020 12:27:13 -0400
X-MC-Unique: -5r2PmB7Oiq1l8_VIm6jVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A4F800C60;
 Fri, 26 Jun 2020 16:27:12 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E8879305;
 Fri, 26 Jun 2020 16:27:07 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] trace: Add a trace backend for the recorder library
Date: Fri, 26 Jun 2020 18:27:03 +0200
Message-Id: <20200626162706.3304357-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
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
to the recorder. Traces using the recorder are intentionally "always on".=
=0D
An example is given of how the recorder can also be used separately=0D
from generated traces. This can be useful if you want to enable=0D
multiple related traces for a particular topic.=0D
=0D
This series requires a small makefile fix submitted earlier, included=0D
here for convenience.=0D
=0D
Christophe de Dinechin (3):=0D
  Makefile: Compute libraries for libqemuutil.a and libvhost-user.a=0D
  trace: Add support for recorder back-end=0D
  trace: Example of "centralized" recorder tracing=0D
=0D
 Makefile                              |  2 ++=0D
 configure                             |  5 +++=0D
 hmp-commands.hx                       | 19 ++++++++--=0D
 monitor/misc.c                        | 27 ++++++++++++++=0D
 scripts/tracetool/backend/recorder.py | 51 +++++++++++++++++++++++++++=0D
 trace/Makefile.objs                   |  2 ++=0D
 trace/control.c                       |  7 ++++=0D
 trace/recorder.c                      | 22 ++++++++++++=0D
 trace/recorder.h                      | 34 ++++++++++++++++++=0D
 util/module.c                         |  8 +++++=0D
 util/qemu-thread-common.h             |  7 ++++=0D
 11 files changed, 182 insertions(+), 2 deletions(-)=0D
 create mode 100644 scripts/tracetool/backend/recorder.py=0D
 create mode 100644 trace/recorder.c=0D
 create mode 100644 trace/recorder.h=0D
=0D
--=20=0D
2.26.2=0D
=0D


