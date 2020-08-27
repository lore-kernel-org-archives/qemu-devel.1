Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D9622B4E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8O4gqoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D9622B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIy5-0006ww-Mm
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuI-0001ny-Ud
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuH-0004JI-3W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow5mwgYE3lLOnFuNqYI6EDG0/V17MRwun+Vp8JUKo6U=;
 b=g8O4gqoAgCi6AmlW79rW+oarqLxQf74Q/rWx6mxPa5P95QKNX2ZhUuKS85XK+RxDqwehCg
 Mqpp3rjJ0GTuIJIPcbIMcaUJQtF1Xa6gsoDPlnkOm6shPE51PHbdSHi+CwmAzu9cnRn7OX
 SXNS+WARUWKlv3wnd16IR63PR54y3gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-0_xU3S25MquERHyalKKaIA-1; Thu, 27 Aug 2020 10:29:31 -0400
X-MC-Unique: 0_xU3S25MquERHyalKKaIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 947CEAE400;
 Thu, 27 Aug 2020 14:29:30 +0000 (UTC)
Received: from localhost (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860F66198B;
 Thu, 27 Aug 2020 14:29:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tracetool: add input filename and line number to Event
Date: Thu, 27 Aug 2020 15:29:14 +0100
Message-Id: <20200827142915.108730-4-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-1-stefanha@redhat.com>
References: <20200827142915.108730-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U3RvcmUgdGhlIGlucHV0IGZpbGVuYW1lIGFuZCBsaW5lIG51bWJlciBpbiBFdmVudC4KCkEgbGF0
ZXIgcGF0Y2ggd2lsbCB1c2UgdGhpcyB0byBpbXByb3ZlIGVycm9yIG1lc3NhZ2VzLgoKU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHNjcmlw
dHMvdHJhY2V0b29sL19faW5pdF9fLnB5IHwgMjcgKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zY3JpcHRzL3RyYWNldG9vbC9fX2luaXRfXy5weSBiL3NjcmlwdHMvdHJhY2V0b29s
L19faW5pdF9fLnB5CmluZGV4IGU0ZWU0ZDVlNjEuLjFhNmUyZmE2NGEgMTAwNjQ0Ci0tLSBhL3Nj
cmlwdHMvdHJhY2V0b29sL19faW5pdF9fLnB5CisrKyBiL3NjcmlwdHMvdHJhY2V0b29sL19faW5p
dF9fLnB5CkBAIC0yMTgsNiArMjE4LDEwIEBAIGNsYXNzIEV2ZW50KG9iamVjdCk6CiAgICAgICAg
IFByb3BlcnRpZXMgb2YgdGhlIGV2ZW50LgogICAgIGFyZ3MgOiBBcmd1bWVudHMKICAgICAgICAg
VGhlIGV2ZW50IGFyZ3VtZW50cy4KKyAgICBsaW5lbm8gOiBpbnQKKyAgICAgICAgVGhlIGxpbmUg
bnVtYmVyIGluIHRoZSBpbnB1dCBmaWxlLgorICAgIGZpbGVuYW1lIDogc3RyCisgICAgICAgIFRo
ZSBwYXRoIHRvIHRoZSBpbnB1dCBmaWxlLgogCiAgICAgIiIiCiAKQEAgLTIzMCw3ICsyMzQsNyBA
QCBjbGFzcyBFdmVudChvYmplY3QpOgogCiAgICAgX1ZBTElEX1BST1BTID0gc2V0KFsiZGlzYWJs
ZSIsICJ0Y2ciLCAidGNnLXRyYW5zIiwgInRjZy1leGVjIiwgInZjcHUiXSkKIAotICAgIGRlZiBf
X2luaXRfXyhzZWxmLCBuYW1lLCBwcm9wcywgZm10LCBhcmdzLCBvcmlnPU5vbmUsCisgICAgZGVm
IF9faW5pdF9fKHNlbGYsIG5hbWUsIHByb3BzLCBmbXQsIGFyZ3MsIGxpbmVubywgZmlsZW5hbWUs
IG9yaWc9Tm9uZSwKICAgICAgICAgICAgICAgICAgZXZlbnRfdHJhbnM9Tm9uZSwgZXZlbnRfZXhl
Yz1Ob25lKToKICAgICAgICAgIiIiCiAgICAgICAgIFBhcmFtZXRlcnMKQEAgLTI0Myw2ICsyNDcs
MTAgQEAgY2xhc3MgRXZlbnQob2JqZWN0KToKICAgICAgICAgICAgIEV2ZW50IHByaW50aW5nIGZv
cm1hdCBzdHJpbmcocykuCiAgICAgICAgIGFyZ3MgOiBBcmd1bWVudHMKICAgICAgICAgICAgIEV2
ZW50IGFyZ3VtZW50cy4KKyAgICAgICAgbGluZW5vIDogaW50CisgICAgICAgICAgICBUaGUgbGlu
ZSBudW1iZXIgaW4gdGhlIGlucHV0IGZpbGUuCisgICAgICAgIGZpbGVuYW1lIDogc3RyCisgICAg
ICAgICAgICBUaGUgcGF0aCB0byB0aGUgaW5wdXQgZmlsZS4KICAgICAgICAgb3JpZyA6IEV2ZW50
IG9yIE5vbmUKICAgICAgICAgICAgIE9yaWdpbmFsIEV2ZW50IGJlZm9yZSB0cmFuc2Zvcm1hdGlv
bi9nZW5lcmF0aW9uLgogICAgICAgICBldmVudF90cmFucyA6IEV2ZW50IG9yIE5vbmUKQEAgLTI1
NSw2ICsyNjMsOCBAQCBjbGFzcyBFdmVudChvYmplY3QpOgogICAgICAgICBzZWxmLnByb3BlcnRp
ZXMgPSBwcm9wcwogICAgICAgICBzZWxmLmZtdCA9IGZtdAogICAgICAgICBzZWxmLmFyZ3MgPSBh
cmdzCisgICAgICAgIHNlbGYubGluZW5vID0gaW50KGxpbmVubykKKyAgICAgICAgc2VsZi5maWxl
bmFtZSA9IHN0cihmaWxlbmFtZSkKICAgICAgICAgc2VsZi5ldmVudF90cmFucyA9IGV2ZW50X3Ry
YW5zCiAgICAgICAgIHNlbGYuZXZlbnRfZXhlYyA9IGV2ZW50X2V4ZWMKIApAQCAtMjc2LDE2ICsy
ODYsMjEgQEAgY2xhc3MgRXZlbnQob2JqZWN0KToKICAgICBkZWYgY29weShzZWxmKToKICAgICAg
ICAgIiIiQ3JlYXRlIGEgbmV3IGNvcHkuIiIiCiAgICAgICAgIHJldHVybiBFdmVudChzZWxmLm5h
bWUsIGxpc3Qoc2VsZi5wcm9wZXJ0aWVzKSwgc2VsZi5mbXQsCi0gICAgICAgICAgICAgICAgICAg
ICBzZWxmLmFyZ3MuY29weSgpLCBzZWxmLCBzZWxmLmV2ZW50X3RyYW5zLCBzZWxmLmV2ZW50X2V4
ZWMpCisgICAgICAgICAgICAgICAgICAgICBzZWxmLmFyZ3MuY29weSgpLCBzZWxmLmxpbmVubywg
c2VsZi5maWxlbmFtZSwKKyAgICAgICAgICAgICAgICAgICAgIHNlbGYsIHNlbGYuZXZlbnRfdHJh
bnMsIHNlbGYuZXZlbnRfZXhlYykKIAogICAgIEBzdGF0aWNtZXRob2QKLSAgICBkZWYgYnVpbGQo
bGluZV9zdHIpOgorICAgIGRlZiBidWlsZChsaW5lX3N0ciwgbGluZW5vLCBmaWxlbmFtZSk6CiAg
ICAgICAgICIiIkJ1aWxkIGFuIEV2ZW50IGluc3RhbmNlIGZyb20gYSBzdHJpbmcuCiAKICAgICAg
ICAgUGFyYW1ldGVycwogICAgICAgICAtLS0tLS0tLS0tCiAgICAgICAgIGxpbmVfc3RyIDogc3Ry
CiAgICAgICAgICAgICBMaW5lIGRlc2NyaWJpbmcgdGhlIGV2ZW50LgorICAgICAgICBsaW5lbm8g
OiBpbnQKKyAgICAgICAgICAgIExpbmUgbnVtYmVyIGluIGlucHV0IGZpbGUuCisgICAgICAgIGZp
bGVuYW1lIDogc3RyCisgICAgICAgICAgICBQYXRoIHRvIGlucHV0IGZpbGUuCiAgICAgICAgICIi
IgogICAgICAgICBtID0gRXZlbnQuX0NSRS5tYXRjaChsaW5lX3N0cikKICAgICAgICAgYXNzZXJ0
IG0gaXMgbm90IE5vbmUKQEAgLTMxNSw3ICszMzAsNyBAQCBjbGFzcyBFdmVudChvYmplY3QpOgog
ICAgICAgICBpZiAidGNnIiBpbiBwcm9wcyBhbmQgaXNpbnN0YW5jZShmbXQsIHN0cik6CiAgICAg
ICAgICAgICByYWlzZSBWYWx1ZUVycm9yKCJFdmVudHMgd2l0aCAndGNnJyBwcm9wZXJ0eSBtdXN0
IGhhdmUgdHdvIGZvcm1hdCBzdHJpbmdzIikKIAotICAgICAgICBldmVudCA9IEV2ZW50KG5hbWUs
IHByb3BzLCBmbXQsIGFyZ3MpCisgICAgICAgIGV2ZW50ID0gRXZlbnQobmFtZSwgcHJvcHMsIGZt
dCwgYXJncywgbGluZW5vLCBmaWxlbmFtZSkKIAogICAgICAgICAjIGFkZCBpbXBsaWNpdCBhcmd1
bWVudHMgd2hlbiB1c2luZyB0aGUgJ3ZjcHUnIHByb3BlcnR5CiAgICAgICAgIGltcG9ydCB0cmFj
ZXRvb2wudmNwdQpAQCAtMzYwLDYgKzM3NSw4IEBAIGNsYXNzIEV2ZW50KG9iamVjdCk6CiAgICAg
ICAgICAgICAgICAgICAgICBsaXN0KHNlbGYucHJvcGVydGllcyksCiAgICAgICAgICAgICAgICAg
ICAgICBzZWxmLmZtdCwKICAgICAgICAgICAgICAgICAgICAgIHNlbGYuYXJncy50cmFuc2Zvcm0o
KnRyYW5zKSwKKyAgICAgICAgICAgICAgICAgICAgIHNlbGYubGluZW5vLAorICAgICAgICAgICAg
ICAgICAgICAgc2VsZi5maWxlbmFtZSwKICAgICAgICAgICAgICAgICAgICAgIHNlbGYpCiAKIApA
QCAtMzg2LDcgKzQwMyw3IEBAIGRlZiByZWFkX2V2ZW50cyhmb2JqLCBmbmFtZSk6CiAgICAgICAg
ICAgICBjb250aW51ZQogCiAgICAgICAgIHRyeToKLSAgICAgICAgICAgIGV2ZW50ID0gRXZlbnQu
YnVpbGQobGluZSkKKyAgICAgICAgICAgIGV2ZW50ID0gRXZlbnQuYnVpbGQobGluZSwgbGluZW5v
LCBmbmFtZSkKICAgICAgICAgZXhjZXB0IFZhbHVlRXJyb3IgYXMgZToKICAgICAgICAgICAgIGFy
ZzAgPSAnRXJyb3IgYXQgJXM6JWQ6ICVzJyAlIChmbmFtZSwgbGluZW5vLCBlLmFyZ3NbMF0pCiAg
ICAgICAgICAgICBlLmFyZ3MgPSAoYXJnMCwpICsgZS5hcmdzWzE6XQotLSAKMi4yNi4yCgo=


