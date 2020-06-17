Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B835EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A582098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmRmjnyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A582098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY2F-000458-M7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1F-0002DM-23
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1D-0002le-Kd
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgNnXjQJLjsUTRKKTVtMZ/B9j1jc9+hdmKfY2K8Dqjo=;
 b=CmRmjnyyG6HBRD/iouQSybULLgLO2636bn/sEZzVTMUbJOZl73fxmbTVxRn93snxwUAovh
 KELzAreuxJVx7ISCR4wNgUJwDYIGJUM6V0l8IwiEBM10E8i//BHo2i1TY+9cCEP8aAUzw6
 F+ssb0D/WHLUuYVFKYVqTGS8nVso4Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-0NHw3vrpMaCLFJ7GnzYXQA-1; Wed, 17 Jun 2020 09:22:14 -0400
X-MC-Unique: 0NHw3vrpMaCLFJ7GnzYXQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F248835B7B;
 Wed, 17 Jun 2020 13:22:13 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 058057E59F;
 Wed, 17 Jun 2020 13:22:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] block/nvme: poll queues without q->lock
Date: Wed, 17 Jun 2020 14:21:55 +0100
Message-Id: <20200617132201.1832152-2-stefanha@redhat.com>
In-Reply-To: <20200617132201.1832152-1-stefanha@redhat.com>
References: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
ZTQzNzVlYzI0NSAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpA
QCAtNTEyLDYgKzUxMiwxOCBAQCBzdGF0aWMgYm9vbCBudm1lX3BvbGxfcXVldWVzKEJEUlZOVk1l
U3RhdGUgKnMpCiAKICAgICBmb3IgKGkgPSAwOyBpIDwgcy0+bnJfcXVldWVzOyBpKyspIHsKICAg
ICAgICAgTlZNZVF1ZXVlUGFpciAqcSA9IHMtPnF1ZXVlc1tpXTsKKyAgICAgICAgY29uc3Qgc2l6
ZV90IGNxZV9vZmZzZXQgPSBxLT5jcS5oZWFkICogTlZNRV9DUV9FTlRSWV9CWVRFUzsKKyAgICAg
ICAgTnZtZUNxZSAqY3FlID0gKE52bWVDcWUgKikmcS0+Y3EucXVldWVbY3FlX29mZnNldF07CisK
KyAgICAgICAgLyoKKyAgICAgICAgICogRG8gYW4gZWFybHkgY2hlY2sgZm9yIGNvbXBsZXRpb25z
LiBxLT5sb2NrIGlzbid0IG5lZWRlZCBiZWNhdXNlCisgICAgICAgICAqIG52bWVfcHJvY2Vzc19j
b21wbGV0aW9uKCkgb25seSBydW5zIGluIHRoZSBldmVudCBsb29wIHRocmVhZCBhbmQKKyAgICAg
ICAgICogY2Fubm90IHJhY2Ugd2l0aCBpdHNlbGYuCisgICAgICAgICAqLworICAgICAgICBpZiAo
KGxlMTZfdG9fY3B1KGNxZS0+c3RhdHVzKSAmIDB4MSkgPT0gcS0+Y3FfcGhhc2UpIHsKKyAgICAg
ICAgICAgIGNvbnRpbnVlOworICAgICAgICB9CisKICAgICAgICAgcWVtdV9tdXRleF9sb2NrKCZx
LT5sb2NrKTsKICAgICAgICAgd2hpbGUgKG52bWVfcHJvY2Vzc19jb21wbGV0aW9uKHMsIHEpKSB7
CiAgICAgICAgICAgICAvKiBLZWVwIHBvbGxpbmcgKi8KLS0gCjIuMjYuMgoK


