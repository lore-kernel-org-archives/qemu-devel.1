Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C48C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F0C2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgtqWCzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F0C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIwf-0004zp-PX
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuK-0001rp-Gf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuI-0004JV-K1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjO/UPdB4O1n8iYVXF2z8DOoNo+23LLam4UaqokY/cE=;
 b=JgtqWCzqSf4dg2pP6KBFidKFpm+NPMJijv9AWe4cdKiHhNDd1yL/S4L9hrhtYaThtEA71H
 Vzp0+7w+JhLTpTkvzIS7p4nIs4QX7ta6dKv0uDzfyaj2rvtZdYbNP5tW5dJIR83T5CLY6T
 qhgLEaYP4GEn3fdvJlEQcIg3OZs/m0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-mc1YU59MMXCgG30ldzo2OA-1; Thu, 27 Aug 2020 10:29:33 -0400
X-MC-Unique: mc1YU59MMXCgG30ldzo2OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EEE801AC2;
 Thu, 27 Aug 2020 14:29:32 +0000 (UTC)
Received: from localhost (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10CAC60FC2;
 Thu, 27 Aug 2020 14:29:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tracetool: show trace-events filename/lineno in fmt
 string errors
Date: Thu, 27 Aug 2020 15:29:15 +0100
Message-Id: <20200827142915.108730-5-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-1-stefanha@redhat.com>
References: <20200827142915.108730-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

VGhlIGNvbXBpbGVyIGVuY291bnRlcnMgdHJhY2UgZXZlbnQgZm9ybWF0IHN0cmluZ3MgaW4gZ2Vu
ZXJhdGVkIGNvZGUuCkZvcm1hdCBzdHJpbmdzIGFyZSBlcnJvci1wcm9uZSBhbmQgdGhlcmVmb3Jl
IGNsZWFyIGNvbXBpbGVyIGVycm9ycyBhcmUKaW1wb3J0YW50LgoKVXNlIHRoZSAjbGluZSBkaXJl
Y3RpdmUgdG8gc2hvdyB0aGUgdHJhY2UtZXZlbnRzIGZpbGVuYW1lIGFuZCBsaW5lCm51bWJlciBp
biBmb3JtYXQgc3RyaW5nIGVycm9yczoKaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2dj
Yy0xMC4yLjAvY3BwL0xpbmUtQ29udHJvbC5odG1sCgpGb3IgZXhhbXBsZSwgaWYgdGhlIGNwdV9p
biB0cmFjZSBldmVudCdzICV1IGlzIGNoYW5nZWQgdG8gJXAgdGhlCmZvbGxvd2luZyBlcnJvciBp
cyByZXBvcnRlZDoKCiAgdHJhY2UtZXZlbnRzOjI5OjE4OiBlcnJvcjogZm9ybWF0IOKAmCVw4oCZ
IGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJh2b2lkICrigJksIGJ1dCBhcmd1bWVudCA3IGhh
cyB0eXBlIOKAmHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1mb3JtYXQ9XQoKTGluZSAyOSBpbiB0
cmFjZS1ldmVudHMgaXMgd2hlcmUgY3B1X2luIGlzIGRlZmluZWQuIFRoaXMgd29ya3MgZm9yIGFu
eQp0cmFjZS1ldmVudHMgZmlsZSBpbiB0aGUgUUVNVSBzb3VyY2UgdHJlZSBhbmQgdGhlIGNvcnJl
Y3QgcGF0aCBpcwpkaXNwbGF5ZWQuCgpVbmZvcnR1bmF0ZWx5IHRoZXJlIGRvZXMgbm90IHNlZW0g
dG8gYmUgYSB3YXkgdG8gc2V0IHRoZSBjb2x1bW4sIHNvICIxOCIKaXMgbm90IHRoZSByaWdodCBj
aGFyYWN0ZXIgb24gdGhhdCBsaW5lLgoKU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBzY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2Z0cmFjZS5w
eSB8IDQgKysrKwogc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9sb2cucHkgICAgfCA0ICsrKysK
IHNjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvc3lzbG9nLnB5IHwgNCArKysrCiAzIGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zY3JpcHRzL3RyYWNldG9vbC9i
YWNrZW5kL2Z0cmFjZS5weSBiL3NjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvZnRyYWNlLnB5Cmlu
ZGV4IGU5ODQ0ZGQzMzUuLjVmYTMwY2NjMDggMTAwNjQ0Ci0tLSBhL3NjcmlwdHMvdHJhY2V0b29s
L2JhY2tlbmQvZnRyYWNlLnB5CisrKyBiL3NjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvZnRyYWNl
LnB5CkBAIC0zMyw4ICszMywxMCBAQCBkZWYgZ2VuZXJhdGVfaChldmVudCwgZ3JvdXApOgogICAg
ICAgICAnICAgICAgICBpbnQgdW51c2VkIF9fYXR0cmlidXRlX18gKCh1bnVzZWQpKTsnLAogICAg
ICAgICAnICAgICAgICBpbnQgdHJsZW47JywKICAgICAgICAgJyAgICAgICAgaWYgKHRyYWNlX2V2
ZW50X2dldF9zdGF0ZSglKGV2ZW50X2lkKXMpKSB7JywKKyAgICAgICAgJyNsaW5lICUoZXZlbnRf
bGluZW5vKWQgIiUoZXZlbnRfZmlsZW5hbWUpcyInLAogICAgICAgICAnICAgICAgICAgICAgdHJs
ZW4gPSBzbnByaW50ZihmdHJhY2VfYnVmLCBNQVhfVFJBQ0VfU1RSTEVOLCcsCiAgICAgICAgICcg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlKG5hbWUpcyAiICUoZm10KXMgIlxcbiIgJShh
cmduYW1lcylzKTsnLAorICAgICAgICAnI2xpbmUgJShvdXRfbmV4dF9saW5lbm8pZCAiJShvdXRf
ZmlsZW5hbWUpcyInLAogICAgICAgICAnICAgICAgICAgICAgdHJsZW4gPSBNSU4odHJsZW4sIE1B
WF9UUkFDRV9TVFJMRU4gLSAxKTsnLAogICAgICAgICAnICAgICAgICAgICAgdW51c2VkID0gd3Jp
dGUodHJhY2VfbWFya2VyX2ZkLCBmdHJhY2VfYnVmLCB0cmxlbik7JywKICAgICAgICAgJyAgICAg
ICAgfScsCkBAIC00Miw2ICs0NCw4IEBAIGRlZiBnZW5lcmF0ZV9oKGV2ZW50LCBncm91cCk6CiAg
ICAgICAgIG5hbWU9ZXZlbnQubmFtZSwKICAgICAgICAgYXJncz1ldmVudC5hcmdzLAogICAgICAg
ICBldmVudF9pZD0iVFJBQ0VfIiArIGV2ZW50Lm5hbWUudXBwZXIoKSwKKyAgICAgICAgZXZlbnRf
bGluZW5vPWV2ZW50LmxpbmVubywKKyAgICAgICAgZXZlbnRfZmlsZW5hbWU9ZXZlbnQuZmlsZW5h
bWUsCiAgICAgICAgIGZtdD1ldmVudC5mbXQucnN0cmlwKCJcbiIpLAogICAgICAgICBhcmduYW1l
cz1hcmduYW1lcykKIApkaWZmIC0tZ2l0IGEvc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9sb2cu
cHkgYi9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2xvZy5weQppbmRleCA4NzcyMjJiYmU5Li5i
YzQzZGJiNGY0IDEwMDY0NAotLS0gYS9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2xvZy5weQor
KysgYi9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2xvZy5weQpAQCAtMzcsMTIgKzM3LDE2IEBA
IGRlZiBnZW5lcmF0ZV9oKGV2ZW50LCBncm91cCk6CiAgICAgb3V0KCcgICAgaWYgKCUoY29uZClz
ICYmIHFlbXVfbG9nbGV2ZWxfbWFzayhMT0dfVFJBQ0UpKSB7JywKICAgICAgICAgJyAgICAgICAg
c3RydWN0IHRpbWV2YWwgX25vdzsnLAogICAgICAgICAnICAgICAgICBnZXR0aW1lb2ZkYXkoJl9u
b3csIE5VTEwpOycsCisgICAgICAgICcjbGluZSAlKGV2ZW50X2xpbmVubylkICIlKGV2ZW50X2Zp
bGVuYW1lKXMiJywKICAgICAgICAgJyAgICAgICAgcWVtdV9sb2coIiUlZEAlJXp1LiUlMDZ6dTol
KG5hbWUpcyAiICUoZm10KXMgIlxcbiIsJywKICAgICAgICAgJyAgICAgICAgICAgICAgICAgcWVt
dV9nZXRfdGhyZWFkX2lkKCksJywKICAgICAgICAgJyAgICAgICAgICAgICAgICAgKHNpemVfdClf
bm93LnR2X3NlYywgKHNpemVfdClfbm93LnR2X3VzZWMnLAogICAgICAgICAnICAgICAgICAgICAg
ICAgICAlKGFyZ25hbWVzKXMpOycsCisgICAgICAgICcjbGluZSAlKG91dF9uZXh0X2xpbmVubylk
ICIlKG91dF9maWxlbmFtZSlzIicsCiAgICAgICAgICcgICAgfScsCiAgICAgICAgIGNvbmQ9Y29u
ZCwKKyAgICAgICAgZXZlbnRfbGluZW5vPWV2ZW50LmxpbmVubywKKyAgICAgICAgZXZlbnRfZmls
ZW5hbWU9ZXZlbnQuZmlsZW5hbWUsCiAgICAgICAgIG5hbWU9ZXZlbnQubmFtZSwKICAgICAgICAg
Zm10PWV2ZW50LmZtdC5yc3RyaXAoIlxuIiksCiAgICAgICAgIGFyZ25hbWVzPWFyZ25hbWVzKQpk
aWZmIC0tZ2l0IGEvc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9zeXNsb2cucHkgYi9zY3JpcHRz
L3RyYWNldG9vbC9iYWNrZW5kL3N5c2xvZy5weQppbmRleCAxMzczYTkwMTkyLi41YTNhMDBmZTMx
IDEwMDY0NAotLS0gYS9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL3N5c2xvZy5weQorKysgYi9z
Y3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL3N5c2xvZy5weQpAQCAtMzUsOSArMzUsMTMgQEAgZGVm
IGdlbmVyYXRlX2goZXZlbnQsIGdyb3VwKToKICAgICAgICAgY29uZCA9ICJ0cmFjZV9ldmVudF9n
ZXRfc3RhdGUoJXMpIiAlICgiVFJBQ0VfIiArIGV2ZW50Lm5hbWUudXBwZXIoKSkKIAogICAgIG91
dCgnICAgIGlmICglKGNvbmQpcykgeycsCisgICAgICAgICcjbGluZSAlKGV2ZW50X2xpbmVubylk
ICIlKGV2ZW50X2ZpbGVuYW1lKXMiJywKICAgICAgICAgJyAgICAgICAgc3lzbG9nKExPR19JTkZP
LCAiJShuYW1lKXMgIiAlKGZtdClzICUoYXJnbmFtZXMpcyk7JywKKyAgICAgICAgJyNsaW5lICUo
b3V0X25leHRfbGluZW5vKWQgIiUob3V0X2ZpbGVuYW1lKXMiJywKICAgICAgICAgJyAgICB9JywK
ICAgICAgICAgY29uZD1jb25kLAorICAgICAgICBldmVudF9saW5lbm89ZXZlbnQubGluZW5vLAor
ICAgICAgICBldmVudF9maWxlbmFtZT1ldmVudC5maWxlbmFtZSwKICAgICAgICAgbmFtZT1ldmVu
dC5uYW1lLAogICAgICAgICBmbXQ9ZXZlbnQuZm10LnJzdHJpcCgiXG4iKSwKICAgICAgICAgYXJn
bmFtZXM9YXJnbmFtZXMpCi0tIAoyLjI2LjIKCg==


