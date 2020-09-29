Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823EDC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D779B207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUNsFhoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D779B207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFJD-0006gw-JZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAe-0006wq-Is
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAc-000353-9A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuocNyX1NVSycNpIxw3cbIhuzHCegA9ocw7dIxEyKH4=;
 b=OUNsFhocyZ/d+FUAOjLgDYJhFMYJbV3BwmaRwmgfhXffF04i8lQCXg1ekibRQsvb3u3K25
 UMkFmPMmuWPOWDkcVN31qMT+g5+tsbM9QeoD7gzWICejN3WrsCV7P2pKkRu71r+nz5tPEi
 s/NCQJbaJnKFG7ikhNIDm9K5Fyi6R3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-W7w2MFDgNjyy0z5Vb5_yEQ-1; Tue, 29 Sep 2020 08:55:47 -0400
X-MC-Unique: W7w2MFDgNjyy0z5Vb5_yEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E9310BBED5;
 Tue, 29 Sep 2020 12:55:46 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D445528545;
 Tue, 29 Sep 2020 12:55:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] block/export: add iothread and fixed-iothread options
Date: Tue, 29 Sep 2020 13:55:16 +0100
Message-Id: <20200929125516.186715-5-stefanha@redhat.com>
In-Reply-To: <20200929125516.186715-1-stefanha@redhat.com>
References: <20200929125516.186715-1-stefanha@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBzcGVjaWZ5IHRoZSBpb3RocmVhZCB3aGVyZSB0aGUgZXhwb3J0
IHdpbGwgcnVuLiBCeQpkZWZhdWx0IHRoZSBibG9jayBub2RlIGNhbiBiZSBtb3ZlZCB0byBvdGhl
ciBBaW9Db250ZXh0cyBsYXRlciBhbmQgdGhlCmV4cG9ydCB3aWxsIGZvbGxvdy4gVGhlIGZpeGVk
LWlvdGhyZWFkIG9wdGlvbiBmb3JjZXMgc3RyaWN0IGJlaGF2aW9yCnRoYXQgcHJldmVudHMgY2hh
bmdpbmcgQWlvQ29udGV4dCB3aGlsZSB0aGUgZXhwb3J0IGlzIGFjdGl2ZS4gU2VlIHRoZQpRQVBJ
IGRvY3MgZm9yIGRldGFpbHMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQpOb3RlIHRoZSB4LWJsb2NrZGV2LXNldC1pb3RocmVhZCBRTVAg
Y29tbWFuZCBjYW4gYmUgdXNlZCB0byBkbyB0aGUgc2FtZSwKYnV0IG5vdCBmcm9tIHRoZSBjb21t
YW5kLWxpbmUuIEFuZCBpdCByZXF1aXJlcyBzZW5kaW5nIGFuIGFkZGl0aW9uYWwKY29tbWFuZC4K
CkluIHRoZSBsb25nIHJ1biB2aG9zdC11c2VyLWJsayB3aWxsIHN1cHBvcnQgcGVyLXZpcnRxdWV1
ZSBpb3RocmVhZAptYXBwaW5ncy4gQnV0IGZvciBub3cgYSBzaW5nbGUgaW90aHJlYWQgbWFrZXMg
c2Vuc2UgYW5kIG1vc3Qgb3RoZXIKdHJhbnNwb3J0cyB3aWxsIGp1c3QgdXNlIG9uZSBpb3RocmVh
ZCBhbnl3YXkuCi0tLQogcWFwaS9ibG9jay1leHBvcnQuanNvbiAgICAgICAgICAgICAgIHwgMTEg
KysrKysrKysrKwogYmxvY2svZXhwb3J0L2V4cG9ydC5jICAgICAgICAgICAgICAgIHwgMzEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNl
cnZlci5jIHwgIDUgKysrKy0KIG5iZC9zZXJ2ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyIC0tCiA0IGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1leHBvcnQuanNvbiBiL3FhcGkvYmxvY2stZXhwb3J0
Lmpzb24KaW5kZXggODdhYzUxMTdjZC4uZTJjYjIxZjVmMSAxMDA2NDQKLS0tIGEvcWFwaS9ibG9j
ay1leHBvcnQuanNvbgorKysgYi9xYXBpL2Jsb2NrLWV4cG9ydC5qc29uCkBAIC0yMTksMTEgKzIx
OSwyMiBAQAogIyAgICAgICAgICAgICAgICBleHBvcnQgYmVmb3JlIGNvbXBsZXRpb24gaXMgc2ln
bmFsbGVkLiAoc2luY2U6IDUuMjsKICMgICAgICAgICAgICAgICAgZGVmYXVsdDogZmFsc2UpCiAj
CisjIEBpb3RocmVhZDogVGhlIG5hbWUgb2YgdGhlIGlvdGhyZWFkIG9iamVjdCB3aGVyZSB0aGUg
ZXhwb3J0IHdpbGwgcnVuLiBUaGUKKyMgICAgICAgICAgICBkZWZhdWx0IGlzIHRvIHVzZSB0aGUg
dGhyZWFkIGN1cnJlbnRseSBhc3NvY2lhdGVkIHdpdGggdGhlICMKKyMgICAgICAgICAgICBibG9j
ayBub2RlLiAoc2luY2U6IDUuMikKKyMKKyMgQGZpeGVkLWlvdGhyZWFkOiBUcnVlIHByZXZlbnRz
IHRoZSBibG9jayBub2RlIGZyb20gYmVpbmcgbW92ZWQgdG8gYW5vdGhlcgorIyAgICAgICAgICAg
ICAgICAgIHRocmVhZCB3aGlsZSB0aGUgZXhwb3J0IGlzIGFjdGl2ZS4gSWYgdHJ1ZSBhbmQgQGlv
dGhyZWFkIGlzCisjICAgICAgICAgICAgICAgICAgZ2l2ZW4sIGV4cG9ydCBjcmVhdGlvbiBmYWls
cyBpZiB0aGUgYmxvY2sgbm9kZSBjYW5ub3QgYmUKKyMgICAgICAgICAgICAgICAgICBtb3ZlZCB0
byB0aGUgaW90aHJlYWQuIFRoZSBkZWZhdWx0IGlzIGZhbHNlLgorIwogIyBTaW5jZTogNC4yCiAj
IwogeyAndW5pb24nOiAnQmxvY2tFeHBvcnRPcHRpb25zJywKICAgJ2Jhc2UnOiB7ICd0eXBlJzog
J0Jsb2NrRXhwb3J0VHlwZScsCiAgICAgICAgICAgICAnaWQnOiAnc3RyJywKKwkgICAgJypmaXhl
ZC1pb3RocmVhZCc6ICdib29sJywKKwkgICAgJyppb3RocmVhZCc6ICdzdHInLAogICAgICAgICAg
ICAgJ25vZGUtbmFtZSc6ICdzdHInLAogICAgICAgICAgICAgJyp3cml0YWJsZSc6ICdib29sJywK
ICAgICAgICAgICAgICcqd3JpdGV0aHJvdWdoJzogJ2Jvb2wnIH0sCmRpZmYgLS1naXQgYS9ibG9j
ay9leHBvcnQvZXhwb3J0LmMgYi9ibG9jay9leHBvcnQvZXhwb3J0LmMKaW5kZXggNTUwODk3ZTIz
Ni4uYTViNmIwMjcwMyAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L2V4cG9ydC5jCisrKyBiL2Js
b2NrL2V4cG9ydC9leHBvcnQuYwpAQCAtMTUsNiArMTUsNyBAQAogCiAjaW5jbHVkZSAiYmxvY2sv
YmxvY2suaCIKICNpbmNsdWRlICJzeXNlbXUvYmxvY2stYmFja2VuZC5oIgorI2luY2x1ZGUgInN5
c2VtdS9pb3RocmVhZC5oIgogI2luY2x1ZGUgImJsb2NrL2V4cG9ydC5oIgogI2luY2x1ZGUgImJs
b2NrL25iZC5oIgogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKQEAgLTYzLDEwICs2NCwxMSBAQCBz
dGF0aWMgY29uc3QgQmxvY2tFeHBvcnREcml2ZXIgKmJsa19leHBfZmluZF9kcml2ZXIoQmxvY2tF
eHBvcnRUeXBlIHR5cGUpCiAKIEJsb2NrRXhwb3J0ICpibGtfZXhwX2FkZChCbG9ja0V4cG9ydE9w
dGlvbnMgKmV4cG9ydCwgRXJyb3IgKiplcnJwKQogeworICAgIGJvb2wgZml4ZWRfaW90aHJlYWQg
PSBleHBvcnQtPmhhc19maXhlZF9pb3RocmVhZCAmJiBleHBvcnQtPmZpeGVkX2lvdGhyZWFkOwog
ICAgIGNvbnN0IEJsb2NrRXhwb3J0RHJpdmVyICpkcnY7CiAgICAgQmxvY2tFeHBvcnQgKmV4cCA9
IE5VTEw7CiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnM7Ci0gICAgQmxvY2tCYWNrZW5kICpibGs7
CisgICAgQmxvY2tCYWNrZW5kICpibGsgPSBOVUxMOwogICAgIEFpb0NvbnRleHQgKmN0eDsKICAg
ICB1aW50NjRfdCBwZXJtOwogICAgIGludCByZXQ7CkBAIC0xMDIsNiArMTA0LDI4IEBAIEJsb2Nr
RXhwb3J0ICpibGtfZXhwX2FkZChCbG9ja0V4cG9ydE9wdGlvbnMgKmV4cG9ydCwgRXJyb3IgKipl
cnJwKQogICAgIGN0eCA9IGJkcnZfZ2V0X2Fpb19jb250ZXh0KGJzKTsKICAgICBhaW9fY29udGV4
dF9hY3F1aXJlKGN0eCk7CiAKKyAgICBpZiAoZXhwb3J0LT5oYXNfaW90aHJlYWQpIHsKKyAgICAg
ICAgSU9UaHJlYWQgKmlvdGhyZWFkOworICAgICAgICBBaW9Db250ZXh0ICpuZXdfY3R4OworCisg
ICAgICAgIGlvdGhyZWFkID0gaW90aHJlYWRfYnlfaWQoZXhwb3J0LT5pb3RocmVhZCk7CisgICAg
ICAgIGlmICghaW90aHJlYWQpIHsKKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImlvdGhy
ZWFkIFwiJXNcIiBub3QgZm91bmQiLCBleHBvcnQtPmlvdGhyZWFkKTsKKyAgICAgICAgICAgIGdv
dG8gZmFpbDsKKyAgICAgICAgfQorCisgICAgICAgIG5ld19jdHggPSBpb3RocmVhZF9nZXRfYWlv
X2NvbnRleHQoaW90aHJlYWQpOworCisgICAgICAgIHJldCA9IGJkcnZfdHJ5X3NldF9haW9fY29u
dGV4dChicywgbmV3X2N0eCwgZXJycCk7CisgICAgICAgIGlmIChyZXQgPT0gMCkgeworICAgICAg
ICAgICAgYWlvX2NvbnRleHRfcmVsZWFzZShjdHgpOworICAgICAgICAgICAgYWlvX2NvbnRleHRf
YWNxdWlyZShuZXdfY3R4KTsKKyAgICAgICAgICAgIGN0eCA9IG5ld19jdHg7CisgICAgICAgIH0g
ZWxzZSBpZiAoZml4ZWRfaW90aHJlYWQpIHsKKyAgICAgICAgICAgIGdvdG8gZmFpbDsKKyAgICAg
ICAgfQorICAgIH0KKwogICAgIC8qCiAgICAgICogQmxvY2sgZXhwb3J0cyBhcmUgdXNlZCBmb3Ig
bm9uLXNoYXJlZCBzdG9yYWdlIG1pZ3JhdGlvbi4gTWFrZSBzdXJlCiAgICAgICogdGhhdCBCRFJW
X09fSU5BQ1RJVkUgaXMgY2xlYXJlZCBhbmQgdGhlIGltYWdlIGlzIHJlYWR5IGZvciB3cml0ZQpA
QCAtMTE2LDYgKzE0MCwxMSBAQCBCbG9ja0V4cG9ydCAqYmxrX2V4cF9hZGQoQmxvY2tFeHBvcnRP
cHRpb25zICpleHBvcnQsIEVycm9yICoqZXJycCkKICAgICB9CiAKICAgICBibGsgPSBibGtfbmV3
KGN0eCwgcGVybSwgQkxLX1BFUk1fQUxMKTsKKworICAgIGlmICghZml4ZWRfaW90aHJlYWQpIHsK
KyAgICAgICAgYmxrX3NldF9hbGxvd19haW9fY29udGV4dF9jaGFuZ2UoYmxrLCB0cnVlKTsKKyAg
ICB9CisKICAgICByZXQgPSBibGtfaW5zZXJ0X2JzKGJsaywgYnMsIGVycnApOwogICAgIGlmIChy
ZXQgPCAwKSB7CiAgICAgICAgIGdvdG8gZmFpbDsKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2
ZXIuYwppbmRleCA4MTA3MmE1YTQ2Li5hMWMzNzU0OGUxIDEwMDY0NAotLS0gYS9ibG9jay9leHBv
cnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXIt
YmxrLXNlcnZlci5jCkBAIC0zMjMsMTMgKzMyMywxNyBAQCBzdGF0aWMgY29uc3QgVnVEZXZJZmFj
ZSB2dV9ibGtfaWZhY2UgPSB7CiBzdGF0aWMgdm9pZCBibGtfYWlvX2F0dGFjaGVkKEFpb0NvbnRl
eHQgKmN0eCwgdm9pZCAqb3BhcXVlKQogewogICAgIFZ1QmxrRXhwb3J0ICp2ZXhwID0gb3BhcXVl
OworCisgICAgdmV4cC0+ZXhwb3J0LmN0eCA9IGN0eDsKICAgICB2aG9zdF91c2VyX3NlcnZlcl9h
dHRhY2hfYWlvX2NvbnRleHQoJnZleHAtPnZ1X3NlcnZlciwgY3R4KTsKIH0KIAogc3RhdGljIHZv
aWQgYmxrX2Fpb19kZXRhY2godm9pZCAqb3BhcXVlKQogewogICAgIFZ1QmxrRXhwb3J0ICp2ZXhw
ID0gb3BhcXVlOworCiAgICAgdmhvc3RfdXNlcl9zZXJ2ZXJfZGV0YWNoX2Fpb19jb250ZXh0KCZ2
ZXhwLT52dV9zZXJ2ZXIpOworICAgIHZleHAtPmV4cG9ydC5jdHggPSBOVUxMOwogfQogCiBzdGF0
aWMgdm9pZApAQCAtMzg0LDcgKzM4OCw2IEBAIHN0YXRpYyBpbnQgdnVfYmxrX2V4cF9jcmVhdGUo
QmxvY2tFeHBvcnQgKmV4cCwgQmxvY2tFeHBvcnRPcHRpb25zICpvcHRzLAogICAgIHZ1X2Jsa19p
bml0aWFsaXplX2NvbmZpZyhibGtfYnMoZXhwLT5ibGspLCAmdmV4cC0+YmxrY2ZnLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGxvZ2ljYWxfYmxvY2tfc2l6ZSk7CiAKLSAgICBibGtf
c2V0X2FsbG93X2Fpb19jb250ZXh0X2NoYW5nZShleHAtPmJsaywgdHJ1ZSk7CiAgICAgYmxrX2Fk
ZF9haW9fY29udGV4dF9ub3RpZmllcihleHAtPmJsaywgYmxrX2Fpb19hdHRhY2hlZCwgYmxrX2Fp
b19kZXRhY2gsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZXhwKTsKIApkaWZm
IC0tZ2l0IGEvbmJkL3NlcnZlci5jIGIvbmJkL3NlcnZlci5jCmluZGV4IGY3NDc2NmFkZDcuLjg2
NzYwMDgzMTkgMTAwNjQ0Ci0tLSBhL25iZC9zZXJ2ZXIuYworKysgYi9uYmQvc2VydmVyLmMKQEAg
LTE1NjAsOCArMTU2MCw2IEBAIHN0YXRpYyBpbnQgbmJkX2V4cG9ydF9jcmVhdGUoQmxvY2tFeHBv
cnQgKmJsa19leHAsIEJsb2NrRXhwb3J0T3B0aW9ucyAqZXhwX2FyZ3MsCiAgICAgICAgIHJldHVy
biByZXQ7CiAgICAgfQogCi0gICAgYmxrX3NldF9hbGxvd19haW9fY29udGV4dF9jaGFuZ2UoYmxr
LCB0cnVlKTsKLQogICAgIFFUQUlMUV9JTklUKCZleHAtPmNsaWVudHMpOwogICAgIGV4cC0+bmFt
ZSA9IGdfc3RyZHVwKGFyZy0+bmFtZSk7CiAgICAgZXhwLT5kZXNjcmlwdGlvbiA9IGdfc3RyZHVw
KGFyZy0+ZGVzY3JpcHRpb24pOwotLSAKMi4yNi4yCgo=


