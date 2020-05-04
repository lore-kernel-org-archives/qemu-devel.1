Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC25206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZOxuRJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC25206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcr1-00076q-KQ
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoY-00036v-T2
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoY-0007p4-3f
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588605325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+mZ1N7dGqM8m4x82r+/xQOUNB890dMBeCU3PxbO+hU=;
 b=LZOxuRJmIEpTkq0QYrU9cm2m0jpCgeNEmBwsRiwZARivM1x+4riayCQN/XmuCDNSCuZo60
 kHYsE1t6vHCYDcidQygYKRMA2OBxN8vmgg5XdSpY1JZkEHpJTOf9Nq0ZBVHvh8oqsH8y9n
 JoYtQUJe1ZsES6YMJAChXLSR6LeSFjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-BrrKHOuaNCGK8Kkbx-d6og-1; Mon, 04 May 2020 11:15:21 -0400
X-MC-Unique: BrrKHOuaNCGK8Kkbx-d6og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A12A800D24;
 Mon,  4 May 2020 15:15:19 +0000 (UTC)
Received: from localhost (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA8047052C;
 Mon,  4 May 2020 15:15:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/4] lockable: fix __COUNTER__ macro to be referenced
 properly
Date: Mon,  4 May 2020 16:14:36 +0100
Message-Id: <20200504151438.362702-3-stefanha@redhat.com>
In-Reply-To: <20200504151438.362702-1-stefanha@redhat.com>
References: <20200504151438.362702-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRGFuaWVsIEJyb2Rza3kgPGRuYnJkc2t5QGdtYWlsLmNvbT4KCi0gX19DT1VOVEVSX18g
ZG9lc24ndCB3b3JrIHdpdGggIyMgY29uY2F0Ci0gcmVwbGFjZWQgIyMgd2l0aCBnbHVlKCkgbWFj
cm8gc28gX19DT1VOVEVSX18gaXMgZXZhbHVhdGVkCgpGaXhlczogMzI4NGMzZGRjNAoKU2lnbmVk
LW9mZi1ieTogRGFuaWVsIEJyb2Rza3kgPGRuYnJkc2t5QGdtYWlsLmNvbT4KTWVzc2FnZS1pZDog
MjAyMDA0MDQwNDIxMDguMzg5NjM1LTItZG5icmRza3lAZ21haWwuY29tClNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL3FlbXUv
bG9ja2FibGUuaCB8IDcgKysrKy0tLQogaW5jbHVkZS9xZW11L3JjdS5oICAgICAgfCAyICstCiAy
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaCBiL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5oCmlu
ZGV4IDFhZWIyY2IxYTYuLmI2MjAwMjMxNDEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9sb2Nr
YWJsZS5oCisrKyBiL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5oCkBAIC0xNTIsNyArMTUyLDcgQEAg
R19ERUZJTkVfQVVUT1BUUl9DTEVBTlVQX0ZVTkMoUWVtdUxvY2thYmxlLCBxZW11X2xvY2thYmxl
X2F1dG9fdW5sb2NrKQogICogICB9CiAgKi8KICNkZWZpbmUgV0lUSF9RRU1VX0xPQ0tfR1VBUkQo
eCkgXAotICAgIFdJVEhfUUVNVV9MT0NLX0dVQVJEXygoeCksIHFlbXVfbG9ja2FibGVfYXV0byMj
X19DT1VOVEVSX18pCisgICAgV0lUSF9RRU1VX0xPQ0tfR1VBUkRfKCh4KSwgZ2x1ZShxZW11X2xv
Y2thYmxlX2F1dG8sIF9fQ09VTlRFUl9fKSkKIAogLyoqCiAgKiBRRU1VX0xPQ0tfR1VBUkQgLSBM
b2NrIGFuIG9iamVjdCB1bnRpbCB0aGUgZW5kIG9mIHRoZSBzY29wZQpAQCAtMTY5LDggKzE2OSw5
IEBAIEdfREVGSU5FX0FVVE9QVFJfQ0xFQU5VUF9GVU5DKFFlbXVMb2NrYWJsZSwgcWVtdV9sb2Nr
YWJsZV9hdXRvX3VubG9jaykKICAqICAgICAgIHJldHVybjsgPC0tIG11dGV4IGlzIGF1dG9tYXRp
Y2FsbHkgdW5sb2NrZWQKICAqICAgfQogICovCi0jZGVmaW5lIFFFTVVfTE9DS19HVUFSRCh4KSBc
Ci0gICAgZ19hdXRvcHRyKFFlbXVMb2NrYWJsZSkgcWVtdV9sb2NrYWJsZV9hdXRvIyNfX0NPVU5U
RVJfXyA9IFwKKyNkZWZpbmUgUUVNVV9MT0NLX0dVQVJEKHgpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAorICAgIGdfYXV0b3B0cihRZW11TG9ja2FibGUpICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgZ2x1ZShxZW11X2xvY2thYmxlX2F1
dG8sIF9fQ09VTlRFUl9fKSBHX0dOVUNfVU5VU0VEID0gICAgICAgIFwKICAgICAgICAgICAgIHFl
bXVfbG9ja2FibGVfYXV0b19sb2NrKFFFTVVfTUFLRV9MT0NLQUJMRSgoeCkpKQogCiAjZW5kaWYK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9yY3UuaCBiL2luY2x1ZGUvcWVtdS9yY3UuaAppbmRl
eCA5YzgyNjgzZTM3Li41NzBhYTYwM2ViIDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvcmN1LmgK
KysrIGIvaW5jbHVkZS9xZW11L3JjdS5oCkBAIC0xNzAsNyArMTcwLDcgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIHJjdV9yZWFkX2F1dG9fdW5sb2NrKFJDVVJlYWRBdXRvICpyKQogR19ERUZJTkVfQVVU
T1BUUl9DTEVBTlVQX0ZVTkMoUkNVUmVhZEF1dG8sIHJjdV9yZWFkX2F1dG9fdW5sb2NrKQogCiAj
ZGVmaW5lIFdJVEhfUkNVX1JFQURfTE9DS19HVUFSRCgpIFwKLSAgICBXSVRIX1JDVV9SRUFEX0xP
Q0tfR1VBUkRfKF9yY3VfcmVhZF9hdXRvIyNfX0NPVU5URVJfXykKKyAgICBXSVRIX1JDVV9SRUFE
X0xPQ0tfR1VBUkRfKGdsdWUoX3JjdV9yZWFkX2F1dG8sIF9fQ09VTlRFUl9fKSkKIAogI2RlZmlu
ZSBXSVRIX1JDVV9SRUFEX0xPQ0tfR1VBUkRfKHZhcikgXAogICAgIGZvciAoZ19hdXRvcHRyKFJD
VVJlYWRBdXRvKSB2YXIgPSByY3VfcmVhZF9hdXRvX2xvY2soKTsgXAotLSAKMi4yNS4zCgo=


