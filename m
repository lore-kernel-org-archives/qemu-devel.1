Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADAFC388D2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593B522267
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHZHlhjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593B522267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyYF-0002Qb-3b
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCy-0002ho-6s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCm-00033q-27
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAikgXGsrvX+Gc+t0sKrq+7dNV1umIAADR+DJpDBBbY=;
 b=PHZHlhjQdGXNxdKOs3AOCeI5pMgiXXZzbwiEP+E+cbymTfbCh10PZitM71UwCAHuNWifbl
 WWZTpUk+CIDDkxCoLdBNSupgA3NZNh/4Z/xXV9Mwfb9TviOCRHOEKL9yn/V4tCnFXoAZXr
 VHCGc32JruMgCrUJMUb9rU15/wSpf/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-FcJM3pL1M9WKs--INW9s1w-1; Fri, 09 Oct 2020 15:37:22 -0400
X-MC-Unique: FcJM3pL1M9WKs--INW9s1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C2E101FFB0;
 Fri,  9 Oct 2020 19:37:21 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 410627664D;
 Fri,  9 Oct 2020 19:37:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 21/30] qemu-storage-daemon: avoid compiling blockdev_ss twice
Date: Fri,  9 Oct 2020 20:35:20 +0100
Message-Id: <20201009193529.322822-22-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW50cm9kdWNlIGxpYmJsa2Rldi5mYSB0byBhdm9pZCByZWNvbXBpbGluZyBibG9ja2Rldl9zcyB0
d2ljZS4KClN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4K
UmV2aWV3ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDog
MjAyMDA5MjkxMjU1MTYuMTg2NzE1LTMtc3RlZmFuaGFAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysrLS0KIHN0b3JhZ2UtZGFlbW9uL21lc29uLmJ1
aWxkIHwgIDMgKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA0ZGRk
ODk5ZmRkLi4yZmIwYmI3Y2I0IDEwMDY0NAotLS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5i
dWlsZApAQCAtMTM2Niw3ICsxMzY2LDYgQEAgYmxvY2tkZXZfc3MuYWRkKGZpbGVzKAogYmxvY2tk
ZXZfc3MuYWRkKHdoZW46ICdDT05GSUdfUE9TSVgnLCBpZl90cnVlOiBmaWxlcygnb3MtcG9zaXgu
YycpKQogc29mdG1tdV9zcy5hZGQod2hlbjogJ0NPTkZJR19XSU4zMicsIGlmX3RydWU6IFtmaWxl
cygnb3Mtd2luMzIuYycpXSkKIAotc29mdG1tdV9zcy5hZGRfYWxsKGJsb2NrZGV2X3NzKQogc29m
dG1tdV9zcy5hZGQoZmlsZXMoCiAgICdib290ZGV2aWNlLmMnLAogICAnZG1hLWhlbHBlcnMuYycs
CkBAIC0xNDYyLDYgKzE0NjEsMTUgQEAgYmxvY2sgPSBkZWNsYXJlX2RlcGVuZGVuY3kobGlua193
aG9sZTogW2xpYmJsb2NrXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmtfYXJnczog
J0BibG9jay5zeW1zJywKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczog
W2NyeXB0bywgaW9dKQogCitibG9ja2Rldl9zcyA9IGJsb2NrZGV2X3NzLmFwcGx5KGNvbmZpZ19o
b3N0LCBzdHJpY3Q6IGZhbHNlKQorbGliYmxvY2tkZXYgPSBzdGF0aWNfbGlicmFyeSgnYmxvY2tk
ZXYnLCBibG9ja2Rldl9zcy5zb3VyY2VzKCkgKyBnZW5oLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXBlbmRlbmNpZXM6IGJsb2NrZGV2X3NzLmRlcGVuZGVuY2llcygpLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBuYW1lX3N1ZmZpeDogJ2ZhJywKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYnVpbGRfYnlfZGVmYXVsdDogZmFsc2UpCisKK2Jsb2NrZGV2ID0gZGVj
bGFyZV9kZXBlbmRlbmN5KGxpbmtfd2hvbGU6IFtsaWJibG9ja2Rldl0sCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9ja10pCisKIHFtcF9zcyA9IHFtcF9z
cy5hcHBseShjb25maWdfaG9zdCwgc3RyaWN0OiBmYWxzZSkKIGxpYnFtcCA9IHN0YXRpY19saWJy
YXJ5KCdxbXAnLCBxbXBfc3Muc291cmNlcygpICsgZ2VuaCwKICAgICAgICAgICAgICAgICAgICAg
ICAgIGRlcGVuZGVuY2llczogcW1wX3NzLmRlcGVuZGVuY2llcygpLApAQCAtMTQ3OCw3ICsxNDg2
LDcgQEAgZm9yZWFjaCBtIDogYmxvY2tfbW9kcyArIHNvZnRtbXVfbW9kcwogICAgICAgICAgICAg
ICAgIGluc3RhbGxfZGlyOiBjb25maWdfaG9zdFsncWVtdV9tb2RkaXInXSkKIGVuZGZvcmVhY2gK
IAotc29mdG1tdV9zcy5hZGQoYXV0aHosIGJsb2NrLCBjaGFyZGV2LCBjcnlwdG8sIGlvLCBxbXAp
Citzb2Z0bW11X3NzLmFkZChhdXRoeiwgYmxvY2tkZXYsIGNoYXJkZXYsIGNyeXB0bywgaW8sIHFt
cCkKIGNvbW1vbl9zcy5hZGQocW9tLCBxZW11dXRpbCkKIAogY29tbW9uX3NzLmFkZF9hbGwod2hl
bjogJ0NPTkZJR19TT0ZUTU1VJywgaWZfdHJ1ZTogW3NvZnRtbXVfc3NdKQpkaWZmIC0tZ2l0IGEv
c3RvcmFnZS1kYWVtb24vbWVzb24uYnVpbGQgYi9zdG9yYWdlLWRhZW1vbi9tZXNvbi5idWlsZApp
bmRleCAwNDA5YWNjM2Y1Li5jNWFkY2U4MWMzIDEwMDY0NAotLS0gYS9zdG9yYWdlLWRhZW1vbi9t
ZXNvbi5idWlsZAorKysgYi9zdG9yYWdlLWRhZW1vbi9tZXNvbi5idWlsZApAQCAtMSw3ICsxLDYg
QEAKIHFzZF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcXNkX3NzLmFkZChmaWxlcygncWVtdS1zdG9y
YWdlLWRhZW1vbi5jJykpCi1xc2Rfc3MuYWRkKGJsb2NrLCBjaGFyZGV2LCBxbXAsIHFvbSwgcWVt
dXV0aWwpCi1xc2Rfc3MuYWRkX2FsbChibG9ja2Rldl9zcykKK3FzZF9zcy5hZGQoYmxvY2tkZXYs
IGNoYXJkZXYsIHFtcCwgcW9tLCBxZW11dXRpbCkKIAogc3ViZGlyKCdxYXBpJykKIAotLSAKMi4y
Ni4yCgo=


