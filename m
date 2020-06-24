Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E26E20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgoHZCwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E26E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2I3-0007Wm-J5
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2FB-0002Fu-8w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:03:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2F9-0003jy-MH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=px6UzXrF2X1M4UOHq2k4dKpAGlLnAFyJPkYcTsXrT7M=;
 b=bgoHZCwEsYESwA8RXz/cm6vznIIQNl5fJhVrDQQnSfW6fXniKnPkhpFt/JDdcI/oOJt+k0
 zqqVeDUH9gaLceUfOFR+Ugs6QMyUzhWmAdxp9N/Q9vmG6lcua8XnKj8sz8i2cAsBHFLIrj
 a1SMGwHwN6qMk6UJyhtzysb8Vh42ZJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ADP_mQo5O26SzIT4yZH5Ng-1; Wed, 24 Jun 2020 06:02:56 -0400
X-MC-Unique: ADP_mQo5O26SzIT4yZH5Ng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A8B1B18BCA;
 Wed, 24 Jun 2020 10:02:55 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E987D79315;
 Wed, 24 Jun 2020 10:02:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/12] block/nvme: drop tautologous assertion
Date: Wed, 24 Jun 2020 11:02:05 +0100
Message-Id: <20200624100210.59975-8-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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

bnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oKSBleHBsaWNpdGx5IGNoZWNrcyBjaWQgc28gdGhlIGFz
c2VydGlvbiB0aGF0CmZvbGxvd3MgaXMgYWx3YXlzIHRydWU6CgogIGlmIChjaWQgPT0gMCB8fCBj
aWQgPiBOVk1FX1FVRVVFX1NJWkUpIHsKICAgICAgLi4uCiAgICAgIGNvbnRpbnVlOwogIH0KICBh
c3NlcnQoY2lkIDw9IE5WTUVfUVVFVUVfU0laRSk7CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTZXJnaW8gTG9wZXogPHNs
cEByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDYxNzEzMjIwMS4xODMyMTUyLTMtc3RlZmFu
aGFAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ci0tLQogYmxvY2svbnZtZS5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCBl
NDM3NWVjMjQ1Li5kNTY3ZWNlM2Y0IDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxv
Y2svbnZtZS5jCkBAIC0zMzYsNyArMzM2LDYgQEAgc3RhdGljIGJvb2wgbnZtZV9wcm9jZXNzX2Nv
bXBsZXRpb24oQkRSVk5WTWVTdGF0ZSAqcywgTlZNZVF1ZXVlUGFpciAqcSkKICAgICAgICAgICAg
ICAgICAgICAgY2lkKTsKICAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgICB9Ci0gICAgICAg
IGFzc2VydChjaWQgPD0gTlZNRV9RVUVVRV9TSVpFKTsKICAgICAgICAgdHJhY2VfbnZtZV9jb21w
bGV0ZV9jb21tYW5kKHMsIHEtPmluZGV4LCBjaWQpOwogICAgICAgICBwcmVxID0gJnEtPnJlcXNb
Y2lkIC0gMV07CiAgICAgICAgIHJlcSA9ICpwcmVxOwotLSAKMi4yNi4yCgo=


