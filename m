Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B80C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B26220709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyegRFRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B26220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5nd-0004JI-BG
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mS-0002mE-2m
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mR-0002Sr-59
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589908309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqQP2gEWiHT1RhvkO6A6rp0yPTnbuodhCHyBJ6H7YKQ=;
 b=RyegRFRkOHxneAmOZH2kxbbC7ggeAjhGG2GL9QaBuDCrJspE4aEsu/5YLHCp4aZARNDWRD
 EWWlJfbVcIfEdNEuRteqOkbiK3t6Hk0/kz+OfsuCCYBSOaT7mRg4GbTvOOLhYKSGb8mJVS
 fOq531XMB9jw/maLXykyVfqZrnjZB34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-6ArE6UUoOj-WBPTaYoCVug-1; Tue, 19 May 2020 13:11:47 -0400
X-MC-Unique: 6ArE6UUoOj-WBPTaYoCVug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D7A57093;
 Tue, 19 May 2020 17:11:46 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94E3A50F54;
 Tue, 19 May 2020 17:11:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] block/nvme: poll queues without q->lock
Date: Tue, 19 May 2020 18:11:32 +0100
Message-Id: <20200519171138.201667-2-stefanha@redhat.com>
In-Reply-To: <20200519171138.201667-1-stefanha@redhat.com>
References: <20200519171138.201667-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

QSBsb3Qgb2YgQ1BVIHRpbWUgaXMgc3BlbnQgc2ltcGx5IGxvY2tpbmcvdW5sb2NraW5nIHEtPmxv
Y2sgZHVyaW5nCnBvbGxpbmcuIENoZWNrIGZvciBjb21wbGV0aW9uIG91dHNpZGUgdGhlIGxvY2sg
dG8gbWFrZSBxLT5sb2NrIGRpc2FwcGVhcgpmcm9tIHRoZSBwcm9maWxlLgoKU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUu
YyB8IDEyICsrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggZWIyZjU0ZGQ5ZC4u
N2ViNDUxMjY2NiAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpA
QCAtNTEyLDYgKzUxMiwxOCBAQCBzdGF0aWMgYm9vbCBudm1lX3BvbGxfcXVldWVzKEJEUlZOVk1l
U3RhdGUgKnMpCiAKICAgICBmb3IgKGkgPSAwOyBpIDwgcy0+bnJfcXVldWVzOyBpKyspIHsKICAg
ICAgICAgTlZNZVF1ZXVlUGFpciAqcSA9IHMtPnF1ZXVlc1tpXTsKKyAgICAgICAgY29uc3Qgc2l6
ZV90IGNxZV9vZmZzZXQgPSBxLT5jcS5oZWFkICogTlZNRV9DUV9FTlRSWV9CWVRFUzsKKyAgICAg
ICAgTnZtZUNxZSAqY3FlID0gKE52bWVDcWUgKikmcS0+Y3EucXVldWVbY3FlX29mZnNldF07CisK
KyAgICAgICAgLyoKKyAgICAgICAgICogcS0+bG9jayBpc24ndCBuZWVkZWQgZm9yIGNoZWNraW5n
IGNvbXBsZXRpb24gYmVjYXVzZQorICAgICAgICAgKiBudm1lX3Byb2Nlc3NfY29tcGxldGlvbigp
IG9ubHkgcnVucyBpbiB0aGUgZXZlbnQgbG9vcCB0aHJlYWQgYW5kCisgICAgICAgICAqIGNhbm5v
dCByYWNlIHdpdGggaXRzZWxmLgorICAgICAgICAgKi8KKyAgICAgICAgaWYgKChsZTE2X3RvX2Nw
dShjcWUtPnN0YXR1cykgJiAweDEpID09IHEtPmNxX3BoYXNlKSB7CisgICAgICAgICAgICBjb250
aW51ZTsKKyAgICAgICAgfQorCiAgICAgICAgIHFlbXVfbXV0ZXhfbG9jaygmcS0+bG9jayk7CiAg
ICAgICAgIHdoaWxlIChudm1lX3Byb2Nlc3NfY29tcGxldGlvbihzLCBxKSkgewogICAgICAgICAg
ICAgLyogS2VlcCBwb2xsaW5nICovCi0tIAoyLjI1LjMKCg==


