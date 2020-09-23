Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3EF20719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwqpdEfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3EF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7VE-0005bV-Vo
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mt-0003zY-F9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mq-0006Jw-AE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Z/uY+MgIruUkR9z7pOKiKQWr0sxUm7btHUr+4CZfFk=;
 b=LwqpdEfIYYAIsI8yWAo0kuDgSrtJZ0Dhj4aGfDq297fGO7sopCObOfIi+T4cxIP2cDNmZO
 MUmdv/548HyfY+/L3vsK/8UQXbqMiHEV2slqr79uPxlMDOGBFfwgbxkmx9+zQCVY1tdMm/
 R8Re2BOmPtCnoq1EhWsSFSaZvDVQxNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-c1xF5bFIMOuoXhgysz2ZDg-1; Wed, 23 Sep 2020 12:11:32 -0400
X-MC-Unique: c1xF5bFIMOuoXhgysz2ZDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3BCB2FD02;
 Wed, 23 Sep 2020 16:11:31 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3EC55783;
 Wed, 23 Sep 2020 16:11:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/13] tests: add test-fdmon-epoll
Date: Wed, 23 Sep 2020 17:10:30 +0100
Message-Id: <20200923161031.69474-13-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGVzdCBhaW9fZGlzYWJsZV9leHRlcm5hbCgpLCB3aGljaCBzd2l0Y2hlcyBmcm9tIGZkbW9uLWVw
b2xsIGJhY2sgdG8KZmRtb24tcG9sbC4gVGhpcyByZXN1bHRlZCBpbiBhbiBhc3NlcnRpb24gZmFp
bHVyZSB0aGF0IHdhcyBmaXhlZCBpbiB0aGUKcHJldmlvdXMgcGF0Y2guCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIw
MDkxNTEyMDMzOS43MDI5MzgtMy1zdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICB8ICAxICsKIHRlc3RzL3Rlc3QtZmRtb24tZXBvbGwuYyB8IDczICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL21lc29uLmJ1aWxkICAg
ICAgICB8ICAzICsrCiAzIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy90ZXN0LWZkbW9uLWVwb2xsLmMKCmRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDUzNGZiNGM1MTkuLjVlZWQxZTY5MmIgMTAwNjQ0Ci0t
LSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yMTMyLDYgKzIxMzIsNyBAQCBG
OiBtaWdyYXRpb24vYmxvY2sqCiBGOiBpbmNsdWRlL2Jsb2NrL2Fpby5oCiBGOiBpbmNsdWRlL2Js
b2NrL2Fpby13YWl0LmgKIEY6IHNjcmlwdHMvcWVtdWdkYi9haW8ucHkKK0Y6IHRlc3RzL3Rlc3Qt
ZmRtb24tZXBvbGwuYwogVDogZ2l0IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9xZW11Lmdp
dCBibG9jawogCiBCbG9jayBTQ1NJIHN1YnN5c3RlbQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGVzdC1m
ZG1vbi1lcG9sbC5jIGIvdGVzdHMvdGVzdC1mZG1vbi1lcG9sbC5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAuLjExZmQ4YTJmYTkKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0
cy90ZXN0LWZkbW9uLWVwb2xsLmMKQEAgLTAsMCArMSw3MyBAQAorLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KKy8qCisgKiBmZG1vbi1lcG9sbCB0ZXN0cwor
ICoKKyAqIENvcHlyaWdodCAoYykgMjAyMCBSZWQgSGF0LCBJbmMuCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJibG9jay9haW8uaCIKKyNpbmNsdWRlICJxYXBpL2Vy
cm9yLmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKKworc3RhdGljIEFpb0NvbnRleHQg
KmN0eDsKKworc3RhdGljIHZvaWQgZHVtbXlfZmRfaGFuZGxlcihFdmVudE5vdGlmaWVyICpub3Rp
ZmllcikKK3sKKyAgICBldmVudF9ub3RpZmllcl90ZXN0X2FuZF9jbGVhcihub3RpZmllcik7Cit9
CisKK3N0YXRpYyB2b2lkIGFkZF9ldmVudF9ub3RpZmllcnMoRXZlbnROb3RpZmllciAqbm90aWZp
ZXJzLCBzaXplX3QgbikKK3sKKyAgICBmb3IgKHNpemVfdCBpID0gMDsgaSA8IG47IGkrKykgewor
ICAgICAgICBldmVudF9ub3RpZmllcl9pbml0KCZub3RpZmllcnNbaV0sIGZhbHNlKTsKKyAgICAg
ICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZub3RpZmllcnNbaV0sIGZhbHNlLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGR1bW15X2ZkX2hhbmRsZXIsIE5VTEwpOworICAg
IH0KK30KKworc3RhdGljIHZvaWQgcmVtb3ZlX2V2ZW50X25vdGlmaWVycyhFdmVudE5vdGlmaWVy
ICpub3RpZmllcnMsIHNpemVfdCBuKQoreworICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbjsg
aSsrKSB7CisgICAgICAgIGFpb19zZXRfZXZlbnRfbm90aWZpZXIoY3R4LCAmbm90aWZpZXJzW2ld
LCBmYWxzZSwgTlVMTCwgTlVMTCk7CisgICAgICAgIGV2ZW50X25vdGlmaWVyX2NsZWFudXAoJm5v
dGlmaWVyc1tpXSk7CisgICAgfQorfQorCisvKiBDaGVjayB0aGF0IGZkIGhhbmRsZXJzIHdvcmsg
d2hlbiBleHRlcm5hbCBjbGllbnRzIGFyZSBkaXNhYmxlZCAqLworc3RhdGljIHZvaWQgdGVzdF9l
eHRlcm5hbF9kaXNhYmxlZCh2b2lkKQoreworICAgIEV2ZW50Tm90aWZpZXIgbm90aWZpZXJzWzEw
MF07CisKKyAgICAvKiBmZG1vbi1lcG9sbCBpcyBvbmx5IGVuYWJsZWQgd2hlbiBtYW55IGZkIGhh
bmRsZXJzIGFyZSByZWdpc3RlcmVkICovCisgICAgYWRkX2V2ZW50X25vdGlmaWVycyhub3RpZmll
cnMsIEdfTl9FTEVNRU5UUyhub3RpZmllcnMpKTsKKworICAgIGV2ZW50X25vdGlmaWVyX3NldCgm
bm90aWZpZXJzWzBdKTsKKyAgICBhc3NlcnQoYWlvX3BvbGwoY3R4LCB0cnVlKSk7CisKKyAgICBh
aW9fZGlzYWJsZV9leHRlcm5hbChjdHgpOworICAgIGV2ZW50X25vdGlmaWVyX3NldCgmbm90aWZp
ZXJzWzBdKTsKKyAgICBhc3NlcnQoYWlvX3BvbGwoY3R4LCB0cnVlKSk7CisgICAgYWlvX2VuYWJs
ZV9leHRlcm5hbChjdHgpOworCisgICAgcmVtb3ZlX2V2ZW50X25vdGlmaWVycyhub3RpZmllcnMs
IEdfTl9FTEVNRU5UUyhub3RpZmllcnMpKTsKK30KKworaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQoreworICAgIC8qCisgICAgICogVGhpcyBjb2RlIHJlbGllcyBvbiB0aGUgZmFjdCB0
aGF0IGZkbW9uLWlvX3VyaW5nIGRpc2FibGVzIGl0c2VsZiB3aGVuCisgICAgICogdGhlIGdsaWIg
bWFpbiBsb29wIGlzIGluIHVzZS4gVGhlIG1haW4gbG9vcCB1c2VzIGZkbW9uLXBvbGwgYW5kIHVw
Z3JhZGVzCisgICAgICogdG8gZmRtb24tZXBvbGwgd2hlbiB0aGUgbnVtYmVyIG9mIGZkcyBleGNl
ZWRzIGEgdGhyZXNob2xkLgorICAgICAqLworICAgIHFlbXVfaW5pdF9tYWluX2xvb3AoJmVycm9y
X2ZhdGFsKTsKKyAgICBjdHggPSBxZW11X2dldF9haW9fY29udGV4dCgpOworCisgICAgd2hpbGUg
KGdfbWFpbl9jb250ZXh0X2l0ZXJhdGlvbihOVUxMLCBmYWxzZSkpIHsKKyAgICAgICAgLyogRG8g
bm90aGluZyAqLworICAgIH0KKworICAgIGdfdGVzdF9pbml0KCZhcmdjLCAmYXJndiwgTlVMTCk7
CisgICAgZ190ZXN0X2FkZF9mdW5jKCIvZmRtb24tZXBvbGwvZXh0ZXJuYWwtZGlzYWJsZWQiLCB0
ZXN0X2V4dGVybmFsX2Rpc2FibGVkKTsKKyAgICByZXR1cm4gZ190ZXN0X3J1bigpOworfQpkaWZm
IC0tZ2l0IGEvdGVzdHMvbWVzb24uYnVpbGQgYi90ZXN0cy9tZXNvbi5idWlsZAppbmRleCA4YzNl
OTMwNjg3Li4wNDA3MmE2NGNhIDEwMDY0NAotLS0gYS90ZXN0cy9tZXNvbi5idWlsZAorKysgYi90
ZXN0cy9tZXNvbi5idWlsZApAQCAtMTcwLDYgKzE3MCw5IEBAIGlmIGhhdmVfYmxvY2sKICAgaWYg
J0NPTkZJR19ORVRUTEUnIGluIGNvbmZpZ19ob3N0IG9yICdDT05GSUdfR0NSWVBUJyBpbiBjb25m
aWdfaG9zdAogICAgIHRlc3RzICs9IHsndGVzdC1jcnlwdG8tcGJrZGYnOiBbaW9dfQogICBlbmRp
ZgorICBpZiAnQ09ORklHX0VQT0xMX0NSRUFURTEnIGluIGNvbmZpZ19ob3N0CisgICAgdGVzdHMg
Kz0geyd0ZXN0LWZkbW9uLWVwb2xsJzogW3Rlc3RibG9ja119CisgIGVuZGlmCiAgIGJlbmNocyAr
PSB7CiAgICAgICdiZW5jaG1hcmstY3J5cHRvLWhhc2gnOiBbY3J5cHRvXSwKICAgICAgJ2JlbmNo
bWFyay1jcnlwdG8taG1hYyc6IFtjcnlwdG9dLAotLSAKMi4yNi4yCgo=


