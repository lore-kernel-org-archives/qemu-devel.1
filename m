Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285A522282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQd3vf/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285A522282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyPV-0001RW-46
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyC6-0001Mx-Kc
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyC4-0002yZ-Uu
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNfN2apRAUP53nI5+CzLUKJ5iAStnHcFEQ3Mb3hTQOo=;
 b=ZQd3vf/8RnMEOEu9gF+UZ+tJQtxPTM9DlFrG7hitwDESoJ80+Xw9dpppUIJH0893uExOeU
 u1j8rEPWn+5qmTrap+sy/ir20SzCKGibjXUXuMSW4MZ3MqKO8ap3yqLzNd57X7YwHHv/Sz
 tWrqNfRXnUok0ZigRxzh5HvGxYEdQNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xZFB22IwM8eBqc45YIruGg-1; Fri, 09 Oct 2020 15:36:40 -0400
X-MC-Unique: xZFB22IwM8eBqc45YIruGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6080100746B;
 Fri,  9 Oct 2020 19:36:38 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2CC41002382;
 Fri,  9 Oct 2020 19:36:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 11/30] util/vhost-user-server: drop unnecessary watch deletion
Date: Fri,  9 Oct 2020 20:35:10 +0100
Message-Id: <20201009193529.322822-12-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

RXhwbGljaXRseSBkZWxldGluZyB3YXRjaGVzIGlzIG5vdCBuZWNlc3Nhcnkgc2luY2UgbGlidmhv
c3QtdXNlciBjYWxscwpyZW1vdmVfd2F0Y2goKSBkdXJpbmcgdnVfZGVpbml0KCkuIEFkZCBhbiBh
c3NlcnRpb24gdG8gY2hlY2sgdGhpcwp0aG91Z2guCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTI0MTUxNTQ5Ljkx
MzczNy01LXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3pp
IDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyB8IDE5
ICsrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyBiL3V0
aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwppbmRleCBlYmU0Nzg4NWY1Li5lYmI4NTA3MzFiIDEwMDY0
NAotLS0gYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKKysrIGIvdXRpbC92aG9zdC11c2VyLXNl
cnZlci5jCkBAIC00OCwyMSArNDgsNiBAQCBzdGF0aWMgdm9pZCBjbG9zZV9jbGllbnQoVnVTZXJ2
ZXIgKnNlcnZlcikKICAgICAvKiBXaGVuIHRoaXMgaXMgc2V0IHZ1X2NsaWVudF90cmlwIHdpbGwg
c3RvcCBuZXcgcHJvY2Vzc2luZyB2aG9zdC11c2VyIG1lc3NhZ2UgKi8KICAgICBzZXJ2ZXItPnNp
b2MgPSBOVUxMOwogCi0gICAgVnVGZFdhdGNoICp2dV9mZF93YXRjaCwgKm5leHQ7Ci0gICAgUVRB
SUxRX0ZPUkVBQ0hfU0FGRSh2dV9mZF93YXRjaCwgJnNlcnZlci0+dnVfZmRfd2F0Y2hlcywgbmV4
dCwgbmV4dCkgewotICAgICAgICBhaW9fc2V0X2ZkX2hhbmRsZXIoc2VydmVyLT5pb2MtPmN0eCwg
dnVfZmRfd2F0Y2gtPmZkLCB0cnVlLCBOVUxMLAotICAgICAgICAgICAgICAgICAgICAgICAgICAg
TlVMTCwgTlVMTCwgTlVMTCk7Ci0gICAgfQotCi0gICAgd2hpbGUgKCFRVEFJTFFfRU1QVFkoJnNl
cnZlci0+dnVfZmRfd2F0Y2hlcykpIHsKLSAgICAgICAgUVRBSUxRX0ZPUkVBQ0hfU0FGRSh2dV9m
ZF93YXRjaCwgJnNlcnZlci0+dnVfZmRfd2F0Y2hlcywgbmV4dCwgbmV4dCkgewotICAgICAgICAg
ICAgaWYgKCF2dV9mZF93YXRjaC0+cHJvY2Vzc2luZykgewotICAgICAgICAgICAgICAgIFFUQUlM
UV9SRU1PVkUoJnNlcnZlci0+dnVfZmRfd2F0Y2hlcywgdnVfZmRfd2F0Y2gsIG5leHQpOwotICAg
ICAgICAgICAgICAgIGdfZnJlZSh2dV9mZF93YXRjaCk7Ci0gICAgICAgICAgICB9Ci0gICAgICAg
IH0KLSAgICB9Ci0KICAgICB3aGlsZSAoc2VydmVyLT5wcm9jZXNzaW5nX21zZykgewogICAgICAg
ICBpZiAoc2VydmVyLT5pb2MtPnJlYWRfY29yb3V0aW5lKSB7CiAgICAgICAgICAgICBzZXJ2ZXIt
PmlvYy0+cmVhZF9jb3JvdXRpbmUgPSBOVUxMOwpAQCAtNzMsNiArNTgsMTAgQEAgc3RhdGljIHZv
aWQgY2xvc2VfY2xpZW50KFZ1U2VydmVyICpzZXJ2ZXIpCiAgICAgfQogCiAgICAgdnVfZGVpbml0
KCZzZXJ2ZXItPnZ1X2Rldik7CisKKyAgICAvKiB2dV9kZWluaXQoKSBzaG91bGQgaGF2ZSBjYWxs
ZWQgcmVtb3ZlX3dhdGNoKCkgKi8KKyAgICBhc3NlcnQoUVRBSUxRX0VNUFRZKCZzZXJ2ZXItPnZ1
X2ZkX3dhdGNoZXMpKTsKKwogICAgIG9iamVjdF91bnJlZihPQkpFQ1Qoc2lvYykpOwogICAgIG9i
amVjdF91bnJlZihPQkpFQ1Qoc2VydmVyLT5pb2MpKTsKIH0KLS0gCjIuMjYuMgoK


