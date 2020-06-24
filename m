Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20840C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E0420720
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUlrlUM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E0420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo30H-0001c2-47
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2yi-0007YR-0Z
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:50:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2yg-0000oo-C6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbJOg/nv+ZCE+TPgqIsQ1ilmNbbkdoUQ+wuzW+cmF4g=;
 b=TUlrlUM9Q7z7GvJKdoE3UB9ix1BvwuQ6O7/hxVN4Nx3HDGPAAHqK9d9XBuszmihsLqEy0K
 Tn3DniAllIiSqO5fTLivp1HzymoYPz6x0g+vp+8g+CZNMOMb40hujgTRjprFRE4DMSdxKW
 6xUzTMSUJO0OXW5c37Lx2WiEq2PSzTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-BotcB8MVOpWNTEDaeWvXeA-1; Wed, 24 Jun 2020 06:49:59 -0400
X-MC-Unique: BotcB8MVOpWNTEDaeWvXeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0551005513;
 Wed, 24 Jun 2020 10:49:58 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 326FF61981;
 Wed, 24 Jun 2020 10:49:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] trace/simple: Fix unauthorized enable
Date: Wed, 24 Jun 2020 11:49:35 +0100
Message-Id: <20200624104935.61329-3-stefanha@redhat.com>
In-Reply-To: <20200624104935.61329-1-stefanha@redhat.com>
References: <20200624104935.61329-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPgoKc3Rfc2V0X3RyYWNl
X2ZpbGUoKSBhY2NpZGVudGFsbHkgZW5hYmxlcyB0cmFjaW5nLiAgSXQncyBjYWxsZWQKdW5jb25k
aXRpb25hbGx5IGR1cmluZyBzdGFydHVwLCB3aGljaCBpcyB3aHkgUUVNVSBidWlsdCB3aXRoIHRo
ZQpzaW1wbGUgdHJhY2UgYmFja2VuZCBhbHdheXMgd3JpdGVzIGEgdHJhY2UgZmlsZSAidHJhY2Ut
JFBJRCIuCgpUaGlzIGhhcyBiZWVuIGJyb2tlbiBmb3IgcXVpdGUgYSB3aGlsZS4gIEkgZGlkbid0
IHRyYWNrIGRvd24gdGhlIGV4YWN0CmNvbW1pdC4KCkZpeCBzdF9zZXRfdHJhY2VfZmlsZSgpIHRv
IHJlc3RvcmUgdGhlIHN0YXRlLgoKU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFy
bWJydUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDUyNzA2NTYxMy4yNTMyMi0xLWFybWJy
dUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiB0cmFjZS9zaW1wbGUuaCB8ICAyICstCiB0cmFjZS9zaW1wbGUuYyB8IDIw
ICsrKysrKysrKysrKysrLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdHJhY2Uvc2ltcGxlLmggYi90cmFjZS9zaW1w
bGUuaAppbmRleCA1NzcxYTA2MzRmLi4yNmNjYmM4YjhhIDEwMDY0NAotLS0gYS90cmFjZS9zaW1w
bGUuaAorKysgYi90cmFjZS9zaW1wbGUuaApAQCAtMTIsNyArMTIsNyBAQAogI2RlZmluZSBUUkFD
RV9TSU1QTEVfSAogCiB2b2lkIHN0X3ByaW50X3RyYWNlX2ZpbGVfc3RhdHVzKHZvaWQpOwotdm9p
ZCBzdF9zZXRfdHJhY2VfZmlsZV9lbmFibGVkKGJvb2wgZW5hYmxlKTsKK2Jvb2wgc3Rfc2V0X3Ry
YWNlX2ZpbGVfZW5hYmxlZChib29sIGVuYWJsZSk7CiB2b2lkIHN0X3NldF90cmFjZV9maWxlKGNv
bnN0IGNoYXIgKmZpbGUpOwogYm9vbCBzdF9pbml0KHZvaWQpOwogdm9pZCBzdF9mbHVzaF90cmFj
ZV9idWZmZXIodm9pZCk7CmRpZmYgLS1naXQgYS90cmFjZS9zaW1wbGUuYyBiL3RyYWNlL3NpbXBs
ZS5jCmluZGV4IGZjNzEwNmVjNDkuLjljZDJlZDFmYjMgMTAwNjQ0Ci0tLSBhL3RyYWNlL3NpbXBs
ZS5jCisrKyBiL3RyYWNlL3NpbXBsZS5jCkBAIC0zMDIsMTAgKzMwMiwxNyBAQCBzdGF0aWMgaW50
IHN0X3dyaXRlX2V2ZW50X21hcHBpbmcodm9pZCkKICAgICByZXR1cm4gMDsKIH0KIAotdm9pZCBz
dF9zZXRfdHJhY2VfZmlsZV9lbmFibGVkKGJvb2wgZW5hYmxlKQorLyoqCisgKiBFbmFibGUgLyBk
aXNhYmxlIHRyYWNpbmcsIHJldHVybiB3aGV0aGVyIGl0IHdhcyBlbmFibGVkLgorICoKKyAqIEBl
bmFibGU6IGVuYWJsZSBpZiAldHJ1ZSwgZWxzZSBkaXNhYmxlLgorICovCitib29sIHN0X3NldF90
cmFjZV9maWxlX2VuYWJsZWQoYm9vbCBlbmFibGUpCiB7CisgICAgYm9vbCB3YXNfZW5hYmxlZCA9
IHRyYWNlX2ZwOworCiAgICAgaWYgKGVuYWJsZSA9PSAhIXRyYWNlX2ZwKSB7Ci0gICAgICAgIHJl
dHVybjsgLyogbm8gY2hhbmdlICovCisgICAgICAgIHJldHVybiB3YXNfZW5hYmxlZDsgICAgIC8q
IG5vIGNoYW5nZSAqLwogICAgIH0KIAogICAgIC8qIEhhbHQgdHJhY2Ugd3JpdGVvdXQgKi8KQEAg
LTMyMywxNCArMzMwLDE0IEBAIHZvaWQgc3Rfc2V0X3RyYWNlX2ZpbGVfZW5hYmxlZChib29sIGVu
YWJsZSkKIAogICAgICAgICB0cmFjZV9mcCA9IGZvcGVuKHRyYWNlX2ZpbGVfbmFtZSwgIndiIik7
CiAgICAgICAgIGlmICghdHJhY2VfZnApIHsKLSAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAg
ICAgIHJldHVybiB3YXNfZW5hYmxlZDsKICAgICAgICAgfQogCiAgICAgICAgIGlmIChmd3JpdGUo
JmhlYWRlciwgc2l6ZW9mIGhlYWRlciwgMSwgdHJhY2VfZnApICE9IDEgfHwKICAgICAgICAgICAg
IHN0X3dyaXRlX2V2ZW50X21hcHBpbmcoKSA8IDApIHsKICAgICAgICAgICAgIGZjbG9zZSh0cmFj
ZV9mcCk7CiAgICAgICAgICAgICB0cmFjZV9mcCA9IE5VTEw7Ci0gICAgICAgICAgICByZXR1cm47
CisgICAgICAgICAgICByZXR1cm4gd2FzX2VuYWJsZWQ7CiAgICAgICAgIH0KIAogICAgICAgICAv
KiBSZXN1bWUgdHJhY2Ugd3JpdGVvdXQgKi8KQEAgLTM0MCw2ICszNDcsNyBAQCB2b2lkIHN0X3Nl
dF90cmFjZV9maWxlX2VuYWJsZWQoYm9vbCBlbmFibGUpCiAgICAgICAgIGZjbG9zZSh0cmFjZV9m
cCk7CiAgICAgICAgIHRyYWNlX2ZwID0gTlVMTDsKICAgICB9CisgICAgcmV0dXJuIHdhc19lbmFi
bGVkOwogfQogCiAvKioKQEAgLTM1MCw3ICszNTgsNyBAQCB2b2lkIHN0X3NldF90cmFjZV9maWxl
X2VuYWJsZWQoYm9vbCBlbmFibGUpCiAgKi8KIHZvaWQgc3Rfc2V0X3RyYWNlX2ZpbGUoY29uc3Qg
Y2hhciAqZmlsZSkKIHsKLSAgICBzdF9zZXRfdHJhY2VfZmlsZV9lbmFibGVkKGZhbHNlKTsKKyAg
ICBib29sIHNhdmVkX2VuYWJsZSA9IHN0X3NldF90cmFjZV9maWxlX2VuYWJsZWQoZmFsc2UpOwog
CiAgICAgZ19mcmVlKHRyYWNlX2ZpbGVfbmFtZSk7CiAKQEAgLTM2MSw3ICszNjksNyBAQCB2b2lk
IHN0X3NldF90cmFjZV9maWxlKGNvbnN0IGNoYXIgKmZpbGUpCiAgICAgICAgIHRyYWNlX2ZpbGVf
bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXMiLCBmaWxlKTsKICAgICB9CiAKLSAgICBzdF9zZXRf
dHJhY2VfZmlsZV9lbmFibGVkKHRydWUpOworICAgIHN0X3NldF90cmFjZV9maWxlX2VuYWJsZWQo
c2F2ZWRfZW5hYmxlKTsKIH0KIAogdm9pZCBzdF9wcmludF90cmFjZV9maWxlX3N0YXR1cyh2b2lk
KQotLSAKMi4yNi4yCgo=


