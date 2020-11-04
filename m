Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12639C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFE62074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+iOPrzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFE62074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKa3-0006B4-IA
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYg-0004Rl-QH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYf-0007pq-4V
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWbsFp7DBE9N9DNywJF9TpUh112RLQk5tV8p3cqgf6g=;
 b=i+iOPrzoqcn1c53qEt1TcfEvO7YDVWjyoJGdqF45ETgdzpYskv/FJZRRT6LxG++jeTC84S
 gfkZJ6sIrUXXXm6LxsTzVDPk6ccIp2ClGJpLscnYtgQh4+YwdwL/gPjPtySBoi68dsnRJB
 29bF1QURnb90cKtHs51y4JLMfLRO/18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-VPQui5vfNhu2ohf8eAiOMQ-1; Wed, 04 Nov 2020 10:18:39 -0500
X-MC-Unique: VPQui5vfNhu2ohf8eAiOMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892431018F64;
 Wed,  4 Nov 2020 15:18:37 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBF5673664;
 Wed,  4 Nov 2020 15:18:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/33] accel/kvm: add PIO ioeventfds only in case
 kvm_eventfds_allowed is true
Date: Wed,  4 Nov 2020 15:17:56 +0000
Message-Id: <20201104151828.405824-2-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Afanasova <eafanasova@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRWxlbmEgQWZhbmFzb3ZhIDxlYWZhbmFzb3ZhQGdtYWlsLmNvbT4KClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTog
RWxlbmEgQWZhbmFzb3ZhIDxlYWZhbmFzb3ZhQGdtYWlsLmNvbT4KTWVzc2FnZS1JZDogPDIwMjAx
MDE3MjEwMTAyLjI2MDM2LTEtZWFmYW5hc292YUBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBhY2NlbC9rdm0va3ZtLWFs
bC5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYWNjZWwva3ZtL2t2bS1hbGwuYyBiL2FjY2VsL2t2bS9rdm0t
YWxsLmMKaW5kZXggOWVmNWRhZjRjNS4uYmFhYTU0MjQ5ZCAxMDA2NDQKLS0tIGEvYWNjZWwva3Zt
L2t2bS1hbGwuYworKysgYi9hY2NlbC9rdm0va3ZtLWFsbC5jCkBAIC0yMjM5LDggKzIyMzksMTAg
QEAgc3RhdGljIGludCBrdm1faW5pdChNYWNoaW5lU3RhdGUgKm1zKQogCiAgICAga3ZtX21lbW9y
eV9saXN0ZW5lcl9yZWdpc3RlcihzLCAmcy0+bWVtb3J5X2xpc3RlbmVyLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCAwKTsKLSAgICBtZW1v
cnlfbGlzdGVuZXJfcmVnaXN0ZXIoJmt2bV9pb19saXN0ZW5lciwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfaW8pOworICAgIGlmIChrdm1fZXZlbnRmZHNfYWxs
b3dlZCkgeworICAgICAgICBtZW1vcnlfbGlzdGVuZXJfcmVnaXN0ZXIoJmt2bV9pb19saXN0ZW5l
ciwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNlX2lvKTsK
KyAgICB9CiAgICAgbWVtb3J5X2xpc3RlbmVyX3JlZ2lzdGVyKCZrdm1fY29hbGVzY2VkX3Bpb19s
aXN0ZW5lciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfaW8p
OwogCi0tIAoyLjI4LjAKCg==


