Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE40C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80D20731
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYvYfCWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGHga-0002VJ-AI
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHfl-0001pQ-4L
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHfi-0002ux-MF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599725469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7FvQg7HScs09FqTYVXZm5vA9SwngCyL8cHIBDd3jrUc=;
 b=UYvYfCWcCrnAFMDD6/xDEdIHGmVv7XIFsd37hZ38Kjsli999D9tC4nfRC6plQkTQv9Wfzd
 mYfe4duuI5NbUcLxxwIFKZPacWF2UadKlF1OQBUdDkAlb2qtFhOq6su9Z0YPhdzOQBDvrS
 RR8W17nsXaejYhmf/HfoA7q9jvIgalQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-iCPlaMOZPOupodFdK0yHew-1; Thu, 10 Sep 2020 04:11:05 -0400
X-MC-Unique: iCPlaMOZPOupodFdK0yHew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4274518A2252;
 Thu, 10 Sep 2020 08:11:04 +0000 (UTC)
Received: from localhost (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAF9A8357E;
 Thu, 10 Sep 2020 08:11:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] Tracing patches
Date: Thu, 10 Sep 2020 09:10:41 +0100
Message-Id: <20200910081049.38393-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5NDM1YThiM2RkMzVmMWY5MjZmMWI5
MTI3ZThhOTA2MjE3YTU1MThhOgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL2tyYXhlbC90YWdzL3Npcml1cy9pcHhlLTIwMjAwOTA4LXB1bGwtcmVxdWVzdCcgaW50byBz
dGFnaW5nICgyMDIwLTA5LTA4IDIxOjIxOjEzICswMTAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9xZW11Lmdp
dCB0YWdzL3RyYWNpbmctcHVsbC1yZXF1ZXN0Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8gYjE1ZTQwMmZjODg2MWFkYjY1ZDE2OGQzODBmMzliMzEwNTk5YTUzMzoKCiAgdHJhY2UtZXZl
bnRzOiBGaXggYXR0cmlidXRpb24gb2YgdHJhY2UgcG9pbnRzIHRvIHNvdXJjZSAoMjAyMC0wOS0w
OSAxNzoxNzo1OCArMDEwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUHVsbCByZXF1ZXN0Cgp2MjoKICogUmViYXNlZCBh
ZnRlciBtZXNvbiBhbmQgcmVzb2x2ZWQgY29uZmxpY3QgaW4gInNvZnRtbXU6IEFkZCBtaXNzaW5n
IHRyYWNlLWV2ZW50cyBmaWxlIgogKiBEcm9wcGVkICJtZXNvbjogRG9uJ3QgbWFrZSBvYmplY3Qg
ZmlsZXMgZm9yIGR0cmFjZSBvbiBtYWNPUyIgKGFscmVhZHkgbWVyZ2VkIHZpYSBQYW9sbydzIHRy
ZWUpCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCgpNYXJrdXMgQXJtYnJ1c3RlciAoNCk6CiAgc2NyaXB0cy9jbGVhbnVwLXRy
YWNlLWV2ZW50czogRml4IGZvciB2Y3B1IHByb3BlcnR5CiAgc2NyaXB0cy9jbGVhbnVwLXRyYWNl
LWV2ZW50czogRW1pdCBmaWxlcyBpbiBhbHBoYWJldGljYWwgb3JkZXIKICB0cmFjZS1ldmVudHM6
IERlbGV0ZSB1bnVzZWQgdHJhY2UgcG9pbnRzCiAgdHJhY2UtZXZlbnRzOiBGaXggYXR0cmlidXRp
b24gb2YgdHJhY2UgcG9pbnRzIHRvIHNvdXJjZQoKUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgKDEp
OgogIHNvZnRtbXU6IEFkZCBtaXNzaW5nIHRyYWNlLWV2ZW50cyBmaWxlCgpSb21hbiBCb2xzaGFr
b3YgKDMpOgogIHNjcmlwdHMvdHJhY2V0b29sOiBGaXggZHRyYWNlIGdlbmVyYXRpb24gZm9yIG1h
Y09TCiAgc2NyaXB0cy90cmFjZXRvb2w6IFVzZSB2b2lkIHBvaW50ZXIgZm9yIHZjcHUKICBuZXQv
Y29sbzogTWF0Y2ggaXMtZW5hYmxlZCBwcm9iZSB0byB0cmFjZXBvaW50Cgogc29mdG1tdS90cmFj
ZS5oICAgICAgICAgICAgICAgICB8ICAxICsKIG5ldC9jb2xvLWNvbXBhcmUuYyAgICAgICAgICAg
ICAgfCA0MiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIG5ldC9maWx0ZXItcmV3
cml0ZXIuYyAgICAgICAgICAgfCAxMCArKysrKystLQogc29mdG1tdS9iYWxsb29uLmMgICAgICAg
ICAgICAgICB8ICAyICstCiBzb2Z0bW11L2lvcG9ydC5jICAgICAgICAgICAgICAgIHwgIDIgKy0K
IHNvZnRtbXUvbWVtb3J5LmMgICAgICAgICAgICAgICAgfCAgMiArLQogc29mdG1tdS92bC5jICAg
ICAgICAgICAgICAgICAgICB8ICAyICstCiBhdWRpby90cmFjZS1ldmVudHMgICAgICAgICAgICAg
IHwgIDMgLS0tCiBibG9jay90cmFjZS1ldmVudHMgICAgICAgICAgICAgIHwgIDggKystLS0tLQog
aHcvYmxvY2svdHJhY2UtZXZlbnRzICAgICAgICAgICB8ICAyICstCiBody9jaGFyL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgIHwgIDIgKy0KIGh3L2Rpc3BsYXkvdHJhY2UtZXZlbnRzICAgICAgICAg
fCAgNCArKystCiBody9oeXBlcnYvdHJhY2UtZXZlbnRzICAgICAgICAgIHwgIDIgKy0KIGh3L21p
cHMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgfCAgMiArLQogaHcvbWlzYy90cmFjZS1ldmVudHMg
ICAgICAgICAgICB8ICA5ICsrKy0tLS0KIGh3L3BwYy90cmFjZS1ldmVudHMgICAgICAgICAgICAg
fCAxMCArKy0tLS0tLQogaHcvcmlzY3YvdHJhY2UtZXZlbnRzICAgICAgICAgICB8ICAyICstCiBo
dy9ydGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgIHwgIDIgKy0KIGh3L3RpbWVyL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgfCAgMSAtCiBody90cG0vdHJhY2UtZXZlbnRzICAgICAgICAgICAgIHwg
IDIgKy0KIGh3L3VzYi90cmFjZS1ldmVudHMgICAgICAgICAgICAgfCAgNCArKystCiBody92Zmlv
L3RyYWNlLWV2ZW50cyAgICAgICAgICAgIHwgMTAgKysrKy0tLS0KIGh3L3ZpcnRpby90cmFjZS1l
dmVudHMgICAgICAgICAgfCAgMiArLQogbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICB8
ICAxICsKIG1pZ3JhdGlvbi90cmFjZS1ldmVudHMgICAgICAgICAgfCAzNyArKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQogbmV0L3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICB8ICAyIC0t
CiBzY3JpcHRzL2NsZWFudXAtdHJhY2UtZXZlbnRzLnBsIHwgMjMgKysrKysrKysrKystLS0tLS0t
CiBzY3JpcHRzL3RyYWNldG9vbC9mb3JtYXQvZC5weSAgIHwgMTUgKysrKysrKysrKystCiBzY3Jp
cHRzL3RyYWNldG9vbC92Y3B1LnB5ICAgICAgIHwgIDIgKy0KIHNvZnRtbXUvdHJhY2UtZXZlbnRz
ICAgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvcHBjL3RyYWNl
LWV2ZW50cyAgICAgICAgIHwgIDEgLQogdGFyZ2V0L3Jpc2N2L3RyYWNlLWV2ZW50cyAgICAgICB8
ICAyICstCiB0cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgIHwgMzIgKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogdWkvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICB8ICA2ICsrLS0t
CiB1dGlsL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgIHwgIDQgKysrLQogMzUgZmlsZXMgY2hh
bmdlZCwgMTUxIGluc2VydGlvbnMoKyksIDEyOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBzb2Z0bW11L3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb2Z0bW11L3RyYWNlLWV2
ZW50cwoKLS0gCjIuMjYuMgoK


