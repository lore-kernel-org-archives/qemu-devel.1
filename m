Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6593A20870
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcqeeAf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6593A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2yw-00035L-Dj
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zt-0005An-R2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zr-0004IP-Qn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLOaqtj2fmEtHdFpuTk5bMUif77+ghpGyaaaVX0TGMc=;
 b=HcqeeAf37xaxbXZXRXJJq5uorkxkOck6/mSS/8Wu58fAZY/v1+clKSf6cCk8MfGvNNkLzH
 BqFoK4UYMaxTvV3E3LkpUX+j1a7W/+J2xmtDxz0BL5aoQTXLxiT1syVGLwQa0NhDTpf1jM
 jw4kTsQFbXiv25V7k6lFmoyyVtudgf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-8K53_xWGPg2Ti-8wdkP7yQ-1; Mon, 12 Oct 2020 14:29:40 -0400
X-MC-Unique: 8K53_xWGPg2Ti-8wdkP7yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B49427F8;
 Mon, 12 Oct 2020 18:29:39 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECC985C706;
 Mon, 12 Oct 2020 18:29:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 25/30] tests/qtest: add multi-queue test case to
 vhost-user-blk-test
Date: Mon, 12 Oct 2020 19:27:55 +0100
Message-Id: <20201012182800.157697-26-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNz
YWdlLWlkOiAyMDIwMTAwMTE0NDYwNC41NTk3MzMtMy1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0
cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMgfCA4MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMgYi90ZXN0
cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMKaW5kZXggNDJlNGNmZGU4Mi4uYjlmMzUxOTFk
ZiAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jCisrKyBiL3Rl
c3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYwpAQCAtNTU5LDYgKzU1OSw2NyBAQCBzdGF0
aWMgdm9pZCBwY2lfaG90cGx1Zyh2b2lkICpvYmosIHZvaWQgKmRhdGEsIFFHdWVzdEFsbG9jYXRv
ciAqdF9hbGxvYykKICAgICBxcGNpX3VucGx1Z19hY3BpX2RldmljZV90ZXN0KHF0cywgImRydjEi
LCBQQ0lfU0xPVF9IUCk7CiB9CiAKK3N0YXRpYyB2b2lkIG11bHRpcXVldWUodm9pZCAqb2JqLCB2
b2lkICpkYXRhLCBRR3Vlc3RBbGxvY2F0b3IgKnRfYWxsb2MpCit7CisgICAgUVZpcnRpb1BDSURl
dmljZSAqcGRldjEgPSBvYmo7CisgICAgUVZpcnRpb0RldmljZSAqZGV2MSA9ICZwZGV2MS0+dmRl
djsKKyAgICBRVmlydGlvUENJRGV2aWNlICpwZGV2ODsKKyAgICBRVmlydGlvRGV2aWNlICpkZXY4
OworICAgIFFUZXN0U3RhdGUgKnF0cyA9IHBkZXYxLT5wZGV2LT5idXMtPnF0czsKKyAgICB1aW50
NjRfdCBmZWF0dXJlczsKKyAgICB1aW50MTZfdCBudW1fcXVldWVzOworCisgICAgLyoKKyAgICAg
KiBUaGUgcHJpbWFyeSBkZXZpY2UgaGFzIDEgcXVldWUgYW5kIFZJUlRJT19CTEtfRl9NUSBpcyBu
b3QgZW5hYmxlZC4gVGhlCisgICAgICogVklSVElPIHNwZWNpZmljYXRpb24gYWxsb3dzIFZJUlRJ
T19CTEtfRl9NUSB0byBiZSBlbmFibGVkIHdoZW4gdGhlcmUgaXMKKyAgICAgKiBvbmx5IDEgdmly
dHF1ZXVlLCBidXQgLS1kZXZpY2Ugdmhvc3QtdXNlci1ibGstcGNpIGRvZXNuJ3QgZG8gdGhpcyAo
d2hpY2gKKyAgICAgKiBpcyBhbHNvIHNwZWMtY29tcGxpYW50KS4KKyAgICAgKi8KKyAgICBmZWF0
dXJlcyA9IHF2aXJ0aW9fZ2V0X2ZlYXR1cmVzKGRldjEpOworICAgIGdfYXNzZXJ0X2NtcGludChm
ZWF0dXJlcyAmICgxdSA8PCBWSVJUSU9fQkxLX0ZfTVEpLCA9PSwgMCk7CisgICAgZmVhdHVyZXMg
PSBmZWF0dXJlcyAmIH4oUVZJUlRJT19GX0JBRF9GRUFUVVJFIHwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoMXUgPDwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSB8CisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKDF1IDw8IFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSkgfAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICgxdSA8PCBWSVJUSU9fQkxLX0ZfU0NTSSkpOwor
ICAgIHF2aXJ0aW9fc2V0X2ZlYXR1cmVzKGRldjEsIGZlYXR1cmVzKTsKKworICAgIC8qIEhvdHBs
dWcgYSBzZWNvbmRhcnkgZGV2aWNlIHdpdGggOCBxdWV1ZXMgKi8KKyAgICBxdGVzdF9xbXBfZGV2
aWNlX2FkZChxdHMsICJ2aG9zdC11c2VyLWJsay1wY2kiLCAiZHJ2MSIsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgInsnYWRkcic6ICVzLCAnY2hhcmRldic6ICdjaGFyMicsICdudW0tcXVldWVz
JzogOH0iLAorICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmluZ2lmeShQQ0lfU0xPVF9IUCkg
Ii4wIik7CisKKyAgICBwZGV2OCA9IHZpcnRpb19wY2lfbmV3KHBkZXYxLT5wZGV2LT5idXMsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmKFFQQ0lBZGRyZXNzKSB7CisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLmRldmZuID0gUVBDSV9ERVZGTihQQ0lfU0xPVF9IUCwgMCkKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH0pOworICAgIGdfYXNzZXJ0X25vbm51bGwocGRldjgp
OworICAgIGdfYXNzZXJ0X2NtcGludChwZGV2OC0+dmRldi5kZXZpY2VfdHlwZSwgPT0sIFZJUlRJ
T19JRF9CTE9DSyk7CisKKyAgICBxb3Nfb2JqZWN0X3N0YXJ0X2h3KCZwZGV2OC0+b2JqKTsKKwor
ICAgIGRldjggPSAmcGRldjgtPnZkZXY7CisgICAgZmVhdHVyZXMgPSBxdmlydGlvX2dldF9mZWF0
dXJlcyhkZXY4KTsKKyAgICBnX2Fzc2VydF9jbXBpbnQoZmVhdHVyZXMgJiAoMXUgPDwgVklSVElP
X0JMS19GX01RKSwKKyAgICAgICAgICAgICAgICAgICAgPT0sCisgICAgICAgICAgICAgICAgICAg
ICgxdSA8PCBWSVJUSU9fQkxLX0ZfTVEpKTsKKyAgICBmZWF0dXJlcyA9IGZlYXR1cmVzICYgfihR
VklSVElPX0ZfQkFEX0ZFQVRVUkUgfAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICgxdSA8
PCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpIHwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAoMXUgPDwgVklSVElPX0ZfTk9USUZZX09OX0VNUFRZKSB8CisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKDF1IDw8IFZJUlRJT19CTEtfRl9TQ1NJKSB8CisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKDF1IDw8IFZJUlRJT19CTEtfRl9NUSkpOworICAgIHF2aXJ0aW9fc2V0X2Zl
YXR1cmVzKGRldjgsIGZlYXR1cmVzKTsKKworICAgIG51bV9xdWV1ZXMgPSBxdmlydGlvX2NvbmZp
Z19yZWFkdyhkZXY4LAorICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19ibGtfY29u
ZmlnLCBudW1fcXVldWVzKSk7CisgICAgZ19hc3NlcnRfY21waW50KG51bV9xdWV1ZXMsID09LCA4
KTsKKworICAgIHF2aXJ0aW9fcGNpX2RldmljZV9kaXNhYmxlKHBkZXY4KTsKKyAgICBxb3Nfb2Jq
ZWN0X2Rlc3Ryb3koJnBkZXY4LT5vYmopOworCisgICAgLyogdW5wbHVnIHNlY29uZGFyeSBkaXNr
ICovCisgICAgcXBjaV91bnBsdWdfYWNwaV9kZXZpY2VfdGVzdChxdHMsICJkcnYxIiwgUENJX1NM
T1RfSFApOworfQorCiAvKgogICogQ2hlY2sgdGhhdCBzZXR0aW5nIHRoZSB2cmluZyBhZGRyIG9u
IGEgbm9uLWV4aXN0ZW50IHZpcnRxdWV1ZSBkb2VzCiAgKiBub3QgY3Jhc2guCkBAIC02NDMsNyAr
NzA0LDggQEAgc3RhdGljIHZvaWQgcXVpdF9zdG9yYWdlX2RhZW1vbih2b2lkICpxbXBfdGVzdF9z
dGF0ZSkKICAgICBnX2ZyZWUocW1wX3Rlc3Rfc3RhdGUpOwogfQogCi1zdGF0aWMgY2hhciAqc3Rh
cnRfdmhvc3RfdXNlcl9ibGsoR1N0cmluZyAqY21kX2xpbmUsIGludCB2dXNfaW5zdGFuY2VzKQor
c3RhdGljIGNoYXIgKnN0YXJ0X3Zob3N0X3VzZXJfYmxrKEdTdHJpbmcgKmNtZF9saW5lLCBpbnQg
dnVzX2luc3RhbmNlcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnVt
X3F1ZXVlcykKIHsKICAgICBjb25zdCBjaGFyICp2aG9zdF91c2VyX2Jsa19iaW4gPSBxdGVzdF9x
ZW11X3N0b3JhZ2VfZGFlbW9uX2JpbmFyeSgpOwogICAgIGludCBmZCwgcW1wX2ZkLCBpOwpAQCAt
Njc1LDggKzczNyw4IEBAIHN0YXRpYyBjaGFyICpzdGFydF92aG9zdF91c2VyX2JsayhHU3RyaW5n
ICpjbWRfbGluZSwgaW50IHZ1c19pbnN0YW5jZXMpCiAgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9w
cmludGYoc3RvcmFnZV9kYWVtb25fY29tbWFuZCwKICAgICAgICAgICAgICItLWJsb2NrZGV2IGRy
aXZlcj1maWxlLG5vZGUtbmFtZT1kaXNrJWQsZmlsZW5hbWU9JXMgIgogICAgICAgICAgICAgIi0t
ZXhwb3J0IHR5cGU9dmhvc3QtdXNlci1ibGssaWQ9ZGlzayVkLGFkZHIudHlwZT11bml4LGFkZHIu
cGF0aD0lcywiCi0gICAgICAgICAgICAibm9kZS1uYW1lPWRpc2slaSx3cml0YWJsZT1vbiAiLAot
ICAgICAgICAgICAgaSwgaW1nX3BhdGgsIGksIHNvY2tfcGF0aCwgaSk7CisgICAgICAgICAgICAi
bm9kZS1uYW1lPWRpc2slaSx3cml0YWJsZT1vbixudW0tcXVldWVzPSVkICIsCisgICAgICAgICAg
ICBpLCBpbWdfcGF0aCwgaSwgc29ja19wYXRoLCBpLCBudW1fcXVldWVzKTsKIAogICAgICAgICBn
X3N0cmluZ19hcHBlbmRfcHJpbnRmKGNtZF9saW5lLCAiLWNoYXJkZXYgc29ja2V0LGlkPWNoYXIl
ZCxwYXRoPSVzICIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSArIDEsIHNvY2tf
cGF0aCk7CkBAIC03MDUsNyArNzY3LDcgQEAgc3RhdGljIGNoYXIgKnN0YXJ0X3Zob3N0X3VzZXJf
YmxrKEdTdHJpbmcgKmNtZF9saW5lLCBpbnQgdnVzX2luc3RhbmNlcykKIAogc3RhdGljIHZvaWQg
KnZob3N0X3VzZXJfYmxrX3Rlc3Rfc2V0dXAoR1N0cmluZyAqY21kX2xpbmUsIHZvaWQgKmFyZykK
IHsKLSAgICBzdGFydF92aG9zdF91c2VyX2JsayhjbWRfbGluZSwgMSk7CisgICAgc3RhcnRfdmhv
c3RfdXNlcl9ibGsoY21kX2xpbmUsIDEsIDEpOwogICAgIHJldHVybiBhcmc7CiB9CiAKQEAgLTcx
OSw3ICs3ODEsMTMgQEAgc3RhdGljIHZvaWQgKnZob3N0X3VzZXJfYmxrX3Rlc3Rfc2V0dXAoR1N0
cmluZyAqY21kX2xpbmUsIHZvaWQgKmFyZykKIHN0YXRpYyB2b2lkICp2aG9zdF91c2VyX2Jsa19o
b3RwbHVnX3Rlc3Rfc2V0dXAoR1N0cmluZyAqY21kX2xpbmUsIHZvaWQgKmFyZykKIHsKICAgICAv
KiAiLWNoYXJkZXYgc29ja2V0LGlkPWNoYXIyIiBpcyB1c2VkIGZvciBwY2lfaG90cGx1ZyovCi0g
ICAgc3RhcnRfdmhvc3RfdXNlcl9ibGsoY21kX2xpbmUsIDIpOworICAgIHN0YXJ0X3Zob3N0X3Vz
ZXJfYmxrKGNtZF9saW5lLCAyLCAxKTsKKyAgICByZXR1cm4gYXJnOworfQorCitzdGF0aWMgdm9p
ZCAqdmhvc3RfdXNlcl9ibGtfbXVsdGlxdWV1ZV90ZXN0X3NldHVwKEdTdHJpbmcgKmNtZF9saW5l
LCB2b2lkICphcmcpCit7CisgICAgc3RhcnRfdmhvc3RfdXNlcl9ibGsoY21kX2xpbmUsIDIsIDgp
OwogICAgIHJldHVybiBhcmc7CiB9CiAKQEAgLTc0Niw2ICs4MTQsOSBAQCBzdGF0aWMgdm9pZCBy
ZWdpc3Rlcl92aG9zdF91c2VyX2Jsa190ZXN0KHZvaWQpCiAKICAgICBvcHRzLmJlZm9yZSA9IHZo
b3N0X3VzZXJfYmxrX2hvdHBsdWdfdGVzdF9zZXR1cDsKICAgICBxb3NfYWRkX3Rlc3QoImhvdHBs
dWciLCAidmhvc3QtdXNlci1ibGstcGNpIiwgcGNpX2hvdHBsdWcsICZvcHRzKTsKKworICAgIG9w
dHMuYmVmb3JlID0gdmhvc3RfdXNlcl9ibGtfbXVsdGlxdWV1ZV90ZXN0X3NldHVwOworICAgIHFv
c19hZGRfdGVzdCgibXVsdGlxdWV1ZSIsICJ2aG9zdC11c2VyLWJsay1wY2kiLCBtdWx0aXF1ZXVl
LCAmb3B0cyk7CiB9CiAKIGxpYnFvc19pbml0KHJlZ2lzdGVyX3Zob3N0X3VzZXJfYmxrX3Rlc3Qp
OwotLSAKMi4yNi4yCgo=


