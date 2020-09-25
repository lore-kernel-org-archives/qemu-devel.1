Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B072086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJcm78M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo7c-00044V-Fk
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLo01-0004lu-6l
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzy-0008KK-MI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=on72vSdxS28kZfDu2pYVVObQVetDsjIKlZe+QSATkhs=;
 b=AJcm78M5LgvZGHyD15S9x2Ifo0/V0V7w2nPg4IQJPxbrNY00PJlY2vgRY22oJn+ZrrbJbc
 o30VZoFAoLvJtqQlmmtAxL7wI56fJJBki3UWglTWz9A9wfHwMcOcPuRsraM/M16ynOCWfM
 v0blIEduhRVkHOA0G2IUZ2ezuky0REE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-w7SSzs2WO-GAcofAhYLlLQ-1; Fri, 25 Sep 2020 09:42:50 -0400
X-MC-Unique: w7SSzs2WO-GAcofAhYLlLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A081280732A;
 Fri, 25 Sep 2020 13:42:49 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4451155786;
 Fri, 25 Sep 2020 13:42:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] block/export: add BlockExportOptions->iothread member
Date: Fri, 25 Sep 2020 14:42:29 +0100
Message-Id: <20200925134229.246169-5-stefanha@redhat.com>
In-Reply-To: <20200925134229.246169-1-stefanha@redhat.com>
References: <20200925134229.246169-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBzcGVjaWZ5IHRoZSBpb3RocmVhZCB3aGVyZSB0aGUgZXhwb3J0
IHdpbGwgcnVuLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgotLS0KTm90ZSB0aGUgeC1ibG9ja2Rldi1zZXQtaW90aHJlYWQgUU1QIGNvbW1hbmQg
Y2FuIGJlIHVzZWQgdG8gZG8gdGhlIHNhbWUsCmJ1dCBub3QgZnJvbSB0aGUgY29tbWFuZC1saW5l
LiBBbmQgaXQgcmVxdWlyZXMgc2VuZGluZyBhbiBhZGRpdGlvbmFsCmNvbW1hbmQuCgpJbiB0aGUg
bG9uZyBydW4gdmhvc3QtdXNlci1ibGsgd2lsbCBzdXBwb3J0IHBlci12aXJ0cXVldWUgaW90aHJl
YWQKbWFwcGluZ3MuIEJ1dCBmb3Igbm93IGEgc2luZ2xlIGlvdGhyZWFkIG1ha2VzIHNlbnNlIGFu
ZCBtb3N0IG90aGVyCnRyYW5zcG9ydHMgd2lsbCBqdXN0IHVzZSBvbmUgaW90aHJlYWQgYW55d2F5
LgotLS0KIHFhcGkvYmxvY2stZXhwb3J0Lmpzb24gfCAgNCArKysrCiBibG9jay9leHBvcnQvZXhw
b3J0LmMgIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwg
MjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2st
ZXhwb3J0Lmpzb24gYi9xYXBpL2Jsb2NrLWV4cG9ydC5qc29uCmluZGV4IDg3YWM1MTE3Y2QuLmVi
YTZmNmVhZTkgMTAwNjQ0Ci0tLSBhL3FhcGkvYmxvY2stZXhwb3J0Lmpzb24KKysrIGIvcWFwaS9i
bG9jay1leHBvcnQuanNvbgpAQCAtMjE5LDExICsyMTksMTUgQEAKICMgICAgICAgICAgICAgICAg
ZXhwb3J0IGJlZm9yZSBjb21wbGV0aW9uIGlzIHNpZ25hbGxlZC4gKHNpbmNlOiA1LjI7CiAjICAg
ICAgICAgICAgICAgIGRlZmF1bHQ6IGZhbHNlKQogIworIyBAaW90aHJlYWQ6IFRoZSBuYW1lIG9m
IHRoZSBpb3RocmVhZCBvYmplY3Qgd2hlcmUgdGhlIGV4cG9ydCB3aWxsIHJ1bi4gVGhlCisjICAg
ICAgICAgICAgZGVmYXVsdCBpcyB0aGUgbWFpbiBsb29wIHRocmVhZC4gKHNpbmNlOiA1LjIpCisj
CiAjIFNpbmNlOiA0LjIKICMjCiB7ICd1bmlvbic6ICdCbG9ja0V4cG9ydE9wdGlvbnMnLAogICAn
YmFzZSc6IHsgJ3R5cGUnOiAnQmxvY2tFeHBvcnRUeXBlJywKICAgICAgICAgICAgICdpZCc6ICdz
dHInLAorCSAgICAnKmlvdGhyZWFkJzogJ3N0cicsCiAgICAgICAgICAgICAnbm9kZS1uYW1lJzog
J3N0cicsCiAgICAgICAgICAgICAnKndyaXRhYmxlJzogJ2Jvb2wnLAogICAgICAgICAgICAgJyp3
cml0ZXRocm91Z2gnOiAnYm9vbCcgfSwKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9ydC9leHBvcnQu
YyBiL2Jsb2NrL2V4cG9ydC9leHBvcnQuYwppbmRleCA1NTA4OTdlMjM2Li4wZmIzZDc2ZWUzIDEw
MDY0NAotLS0gYS9ibG9jay9leHBvcnQvZXhwb3J0LmMKKysrIGIvYmxvY2svZXhwb3J0L2V4cG9y
dC5jCkBAIC0xNSw2ICsxNSw3IEBACiAKICNpbmNsdWRlICJibG9jay9ibG9jay5oIgogI2luY2x1
ZGUgInN5c2VtdS9ibG9jay1iYWNrZW5kLmgiCisjaW5jbHVkZSAic3lzZW11L2lvdGhyZWFkLmgi
CiAjaW5jbHVkZSAiYmxvY2svZXhwb3J0LmgiCiAjaW5jbHVkZSAiYmxvY2svbmJkLmgiCiAjaW5j
bHVkZSAicWFwaS9lcnJvci5oIgpAQCAtNjYsNyArNjcsNyBAQCBCbG9ja0V4cG9ydCAqYmxrX2V4
cF9hZGQoQmxvY2tFeHBvcnRPcHRpb25zICpleHBvcnQsIEVycm9yICoqZXJycCkKICAgICBjb25z
dCBCbG9ja0V4cG9ydERyaXZlciAqZHJ2OwogICAgIEJsb2NrRXhwb3J0ICpleHAgPSBOVUxMOwog
ICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzOwotICAgIEJsb2NrQmFja2VuZCAqYmxrOworICAgIEJs
b2NrQmFja2VuZCAqYmxrID0gTlVMTDsKICAgICBBaW9Db250ZXh0ICpjdHg7CiAgICAgdWludDY0
X3QgcGVybTsKICAgICBpbnQgcmV0OwpAQCAtMTAyLDYgKzEwMywyOSBAQCBCbG9ja0V4cG9ydCAq
YmxrX2V4cF9hZGQoQmxvY2tFeHBvcnRPcHRpb25zICpleHBvcnQsIEVycm9yICoqZXJycCkKICAg
ICBjdHggPSBiZHJ2X2dldF9haW9fY29udGV4dChicyk7CiAgICAgYWlvX2NvbnRleHRfYWNxdWly
ZShjdHgpOwogCisgICAgaWYgKGV4cG9ydC0+aGFzX2lvdGhyZWFkKSB7CisgICAgICAgIElPVGhy
ZWFkICppb3RocmVhZDsKKyAgICAgICAgQWlvQ29udGV4dCAqbmV3X2N0eDsKKworICAgICAgICBp
b3RocmVhZCA9IGlvdGhyZWFkX2J5X2lkKGV4cG9ydC0+aW90aHJlYWQpOworICAgICAgICBpZiAo
IWlvdGhyZWFkKSB7CisgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJpb3RocmVhZCBcIiVz
XCIgbm90IGZvdW5kIiwgZXhwb3J0LT5pb3RocmVhZCk7CisgICAgICAgICAgICBnb3RvIGZhaWw7
CisgICAgICAgIH0KKworICAgICAgICBuZXdfY3R4ID0gaW90aHJlYWRfZ2V0X2Fpb19jb250ZXh0
KGlvdGhyZWFkKTsKKworICAgICAgICByZXQgPSBiZHJ2X3RyeV9zZXRfYWlvX2NvbnRleHQoYnMs
IG5ld19jdHgsIGVycnApOworICAgICAgICBpZiAocmV0ICE9IDApIHsKKyAgICAgICAgICAgIGdv
dG8gZmFpbDsKKyAgICAgICAgfQorCisgICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2UoY3R4KTsK
KyAgICAgICAgYWlvX2NvbnRleHRfYWNxdWlyZShuZXdfY3R4KTsKKworICAgICAgICBjdHggPSBu
ZXdfY3R4OworICAgIH0KKwogICAgIC8qCiAgICAgICogQmxvY2sgZXhwb3J0cyBhcmUgdXNlZCBm
b3Igbm9uLXNoYXJlZCBzdG9yYWdlIG1pZ3JhdGlvbi4gTWFrZSBzdXJlCiAgICAgICogdGhhdCBC
RFJWX09fSU5BQ1RJVkUgaXMgY2xlYXJlZCBhbmQgdGhlIGltYWdlIGlzIHJlYWR5IGZvciB3cml0
ZQotLSAKMi4yNi4yCgo=


