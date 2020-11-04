Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF1C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF6E206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfYb8mX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF6E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKgG-0007Aq-Fg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZC-00055i-Gt
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZA-0007uM-O4
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxDVLOr8xwRV8sjIEMjjd9BMHpXbgUmTJTFi4H6YsS8=;
 b=OfYb8mX6z4NgruXqq0whrOtvGoQeVIiO7Y94O8KzSNlOPkxqX1gVf0wBkGIsbMZCmCKnvI
 qSj7kNy+uoAZvvamEMKEYPdLcRjom8P1JRjdtQiGidMiRZqOl/QLHrKmVxkZ9/tZCSrhns
 qMlVOGhj+fwRr5EbMy2UCKIjC1Vf0EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-aFds57BUPTGtQO2KKuMpcg-1; Wed, 04 Nov 2020 10:19:11 -0500
X-MC-Unique: aFds57BUPTGtQO2KKuMpcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71DFF1087D64;
 Wed,  4 Nov 2020 15:19:09 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8797919C4F;
 Wed,  4 Nov 2020 15:19:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/33] block/nvme: Report warning with warn_report()
Date: Wed,  4 Nov 2020 15:18:00 +0000
Message-Id: <20201104151828.405824-6-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKSW5zdGVh
ZCBvZiBkaXNwbGF5aW5nIHdhcm5pbmcgb24gc3RkZXJyLCB1c2Ugd2Fybl9yZXBvcnQoKQp3aGlj
aCBhbHNvIGRpc3BsYXlzIGl0IG9uIHRoZSBtb25pdG9yLgoKUmV2aWV3ZWQtYnk6IEVyaWMgQXVn
ZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJl
ZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
cmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMjkwOTMzMDYuMTA2Mzg3OS00LXBoaWxtZEBy
ZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ci0tLQog
YmxvY2svbnZtZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwpp
bmRleCA3MzlhMGE3MDBjLi42ZjFkN2Y5YjJhIDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysr
IGIvYmxvY2svbnZtZS5jCkBAIC0zOTksOCArMzk5LDggQEAgc3RhdGljIGJvb2wgbnZtZV9wcm9j
ZXNzX2NvbXBsZXRpb24oTlZNZVF1ZXVlUGFpciAqcSkKICAgICAgICAgfQogICAgICAgICBjaWQg
PSBsZTE2X3RvX2NwdShjLT5jaWQpOwogICAgICAgICBpZiAoY2lkID09IDAgfHwgY2lkID4gTlZN
RV9RVUVVRV9TSVpFKSB7Ci0gICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlVuZXhwZWN0ZWQg
Q0lEIGluIGNvbXBsZXRpb24gcXVldWU6ICUiIFBSSXUzMiAiXG4iLAotICAgICAgICAgICAgICAg
ICAgICBjaWQpOworICAgICAgICAgICAgd2Fybl9yZXBvcnQoIk5WTWU6IFVuZXhwZWN0ZWQgQ0lE
IGluIGNvbXBsZXRpb24gcXVldWU6ICUiUFJJdTMyIiwgIgorICAgICAgICAgICAgICAgICAgICAg
ICAgInF1ZXVlIHNpemU6ICV1IiwgY2lkLCBOVk1FX1FVRVVFX1NJWkUpOwogICAgICAgICAgICAg
Y29udGludWU7CiAgICAgICAgIH0KICAgICAgICAgdHJhY2VfbnZtZV9jb21wbGV0ZV9jb21tYW5k
KHMsIHEtPmluZGV4LCBjaWQpOwotLSAKMi4yOC4wCgo=


