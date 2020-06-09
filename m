Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F02C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1043C20801
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxTLnpi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043C20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii47-0001Di-3F
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jiheT-00043o-UA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jiheS-0007Xq-Jd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAnKvQtas0Df8i94IWZGQbelkFtafrMMwgZzKd+IpYY=;
 b=WxTLnpi7e335hX0Y5l3aS42DSwTRpAYBjagBD91JwvvbHbaH/ZwRxXEmdUgCvAa3L/9VzM
 b1sF5Hczg2tZh8nhcOMepxhFbJPejaq6SGJK4taUmssXk9VtJLDcf4XV6bjd2kdZTYhkvA
 7Shom+ZbFGmlXxqc9q5DEuxKmtEXyIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-I8TtLYdsONi7m_tEhKieMA-1; Tue, 09 Jun 2020 13:02:58 -0400
X-MC-Unique: I8TtLYdsONi7m_tEhKieMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FDC4107ACCD;
 Tue,  9 Jun 2020 17:02:57 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 758F560C87;
 Tue,  9 Jun 2020 17:02:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] libvhost-user: advertise vring features
Date: Tue,  9 Jun 2020 18:02:13 +0100
Message-Id: <20200609170218.246468-3-stefanha@redhat.com>
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bGlidmhvc3QtdXNlciBpbXBsZW1lbnRzIHNldmVyYWwgdnJpbmcgZmVhdHVyZXMgd2l0aG91dCBh
ZHZlcnRpc2luZwp0aGVtLiBUaGVyZSBpcyBubyB3YXkgZm9yIHRoZSB2aG9zdC11c2VyIG1hc3Rl
ciB0byBkZXRlY3Qgc3VwcG9ydCBmb3IKdGhlc2UgZmVhdHVyZXMuCgpUaGluZ3MgbW9yZSBvciBs
ZXNzIHdvcmsgdG9kYXkgYmVjYXVzZSBRRU1VIGFzc3VtZXMgdGhlIHZob3N0LXVzZXIKYmFja2Vu
ZCBhbHdheXMgaW1wbGVtZW50cyBjZXJ0YWluIGZlYXR1cmUgYml0cyBsaWtlClZJUlRJT19SSU5H
X0ZfRVZFTlRfSURYLiBUaGlzIGlzIG5vdCBkb2N1bWVudGVkIGFueXdoZXJlLgoKVGhpcyBwYXRj
aCBleHBsaWNpdGx5IGFkdmVydGlzZXMgZmVhdHVyZXMgaW1wbGVtZW50ZWQgaW4gbGlidmhvc3Qt
dXNlcgpzbyB0aGF0IHRoZSB2aG9zdC11c2VyIG1hc3RlciBkb2VzIG5vdCBuZWVkIHRvIG1ha2Ug
dW5kb2N1bWVudGVkCmFzc3VtcHRpb25zLgoKRmVhdHVyZSBiaXRzIHRoYXQgbGlidmhvc3QtdXNl
ciBub3cgYWR2ZXJ0aXNlcyBjYW4gYmUgcmVtb3ZlZCBmcm9tCnZob3N0LXVzZXItYmxrLmMuIERl
dmljZXMgc2hvdWxkIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgYWR2ZXJ0aXNpbmcKdnJpbmcgZmVh
dHVyZSBiaXRzLCB0aGF0IGlzIGxpYnZob3N0LXVzZXIncyBqb2IuCgpDYzogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
UmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQu
Y29tPgotLS0KSSBoYXZlIHRlc3RlZCBtYWtlIGNoZWNrIGFuZCB2aXJ0aW9mc2QuCi0tLQogY29u
dHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYyAgIHwgMTAgKysrKysrKysrKwogY29u
dHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jIHwgIDQgKy0tLQogMiBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Nv
bnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMgYi9jb250cmliL2xpYnZob3N0LXVz
ZXIvbGlidmhvc3QtdXNlci5jCmluZGV4IDNiY2E5OTZjNjIuLmI0Mzg3NGJhMTIgMTAwNjQ0Ci0t
LSBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMKKysrIGIvY29udHJpYi9s
aWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYwpAQCAtNDk1LDYgKzQ5NSwxNiBAQCBzdGF0aWMg
Ym9vbAogdnVfZ2V0X2ZlYXR1cmVzX2V4ZWMoVnVEZXYgKmRldiwgVmhvc3RVc2VyTXNnICp2bXNn
KQogewogICAgIHZtc2ctPnBheWxvYWQudTY0ID0KKyAgICAgICAgLyoKKyAgICAgICAgICogVGhl
IGZvbGxvd2luZyBWSVJUSU8gZmVhdHVyZSBiaXRzIGFyZSBzdXBwb3J0ZWQgYnkgb3VyIHZpcnRx
dWV1ZQorICAgICAgICAgKiBpbXBsZW1lbnRhdGlvbjoKKyAgICAgICAgICovCisgICAgICAgIDFV
TEwgPDwgVklSVElPX0ZfTk9USUZZX09OX0VNUFRZIHwKKyAgICAgICAgMVVMTCA8PCBWSVJUSU9f
UklOR19GX0lORElSRUNUX0RFU0MgfAorICAgICAgICAxVUxMIDw8IFZJUlRJT19SSU5HX0ZfRVZF
TlRfSURYIHwKKyAgICAgICAgMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEgfAorCisgICAgICAg
IC8qIHZob3N0LXVzZXIgZmVhdHVyZSBiaXRzICovCiAgICAgICAgIDFVTEwgPDwgVkhPU1RfRl9M
T0dfQUxMIHwKICAgICAgICAgMVVMTCA8PCBWSE9TVF9VU0VSX0ZfUFJPVE9DT0xfRkVBVFVSRVM7
CiAKZGlmZiAtLWdpdCBhL2NvbnRyaWIvdmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYyBi
L2NvbnRyaWIvdmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYwppbmRleCA2ZmQ5MWM3ZTk5
Li4yNWVjY2QwMmI1IDEwMDY0NAotLS0gYS9jb250cmliL3Zob3N0LXVzZXItYmxrL3Zob3N0LXVz
ZXItYmxrLmMKKysrIGIvY29udHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jCkBA
IC0zODIsOSArMzgyLDcgQEAgdnViX2dldF9mZWF0dXJlcyhWdURldiAqZGV2KQogICAgICAgICAg
ICAgICAgMXVsbCA8PCBWSVJUSU9fQkxLX0ZfRElTQ0FSRCB8CiAgICAgICAgICAgICAgICAxdWxs
IDw8IFZJUlRJT19CTEtfRl9XUklURV9aRVJPRVMgfAogICAgICAgICAgICAgICAgI2VuZGlmCi0g
ICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19CTEtfRl9DT05GSUdfV0NFIHwKLSAgICAgICAg
ICAgICAgIDF1bGwgPDwgVklSVElPX0ZfVkVSU0lPTl8xIHwKLSAgICAgICAgICAgICAgIDF1bGwg
PDwgVkhPU1RfVVNFUl9GX1BST1RPQ09MX0ZFQVRVUkVTOworICAgICAgICAgICAgICAgMXVsbCA8
PCBWSVJUSU9fQkxLX0ZfQ09ORklHX1dDRTsKIAogICAgIGlmICh2ZGV2X2Jsay0+ZW5hYmxlX3Jv
KSB7CiAgICAgICAgIGZlYXR1cmVzIHw9IDF1bGwgPDwgVklSVElPX0JMS19GX1JPOwotLSAKMi4y
Ni4yCgo=


