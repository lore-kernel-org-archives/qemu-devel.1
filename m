Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E98424654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVKJ6gdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E98424654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47Ws-0004PE-KI
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j47W3-0003yk-09
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j47W1-0002zV-90
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:22:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j47W1-0002xY-18
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582050156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vfE1X1JGFqyKfp7SozvxEPu1YK6Qig1zeUakm0hN9T0=;
 b=YVKJ6gdlYKcY2ATq2V5HoACglfo7mF1CWyfuybrekHaIRymadk2fabkcnGShhJYo3fobjX
 rjfJ2v2qlEucvxGgGjjCdanL6Vik9m8jAGOQRpFu0WNefPn3l82NlyH4tlFRgbIBzjlpHt
 p01hgynjcapVUEttMn5R4L+pSH1Olmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-s-h_4HsHOIiZXszZvt1Isw-1; Tue, 18 Feb 2020 13:22:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF5E0107B267
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 18:22:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C59015C13B;
 Tue, 18 Feb 2020 18:22:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
Date: Tue, 18 Feb 2020 18:22:26 +0000
Message-Id: <20200218182226.913977-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: s-h_4HsHOIiZXszZvt1Isw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmVhbGxvY2luZyB0aGUgaW9ldmVudGZkc1tdIGFycmF5IGVhY2ggdGltZSBhbiBlbGVtZW50IGlz
IGFkZGVkIGlzIHZlcnkKZXhwZW5zaXZlIGFzIHRoZSBudW1iZXIgb2YgaW9ldmVudGZkcyBpbmNy
ZWFzZXMuICBCYXRjaCBhbGxvY2F0ZSBpbnN0ZWFkCnRvIGFtb3J0aXplIHRoZSBjb3N0IG9mIHJl
YWxsb2MuCgpUaGlzIHBhdGNoIHJlZHVjZXMgTGludXggZ3Vlc3QgYm9vdCB0aW1lcyBmcm9tIDM2
MnMgdG8gMTQwcyB3aGVuIHRoZXJlCmFyZSAyIHZpcnRpby1ibGsgZGV2aWNlcyB3aXRoIDEgdmly
dHF1ZXVlIGFuZCA5OSB2aXJ0aW8tYmxrIGRldmljZXMgd2l0aAozMiB2aXJ0cXVldWVzLgoKU2ln
bmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIG1l
bW9yeS5jIHwgMTcgKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21lbW9yeS5jIGIvbWVtb3J5LmMK
aW5kZXggYWVhYThkY2M5ZS4uMmQ2ZjkzMWY4YyAxMDA2NDQKLS0tIGEvbWVtb3J5LmMKKysrIGIv
bWVtb3J5LmMKQEAgLTc5NCwxMCArNzk0LDE4IEBAIHN0YXRpYyB2b2lkIGFkZHJlc3Nfc3BhY2Vf
dXBkYXRlX2lvZXZlbnRmZHMoQWRkcmVzc1NwYWNlICphcykKICAgICBGbGF0VmlldyAqdmlldzsK
ICAgICBGbGF0UmFuZ2UgKmZyOwogICAgIHVuc2lnbmVkIGlvZXZlbnRmZF9uYiA9IDA7Ci0gICAg
TWVtb3J5UmVnaW9uSW9ldmVudGZkICppb2V2ZW50ZmRzID0gTlVMTDsKKyAgICB1bnNpZ25lZCBp
b2V2ZW50ZmRfbWF4OworICAgIE1lbW9yeVJlZ2lvbklvZXZlbnRmZCAqaW9ldmVudGZkczsKICAg
ICBBZGRyUmFuZ2UgdG1wOwogICAgIHVuc2lnbmVkIGk7CiAKKyAgICAvKgorICAgICAqIEl0IGlz
IGxpa2VseSB0aGF0IHRoZSBudW1iZXIgb2YgaW9ldmVudGZkcyBoYXNuJ3QgY2hhbmdlZCBtdWNo
LCBzbyB1c2UKKyAgICAgKiB0aGUgcHJldmlvdXMgc2l6ZSBhcyB0aGUgc3RhcnRpbmcgdmFsdWUu
CisgICAgICovCisgICAgaW9ldmVudGZkX21heCA9IGFzLT5pb2V2ZW50ZmRfbmI7CisgICAgaW9l
dmVudGZkcyA9IGdfbmV3KE1lbW9yeVJlZ2lvbklvZXZlbnRmZCwgaW9ldmVudGZkX21heCk7CisK
ICAgICB2aWV3ID0gYWRkcmVzc19zcGFjZV9nZXRfZmxhdHZpZXcoYXMpOwogICAgIEZPUl9FQUNI
X0ZMQVRfUkFOR0UoZnIsIHZpZXcpIHsKICAgICAgICAgZm9yIChpID0gMDsgaSA8IGZyLT5tci0+
aW9ldmVudGZkX25iOyArK2kpIHsKQEAgLTgwNiw4ICs4MTQsMTEgQEAgc3RhdGljIHZvaWQgYWRk
cmVzc19zcGFjZV91cGRhdGVfaW9ldmVudGZkcyhBZGRyZXNzU3BhY2UgKmFzKQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50MTI4X21ha2U2NChmci0+b2Zm
c2V0X2luX3JlZ2lvbikpKTsKICAgICAgICAgICAgIGlmIChhZGRycmFuZ2VfaW50ZXJzZWN0cyhm
ci0+YWRkciwgdG1wKSkgewogICAgICAgICAgICAgICAgICsraW9ldmVudGZkX25iOwotICAgICAg
ICAgICAgICAgIGlvZXZlbnRmZHMgPSBnX3JlYWxsb2MoaW9ldmVudGZkcywKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvZXZlbnRmZF9uYiAqIHNpemVvZigqaW9l
dmVudGZkcykpOworICAgICAgICAgICAgICAgIGlmIChpb2V2ZW50ZmRfbmIgPiBpb2V2ZW50ZmRf
bWF4KSB7CisgICAgICAgICAgICAgICAgICAgIGlvZXZlbnRmZF9tYXggKz0gNjQ7CisgICAgICAg
ICAgICAgICAgICAgIGlvZXZlbnRmZHMgPSBnX3JlYWxsb2MoaW9ldmVudGZkcywKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpb2V2ZW50ZmRfbWF4ICogc2l6ZW9mKCppb2V2ZW50ZmRzKSk7
CisgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgIGlvZXZlbnRmZHNbaW9ldmVudGZk
X25iLTFdID0gZnItPm1yLT5pb2V2ZW50ZmRzW2ldOwogICAgICAgICAgICAgICAgIGlvZXZlbnRm
ZHNbaW9ldmVudGZkX25iLTFdLmFkZHIgPSB0bXA7CiAgICAgICAgICAgICB9Ci0tIAoyLjI0LjEK
Cg==


