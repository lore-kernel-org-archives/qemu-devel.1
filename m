Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5EDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9734420767
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWA+ZuMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9734420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2JG-0002fD-ST
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2FF-0002P7-IJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:03:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2FD-0003lH-Qk
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygqOlufNJDpj/1ysa1bHRtC92SpCW8Px0NcFXYI/JZk=;
 b=NWA+ZuMQ4LEMDbCvUa+YAW/+nsdBGuhPdqW2m5XtnLsp3XuwYntl5sTh1pgw9qD+cdVZb6
 xkAB5Rmj1kL8FW1BwJueiGPpGqDRhAZZ8BxnZLLYDWpmcmhF+pPFW8Ld3eX08g60h4iK7R
 vBqGHvPzbskLnkmJYti93wOG+hQAt44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-42DMtY2XMSuKUgkFReMa1A-1; Wed, 24 Jun 2020 06:02:58 -0400
X-MC-Unique: 42DMtY2XMSuKUgkFReMa1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E521EC1B9;
 Wed, 24 Jun 2020 10:02:57 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 254B271694;
 Wed, 24 Jun 2020 10:02:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/12] block/nvme: don't access CQE after moving cq.head
Date: Wed, 24 Jun 2020 11:02:06 +0100
Message-Id: <20200624100210.59975-9-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8gbm90IGFjY2VzcyBhIENRRSBhZnRlciBpbmNyZW1lbnRpbmcgcS0+Y3EuaGVhZCBhbmQgcmVs
ZWFzaW5nIHEtPmxvY2suCkl0IGlzIHVubGlrZWx5IHRoYXQgdGhpcyBjYXVzZXMgcHJvYmxlbXMg
aW4gcHJhY3RpY2UgYnV0IGl0J3MgYSBsYXRlbnQKYnVnLgoKVGhlIHJlYXNvbiB3aHkgaXQgc2hv
dWxkIGJlIHNhZmUgYXQgdGhlIG1vbWVudCBpcyB0aGF0IGNvbXBsZXRpb24KcHJvY2Vzc2luZyBp
cyBub3QgcmUtZW50cmFudCBhbmQgdGhlIENRIGRvb3JiZWxsIGlzbid0IHdyaXR0ZW4gdW50aWwg
dGhlCmVuZCBvZiBudm1lX3Byb2Nlc3NfY29tcGxldGlvbigpLgoKTWFrZSB0aGlzIGNoYW5nZSBu
b3cgYmVjYXVzZSBRRU1VIGV4cGVjdHMgY29tcGxldGlvbiBwcm9jZXNzaW5nIHRvIGJlCnJlLWVu
dHJhbnQgYW5kIGxhdGVyIHBhdGNoZXMgd2lsbCBkbyB0aGF0LgoKU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU2VyZ2lvIExv
cGV6IDxzbHBAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA2MTcxMzIyMDEuMTgzMjE1Mi00
LXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ibG9jay9u
dm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggZDU2N2VjZTNmNC4uMzQ0ODkzODExYSAxMDA2NDQK
LS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAtMzIxLDExICszMjEsMTQg
QEAgc3RhdGljIGJvb2wgbnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oQkRSVk5WTWVTdGF0ZSAqcywg
TlZNZVF1ZXVlUGFpciAqcSkKICAgICBxLT5idXN5ID0gdHJ1ZTsKICAgICBhc3NlcnQocS0+aW5m
bGlnaHQgPj0gMCk7CiAgICAgd2hpbGUgKHEtPmluZmxpZ2h0KSB7CisgICAgICAgIGludCByZXQ7
CiAgICAgICAgIGludDE2X3QgY2lkOworCiAgICAgICAgIGMgPSAoTnZtZUNxZSAqKSZxLT5jcS5x
dWV1ZVtxLT5jcS5oZWFkICogTlZNRV9DUV9FTlRSWV9CWVRFU107CiAgICAgICAgIGlmICgobGUx
Nl90b19jcHUoYy0+c3RhdHVzKSAmIDB4MSkgPT0gcS0+Y3FfcGhhc2UpIHsKICAgICAgICAgICAg
IGJyZWFrOwogICAgICAgICB9CisgICAgICAgIHJldCA9IG52bWVfdHJhbnNsYXRlX2Vycm9yKGMp
OwogICAgICAgICBxLT5jcS5oZWFkID0gKHEtPmNxLmhlYWQgKyAxKSAlIE5WTUVfUVVFVUVfU0la
RTsKICAgICAgICAgaWYgKCFxLT5jcS5oZWFkKSB7CiAgICAgICAgICAgICBxLT5jcV9waGFzZSA9
ICFxLT5jcV9waGFzZTsKQEAgLTM0NCw3ICszNDcsNyBAQCBzdGF0aWMgYm9vbCBudm1lX3Byb2Nl
c3NfY29tcGxldGlvbihCRFJWTlZNZVN0YXRlICpzLCBOVk1lUXVldWVQYWlyICpxKQogICAgICAg
ICBwcmVxLT5idXN5ID0gZmFsc2U7CiAgICAgICAgIHByZXEtPmNiID0gcHJlcS0+b3BhcXVlID0g
TlVMTDsKICAgICAgICAgcWVtdV9tdXRleF91bmxvY2soJnEtPmxvY2spOwotICAgICAgICByZXEu
Y2IocmVxLm9wYXF1ZSwgbnZtZV90cmFuc2xhdGVfZXJyb3IoYykpOworICAgICAgICByZXEuY2Io
cmVxLm9wYXF1ZSwgcmV0KTsKICAgICAgICAgcWVtdV9tdXRleF9sb2NrKCZxLT5sb2NrKTsKICAg
ICAgICAgcS0+aW5mbGlnaHQtLTsKICAgICAgICAgcHJvZ3Jlc3MgPSB0cnVlOwotLSAKMi4yNi4y
Cgo=


