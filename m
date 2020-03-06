Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FB320717
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isfcE1QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FB320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADwo-0007Ln-9h
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jADtK-0003n9-4u
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jADtI-0002Qq-WA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jADtI-0002K0-SF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvHkvVd+7sDC+hYczEiqu5wvxhfUX/wUGDE/sBpPNn4=;
 b=isfcE1QF1hwNvgHnXsh5eaCQ9/JzOPRPWQPFvHKh9F9QrE9ybp42hRG+5YyH1QIYdA8K/q
 busk+Q1NEAJ8hvpmTF+U0oJhxtoffe0Tc8gHSUIp7pNPF9EEtvZdXliTUuAIbKNiUmOeoJ
 T3TX6PrulXekHLv8ysnl7TG5ol3x1TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-tRUanmDlPJa04cFQjeqajg-1; Fri, 06 Mar 2020 09:23:48 -0500
X-MC-Unique: tRUanmDlPJa04cFQjeqajg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8CD800D5B;
 Fri,  6 Mar 2020 14:23:47 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41C68909FB;
 Fri,  6 Mar 2020 14:23:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] tests: Fix a bug with count variables
Date: Fri,  6 Mar 2020 14:23:18 +0000
Message-Id: <20200306142318.1435372-4-stefanha@redhat.com>
In-Reply-To: <20200306142318.1435372-1-stefanha@redhat.com>
References: <20200306142318.1435372-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, qemu-block@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVGlhbmppYSBaaGFuZyA8dGlhbmppYS56aGFuZ0BsaW51eC5hbGliYWJhLmNvbT4KClRo
ZSBjb3VudGluZyBjb2RlIGhlcmUgc2hvdWxkIHVzZSB0aGUgbG9jYWwgdmFyaWFibGUgbl9ub2Rl
c19sb2NhbC4KT3RoZXJ3aXNlLCB0aGUgdmFyaWFibGUgbl9ub2RlcyBpcyBjb3VudGluZyBpbmNv
cnJlY3RseSwgY2F1c2luZyB0aGUKY291bnRpbmcgbG9naWMgb2YgdGhlIGNvZGUgdG8gYmUgd3Jv
bmcuCgpTaWduZWQtb2ZmLWJ5OiBUaWFuamlhIFpoYW5nIDx0aWFuamlhLnpoYW5nQGxpbnV4LmFs
aWJhYmEuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDAyMDcxMTU0MzMuMTE4
MjU0LTEtdGlhbmppYS56aGFuZ0BsaW51eC5hbGliYWJhLmNvbQpNZXNzYWdlLUlkOiA8MjAyMDAy
MDcxMTU0MzMuMTE4MjU0LTEtdGlhbmppYS56aGFuZ0BsaW51eC5hbGliYWJhLmNvbT4KLS0tCiB0
ZXN0cy90ZXN0LXJjdS1saXN0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90ZXN0LXJjdS1saXN0LmMgYi90
ZXN0cy90ZXN0LXJjdS1saXN0LmMKaW5kZXggMTQ0MmMwYzk4Mi4uOTJiZTUxZWM1MCAxMDA2NDQK
LS0tIGEvdGVzdHMvdGVzdC1yY3UtbGlzdC5jCisrKyBiL3Rlc3RzL3Rlc3QtcmN1LWxpc3QuYwpA
QCAtMjM1LDcgKzIzNSw3IEBAIHN0YXRpYyB2b2lkICpyY3VfcV91cGRhdGVyKHZvaWQgKmFyZykK
ICAgICAgICAgICAgIGorKzsKICAgICAgICAgICAgIGlmICh0YXJnZXRfZWwgPT0gaikgewogICAg
ICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2VsZW1lbnQgKm5ld19lbCA9IGdfbmV3KHN0cnVjdCBs
aXN0X2VsZW1lbnQsIDEpOwotICAgICAgICAgICAgICAgIG5fbm9kZXMgKz0gbl9ub2Rlc19sb2Nh
bDsKKyAgICAgICAgICAgICAgICBuX25vZGVzX2xvY2FsKys7CiAgICAgICAgICAgICAgICAgVEVT
VF9MSVNUX0lOU0VSVF9BRlRFUl9SQ1UoZWwsIG5ld19lbCwgZW50cnkpOwogICAgICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICAgICAgfQotLSAKMi4yNC4xCgo=


