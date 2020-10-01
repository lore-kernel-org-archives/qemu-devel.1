Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA2C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7D720780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvXh18+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzvd-0008Mf-TZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNzqf-0003cK-57
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNzqa-0002na-VM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x/nbakShkzgwIP/VVafX/Z5rKUQkqjP+26ILyWoe1o=;
 b=QvXh18+gTkKN1G//tGmxzYQW0zJurQRNEaviGjmipqTjTLZDAYlUHKaVbQ5eAuADK2lapr
 Cbjob7kAlfDkJjEw134+8EWei2paiasBOniNC3lADp5EI/RwAW+AKj0fmJzhtifa8mRPnf
 8vVxjiLkFFQGs5JZG5EBAZmh1Yr5tDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-0GWizxhMNk2rF2jKUiXg0w-1; Thu, 01 Oct 2020 10:46:14 -0400
X-MC-Unique: 0GWizxhMNk2rF2jKUiXg0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B24FB108E1C7;
 Thu,  1 Oct 2020 14:46:11 +0000 (UTC)
Received: from localhost (ovpn-115-144.ams2.redhat.com [10.36.115.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44E9D19C78;
 Thu,  1 Oct 2020 14:46:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/qtest: add multi-queue test case to
 vhost-user-blk-test
Date: Thu,  1 Oct 2020 15:46:04 +0100
Message-Id: <20201001144604.559733-3-stefanha@redhat.com>
In-Reply-To: <20201001144604.559733-1-stefanha@redhat.com>
References: <20201001144604.559733-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYyB8IDgxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYyBi
L3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYwppbmRleCA0MmU0Y2ZkZTgyLi5iOWYz
NTE5MWRmIDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMKKysr
IGIvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jCkBAIC01NTksNiArNTU5LDY3IEBA
IHN0YXRpYyB2b2lkIHBjaV9ob3RwbHVnKHZvaWQgKm9iaiwgdm9pZCAqZGF0YSwgUUd1ZXN0QWxs
b2NhdG9yICp0X2FsbG9jKQogICAgIHFwY2lfdW5wbHVnX2FjcGlfZGV2aWNlX3Rlc3QocXRzLCAi
ZHJ2MSIsIFBDSV9TTE9UX0hQKTsKIH0KIAorc3RhdGljIHZvaWQgbXVsdGlxdWV1ZSh2b2lkICpv
YmosIHZvaWQgKmRhdGEsIFFHdWVzdEFsbG9jYXRvciAqdF9hbGxvYykKK3sKKyAgICBRVmlydGlv
UENJRGV2aWNlICpwZGV2MSA9IG9iajsKKyAgICBRVmlydGlvRGV2aWNlICpkZXYxID0gJnBkZXYx
LT52ZGV2OworICAgIFFWaXJ0aW9QQ0lEZXZpY2UgKnBkZXY4OworICAgIFFWaXJ0aW9EZXZpY2Ug
KmRldjg7CisgICAgUVRlc3RTdGF0ZSAqcXRzID0gcGRldjEtPnBkZXYtPmJ1cy0+cXRzOworICAg
IHVpbnQ2NF90IGZlYXR1cmVzOworICAgIHVpbnQxNl90IG51bV9xdWV1ZXM7CisKKyAgICAvKgor
ICAgICAqIFRoZSBwcmltYXJ5IGRldmljZSBoYXMgMSBxdWV1ZSBhbmQgVklSVElPX0JMS19GX01R
IGlzIG5vdCBlbmFibGVkLiBUaGUKKyAgICAgKiBWSVJUSU8gc3BlY2lmaWNhdGlvbiBhbGxvd3Mg
VklSVElPX0JMS19GX01RIHRvIGJlIGVuYWJsZWQgd2hlbiB0aGVyZSBpcworICAgICAqIG9ubHkg
MSB2aXJ0cXVldWUsIGJ1dCAtLWRldmljZSB2aG9zdC11c2VyLWJsay1wY2kgZG9lc24ndCBkbyB0
aGlzICh3aGljaAorICAgICAqIGlzIGFsc28gc3BlYy1jb21wbGlhbnQpLgorICAgICAqLworICAg
IGZlYXR1cmVzID0gcXZpcnRpb19nZXRfZmVhdHVyZXMoZGV2MSk7CisgICAgZ19hc3NlcnRfY21w
aW50KGZlYXR1cmVzICYgKDF1IDw8IFZJUlRJT19CTEtfRl9NUSksID09LCAwKTsKKyAgICBmZWF0
dXJlcyA9IGZlYXR1cmVzICYgfihRVklSVElPX0ZfQkFEX0ZFQVRVUkUgfAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICgxdSA8PCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpIHwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAoMXUgPDwgVklSVElPX0ZfTk9USUZZX09OX0VNUFRZ
KSB8CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDF1IDw8IFZJUlRJT19CTEtfRl9TQ1NJ
KSk7CisgICAgcXZpcnRpb19zZXRfZmVhdHVyZXMoZGV2MSwgZmVhdHVyZXMpOworCisgICAgLyog
SG90cGx1ZyBhIHNlY29uZGFyeSBkZXZpY2Ugd2l0aCA4IHF1ZXVlcyAqLworICAgIHF0ZXN0X3Ft
cF9kZXZpY2VfYWRkKHF0cywgInZob3N0LXVzZXItYmxrLXBjaSIsICJkcnYxIiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAieydhZGRyJzogJXMsICdjaGFyZGV2JzogJ2NoYXIyJywgJ251bS1x
dWV1ZXMnOiA4fSIsCisgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaW5naWZ5KFBDSV9TTE9U
X0hQKSAiLjAiKTsKKworICAgIHBkZXY4ID0gdmlydGlvX3BjaV9uZXcocGRldjEtPnBkZXYtPmJ1
cywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICYoUVBDSUFkZHJlc3MpIHsKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAuZGV2Zm4gPSBRUENJX0RFVkZOKFBDSV9TTE9UX0hQLCAw
KQorICAgICAgICAgICAgICAgICAgICAgICAgICAgfSk7CisgICAgZ19hc3NlcnRfbm9ubnVsbChw
ZGV2OCk7CisgICAgZ19hc3NlcnRfY21waW50KHBkZXY4LT52ZGV2LmRldmljZV90eXBlLCA9PSwg
VklSVElPX0lEX0JMT0NLKTsKKworICAgIHFvc19vYmplY3Rfc3RhcnRfaHcoJnBkZXY4LT5vYmop
OworCisgICAgZGV2OCA9ICZwZGV2OC0+dmRldjsKKyAgICBmZWF0dXJlcyA9IHF2aXJ0aW9fZ2V0
X2ZlYXR1cmVzKGRldjgpOworICAgIGdfYXNzZXJ0X2NtcGludChmZWF0dXJlcyAmICgxdSA8PCBW
SVJUSU9fQkxLX0ZfTVEpLAorICAgICAgICAgICAgICAgICAgICA9PSwKKyAgICAgICAgICAgICAg
ICAgICAgKDF1IDw8IFZJUlRJT19CTEtfRl9NUSkpOworICAgIGZlYXR1cmVzID0gZmVhdHVyZXMg
JiB+KFFWSVJUSU9fRl9CQURfRkVBVFVSRSB8CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KDF1IDw8IFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykgfAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICgxdSA8PCBWSVJUSU9fRl9OT1RJRllfT05fRU1QVFkpIHwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoMXUgPDwgVklSVElPX0JMS19GX1NDU0kpIHwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoMXUgPDwgVklSVElPX0JMS19GX01RKSk7CisgICAgcXZpcnRpb19z
ZXRfZmVhdHVyZXMoZGV2OCwgZmVhdHVyZXMpOworCisgICAgbnVtX3F1ZXVlcyA9IHF2aXJ0aW9f
Y29uZmlnX3JlYWR3KGRldjgsCisgICAgICAgICAgICBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX2Js
a19jb25maWcsIG51bV9xdWV1ZXMpKTsKKyAgICBnX2Fzc2VydF9jbXBpbnQobnVtX3F1ZXVlcywg
PT0sIDgpOworCisgICAgcXZpcnRpb19wY2lfZGV2aWNlX2Rpc2FibGUocGRldjgpOworICAgIHFv
c19vYmplY3RfZGVzdHJveSgmcGRldjgtPm9iaik7CisKKyAgICAvKiB1bnBsdWcgc2Vjb25kYXJ5
IGRpc2sgKi8KKyAgICBxcGNpX3VucGx1Z19hY3BpX2RldmljZV90ZXN0KHF0cywgImRydjEiLCBQ
Q0lfU0xPVF9IUCk7Cit9CisKIC8qCiAgKiBDaGVjayB0aGF0IHNldHRpbmcgdGhlIHZyaW5nIGFk
ZHIgb24gYSBub24tZXhpc3RlbnQgdmlydHF1ZXVlIGRvZXMKICAqIG5vdCBjcmFzaC4KQEAgLTY0
Myw3ICs3MDQsOCBAQCBzdGF0aWMgdm9pZCBxdWl0X3N0b3JhZ2VfZGFlbW9uKHZvaWQgKnFtcF90
ZXN0X3N0YXRlKQogICAgIGdfZnJlZShxbXBfdGVzdF9zdGF0ZSk7CiB9CiAKLXN0YXRpYyBjaGFy
ICpzdGFydF92aG9zdF91c2VyX2JsayhHU3RyaW5nICpjbWRfbGluZSwgaW50IHZ1c19pbnN0YW5j
ZXMpCitzdGF0aWMgY2hhciAqc3RhcnRfdmhvc3RfdXNlcl9ibGsoR1N0cmluZyAqY21kX2xpbmUs
IGludCB2dXNfaW5zdGFuY2VzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dCBudW1fcXVldWVzKQogewogICAgIGNvbnN0IGNoYXIgKnZob3N0X3VzZXJfYmxrX2JpbiA9IHF0
ZXN0X3FlbXVfc3RvcmFnZV9kYWVtb25fYmluYXJ5KCk7CiAgICAgaW50IGZkLCBxbXBfZmQsIGk7
CkBAIC02NzUsOCArNzM3LDggQEAgc3RhdGljIGNoYXIgKnN0YXJ0X3Zob3N0X3VzZXJfYmxrKEdT
dHJpbmcgKmNtZF9saW5lLCBpbnQgdnVzX2luc3RhbmNlcykKICAgICAgICAgZ19zdHJpbmdfYXBw
ZW5kX3ByaW50ZihzdG9yYWdlX2RhZW1vbl9jb21tYW5kLAogICAgICAgICAgICAgIi0tYmxvY2tk
ZXYgZHJpdmVyPWZpbGUsbm9kZS1uYW1lPWRpc2slZCxmaWxlbmFtZT0lcyAiCiAgICAgICAgICAg
ICAiLS1leHBvcnQgdHlwZT12aG9zdC11c2VyLWJsayxpZD1kaXNrJWQsYWRkci50eXBlPXVuaXgs
YWRkci5wYXRoPSVzLCIKLSAgICAgICAgICAgICJub2RlLW5hbWU9ZGlzayVpLHdyaXRhYmxlPW9u
ICIsCi0gICAgICAgICAgICBpLCBpbWdfcGF0aCwgaSwgc29ja19wYXRoLCBpKTsKKyAgICAgICAg
ICAgICJub2RlLW5hbWU9ZGlzayVpLHdyaXRhYmxlPW9uLG51bS1xdWV1ZXM9JWQgIiwKKyAgICAg
ICAgICAgIGksIGltZ19wYXRoLCBpLCBzb2NrX3BhdGgsIGksIG51bV9xdWV1ZXMpOwogCiAgICAg
ICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYoY21kX2xpbmUsICItY2hhcmRldiBzb2NrZXQsaWQ9
Y2hhciVkLHBhdGg9JXMgIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpICsgMSwg
c29ja19wYXRoKTsKQEAgLTcwNSw3ICs3NjcsNyBAQCBzdGF0aWMgY2hhciAqc3RhcnRfdmhvc3Rf
dXNlcl9ibGsoR1N0cmluZyAqY21kX2xpbmUsIGludCB2dXNfaW5zdGFuY2VzKQogCiBzdGF0aWMg
dm9pZCAqdmhvc3RfdXNlcl9ibGtfdGVzdF9zZXR1cChHU3RyaW5nICpjbWRfbGluZSwgdm9pZCAq
YXJnKQogewotICAgIHN0YXJ0X3Zob3N0X3VzZXJfYmxrKGNtZF9saW5lLCAxKTsKKyAgICBzdGFy
dF92aG9zdF91c2VyX2JsayhjbWRfbGluZSwgMSwgMSk7CiAgICAgcmV0dXJuIGFyZzsKIH0KIApA
QCAtNzE5LDcgKzc4MSwxMyBAQCBzdGF0aWMgdm9pZCAqdmhvc3RfdXNlcl9ibGtfdGVzdF9zZXR1
cChHU3RyaW5nICpjbWRfbGluZSwgdm9pZCAqYXJnKQogc3RhdGljIHZvaWQgKnZob3N0X3VzZXJf
YmxrX2hvdHBsdWdfdGVzdF9zZXR1cChHU3RyaW5nICpjbWRfbGluZSwgdm9pZCAqYXJnKQogewog
ICAgIC8qICItY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcjIiIGlzIHVzZWQgZm9yIHBjaV9ob3RwbHVn
Ki8KLSAgICBzdGFydF92aG9zdF91c2VyX2JsayhjbWRfbGluZSwgMik7CisgICAgc3RhcnRfdmhv
c3RfdXNlcl9ibGsoY21kX2xpbmUsIDIsIDEpOworICAgIHJldHVybiBhcmc7Cit9CisKK3N0YXRp
YyB2b2lkICp2aG9zdF91c2VyX2Jsa19tdWx0aXF1ZXVlX3Rlc3Rfc2V0dXAoR1N0cmluZyAqY21k
X2xpbmUsIHZvaWQgKmFyZykKK3sKKyAgICBzdGFydF92aG9zdF91c2VyX2JsayhjbWRfbGluZSwg
MiwgOCk7CiAgICAgcmV0dXJuIGFyZzsKIH0KIApAQCAtNzQ2LDYgKzgxNCw5IEBAIHN0YXRpYyB2
b2lkIHJlZ2lzdGVyX3Zob3N0X3VzZXJfYmxrX3Rlc3Qodm9pZCkKIAogICAgIG9wdHMuYmVmb3Jl
ID0gdmhvc3RfdXNlcl9ibGtfaG90cGx1Z190ZXN0X3NldHVwOwogICAgIHFvc19hZGRfdGVzdCgi
aG90cGx1ZyIsICJ2aG9zdC11c2VyLWJsay1wY2kiLCBwY2lfaG90cGx1ZywgJm9wdHMpOworCisg
ICAgb3B0cy5iZWZvcmUgPSB2aG9zdF91c2VyX2Jsa19tdWx0aXF1ZXVlX3Rlc3Rfc2V0dXA7Cisg
ICAgcW9zX2FkZF90ZXN0KCJtdWx0aXF1ZXVlIiwgInZob3N0LXVzZXItYmxrLXBjaSIsIG11bHRp
cXVldWUsICZvcHRzKTsKIH0KIAogbGlicW9zX2luaXQocmVnaXN0ZXJfdmhvc3RfdXNlcl9ibGtf
dGVzdCk7Ci0tIAoyLjI2LjIKCg==


