Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2600CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6765F2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWivzlhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6765F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKfO-0005Rz-BL
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZT-0005ji-LU
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZQ-0007wR-4L
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRaqFAw0pIpfUOQtgkrvq47FZKmkwaftYt1bLa1tgto=;
 b=FWivzlhIF/1+j2NCcUgOuNgc3YcCqpOQtEYoUK1k5nChIZTcRFiFJh30gUiUwpBDj7mZ8n
 x7IPhegRhFKXJ7nKJehtsgE//1rrWPFrKpboMir4qMpHh5+WOjYOuVV+JGhra2mV0vn0BJ
 t0/hzyuGpgyvTOeKIa9h8VHHVPhyTps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-khTHMmgRMQyyYbkAacqy8A-1; Wed, 04 Nov 2020 10:19:28 -0500
X-MC-Unique: khTHMmgRMQyyYbkAacqy8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447DF80401E;
 Wed,  4 Nov 2020 15:19:26 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06AA56266E;
 Wed,  4 Nov 2020 15:19:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/33] block/nvme: Trace nvme_poll_queue() per queue
Date: Wed,  4 Nov 2020 15:18:02 +0000
Message-Id: <20201104151828.405824-8-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKQXMgd2Ug
d2FudCB0byBlbmFibGUgbXVsdGlwbGUgcXVldWVzLCByZXBvcnQgdGhlIGV2ZW50CmluIGVhY2gg
bnZtZV9wb2xsX3F1ZXVlKCkgY2FsbCwgcmF0aGVyIHRoYW4gb25jZSBpbgp0aGUgY2FsbGJhY2sg
Y2FsbGluZyBudm1lX3BvbGxfcXVldWVzKCkuCgpSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQu
Y29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5MzMwNi4xMDYzODc5LTYtcGhpbG1kQHJlZGhhdC5j
b20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpU
ZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9u
dm1lLmMgICAgICAgfCAyICstCiBibG9jay90cmFjZS1ldmVudHMgfCAyICstCiAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9j
ay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggMzYxYjU3NzJiNy4uOGQ3NDQwMWFlNyAxMDA2
NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAtNTk0LDYgKzU5NCw3
IEBAIHN0YXRpYyBib29sIG52bWVfcG9sbF9xdWV1ZShOVk1lUXVldWVQYWlyICpxKQogICAgIGNv
bnN0IHNpemVfdCBjcWVfb2Zmc2V0ID0gcS0+Y3EuaGVhZCAqIE5WTUVfQ1FfRU5UUllfQllURVM7
CiAgICAgTnZtZUNxZSAqY3FlID0gKE52bWVDcWUgKikmcS0+Y3EucXVldWVbY3FlX29mZnNldF07
CiAKKyAgICB0cmFjZV9udm1lX3BvbGxfcXVldWUocS0+cywgcS0+aW5kZXgpOwogICAgIC8qCiAg
ICAgICogRG8gYW4gZWFybHkgY2hlY2sgZm9yIGNvbXBsZXRpb25zLiBxLT5sb2NrIGlzbid0IG5l
ZWRlZCBiZWNhdXNlCiAgICAgICogbnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oKSBvbmx5IHJ1bnMg
aW4gdGhlIGV2ZW50IGxvb3AgdGhyZWFkIGFuZApAQCAtNjg0LDcgKzY4NSw2IEBAIHN0YXRpYyBi
b29sIG52bWVfcG9sbF9jYih2b2lkICpvcGFxdWUpCiAgICAgQkRSVk5WTWVTdGF0ZSAqcyA9IGNv
bnRhaW5lcl9vZihlLCBCRFJWTlZNZVN0YXRlLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaXJxX25vdGlmaWVyW01TSVhfU0hBUkVEX0lSUV9JRFhdKTsKIAotICAgIHRyYWNl
X252bWVfcG9sbF9jYihzKTsKICAgICByZXR1cm4gbnZtZV9wb2xsX3F1ZXVlcyhzKTsKIH0KIApk
aWZmIC0tZ2l0IGEvYmxvY2svdHJhY2UtZXZlbnRzIGIvYmxvY2svdHJhY2UtZXZlbnRzCmluZGV4
IGI5MGIwN2IxNWYuLjg2MjkyZjMzMTIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL3RyYWNlLWV2ZW50cwor
KysgYi9ibG9jay90cmFjZS1ldmVudHMKQEAgLTE0NSw3ICsxNDUsNyBAQCBudm1lX2NvbXBsZXRl
X2NvbW1hbmQodm9pZCAqcywgaW50IGluZGV4LCBpbnQgY2lkKSAicyAlcCBxdWV1ZSAlZCBjaWQg
JWQiCiBudm1lX3N1Ym1pdF9jb21tYW5kKHZvaWQgKnMsIGludCBpbmRleCwgaW50IGNpZCkgInMg
JXAgcXVldWUgJWQgY2lkICVkIgogbnZtZV9zdWJtaXRfY29tbWFuZF9yYXcoaW50IGMwLCBpbnQg
YzEsIGludCBjMiwgaW50IGMzLCBpbnQgYzQsIGludCBjNSwgaW50IGM2LCBpbnQgYzcpICIlMDJ4
ICUwMnggJTAyeCAlMDJ4ICUwMnggJTAyeCAlMDJ4ICUwMngiCiBudm1lX2hhbmRsZV9ldmVudCh2
b2lkICpzKSAicyAlcCIKLW52bWVfcG9sbF9jYih2b2lkICpzKSAicyAlcCIKK252bWVfcG9sbF9x
dWV1ZSh2b2lkICpzLCB1bnNpZ25lZCBxX2luZGV4KSAicyAlcCBxICMldSIKIG52bWVfcHJ3X2Fs
aWduZWQodm9pZCAqcywgaW50IGlzX3dyaXRlLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5
dGVzLCBpbnQgZmxhZ3MsIGludCBuaW92KSAicyAlcCBpc193cml0ZSAlZCBvZmZzZXQgMHglIlBS
SXg2NCIgYnl0ZXMgJSJQUklkNjQiIGZsYWdzICVkIG5pb3YgJWQiCiBudm1lX3dyaXRlX3plcm9l
cyh2b2lkICpzLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLCBpbnQgZmxhZ3MpICJz
ICVwIG9mZnNldCAweCUiUFJJeDY0IiBieXRlcyAlIlBSSWQ2NCIgZmxhZ3MgJWQiCiBudm1lX3Fp
b3ZfdW5hbGlnbmVkKGNvbnN0IHZvaWQgKnFpb3YsIGludCBuLCB2b2lkICpiYXNlLCBzaXplX3Qg
c2l6ZSwgaW50IGFsaWduKSAicWlvdiAlcCBuICVkIGJhc2UgJXAgc2l6ZSAweCV6eCBhbGlnbiAw
eCV4IgotLSAKMi4yOC4wCgo=


