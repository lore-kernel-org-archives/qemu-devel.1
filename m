Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD5A2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e53rrxUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD5A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh91j-0002F5-Ra
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yk-0004HU-AY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yj-00071W-Fv
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og13K3Ae1X8gFshWxJRklCY1HCplpSbxNH9Oge6iflw=;
 b=e53rrxUthFew61HP/ezESeaFjx0bcJDn3xeAnhbKQwa2MWutoYcnwEFl31Tg7DEuZT6AiZ
 VH4BrML/maKwaYIg9gyi8DGqv/l1aY89dUVkF9tdMOnUJIfNkUc08ow5qvYsEbYTHpJcbx
 fGVlahpq/0ZEh1NBAOTSnJT5OA++MoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Bx1Rx9B3NcGFQsLbGQQ86g-1; Fri, 05 Jun 2020 05:49:31 -0400
X-MC-Unique: Bx1Rx9B3NcGFQsLbGQQ86g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8AC1940920;
 Fri,  5 Jun 2020 09:49:29 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 124FF60BF4;
 Fri,  5 Jun 2020 09:49:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 09/11] hw/block: Let the NVMe emulated device be target-agnostic
Date: Fri,  5 Jun 2020 10:47:48 +0100
Message-Id: <20200605094750.149957-10-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKTm93IHRo
YW4gdGhlIG5vbi10YXJnZXQgc3BlY2lmaWMgbWVtb3J5X3JlZ2lvbl9tc3luYygpIGZ1bmN0aW9u
CmlzIGF2YWlsYWJsZSwgdXNlIGl0IHRvIG1ha2UgdGhpcyBkZXZpY2UgdGFyZ2V0LWFnbm9zdGlj
LgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpS
ZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+CkFja2VkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpNZXNzYWdl
LWlkOiAyMDIwMDUwODA2MjQ1Ni4yMzM0NC00LXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBody9ibG9jay9N
YWtlZmlsZS5vYmpzIHwgMiArLQogaHcvYmxvY2svbnZtZS5jICAgICAgICB8IDYgKystLS0tCiAy
IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9ody9ibG9jay9NYWtlZmlsZS5vYmpzIGIvaHcvYmxvY2svTWFrZWZpbGUub2JqcwppbmRl
eCA0Nzk2MGI1ZjBkLi44ODU1YzIyNjU2IDEwMDY0NAotLS0gYS9ody9ibG9jay9NYWtlZmlsZS5v
YmpzCisrKyBiL2h3L2Jsb2NrL01ha2VmaWxlLm9ianMKQEAgLTEzLDYgKzEzLDYgQEAgY29tbW9u
LW9iai0kKENPTkZJR19TSDQpICs9IHRjNTgxMjgubwogCiBvYmotJChDT05GSUdfVklSVElPX0JM
SykgKz0gdmlydGlvLWJsay5vCiBvYmotJChDT05GSUdfVkhPU1RfVVNFUl9CTEspICs9IHZob3N0
LXVzZXItYmxrLm8KLW9iai0kKENPTkZJR19OVk1FX1BDSSkgKz0gbnZtZS5vCitjb21tb24tb2Jq
LSQoQ09ORklHX05WTUVfUENJKSArPSBudm1lLm8KIAogb2JqLXkgKz0gZGF0YXBsYW5lLwpkaWZm
IC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2svbnZtZS5jCmluZGV4IDJmMzEwMGU1
NmMuLmEyMWVlY2EyZmIgMTAwNjQ0Ci0tLSBhL2h3L2Jsb2NrL252bWUuYworKysgYi9ody9ibG9j
ay9udm1lLmMKQEAgLTQ2LDggKzQ2LDcgQEAKICNpbmNsdWRlICJxYXBpL3Zpc2l0b3IuaCIKICNp
bmNsdWRlICJzeXNlbXUvaG9zdG1lbS5oIgogI2luY2x1ZGUgInN5c2VtdS9ibG9jay1iYWNrZW5k
LmgiCi0jaW5jbHVkZSAiZXhlYy9yYW1fYWRkci5oIgotCisjaW5jbHVkZSAiZXhlYy9tZW1vcnku
aCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiCiAjaW5j
bHVkZSAicWVtdS9jdXRpbHMuaCIKQEAgLTEyMDcsOCArMTIwNiw3IEBAIHN0YXRpYyB1aW50NjRf
dCBudm1lX21taW9fcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1bnNpZ25lZCBzaXpl
KQogICAgICAgICAgKi8KICAgICAgICAgaWYgKGFkZHIgPT0gMHhFMDggJiYKICAgICAgICAgICAg
IChOVk1FX1BNUkNBUF9QTVJXQk0obi0+YmFyLnBtcmNhcCkgJiAweDAyKSkgewotICAgICAgICAg
ICAgcWVtdV9yYW1fd3JpdGViYWNrKG4tPnBtcmRldi0+bXIucmFtX2Jsb2NrLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDAsIG4tPnBtcmRldi0+c2l6ZSk7CisgICAgICAgICAgICBt
ZW1vcnlfcmVnaW9uX21zeW5jKCZuLT5wbXJkZXYtPm1yLCAwLCBuLT5wbXJkZXYtPnNpemUpOwog
ICAgICAgICB9CiAgICAgICAgIG1lbWNweSgmdmFsLCBwdHIgKyBhZGRyLCBzaXplKTsKICAgICB9
IGVsc2UgewotLSAKMi4yNS40Cgo=


