Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A93C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CADB2072C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqP1kI1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CADB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2bU-0005Bu-8O
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2YR-0003HZ-48
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2YM-00044v-UA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EO2GP8/cUhOZvA5Y5IO2yeAygcpIdE7qOLHBQuf4HNw=;
 b=bqP1kI1fD6AuX7HW8T0JEuiNp5ySKn/UNuBegMQvfLE0AXJAP9J7OJFctrquh7vQ0oJLh8
 VT/aEudEzgmtwup0QVB5rBgiBbhqXKbf71rcz8Whqv93ZYWfBfPnAxkNsQcrVx60ncwdgy
 9hW0aSQ/+Iy8SwhTTsFk6M/y3zh/z+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-t_PiR1xuMUqjrHDd5m23kg-1; Mon, 12 Oct 2020 14:28:07 -0400
X-MC-Unique: t_PiR1xuMUqjrHDd5m23kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50223879518;
 Mon, 12 Oct 2020 18:28:06 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E4BC277DC;
 Mon, 12 Oct 2020 18:28:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 01/30] block/nvme: Add driver statistics for access
 alignment and hw errors
Date: Mon, 12 Oct 2020 19:27:31 +0100
Message-Id: <20201012182800.157697-2-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKS2VlcCBz
dGF0aXN0aWNzIG9mIHNvbWUgaGFyZHdhcmUgZXJyb3JzLCBhbmQgbnVtYmVyIG9mCmFsaWduZWQv
dW5hbGlnbmVkIEkvTyBhY2Nlc3Nlcy4KClFNUCBleGFtcGxlIGJvb3RpbmcgYSBmdWxsIFJIRUwg
OC4zIGFhcmNoNjQgZ3Vlc3Q6Cgp7ICJleGVjdXRlIjogInF1ZXJ5LWJsb2Nrc3RhdHMiIH0Kewog
ICAgInJldHVybiI6IFsKICAgICAgICB7CiAgICAgICAgICAgICJkZXZpY2UiOiAiIiwKICAgICAg
ICAgICAgIm5vZGUtbmFtZSI6ICJkcml2ZTAiLAogICAgICAgICAgICAic3RhdHMiOiB7CiAgICAg
ICAgICAgICAgICAiZmx1c2hfdG90YWxfdGltZV9ucyI6IDYwMjY5NDgsCiAgICAgICAgICAgICAg
ICAid3JfaGlnaGVzdF9vZmZzZXQiOiAzMzgzOTkxMjMwNDY0LAogICAgICAgICAgICAgICAgIndy
X3RvdGFsX3RpbWVfbnMiOiA4MDc0NTA5OTUsCiAgICAgICAgICAgICAgICAiZmFpbGVkX3dyX29w
ZXJhdGlvbnMiOiAwLAogICAgICAgICAgICAgICAgImZhaWxlZF9yZF9vcGVyYXRpb25zIjogMCwK
ICAgICAgICAgICAgICAgICJ3cl9tZXJnZWQiOiAzLAogICAgICAgICAgICAgICAgIndyX2J5dGVz
IjogNTAxMzM1MDQsCiAgICAgICAgICAgICAgICAiZmFpbGVkX3VubWFwX29wZXJhdGlvbnMiOiAw
LAogICAgICAgICAgICAgICAgImZhaWxlZF9mbHVzaF9vcGVyYXRpb25zIjogMCwKICAgICAgICAg
ICAgICAgICJhY2NvdW50X2ludmFsaWQiOiBmYWxzZSwKICAgICAgICAgICAgICAgICJyZF90b3Rh
bF90aW1lX25zIjogMTg0Njk3OTkwMCwKICAgICAgICAgICAgICAgICJmbHVzaF9vcGVyYXRpb25z
IjogMTMwLAogICAgICAgICAgICAgICAgIndyX29wZXJhdGlvbnMiOiA2NTksCiAgICAgICAgICAg
ICAgICAicmRfbWVyZ2VkIjogMTE5MiwKICAgICAgICAgICAgICAgICJyZF9ieXRlcyI6IDIxODI0
NDA5NiwKICAgICAgICAgICAgICAgICJhY2NvdW50X2ZhaWxlZCI6IGZhbHNlLAogICAgICAgICAg
ICAgICAgImlkbGVfdGltZV9ucyI6IDI2Nzg2NDE0OTcsCiAgICAgICAgICAgICAgICAicmRfb3Bl
cmF0aW9ucyI6IDc0MDYsCiAgICAgICAgICAgIH0sCiAgICAgICAgICAgICJkcml2ZXItc3BlY2lm
aWMiOiB7CiAgICAgICAgICAgICAgICAiZHJpdmVyIjogIm52bWUiLAogICAgICAgICAgICAgICAg
ImNvbXBsZXRpb24tZXJyb3JzIjogMCwKICAgICAgICAgICAgICAgICJ1bmFsaWduZWQtYWNjZXNz
ZXMiOiAyOTU5LAogICAgICAgICAgICAgICAgImFsaWduZWQtYWNjZXNzZXMiOiA0NDc3CiAgICAg
ICAgICAgIH0sCiAgICAgICAgICAgICJxZGV2IjogIi9tYWNoaW5lL3BlcmlwaGVyYWwtYW5vbi9k
ZXZpY2VbMF0vdmlydGlvLWJhY2tlbmQiCiAgICAgICAgfQogICAgXQp9CgpTdWdnZXN0ZWQtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBNYXJrdXMg
QXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAxMDAxMTYyOTM5
LjE1Njc5MTUtMS1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogcWFwaS9ibG9jay1jb3JlLmpzb24gfCAyNCAr
KysrKysrKysrKysrKysrKysrKysrKy0KIGJsb2NrL252bWUuYyAgICAgICAgIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLWNvcmUuanNvbiBiL3FhcGkv
YmxvY2stY29yZS5qc29uCmluZGV4IGVlNWViZWY3ZjIuLmUwMGZjMjdiNWUgMTAwNjQ0Ci0tLSBh
L3FhcGkvYmxvY2stY29yZS5qc29uCisrKyBiL3FhcGkvYmxvY2stY29yZS5qc29uCkBAIC05NDcs
NiArOTQ3LDI3IEBACiAgICAgICAnZGlzY2FyZC1uYi1mYWlsZWQnOiAndWludDY0JywKICAgICAg
ICdkaXNjYXJkLWJ5dGVzLW9rJzogJ3VpbnQ2NCcgfSB9CiAKKyMjCisjIEBCbG9ja1N0YXRzU3Bl
Y2lmaWNOdm1lOgorIworIyBOVk1lIGRyaXZlciBzdGF0aXN0aWNzCisjCisjIEBjb21wbGV0aW9u
LWVycm9yczogVGhlIG51bWJlciBvZiBjb21wbGV0aW9uIGVycm9ycy4KKyMKKyMgQGFsaWduZWQt
YWNjZXNzZXM6IFRoZSBudW1iZXIgb2YgYWxpZ25lZCBhY2Nlc3NlcyBwZXJmb3JtZWQgYnkKKyMg
ICAgICAgICAgICAgICAgICAgIHRoZSBkcml2ZXIuCisjCisjIEB1bmFsaWduZWQtYWNjZXNzZXM6
IFRoZSBudW1iZXIgb2YgdW5hbGlnbmVkIGFjY2Vzc2VzIHBlcmZvcm1lZCBieQorIyAgICAgICAg
ICAgICAgICAgICAgICB0aGUgZHJpdmVyLgorIworIyBTaW5jZTogNS4yCisjIworeyAnc3RydWN0
JzogJ0Jsb2NrU3RhdHNTcGVjaWZpY052bWUnLAorICAnZGF0YSc6IHsKKyAgICAgICdjb21wbGV0
aW9uLWVycm9ycyc6ICd1aW50NjQnLAorICAgICAgJ2FsaWduZWQtYWNjZXNzZXMnOiAndWludDY0
JywKKyAgICAgICd1bmFsaWduZWQtYWNjZXNzZXMnOiAndWludDY0JyB9IH0KKwogIyMKICMgQEJs
b2NrU3RhdHNTcGVjaWZpYzoKICMKQEAgLTk1OSw3ICs5ODAsOCBAQAogICAnZGlzY3JpbWluYXRv
cic6ICdkcml2ZXInLAogICAnZGF0YSc6IHsKICAgICAgICdmaWxlJzogJ0Jsb2NrU3RhdHNTcGVj
aWZpY0ZpbGUnLAotICAgICAgJ2hvc3RfZGV2aWNlJzogJ0Jsb2NrU3RhdHNTcGVjaWZpY0ZpbGUn
IH0gfQorICAgICAgJ2hvc3RfZGV2aWNlJzogJ0Jsb2NrU3RhdHNTcGVjaWZpY0ZpbGUnLAorICAg
ICAgJ252bWUnOiAnQmxvY2tTdGF0c1NwZWNpZmljTnZtZScgfSB9CiAKICMjCiAjIEBCbG9ja1N0
YXRzOgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IGI0OGY2
ZjI1ODguLjczOWEwYTcwMGMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9u
dm1lLmMKQEAgLTEyOCw2ICsxMjgsMTIgQEAgc3RydWN0IEJEUlZOVk1lU3RhdGUgewogCiAgICAg
LyogUENJIGFkZHJlc3MgKHJlcXVpcmVkIGZvciBudm1lX3JlZnJlc2hfZmlsZW5hbWUoKSkgKi8K
ICAgICBjaGFyICpkZXZpY2U7CisKKyAgICBzdHJ1Y3QgeworICAgICAgICB1aW50NjRfdCBjb21w
bGV0aW9uX2Vycm9yczsKKyAgICAgICAgdWludDY0X3QgYWxpZ25lZF9hY2Nlc3NlczsKKyAgICAg
ICAgdWludDY0X3QgdW5hbGlnbmVkX2FjY2Vzc2VzOworICAgIH0gc3RhdHM7CiB9OwogCiAjZGVm
aW5lIE5WTUVfQkxPQ0tfT1BUX0RFVklDRSAiZGV2aWNlIgpAQCAtMzg0LDYgKzM5MCw5IEBAIHN0
YXRpYyBib29sIG52bWVfcHJvY2Vzc19jb21wbGV0aW9uKE5WTWVRdWV1ZVBhaXIgKnEpCiAgICAg
ICAgICAgICBicmVhazsKICAgICAgICAgfQogICAgICAgICByZXQgPSBudm1lX3RyYW5zbGF0ZV9l
cnJvcihjKTsKKyAgICAgICAgaWYgKHJldCkgeworICAgICAgICAgICAgcy0+c3RhdHMuY29tcGxl
dGlvbl9lcnJvcnMrKzsKKyAgICAgICAgfQogICAgICAgICBxLT5jcS5oZWFkID0gKHEtPmNxLmhl
YWQgKyAxKSAlIE5WTUVfUVVFVUVfU0laRTsKICAgICAgICAgaWYgKCFxLT5jcS5oZWFkKSB7CiAg
ICAgICAgICAgICBxLT5jcV9waGFzZSA9ICFxLT5jcV9waGFzZTsKQEAgLTExNTUsOCArMTE2NCwx
MCBAQCBzdGF0aWMgaW50IG52bWVfY29fcHJ3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRf
dCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLAogICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoYnl0
ZXMsIHMtPnBhZ2Vfc2l6ZSkpOwogICAgIGFzc2VydChieXRlcyA8PSBzLT5tYXhfdHJhbnNmZXIp
OwogICAgIGlmIChudm1lX3Fpb3ZfYWxpZ25lZChicywgcWlvdikpIHsKKyAgICAgICAgcy0+c3Rh
dHMuYWxpZ25lZF9hY2Nlc3NlcysrOwogICAgICAgICByZXR1cm4gbnZtZV9jb19wcndfYWxpZ25l
ZChicywgb2Zmc2V0LCBieXRlcywgcWlvdiwgaXNfd3JpdGUsIGZsYWdzKTsKICAgICB9CisgICAg
cy0+c3RhdHMudW5hbGlnbmVkX2FjY2Vzc2VzKys7CiAgICAgdHJhY2VfbnZtZV9wcndfYnVmZmVy
ZWQocywgb2Zmc2V0LCBieXRlcywgcWlvdi0+bmlvdiwgaXNfd3JpdGUpOwogICAgIGJ1ZiA9IHFl
bXVfdHJ5X21lbWFsaWduKHMtPnBhZ2Vfc2l6ZSwgYnl0ZXMpOwogCkBAIC0xNDUyLDYgKzE0NjMs
MjEgQEAgc3RhdGljIHZvaWQgbnZtZV91bnJlZ2lzdGVyX2J1ZihCbG9ja0RyaXZlclN0YXRlICpi
cywgdm9pZCAqaG9zdCkKICAgICBxZW11X3ZmaW9fZG1hX3VubWFwKHMtPnZmaW8sIGhvc3QpOwog
fQogCitzdGF0aWMgQmxvY2tTdGF0c1NwZWNpZmljICpudm1lX2dldF9zcGVjaWZpY19zdGF0cyhC
bG9ja0RyaXZlclN0YXRlICpicykKK3sKKyAgICBCbG9ja1N0YXRzU3BlY2lmaWMgKnN0YXRzID0g
Z19uZXcoQmxvY2tTdGF0c1NwZWNpZmljLCAxKTsKKyAgICBCRFJWTlZNZVN0YXRlICpzID0gYnMt
Pm9wYXF1ZTsKKworICAgIHN0YXRzLT5kcml2ZXIgPSBCTE9DS0RFVl9EUklWRVJfTlZNRTsKKyAg
ICBzdGF0cy0+dS5udm1lID0gKEJsb2NrU3RhdHNTcGVjaWZpY052bWUpIHsKKyAgICAgICAgLmNv
bXBsZXRpb25fZXJyb3JzID0gcy0+c3RhdHMuY29tcGxldGlvbl9lcnJvcnMsCisgICAgICAgIC5h
bGlnbmVkX2FjY2Vzc2VzID0gcy0+c3RhdHMuYWxpZ25lZF9hY2Nlc3NlcywKKyAgICAgICAgLnVu
YWxpZ25lZF9hY2Nlc3NlcyA9IHMtPnN0YXRzLnVuYWxpZ25lZF9hY2Nlc3NlcywKKyAgICB9Owor
CisgICAgcmV0dXJuIHN0YXRzOworfQorCiBzdGF0aWMgY29uc3QgY2hhciAqY29uc3QgbnZtZV9z
dHJvbmdfcnVudGltZV9vcHRzW10gPSB7CiAgICAgTlZNRV9CTE9DS19PUFRfREVWSUNFLAogICAg
IE5WTUVfQkxPQ0tfT1BUX05BTUVTUEFDRSwKQEAgLTE0ODUsNiArMTUxMSw3IEBAIHN0YXRpYyBC
bG9ja0RyaXZlciBiZHJ2X252bWUgPSB7CiAgICAgLmJkcnZfcmVmcmVzaF9maWxlbmFtZSAgICA9
IG52bWVfcmVmcmVzaF9maWxlbmFtZSwKICAgICAuYmRydl9yZWZyZXNoX2xpbWl0cyAgICAgID0g
bnZtZV9yZWZyZXNoX2xpbWl0cywKICAgICAuc3Ryb25nX3J1bnRpbWVfb3B0cyAgICAgID0gbnZt
ZV9zdHJvbmdfcnVudGltZV9vcHRzLAorICAgIC5iZHJ2X2dldF9zcGVjaWZpY19zdGF0cyAgPSBu
dm1lX2dldF9zcGVjaWZpY19zdGF0cywKIAogICAgIC5iZHJ2X2RldGFjaF9haW9fY29udGV4dCAg
PSBudm1lX2RldGFjaF9haW9fY29udGV4dCwKICAgICAuYmRydl9hdHRhY2hfYWlvX2NvbnRleHQg
ID0gbnZtZV9hdHRhY2hfYWlvX2NvbnRleHQsCi0tIAoyLjI2LjIKCg==


