Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC86C47256
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEAE206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1M+fTht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEAE206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWKs-00041I-KA
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWK6-0002hj-6i
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWK4-0006Iw-5l
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUWK3-0006FY-L1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588342042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkvF79RrRX5S1GUW/qd4mrdcGIbSvsNKlW8sbMYtD+k=;
 b=Z1M+fThtkel0fCn249tWQh32GlYLhIyolPynoVZO/JYTZjumR0wNdvlAzpuU2iZK+9AGJw
 WlO66XUu8a3P0cIdU+zJrMNnogCbkfRHGWoNOXzxShj0lZ7U9fgnpowugoN0KpsTqL8sIu
 KCXdSlCy/Fbpk4C6ZALl6hpaY/e4K3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-SzHfc6M1NuuzTT3pXhi7Jw-1; Fri, 01 May 2020 10:07:20 -0400
X-MC-Unique: SzHfc6M1NuuzTT3pXhi7Jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865628015D1;
 Fri,  1 May 2020 14:07:19 +0000 (UTC)
Received: from localhost (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32E7E5D9CC;
 Fri,  1 May 2020 14:07:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/2] virtiofsd: stay below fs.file-max sysctl value
 (CVE-2020-10717)
Date: Fri,  1 May 2020 15:06:44 +0100
Message-Id: <20200501140644.220940-3-stefanha@redhat.com>
In-Reply-To: <20200501140644.220940-1-stefanha@redhat.com>
References: <20200501140644.220940-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Avrahami <yavrahami@paloaltonetworks.com>, pjp@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHN5c3RlbS13aWRlIGZzLmZpbGUtbWF4IHN5c2N0bCB2YWx1ZSBkZXRlcm1pbmVzIGhvdyBt
YW55IGZpbGVzIGNhbgpiZSBvcGVuLiAgSXQgZGVmYXVsdHMgdG8gYSB2YWx1ZSBjYWxjdWxhdGVk
IGJhc2VkIG9uIHRoZSBtYWNoaW5lJ3MgUkFNCnNpemUuICBQcmV2aW91c2x5IHZpcnRpb2ZzZCB3
b3VsZCB0cnkgdG8gc2V0IFJMSU1JVF9OT0ZJTEUgdG8gMSwwMDAsMDAwCmFuZCB0aGlzIGFsbG93
ZWQgdGhlIEZVU0UgY2xpZW50IHRvIGV4aGF1c3QgdGhlIG51bWJlciBvZiBvcGVuIGZpbGVzCnN5
c3RlbS13aWRlIG9uIExpbnV4IGhvc3RzIHdpdGggbGVzcyB0aGFuIDEwIEdCIG9mIFJBTSEKClRh
a2UgZnMuZmlsZS1tYXggaW50byBhY2NvdW50IHdoZW4gY2hvb3NpbmcgdGhlIGRlZmF1bHQgUkxJ
TUlUX05PRklMRQp2YWx1ZS4KCkZpeGVzOiBDVkUtMjAyMC0xMDcxNwpSZXBvcnRlZC1ieTogWXV2
YWwgQXZyYWhhbWkgPHlhdnJhaGFtaUBwYWxvYWx0b25ldHdvcmtzLmNvbT4KU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRHIu
IERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT4KLS0tCiB0b29scy92aXJ0
aW9mc2QvaGVscGVyLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90b29s
cy92aXJ0aW9mc2QvaGVscGVyLmMgYi90b29scy92aXJ0aW9mc2QvaGVscGVyLmMKaW5kZXggZGM1
OWYzOGFmMC4uMDBhMWVmNjY2YSAxMDA2NDQKLS0tIGEvdG9vbHMvdmlydGlvZnNkL2hlbHBlci5j
CisrKyBiL3Rvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYwpAQCAtMTc2LDcgKzE3Niw4IEBAIHZvaWQg
ZnVzZV9jbWRsaW5lX2hlbHAodm9pZCkKICAgICAgICAgICAgIiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkZWZhdWx0OiBub194YXR0clxuIgogICAgICAgICAgICAiICAgIC0tcmxpbWl0
LW5vZmlsZT08bnVtPiAgICAgIHNldCBtYXhpbXVtIG51bWJlciBvZiBmaWxlIGRlc2NyaXB0b3Jz
XG4iCiAgICAgICAgICAgICIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDAgbGVhdmVz
IHJsaW1pdCB1bmNoYW5nZWQpXG4iCi0gICAgICAgICAgICIgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGVmYXVsdDogMSwwMDAsMDAwIGlmIHRoZSBjdXJyZW50IHJsaW1pdCBpcyBsb3dl
clxuIgorICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQ6
IG1pbigxMDAwMDAwLCBmcy5maWxlLW1heCAtIDE2Mzg0KVxuIgorICAgICAgICAgICAiICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIHRoZSBjdXJyZW50IHJsaW1pdCBp
cyBsb3dlclxuIgogICAgICAgICAgICApOwogfQogCkBAIC0xOTksOSArMjAwLDMyIEBAIHN0YXRp
YyBpbnQgZnVzZV9oZWxwZXJfb3B0X3Byb2Modm9pZCAqZGF0YSwgY29uc3QgY2hhciAqYXJnLCBp
bnQga2V5LAogCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBnZXRfZGVmYXVsdF9ybGltaXRfbm9maWxl
KHZvaWQpCiB7CisgICAgZ19hdXRvZnJlZSBnY2hhciAqZmlsZV9tYXhfc3RyID0gTlVMTDsKKyAg
ICBjb25zdCBybGltX3QgcmVzZXJ2ZWRfZmRzID0gMTYzODQ7IC8qIGxlYXZlIGF0IGxlYXN0IHRo
aXMgbWFueSBmZHMgZnJlZSAqLwogICAgIHJsaW1fdCBtYXhfZmRzID0gMTAwMDAwMDsgLyogb3Vy
IGRlZmF1bHQgUkxJTUlUX05PRklMRSB0YXJnZXQgKi8KKyAgICBybGltX3QgZmlsZV9tYXg7CiAg
ICAgc3RydWN0IHJsaW1pdCBybGltOwogCisgICAgLyoKKyAgICAgKiBSZWR1Y2UgbWF4X2ZkcyBi
ZWxvdyB0aGUgc3lzdGVtLXdpZGUgbWF4aW11bSwgaWYgbmVjZXNzYXJ5LiAgVGhpcworICAgICAq
IGVuc3VyZXMgdGhlcmUgYXJlIGZkcyBhdmFpbGFibGUgZm9yIG90aGVyIHByb2Nlc3NlcyBzbyB3
ZSBkb24ndAorICAgICAqIGNhdXNlIHJlc291cmNlIGV4aGF1c3Rpb24uCisgICAgICovCisgICAg
aWYgKCFnX2ZpbGVfZ2V0X2NvbnRlbnRzKCIvcHJvYy9zeXMvZnMvZmlsZS1tYXgiLCAmZmlsZV9t
YXhfc3RyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMKSkgeworICAg
ICAgICBmdXNlX2xvZyhGVVNFX0xPR19FUlIsICJjYW4ndCByZWFkIC9wcm9jL3N5cy9mcy9maWxl
LW1heFxuIik7CisgICAgICAgIGV4aXQoMSk7CisgICAgfQorICAgIGZpbGVfbWF4ID0gZ19hc2Np
aV9zdHJ0b3VsbChmaWxlX21heF9zdHIsIE5VTEwsIDEwKTsKKyAgICBpZiAoZmlsZV9tYXggPCAy
ICogcmVzZXJ2ZWRfZmRzKSB7CisgICAgICAgIGZ1c2VfbG9nKEZVU0VfTE9HX0VSUiwKKyAgICAg
ICAgICAgICAgICAgIlRoZSBmcy5maWxlLW1heCBzeXNjdGwgaXMgdG9vIGxvdyAoJWx1KSB0byBh
bGxvdyBhICIKKyAgICAgICAgICAgICAgICAgInJlYXNvbmFibGUgbnVtYmVyIG9mIG9wZW4gZmls
ZXMuXG4iLAorICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylmaWxlX21heCk7CisgICAg
ICAgIGV4aXQoMSk7CisgICAgfQorICAgIG1heF9mZHMgPSBNSU4oZmlsZV9tYXggLSByZXNlcnZl
ZF9mZHMsIG1heF9mZHMpOworCiAgICAgaWYgKGdldHJsaW1pdChSTElNSVRfTk9GSUxFLCAmcmxp
bSkgPCAwKSB7CiAgICAgICAgIGZ1c2VfbG9nKEZVU0VfTE9HX0VSUiwgImdldHJsaW1pdChSTElN
SVRfTk9GSUxFKTogJW1cbiIpOwogICAgICAgICBleGl0KDEpOwotLSAKMi4yNS4zCgo=


