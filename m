Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C46207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOgUajjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C46207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5nm-0004fL-Tq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mX-0002rG-9n
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mW-0002Ve-DR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589908315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+nfQ/k3btjKGYc/RWEmhyNXfBEeP3NikdCpuMvaz5k=;
 b=UOgUajjES/IhyQRzWBv7ksqjtuur78LJlf5gKTtyrJ6K4g9lfIHrI7FbE8f5NibTevn5l2
 t8xc21FNHMFSgOSaRD9ZlRTxGh8EXOBmsZ/S0jeLCjA4if/B389yJvFUv5FuCRQ/NviKLH
 rhP99BtsDoldwNUmoc8lZ6sbmQo8Ro4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-uftcanREPDS83XSYpMjmVQ-1; Tue, 19 May 2020 13:11:52 -0400
X-MC-Unique: uftcanREPDS83XSYpMjmVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90508D8760;
 Tue, 19 May 2020 17:11:50 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3FE6246F;
 Tue, 19 May 2020 17:11:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] block/nvme: drop tautologous assertion
Date: Tue, 19 May 2020 18:11:33 +0100
Message-Id: <20200519171138.201667-3-stefanha@redhat.com>
In-Reply-To: <20200519171138.201667-1-stefanha@redhat.com>
References: <20200519171138.201667-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oKSBleHBsaWNpdGx5IGNoZWNrcyBjaWQgc28gdGhlIGFz
c2VydGlvbiB0aGF0CmZvbGxvd3MgaXMgYWx3YXlzIHRydWU6CgogIGlmIChjaWQgPT0gMCB8fCBj
aWQgPiBOVk1FX1FVRVVFX1NJWkUpIHsKICAgICAgLi4uCiAgICAgIGNvbnRpbnVlOwogIH0KICBh
c3NlcnQoY2lkIDw9IE5WTUVfUVVFVUVfU0laRSk7CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogYmxvY2svbnZtZS5jIHwgMSAtCiAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Js
b2NrL252bWUuYwppbmRleCA3ZWI0NTEyNjY2Li41Mjg2MjI3MDc0IDEwMDY0NAotLS0gYS9ibG9j
ay9udm1lLmMKKysrIGIvYmxvY2svbnZtZS5jCkBAIC0zMzYsNyArMzM2LDYgQEAgc3RhdGljIGJv
b2wgbnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oQkRSVk5WTWVTdGF0ZSAqcywgTlZNZVF1ZXVlUGFp
ciAqcSkKICAgICAgICAgICAgICAgICAgICAgY2lkKTsKICAgICAgICAgICAgIGNvbnRpbnVlOwog
ICAgICAgICB9Ci0gICAgICAgIGFzc2VydChjaWQgPD0gTlZNRV9RVUVVRV9TSVpFKTsKICAgICAg
ICAgdHJhY2VfbnZtZV9jb21wbGV0ZV9jb21tYW5kKHMsIHEtPmluZGV4LCBjaWQpOwogICAgICAg
ICBwcmVxID0gJnEtPnJlcXNbY2lkIC0gMV07CiAgICAgICAgIHJlcSA9ICpwcmVxOwotLSAKMi4y
NS4zCgo=


