Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899CC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C532C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+Hmv2Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C532C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFEb-0003aZ-OQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAc-0006sY-UN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAa-000336-JL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4VuB6wPq4N5geocrCJSklP2nw5ADHs9isNWslqCQUk=;
 b=O+Hmv2PjgKr1O4A+l84uH7s3v8Q/zEJbQWyUDy9Y8zb4svv/q+GsOTavObIYisiyePqlRY
 NpvZXxLRZgRkqyfxJGJV0xEvQEK3cBOXvJIGalahNyWPyR0uZKzFQ8lY+pxXzuQJ8e2813
 42mzMu1ZAP2r2PBR7TxS7P32iluomq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-ho452u4FOReuDmoOVhfgug-1; Tue, 29 Sep 2020 08:55:46 -0400
X-MC-Unique: ho452u4FOReuDmoOVhfgug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DF76409D;
 Tue, 29 Sep 2020 12:55:44 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93FA65D9F7;
 Tue, 29 Sep 2020 12:55:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] block: move block exports to libblockdev
Date: Tue, 29 Sep 2020 13:55:15 +0100
Message-Id: <20200929125516.186715-4-stefanha@redhat.com>
In-Reply-To: <20200929125516.186715-1-stefanha@redhat.com>
References: <20200929125516.186715-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QmxvY2sgZXhwb3J0cyBhcmUgdXNlZCBieSBzb2Z0bW11LCBxZW11LXN0b3JhZ2UtZGFlbW9uLCBh
bmQgcWVtdS1uYmQuClRoZXkgYXJlIG5vdCB1c2VkIGJ5IG90aGVyIHByb2dyYW1zIGFuZCBhcmUg
bm90IG90aGVyd2lzZSBuZWVkZWQgaW4KbGliYmxvY2suCgpVbmRvIHRoZSByZWNlbnQgbW92ZSBv
ZiBibG9ja2Rldi1uYmQuYyBmcm9tIGJsb2NrZGV2X3NzIGludG8gYmxvY2tfc3MuClNpbmNlIGJk
cnZfY2xvc2VfYWxsKCkgKGxpYmJsb2NrKSBjYWxscyBibGtfZXhwX2Nsb3NlX2FsbCgpCihsaWJi
bG9ja2RldikgYSBzdHViIGZ1bmN0aW9uIGlzIHJlcXVpcmVkLi4KCk1ha2UgcWVtdS1uZGIuYyB1
c2Ugc2lnbmFsIGhhbmRsaW5nIHV0aWxpdHkgZnVuY3Rpb25zIGluc3RlYWQgb2YKZHVwbGljYXRp
bmcgdGhlIGNvZGUuIFRoaXMgaGVscHMgYmVjYXVzZSBvcy1wb3NpeC5jIGlzIGluIGxpYmJsb2Nr
ZGV2CmFuZCBpdCBkZXBlbmRzIG9uIGEgcWVtdV9zeXN0ZW1fa2lsbGVkKCkgc3ltYm9sIHRoYXQg
cWVtdS1uYmQuYyBsYWNrcy4KT25jZSB3ZSB1c2UgdGhlIHNpZ25hbCBoYW5kbGluZyB1dGlsaXR5
IGZ1bmN0aW9ucyB3ZSBhbHNvIGVuZCB1cApwcm92aWRpbmcgdGhlIG5lY2Vzc2FyeSBzeW1ib2wu
CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0t
LQogcWVtdS1uYmQuYyAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKy0tLS0tLS0tLS0tLQog
c3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyB8ICA3ICsrKysrKysKIGJsb2NrL2V4cG9ydC9tZXNv
bi5idWlsZCAgfCAgNCArKy0tCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDQgKystLQog
bmJkL21lc29uLmJ1aWxkICAgICAgICAgICB8ICAyICsrCiBzdHVicy9tZXNvbi5idWlsZCAgICAg
ICAgIHwgIDEgKwogNiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzdHVicy9ibGstZXhwLWNsb3NlLWFsbC5jCgpkaWZm
IC0tZ2l0IGEvcWVtdS1uYmQuYyBiL3FlbXUtbmJkLmMKaW5kZXggNmQ3YWM3NDkwZi4uMDY3NzRj
YTYxNSAxMDA2NDQKLS0tIGEvcWVtdS1uYmQuYworKysgYi9xZW11LW5iZC5jCkBAIC0yNSw2ICsy
NSw3IEBACiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1ZGUgInFlbXUvY3V0aWxzLmgi
CiAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCIKKyNpbmNsdWRlICJzeXNlbXUvcnVu
c3RhdGUuaCIgLyogZm9yIHFlbXVfc3lzdGVtX2tpbGxlZCgpIHByb3RvdHlwZSAqLwogI2luY2x1
ZGUgImJsb2NrL2Jsb2NrX2ludC5oIgogI2luY2x1ZGUgImJsb2NrL25iZC5oIgogI2luY2x1ZGUg
InFlbXUvbWFpbi1sb29wLmgiCkBAIC0xNTUsNyArMTU2LDExIEBAIFFFTVVfQ09QWVJJR0hUICJc
biIKIH0KIAogI2lmIEhBVkVfTkJEX0RFVklDRQotc3RhdGljIHZvaWQgdGVybXNpZ19oYW5kbGVy
KGludCBzaWdudW0pCisvKgorICogVGhlIGNsaWVudCB0aHJlYWQgdXNlcyBTSUdURVJNIHRvIGlu
dGVycnVwdCB0aGUgc2VydmVyLiAgQSBzaWduYWwKKyAqIGhhbmRsZXIgZW5zdXJlcyB0aGF0ICJx
ZW11LW5iZCAtdiAtYyIgZXhpdHMgd2l0aCBhIG5pY2Ugc3RhdHVzIGNvZGUuCisgKi8KK3ZvaWQg
cWVtdV9zeXN0ZW1fa2lsbGVkKGludCBzaWdudW0sIHBpZF90IHBpZCkKIHsKICAgICBhdG9taWNf
Y21weGNoZygmc3RhdGUsIFJVTk5JTkcsIFRFUk1JTkFURSk7CiAgICAgcWVtdV9ub3RpZnlfZXZl
bnQoKTsKQEAgLTU4MSwyMCArNTg2LDEyIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKICAgICBjb25zdCBjaGFyICpwaWRfZmlsZV9uYW1lID0gTlVMTDsKICAgICBCbG9ja0V4cG9y
dE9wdGlvbnMgKmV4cG9ydF9vcHRzOwogCisgICAgb3Nfc2V0dXBfZWFybHlfc2lnbmFsX2hhbmRs
aW5nKCk7CisKICNpZiBIQVZFX05CRF9ERVZJQ0UKLSAgICAvKiBUaGUgY2xpZW50IHRocmVhZCB1
c2VzIFNJR1RFUk0gdG8gaW50ZXJydXB0IHRoZSBzZXJ2ZXIuICBBIHNpZ25hbAotICAgICAqIGhh
bmRsZXIgZW5zdXJlcyB0aGF0ICJxZW11LW5iZCAtdiAtYyIgZXhpdHMgd2l0aCBhIG5pY2Ugc3Rh
dHVzIGNvZGUuCi0gICAgICovCi0gICAgc3RydWN0IHNpZ2FjdGlvbiBzYV9zaWd0ZXJtOwotICAg
IG1lbXNldCgmc2Ffc2lndGVybSwgMCwgc2l6ZW9mKHNhX3NpZ3Rlcm0pKTsKLSAgICBzYV9zaWd0
ZXJtLnNhX2hhbmRsZXIgPSB0ZXJtc2lnX2hhbmRsZXI7Ci0gICAgc2lnYWN0aW9uKFNJR1RFUk0s
ICZzYV9zaWd0ZXJtLCBOVUxMKTsKKyAgICBvc19zZXR1cF9zaWduYWxfaGFuZGxpbmcoKTsKICNl
bmRpZiAvKiBIQVZFX05CRF9ERVZJQ0UgKi8KIAotI2lmZGVmIENPTkZJR19QT1NJWAotICAgIHNp
Z25hbChTSUdQSVBFLCBTSUdfSUdOKTsKLSNlbmRpZgotCiAgICAgc29ja2V0X2luaXQoKTsKICAg
ICBlcnJvcl9pbml0KGFyZ3ZbMF0pOwogICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRf
VFJBQ0UpOwpkaWZmIC0tZ2l0IGEvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyBiL3N0dWJzL2Js
ay1leHAtY2xvc2UtYWxsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4u
MWM3MTMxNjc2MwotLS0gL2Rldi9udWxsCisrKyBiL3N0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMK
QEAgLTAsMCArMSw3IEBACisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImJsb2Nr
L2V4cG9ydC5oIgorCisvKiBPbmx5IHVzZWQgaW4gcHJvZ3JhbXMgdGhhdCBzdXBwb3J0IGJsb2Nr
IGV4cG9ydHMgKGxpYmJsb2NrZGV2LmZhKSAqLwordm9pZCBibGtfZXhwX2Nsb3NlX2FsbCh2b2lk
KQoreworfQpkaWZmIC0tZ2l0IGEvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkIGIvYmxvY2svZXhw
b3J0L21lc29uLmJ1aWxkCmluZGV4IDQ2OWE3YWEwZjUuLmEyNzcyYTBkY2UgMTAwNjQ0Ci0tLSBh
L2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZAorKysgYi9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQK
QEAgLTEsMiArMSwyIEBACi1ibG9ja19zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCi1ibG9ja19z
cy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9VU0VSJywgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LXVz
ZXItYmxrLXNlcnZlci5jJykpCitibG9ja2Rldl9zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCiti
bG9ja2Rldl9zcy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9VU0VSJywgaWZfdHJ1ZTogZmlsZXMo
J3Zob3N0LXVzZXItYmxrLXNlcnZlci5jJykpCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21l
c29uLmJ1aWxkCmluZGV4IDE4ZDY4OWI0MjMuLjBlOTUyOGFkYWIgMTAwNjQ0Ci0tLSBhL21lc29u
LmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC04MzUsNyArODM1LDYgQEAgc3ViZGlyKCdkdW1w
JykKIAogYmxvY2tfc3MuYWRkKGZpbGVzKAogICAnYmxvY2suYycsCi0gICdibG9ja2Rldi1uYmQu
YycsCiAgICdibG9ja2pvYi5jJywKICAgJ2pvYi5jJywKICAgJ3FlbXUtaW8tY21kcy5jJywKQEAg
LTg0OCw2ICs4NDcsNyBAQCBzdWJkaXIoJ2Jsb2NrJykKIAogYmxvY2tkZXZfc3MuYWRkKGZpbGVz
KAogICAnYmxvY2tkZXYuYycsCisgICdibG9ja2Rldi1uYmQuYycsCiAgICdpb3RocmVhZC5jJywK
ICAgJ2pvYi1xbXAuYycsCiApKQpAQCAtMTE3MSw3ICsxMTcxLDcgQEAgaWYgaGF2ZV90b29scwog
ICBxZW11X2lvID0gZXhlY3V0YWJsZSgncWVtdS1pbycsIGZpbGVzKCdxZW11LWlvLmMnKSwKICAg
ICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9jaywgcWVtdXV0aWxdLCBpbnN0YWxsOiB0cnVl
KQogICBxZW11X25iZCA9IGV4ZWN1dGFibGUoJ3FlbXUtbmJkJywgZmlsZXMoJ3FlbXUtbmJkLmMn
KSwKLSAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczogW2Jsb2NrLCBxZW11dXRpbF0sIGluc3Rh
bGw6IHRydWUpCisgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9ja2RldiwgcWVtdXV0
aWxdLCBpbnN0YWxsOiB0cnVlKQogCiAgIHN1YmRpcignc3RvcmFnZS1kYWVtb24nKQogICBzdWJk
aXIoJ2NvbnRyaWIvcmRtYWNtLW11eCcpCmRpZmYgLS1naXQgYS9uYmQvbWVzb24uYnVpbGQgYi9u
YmQvbWVzb24uYnVpbGQKaW5kZXggMGMwMGE3NzZkMy4uMmJhYWEzNjk0OCAxMDA2NDQKLS0tIGEv
bmJkL21lc29uLmJ1aWxkCisrKyBiL25iZC9tZXNvbi5idWlsZApAQCAtMSw1ICsxLDcgQEAKIGJs
b2NrX3NzLmFkZChmaWxlcygKICAgJ2NsaWVudC5jJywKICAgJ2NvbW1vbi5jJywKKykpCitibG9j
a2Rldl9zcy5hZGQoZmlsZXMoCiAgICdzZXJ2ZXIuYycsCiApKQpkaWZmIC0tZ2l0IGEvc3R1YnMv
bWVzb24uYnVpbGQgYi9zdHVicy9tZXNvbi5idWlsZAppbmRleCBlMGIzMjJiYzI4Li4wZmRjZjkz
YzA5IDEwMDY0NAotLS0gYS9zdHVicy9tZXNvbi5idWlsZAorKysgYi9zdHVicy9tZXNvbi5idWls
ZApAQCAtMSw2ICsxLDcgQEAKIHN0dWJfc3MuYWRkKGZpbGVzKCdhcmNoX3R5cGUuYycpKQogc3R1
Yl9zcy5hZGQoZmlsZXMoJ2JkcnYtbmV4dC1tb25pdG9yLW93bmVkLmMnKSkKIHN0dWJfc3MuYWRk
KGZpbGVzKCdibGstY29tbWl0LWFsbC5jJykpCitzdHViX3NzLmFkZChmaWxlcygnYmxrLWV4cC1j
bG9zZS1hbGwuYycpKQogc3R1Yl9zcy5hZGQoZmlsZXMoJ2Jsb2NrZGV2LWNsb3NlLWFsbC1iZHJ2
LXN0YXRlcy5jJykpCiBzdHViX3NzLmFkZChmaWxlcygnY2hhbmdlLXN0YXRlLWhhbmRsZXIuYycp
KQogc3R1Yl9zcy5hZGQoZmlsZXMoJ2Nsb2NrLXdhcnAuYycpKQotLSAKMi4yNi4yCgo=


