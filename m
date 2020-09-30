Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF4C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC192074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol4jFLJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC192074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZIJ-00025Q-UM
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZCW-0002hK-Cc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZCU-0006Rq-6v
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601461145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKrnP1d4wk1lclGou8IqtOoKL6rBGmz9VjNNKSijco8=;
 b=Ol4jFLJhkemdV2xuFS1saBdwJHa4k/7Hjtx8MlBPZ7rjXEEJSncKpb3hqSLa3bg5Du2ixP
 aJDRydhpVn0cw+KAzqnyAKdDFQ6u2TBnPr6HD6/YrJA7vq2SalWtiR/39SUZkwOvZt9AIp
 z1jka4FO4TJa/K43P+zKrYj3aLVoUG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Bq4yOP2CNOCsvKsWy5Fpyw-1; Wed, 30 Sep 2020 06:13:48 -0400
X-MC-Unique: Bq4yOP2CNOCsvKsWy5Fpyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B442D185A0C3;
 Wed, 30 Sep 2020 10:13:46 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77A6E61983;
 Wed, 30 Sep 2020 10:13:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 07/17] block: return error-code from bdrv_invalidate_cache
Date: Wed, 30 Sep 2020 11:12:55 +0100
Message-Id: <20200930101305.305302-8-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKVGhpcyBpcyB0aGUgb25seSBjb3JvdXRpbmUgd3JhcHBlciBmcm9tIGJsb2NrLmMgYW5k
IGJsb2NrL2lvLmMgd2hpY2gKZG9lc24ndCByZXR1cm4gYSB2YWx1ZSwgc28gbGV0J3MgY29udmVy
dCBpdCB0byB0aGUgY29tbW9uIGJlaGF2aW9yLCB0bwpzaW1wbGlmeSBtb3ZpbmcgdG8gZ2VuZXJh
dGVkIGNvcm91dGluZSB3cmFwcGVycyBpbiBhIGZ1cnRoZXIgY29tbWl0LgoKQWxzbywgYmRydl9p
bnZhbGlkYXRlX2NhY2hlIGlzIGEgdm9pZCBmdW5jdGlvbiwgcmV0dXJuaW5nIGVycm9yIG9ubHkK
dGhyb3VnaCAqKmVycnAgcGFyYW1ldGVyLCB3aGljaCBpcyBjb25zaWRlcmVkIHRvIGJlIGJhZCBw
cmFjdGljZSwgYXMKaXQgZm9yY2VzIGNhbGxlcnMgdG8gZGVmaW5lIGFuZCBwcm9wYWdhdGUgbG9j
YWxfZXJyIHZhcmlhYmxlLCBzbwpjb252ZXJzaW9uIGlzIGdvb2QgYW55d2F5LgoKVGhpcyBwYXRj
aCBsZWF2ZXMgdGhlIGNvbnZlcnNpb24gb2YgLmJkcnZfY29faW52YWxpZGF0ZV9jYWNoZSgpIGRy
aXZlcgpjYWxsYmFja3MgYW5kIGJkcnZfaW52YWxpZGF0ZV9jYWNoZV9hbGwoKSBmb3IgYW5vdGhl
ciBkYXkuCgpTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpN
ZXNzYWdlLUlkOiA8MjAyMDA5MjQxODU0MTQuMjg2NDItMi12c2VtZW50c292QHZpcnR1b3p6by5j
b20+Ci0tLQogaW5jbHVkZS9ibG9jay9ibG9jay5oIHwgIDIgKy0KIGJsb2NrLmMgICAgICAgICAg
ICAgICB8IDMyICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvYmxvY2svYmxvY2suaCBiL2luY2x1ZGUvYmxvY2svYmxvY2suaAppbmRleCA5ODFhYjViMzE0
Li44MWQ1OTFkZDRjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgKKysrIGIvaW5j
bHVkZS9ibG9jay9ibG9jay5oCkBAIC00NjAsNyArNDYwLDcgQEAgdm9pZCBiZHJ2X2Fpb19jYW5j
ZWxfYXN5bmMoQmxvY2tBSU9DQiAqYWNiKTsKIGludCBiZHJ2X2NvX2lvY3RsKEJsb2NrRHJpdmVy
U3RhdGUgKmJzLCBpbnQgcmVxLCB2b2lkICpidWYpOwogCiAvKiBJbnZhbGlkYXRlIGFueSBjYWNo
ZWQgbWV0YWRhdGEgdXNlZCBieSBpbWFnZSBmb3JtYXRzICovCi12b2lkIGJkcnZfaW52YWxpZGF0
ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKTsKK2ludCBiZHJ2X2lu
dmFsaWRhdGVfY2FjaGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCk7CiB2b2lk
IGJkcnZfaW52YWxpZGF0ZV9jYWNoZV9hbGwoRXJyb3IgKiplcnJwKTsKIGludCBiZHJ2X2luYWN0
aXZhdGVfYWxsKHZvaWQpOwogCmRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYwppbmRleCBm
NzJhMmUyNmU4Li40ODI5YzhhYzQ3IDEwMDY0NAotLS0gYS9ibG9jay5jCisrKyBiL2Jsb2NrLmMK
QEAgLTU3ODEsOCArNTc4MSw4IEBAIHZvaWQgYmRydl9pbml0X3dpdGhfd2hpdGVsaXN0KHZvaWQp
CiAgICAgYmRydl9pbml0KCk7CiB9CiAKLXN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiBiZHJ2X2Nv
X2ludmFsaWRhdGVfY2FjaGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkKK3N0YXRpYyBp
bnQgY29yb3V0aW5lX2ZuIGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRl
ICpicywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApCiB7CiAgICAgQmRydkNoaWxkICpjaGlsZCwgKnBhcmVudDsKICAgICB1aW50
NjRfdCBwZXJtLCBzaGFyZWRfcGVybTsKQEAgLTU3OTEsMTQgKzU3OTEsMTQgQEAgc3RhdGljIHZv
aWQgY29yb3V0aW5lX2ZuIGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRl
ICpicywKICAgICBCZHJ2RGlydHlCaXRtYXAgKmJtOwogCiAgICAgaWYgKCFicy0+ZHJ2KSAgewot
ICAgICAgICByZXR1cm47CisgICAgICAgIHJldHVybiAtRU5PTUVESVVNOwogICAgIH0KIAogICAg
IFFMSVNUX0ZPUkVBQ0goY2hpbGQsICZicy0+Y2hpbGRyZW4sIG5leHQpIHsKICAgICAgICAgYmRy
dl9jb19pbnZhbGlkYXRlX2NhY2hlKGNoaWxkLT5icywgJmxvY2FsX2Vycik7CiAgICAgICAgIGlm
IChsb2NhbF9lcnIpIHsKICAgICAgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9l
cnIpOwotICAgICAgICAgICAgcmV0dXJuOworICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CiAg
ICAgICAgIH0KICAgICB9CiAKQEAgLTU4MjEsNyArNTgyMSw3IEBAIHN0YXRpYyB2b2lkIGNvcm91
dGluZV9mbiBiZHJ2X2NvX2ludmFsaWRhdGVfY2FjaGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsCiAg
ICAgICAgIHJldCA9IGJkcnZfY2hlY2tfcGVybShicywgTlVMTCwgcGVybSwgc2hhcmVkX3Blcm0s
IE5VTEwsIE5VTEwsIGVycnApOwogICAgICAgICBpZiAocmV0IDwgMCkgewogICAgICAgICAgICAg
YnMtPm9wZW5fZmxhZ3MgfD0gQkRSVl9PX0lOQUNUSVZFOwotICAgICAgICAgICAgcmV0dXJuOwor
ICAgICAgICAgICAgcmV0dXJuIHJldDsKICAgICAgICAgfQogICAgICAgICBiZHJ2X3NldF9wZXJt
KGJzLCBwZXJtLCBzaGFyZWRfcGVybSk7CiAKQEAgLTU4MzAsNyArNTgzMCw3IEBAIHN0YXRpYyB2
b2lkIGNvcm91dGluZV9mbiBiZHJ2X2NvX2ludmFsaWRhdGVfY2FjaGUoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsCiAgICAgICAgICAgICBpZiAobG9jYWxfZXJyKSB7CiAgICAgICAgICAgICAgICAgYnMt
Pm9wZW5fZmxhZ3MgfD0gQkRSVl9PX0lOQUNUSVZFOwogICAgICAgICAgICAgICAgIGVycm9yX3By
b3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOwotICAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKICAgICAgICAgICAgIH0KICAgICAgICAgfQogCkBA
IC01ODQyLDcgKzU4NDIsNyBAQCBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gYmRydl9jb19pbnZh
bGlkYXRlX2NhY2hlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLAogICAgICAgICBpZiAocmV0IDwgMCkg
ewogICAgICAgICAgICAgYnMtPm9wZW5fZmxhZ3MgfD0gQkRSVl9PX0lOQUNUSVZFOwogICAgICAg
ICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LCAiQ291bGQgbm90IHJlZnJlc2ggdG90
YWwgc2VjdG9yIGNvdW50Iik7Ci0gICAgICAgICAgICByZXR1cm47CisgICAgICAgICAgICByZXR1
cm4gcmV0OwogICAgICAgICB9CiAgICAgfQogCkBAIC01ODUyLDI3ICs1ODUyLDMwIEBAIHN0YXRp
YyB2b2lkIGNvcm91dGluZV9mbiBiZHJ2X2NvX2ludmFsaWRhdGVfY2FjaGUoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsCiAgICAgICAgICAgICBpZiAobG9jYWxfZXJyKSB7CiAgICAgICAgICAgICAgICAg
YnMtPm9wZW5fZmxhZ3MgfD0gQkRSVl9PX0lOQUNUSVZFOwogICAgICAgICAgICAgICAgIGVycm9y
X3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOwotICAgICAgICAgICAgICAgIHJldHVybjsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKICAgICAgICAgICAgIH0KICAgICAgICAgfQog
ICAgIH0KKworICAgIHJldHVybiAwOwogfQogCiB0eXBlZGVmIHN0cnVjdCBJbnZhbGlkYXRlQ2Fj
aGVDbyB7CiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnM7CiAgICAgRXJyb3IgKiplcnJwOwogICAg
IGJvb2wgZG9uZTsKKyAgICBpbnQgcmV0OwogfSBJbnZhbGlkYXRlQ2FjaGVDbzsKIAogc3RhdGlj
IHZvaWQgY29yb3V0aW5lX2ZuIGJkcnZfaW52YWxpZGF0ZV9jYWNoZV9jb19lbnRyeSh2b2lkICpv
cGFxdWUpCiB7CiAgICAgSW52YWxpZGF0ZUNhY2hlQ28gKmljbyA9IG9wYXF1ZTsKLSAgICBiZHJ2
X2NvX2ludmFsaWRhdGVfY2FjaGUoaWNvLT5icywgaWNvLT5lcnJwKTsKKyAgICBpY28tPnJldCA9
IGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZShpY28tPmJzLCBpY28tPmVycnApOwogICAgIGljby0+
ZG9uZSA9IHRydWU7CiAgICAgYWlvX3dhaXRfa2ljaygpOwogfQogCi12b2lkIGJkcnZfaW52YWxp
ZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKQoraW50IGJkcnZf
aW52YWxpZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKQogewog
ICAgIENvcm91dGluZSAqY287CiAgICAgSW52YWxpZGF0ZUNhY2hlQ28gaWNvID0gewpAQCAtNTg4
OSwyMiArNTg5MiwyMyBAQCB2b2lkIGJkcnZfaW52YWxpZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0
YXRlICpicywgRXJyb3IgKiplcnJwKQogICAgICAgICBiZHJ2X2Nvcm91dGluZV9lbnRlcihicywg
Y28pOwogICAgICAgICBCRFJWX1BPTExfV0hJTEUoYnMsICFpY28uZG9uZSk7CiAgICAgfQorCisg
ICAgcmV0dXJuIGljby5yZXQ7CiB9CiAKIHZvaWQgYmRydl9pbnZhbGlkYXRlX2NhY2hlX2FsbChF
cnJvciAqKmVycnApCiB7CiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnM7Ci0gICAgRXJyb3IgKmxv
Y2FsX2VyciA9IE5VTEw7CiAgICAgQmRydk5leHRJdGVyYXRvciBpdDsKIAogICAgIGZvciAoYnMg
PSBiZHJ2X2ZpcnN0KCZpdCk7IGJzOyBicyA9IGJkcnZfbmV4dCgmaXQpKSB7CiAgICAgICAgIEFp
b0NvbnRleHQgKmFpb19jb250ZXh0ID0gYmRydl9nZXRfYWlvX2NvbnRleHQoYnMpOworICAgICAg
ICBpbnQgcmV0OwogCiAgICAgICAgIGFpb19jb250ZXh0X2FjcXVpcmUoYWlvX2NvbnRleHQpOwot
ICAgICAgICBiZHJ2X2ludmFsaWRhdGVfY2FjaGUoYnMsICZsb2NhbF9lcnIpOworICAgICAgICBy
ZXQgPSBiZHJ2X2ludmFsaWRhdGVfY2FjaGUoYnMsIGVycnApOwogICAgICAgICBhaW9fY29udGV4
dF9yZWxlYXNlKGFpb19jb250ZXh0KTsKLSAgICAgICAgaWYgKGxvY2FsX2VycikgewotICAgICAg
ICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7CisgICAgICAgIGlmIChyZXQg
PCAwKSB7CiAgICAgICAgICAgICBiZHJ2X25leHRfY2xlYW51cCgmaXQpOwogICAgICAgICAgICAg
cmV0dXJuOwogICAgICAgICB9Ci0tIAoyLjI2LjIKCg==


