Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA257C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9179521582
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS4ydFlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9179521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUbv-0008Mz-QY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jsUWP-00047z-VX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:03:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jsUWO-0006ed-Bc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594054991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=apfggld3R7K2A3T1PK9XU7I7BAXDd4dvfqV923imVeM=;
 b=fS4ydFlFfEIqPJREDpLJQmMuHPzPW2W0prujzlbJbHWLWQExBFLSdwz3hrugLjM2XpeNlc
 q7Fdq9hOaQq4YxPKcW5OzGBwYLSkhdnR5fVn3aY2cqzItyzcgA0KezGXsqfkZcab45Ll3j
 qcsP0fCbw9MXYDWpkcpOv7xYTChZlQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-EU33qf56OaCss9KtKEsG5w-1; Mon, 06 Jul 2020 13:03:09 -0400
X-MC-Unique: EU33qf56OaCss9KtKEsG5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA522461;
 Mon,  6 Jul 2020 17:03:08 +0000 (UTC)
Received: from turbo.com (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 285635BACD;
 Mon,  6 Jul 2020 17:02:57 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] trace: Add a trace backend for the recorder library
Date: Mon,  6 Jul 2020 19:02:53 +0200
Message-Id: <20200706170255.1165105-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
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
Later patches wil address larger topics that were discussed that=0D
would impact other tracing mechanisms, as well as GitHub / GitLab=0D
build tests.=0D
=0D
Christophe de Dinechin (2):=0D
  trace: Add support for recorder back-end=0D
  trace: Example of non-tracing recorder use=0D
=0D
 configure                             | 14 ++++++++=0D
 hmp-commands.hx                       | 23 +++++++++++-=0D
 monitor/misc.c                        | 27 ++++++++++++++=0D
 scripts/tracetool/backend/recorder.py | 52 +++++++++++++++++++++++++++=0D
 trace/Makefile.objs                   |  1 +=0D
 trace/control.c                       |  7 ++++=0D
 trace/recorder.c                      | 25 +++++++++++++=0D
 trace/recorder.h                      | 32 +++++++++++++++++=0D
 util/module.c                         |  8 +++++=0D
 util/qemu-thread-common.h             |  7 ++++=0D
 10 files changed, 195 insertions(+), 1 deletion(-)=0D
 create mode 100644 scripts/tracetool/backend/recorder.py=0D
 create mode 100644 trace/recorder.c=0D
 create mode 100644 trace/recorder.h=0D
=0D
--=20=0D
2.26.2=0D
=0D


