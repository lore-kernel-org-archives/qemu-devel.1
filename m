Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84083C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0461620659
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5BaVpVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyi8-0001ch-S9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCy-0002hc-4d
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCr-00034T-Ur
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fc+9WPf4rwxQGzt3S+Ika49SENQOVt99IhQOzMQtiQ=;
 b=b5BaVpVnJ36UgqPcnN8DwuDUnqffSHhDKsgfDRL862808hSEEh9dYNYQmumIW7RYWyVize
 XZCY5dNXOei+dYmvSmjnRq5fFr03pX2NLbUkfJ9e0gA7V5GkqeO5xNQoRxF7oH1ANJdWYn
 Nb7mJvAtjx59oyaYDeouhKv3t27wd3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ol8sqXyWNQmevj-AZ50x-w-1; Fri, 09 Oct 2020 15:37:28 -0400
X-MC-Unique: ol8sqXyWNQmevj-AZ50x-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0C2101FFB1;
 Fri,  9 Oct 2020 19:37:27 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABF01002382;
 Fri,  9 Oct 2020 19:37:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 23/30] block/export: add iothread and fixed-iothread options
Date: Fri,  9 Oct 2020 20:35:22 +0100
Message-Id: <20201009193529.322822-24-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBzcGVjaWZ5IHRoZSBpb3RocmVhZCB3aGVyZSB0aGUgZXhwb3J0
IHdpbGwgcnVuLiBCeQpkZWZhdWx0IHRoZSBibG9jayBub2RlIGNhbiBiZSBtb3ZlZCB0byBvdGhl
ciBBaW9Db250ZXh0cyBsYXRlciBhbmQgdGhlCmV4cG9ydCB3aWxsIGZvbGxvdy4gVGhlIGZpeGVk
LWlvdGhyZWFkIG9wdGlvbiBmb3JjZXMgc3RyaWN0IGJlaGF2aW9yCnRoYXQgcHJldmVudHMgY2hh
bmdpbmcgQWlvQ29udGV4dCB3aGlsZSB0aGUgZXhwb3J0IGlzIGFjdGl2ZS4gU2VlIHRoZQpRQVBJ
IGRvY3MgZm9yIGRldGFpbHMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTI5MTI1NTE2LjE4NjcxNS01LXN0ZWZh
bmhhQHJlZGhhdC5jb20KW0ZpeCBzdHJheSAnIycgY2hhcmFjdGVyIGluIGJsb2NrLWV4cG9ydC5q
c29uIGFuZCBhZGQgbWlzc2luZyAiKHNpbmNlOgo1LjIpIiBhcyBzdWdnZXN0ZWQgYnkgRXJpYyBC
bGFrZS4KLS1TdGVmYW5dClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KLS0tCiBxYXBpL2Jsb2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgfCAx
MSArKysrKysrKysrCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAgICAgICAgICAgfCAzMSAr
KysrKysrKysrKysrKysrKysrKysrKysrKystCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGst
c2VydmVyLmMgfCAgNSArKysrLQogbmJkL3NlcnZlci5jICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgLS0KIDQgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLWV4cG9ydC5qc29uIGIvcWFwaS9ibG9jay1leHBv
cnQuanNvbgppbmRleCBhNzkzZTM0YWY5Li44YTRjZWQ4MTdmIDEwMDY0NAotLS0gYS9xYXBpL2Js
b2NrLWV4cG9ydC5qc29uCisrKyBiL3FhcGkvYmxvY2stZXhwb3J0Lmpzb24KQEAgLTIxOSwxMSAr
MjE5LDIyIEBACiAjICAgICAgICAgICAgICAgIGV4cG9ydCBiZWZvcmUgY29tcGxldGlvbiBpcyBz
aWduYWxsZWQuIChzaW5jZTogNS4yOwogIyAgICAgICAgICAgICAgICBkZWZhdWx0OiBmYWxzZSkK
ICMKKyMgQGlvdGhyZWFkOiBUaGUgbmFtZSBvZiB0aGUgaW90aHJlYWQgb2JqZWN0IHdoZXJlIHRo
ZSBleHBvcnQgd2lsbCBydW4uIFRoZQorIyAgICAgICAgICAgIGRlZmF1bHQgaXMgdG8gdXNlIHRo
ZSB0aHJlYWQgY3VycmVudGx5IGFzc29jaWF0ZWQgd2l0aCB0aGUKKyMgICAgICAgICAgICBibG9j
ayBub2RlLiAoc2luY2U6IDUuMikKKyMKKyMgQGZpeGVkLWlvdGhyZWFkOiBUcnVlIHByZXZlbnRz
IHRoZSBibG9jayBub2RlIGZyb20gYmVpbmcgbW92ZWQgdG8gYW5vdGhlcgorIyAgICAgICAgICAg
ICAgICAgIHRocmVhZCB3aGlsZSB0aGUgZXhwb3J0IGlzIGFjdGl2ZS4gSWYgdHJ1ZSBhbmQgQGlv
dGhyZWFkIGlzCisjICAgICAgICAgICAgICAgICAgZ2l2ZW4sIGV4cG9ydCBjcmVhdGlvbiBmYWls
cyBpZiB0aGUgYmxvY2sgbm9kZSBjYW5ub3QgYmUKKyMgICAgICAgICAgICAgICAgICBtb3ZlZCB0
byB0aGUgaW90aHJlYWQuIFRoZSBkZWZhdWx0IGlzIGZhbHNlLiAoc2luY2U6IDUuMikKKyMKICMg
U2luY2U6IDQuMgogIyMKIHsgJ3VuaW9uJzogJ0Jsb2NrRXhwb3J0T3B0aW9ucycsCiAgICdiYXNl
JzogeyAndHlwZSc6ICdCbG9ja0V4cG9ydFR5cGUnLAogICAgICAgICAgICAgJ2lkJzogJ3N0cics
CisJICAgICcqZml4ZWQtaW90aHJlYWQnOiAnYm9vbCcsCisJICAgICcqaW90aHJlYWQnOiAnc3Ry
JywKICAgICAgICAgICAgICdub2RlLW5hbWUnOiAnc3RyJywKICAgICAgICAgICAgICcqd3JpdGFi
bGUnOiAnYm9vbCcsCiAgICAgICAgICAgICAnKndyaXRldGhyb3VnaCc6ICdib29sJyB9LApkaWZm
IC0tZ2l0IGEvYmxvY2svZXhwb3J0L2V4cG9ydC5jIGIvYmxvY2svZXhwb3J0L2V4cG9ydC5jCmlu
ZGV4IDU1MDg5N2UyMzYuLmE1YjZiMDI3MDMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2V4cG9ydC9leHBv
cnQuYworKysgYi9ibG9jay9leHBvcnQvZXhwb3J0LmMKQEAgLTE1LDYgKzE1LDcgQEAKIAogI2lu
Y2x1ZGUgImJsb2NrL2Jsb2NrLmgiCiAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCIK
KyNpbmNsdWRlICJzeXNlbXUvaW90aHJlYWQuaCIKICNpbmNsdWRlICJibG9jay9leHBvcnQuaCIK
ICNpbmNsdWRlICJibG9jay9uYmQuaCIKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCkBAIC02Mywx
MCArNjQsMTEgQEAgc3RhdGljIGNvbnN0IEJsb2NrRXhwb3J0RHJpdmVyICpibGtfZXhwX2ZpbmRf
ZHJpdmVyKEJsb2NrRXhwb3J0VHlwZSB0eXBlKQogCiBCbG9ja0V4cG9ydCAqYmxrX2V4cF9hZGQo
QmxvY2tFeHBvcnRPcHRpb25zICpleHBvcnQsIEVycm9yICoqZXJycCkKIHsKKyAgICBib29sIGZp
eGVkX2lvdGhyZWFkID0gZXhwb3J0LT5oYXNfZml4ZWRfaW90aHJlYWQgJiYgZXhwb3J0LT5maXhl
ZF9pb3RocmVhZDsKICAgICBjb25zdCBCbG9ja0V4cG9ydERyaXZlciAqZHJ2OwogICAgIEJsb2Nr
RXhwb3J0ICpleHAgPSBOVUxMOwogICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzOwotICAgIEJsb2Nr
QmFja2VuZCAqYmxrOworICAgIEJsb2NrQmFja2VuZCAqYmxrID0gTlVMTDsKICAgICBBaW9Db250
ZXh0ICpjdHg7CiAgICAgdWludDY0X3QgcGVybTsKICAgICBpbnQgcmV0OwpAQCAtMTAyLDYgKzEw
NCwyOCBAQCBCbG9ja0V4cG9ydCAqYmxrX2V4cF9hZGQoQmxvY2tFeHBvcnRPcHRpb25zICpleHBv
cnQsIEVycm9yICoqZXJycCkKICAgICBjdHggPSBiZHJ2X2dldF9haW9fY29udGV4dChicyk7CiAg
ICAgYWlvX2NvbnRleHRfYWNxdWlyZShjdHgpOwogCisgICAgaWYgKGV4cG9ydC0+aGFzX2lvdGhy
ZWFkKSB7CisgICAgICAgIElPVGhyZWFkICppb3RocmVhZDsKKyAgICAgICAgQWlvQ29udGV4dCAq
bmV3X2N0eDsKKworICAgICAgICBpb3RocmVhZCA9IGlvdGhyZWFkX2J5X2lkKGV4cG9ydC0+aW90
aHJlYWQpOworICAgICAgICBpZiAoIWlvdGhyZWFkKSB7CisgICAgICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJpb3RocmVhZCBcIiVzXCIgbm90IGZvdW5kIiwgZXhwb3J0LT5pb3RocmVhZCk7Cisg
ICAgICAgICAgICBnb3RvIGZhaWw7CisgICAgICAgIH0KKworICAgICAgICBuZXdfY3R4ID0gaW90
aHJlYWRfZ2V0X2Fpb19jb250ZXh0KGlvdGhyZWFkKTsKKworICAgICAgICByZXQgPSBiZHJ2X3Ry
eV9zZXRfYWlvX2NvbnRleHQoYnMsIG5ld19jdHgsIGVycnApOworICAgICAgICBpZiAocmV0ID09
IDApIHsKKyAgICAgICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2UoY3R4KTsKKyAgICAgICAgICAg
IGFpb19jb250ZXh0X2FjcXVpcmUobmV3X2N0eCk7CisgICAgICAgICAgICBjdHggPSBuZXdfY3R4
OworICAgICAgICB9IGVsc2UgaWYgKGZpeGVkX2lvdGhyZWFkKSB7CisgICAgICAgICAgICBnb3Rv
IGZhaWw7CisgICAgICAgIH0KKyAgICB9CisKICAgICAvKgogICAgICAqIEJsb2NrIGV4cG9ydHMg
YXJlIHVzZWQgZm9yIG5vbi1zaGFyZWQgc3RvcmFnZSBtaWdyYXRpb24uIE1ha2Ugc3VyZQogICAg
ICAqIHRoYXQgQkRSVl9PX0lOQUNUSVZFIGlzIGNsZWFyZWQgYW5kIHRoZSBpbWFnZSBpcyByZWFk
eSBmb3Igd3JpdGUKQEAgLTExNiw2ICsxNDAsMTEgQEAgQmxvY2tFeHBvcnQgKmJsa19leHBfYWRk
KEJsb2NrRXhwb3J0T3B0aW9ucyAqZXhwb3J0LCBFcnJvciAqKmVycnApCiAgICAgfQogCiAgICAg
YmxrID0gYmxrX25ldyhjdHgsIHBlcm0sIEJMS19QRVJNX0FMTCk7CisKKyAgICBpZiAoIWZpeGVk
X2lvdGhyZWFkKSB7CisgICAgICAgIGJsa19zZXRfYWxsb3dfYWlvX2NvbnRleHRfY2hhbmdlKGJs
aywgdHJ1ZSk7CisgICAgfQorCiAgICAgcmV0ID0gYmxrX2luc2VydF9icyhibGssIGJzLCBlcnJw
KTsKICAgICBpZiAocmV0IDwgMCkgewogICAgICAgICBnb3RvIGZhaWw7CmRpZmYgLS1naXQgYS9i
bG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgYi9ibG9jay9leHBvcnQvdmhvc3Qt
dXNlci1ibGstc2VydmVyLmMKaW5kZXggODEwNzJhNWE0Ni4uYTFjMzc1NDhlMSAxMDA2NDQKLS0t
IGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCisrKyBiL2Jsb2NrL2V4cG9y
dC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtMzIzLDEzICszMjMsMTcgQEAgc3RhdGljIGNv
bnN0IFZ1RGV2SWZhY2UgdnVfYmxrX2lmYWNlID0gewogc3RhdGljIHZvaWQgYmxrX2Fpb19hdHRh
Y2hlZChBaW9Db250ZXh0ICpjdHgsIHZvaWQgKm9wYXF1ZSkKIHsKICAgICBWdUJsa0V4cG9ydCAq
dmV4cCA9IG9wYXF1ZTsKKworICAgIHZleHAtPmV4cG9ydC5jdHggPSBjdHg7CiAgICAgdmhvc3Rf
dXNlcl9zZXJ2ZXJfYXR0YWNoX2Fpb19jb250ZXh0KCZ2ZXhwLT52dV9zZXJ2ZXIsIGN0eCk7CiB9
CiAKIHN0YXRpYyB2b2lkIGJsa19haW9fZGV0YWNoKHZvaWQgKm9wYXF1ZSkKIHsKICAgICBWdUJs
a0V4cG9ydCAqdmV4cCA9IG9wYXF1ZTsKKwogICAgIHZob3N0X3VzZXJfc2VydmVyX2RldGFjaF9h
aW9fY29udGV4dCgmdmV4cC0+dnVfc2VydmVyKTsKKyAgICB2ZXhwLT5leHBvcnQuY3R4ID0gTlVM
TDsKIH0KIAogc3RhdGljIHZvaWQKQEAgLTM4NCw3ICszODgsNiBAQCBzdGF0aWMgaW50IHZ1X2Js
a19leHBfY3JlYXRlKEJsb2NrRXhwb3J0ICpleHAsIEJsb2NrRXhwb3J0T3B0aW9ucyAqb3B0cywK
ICAgICB2dV9ibGtfaW5pdGlhbGl6ZV9jb25maWcoYmxrX2JzKGV4cC0+YmxrKSwgJnZleHAtPmJs
a2NmZywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2dpY2FsX2Jsb2NrX3NpemUp
OwogCi0gICAgYmxrX3NldF9hbGxvd19haW9fY29udGV4dF9jaGFuZ2UoZXhwLT5ibGssIHRydWUp
OwogICAgIGJsa19hZGRfYWlvX2NvbnRleHRfbm90aWZpZXIoZXhwLT5ibGssIGJsa19haW9fYXR0
YWNoZWQsIGJsa19haW9fZGV0YWNoLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmV4cCk7CiAKZGlmZiAtLWdpdCBhL25iZC9zZXJ2ZXIuYyBiL25iZC9zZXJ2ZXIuYwppbmRleCBm
NzQ3NjZhZGQ3Li44Njc2MDA4MzE5IDEwMDY0NAotLS0gYS9uYmQvc2VydmVyLmMKKysrIGIvbmJk
L3NlcnZlci5jCkBAIC0xNTYwLDggKzE1NjAsNiBAQCBzdGF0aWMgaW50IG5iZF9leHBvcnRfY3Jl
YXRlKEJsb2NrRXhwb3J0ICpibGtfZXhwLCBCbG9ja0V4cG9ydE9wdGlvbnMgKmV4cF9hcmdzLAog
ICAgICAgICByZXR1cm4gcmV0OwogICAgIH0KIAotICAgIGJsa19zZXRfYWxsb3dfYWlvX2NvbnRl
eHRfY2hhbmdlKGJsaywgdHJ1ZSk7Ci0KICAgICBRVEFJTFFfSU5JVCgmZXhwLT5jbGllbnRzKTsK
ICAgICBleHAtPm5hbWUgPSBnX3N0cmR1cChhcmctPm5hbWUpOwogICAgIGV4cC0+ZGVzY3JpcHRp
b24gPSBnX3N0cmR1cChhcmctPmRlc2NyaXB0aW9uKTsKLS0gCjIuMjYuMgoK


