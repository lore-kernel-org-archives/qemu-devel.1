Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB27C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA1A222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBJuS+/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA1A222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYqa-0002GW-7K
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYly-00059Y-P8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYlx-00055V-1D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDPK/gDxvSqd+AKC4ACRi9LgzC2OcfLuz1FIto+Zozc=;
 b=HBJuS+/yTFELrIETBgvJuvOHKER7usZfj3q4O85Qk+7sX8pErsvzlsD+AB7BvdzHZV9OnC
 wEQj3ZxrPtBH/siGaC2y4rQBcl0PPlKyG0xtU1h2o9u8v0DbgYxTXpbyHApQaLU16ostm3
 tvC1IZ8g0e6yfxqIHpjDO9P3ph/+T4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-TXtnzSfIMNul0suezRU_iw-1; Thu, 22 Oct 2020 07:28:40 -0400
X-MC-Unique: TXtnzSfIMNul0suezRU_iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F2E835B76;
 Thu, 22 Oct 2020 11:28:38 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88A6C19C78;
 Thu, 22 Oct 2020 11:28:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 11/28] block/export: consolidate request structs into
 VuBlockReq
Date: Thu, 22 Oct 2020 12:27:09 +0100
Message-Id: <20201022112726.736757-12-stefanha@redhat.com>
In-Reply-To: <20201022112726.736757-1-stefanha@redhat.com>
References: <20201022112726.736757-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T25seSBvbmUgc3RydWN0IGlzIG5lZWRlZCBwZXIgcmVxdWVzdC4gRHJvcCByZXFfZGF0YSBhbmQg
dGhlIHNlcGFyYXRlClZ1QmxvY2tSZXEgaW5zdGFuY2UuIEluc3RlYWQgbGV0IHZ1X3F1ZXVlX3Bv
cCgpIGFsbG9jYXRlIGV2ZXJ5dGhpbmcgYXQKb25jZS4KClRoaXMgZml4ZXMgdGhlIHJlcV9kYXRh
IG1lbW9yeSBsZWFrIGluIHZ1X2Jsb2NrX3ZpcnRpb19wcm9jZXNzX3JlcSgpLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAy
MDIwMDkyNDE1MTU0OS45MTM3MzctNi1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9leHBvcnQv
dmhvc3QtdXNlci1ibGstc2VydmVyLmMgfCA2OCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jIGIvYmxvY2svZXhw
b3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCmluZGV4IDJiYTE2MTNjYzkuLmQyMjdiNDY4ZDgg
MTAwNjQ0Ci0tLSBhL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYworKysgYi9i
bG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKQEAgLTI1LDcgKzI1LDcgQEAgc3Ry
dWN0IHZpcnRpb19ibGtfaW5oZHIgewogfTsKIAogdHlwZWRlZiBzdHJ1Y3QgVnVCbG9ja1JlcSB7
Ci0gICAgVnVWaXJ0cUVsZW1lbnQgKmVsZW07CisgICAgVnVWaXJ0cUVsZW1lbnQgZWxlbTsKICAg
ICBpbnQ2NF90IHNlY3Rvcl9udW07CiAgICAgc2l6ZV90IHNpemU7CiAgICAgc3RydWN0IHZpcnRp
b19ibGtfaW5oZHIgKmluOwpAQCAtMzksMTQgKzM5LDEwIEBAIHN0YXRpYyB2b2lkIHZ1X2Jsb2Nr
X3JlcV9jb21wbGV0ZShWdUJsb2NrUmVxICpyZXEpCiAgICAgVnVEZXYgKnZ1X2RldiA9ICZyZXEt
PnNlcnZlci0+dnVfZGV2OwogCiAgICAgLyogSU8gc2l6ZSB3aXRoIDEgZXh0cmEgc3RhdHVzIGJ5
dGUgKi8KLSAgICB2dV9xdWV1ZV9wdXNoKHZ1X2RldiwgcmVxLT52cSwgcmVxLT5lbGVtLCByZXEt
PnNpemUgKyAxKTsKKyAgICB2dV9xdWV1ZV9wdXNoKHZ1X2RldiwgcmVxLT52cSwgJnJlcS0+ZWxl
bSwgcmVxLT5zaXplICsgMSk7CiAgICAgdnVfcXVldWVfbm90aWZ5KHZ1X2RldiwgcmVxLT52cSk7
CiAKLSAgICBpZiAocmVxLT5lbGVtKSB7Ci0gICAgICAgIGZyZWUocmVxLT5lbGVtKTsKLSAgICB9
Ci0KLSAgICBnX2ZyZWUocmVxKTsKKyAgICBmcmVlKHJlcSk7CiB9CiAKIHN0YXRpYyBWdUJsb2Nr
RGV2ICpnZXRfdnVfYmxvY2tfZGV2aWNlX2J5X3NlcnZlcihWdVNlcnZlciAqc2VydmVyKQpAQCAt
ODksMjAgKzg1LDEyIEBAIHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiB2dV9ibG9ja19mbHVzaChW
dUJsb2NrUmVxICpyZXEpCiAgICAgYmxrX2NvX2ZsdXNoKGJhY2tlbmQpOwogfQogCi1zdHJ1Y3Qg
cmVxX2RhdGEgewotICAgIFZ1U2VydmVyICpzZXJ2ZXI7Ci0gICAgVnVWaXJ0cSAqdnE7Ci0gICAg
VnVWaXJ0cUVsZW1lbnQgKmVsZW07Ci19OwotCiBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gdnVf
YmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVxKHZvaWQgKm9wYXF1ZSkKIHsKLSAgICBzdHJ1Y3QgcmVx
X2RhdGEgKmRhdGEgPSBvcGFxdWU7Ci0gICAgVnVTZXJ2ZXIgKnNlcnZlciA9IGRhdGEtPnNlcnZl
cjsKLSAgICBWdVZpcnRxICp2cSA9IGRhdGEtPnZxOwotICAgIFZ1VmlydHFFbGVtZW50ICplbGVt
ID0gZGF0YS0+ZWxlbTsKKyAgICBWdUJsb2NrUmVxICpyZXEgPSBvcGFxdWU7CisgICAgVnVTZXJ2
ZXIgKnNlcnZlciA9IHJlcS0+c2VydmVyOworICAgIFZ1VmlydHFFbGVtZW50ICplbGVtID0gJnJl
cS0+ZWxlbTsKICAgICB1aW50MzJfdCB0eXBlOwotICAgIFZ1QmxvY2tSZXEgKnJlcTsKIAogICAg
IFZ1QmxvY2tEZXYgKnZkZXZfYmxrID0gZ2V0X3Z1X2Jsb2NrX2RldmljZV9ieV9zZXJ2ZXIoc2Vy
dmVyKTsKICAgICBCbG9ja0JhY2tlbmQgKmJhY2tlbmQgPSB2ZGV2X2Jsay0+YmFja2VuZDsKQEAg
LTExMSwxOCArOTksMTMgQEAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIHZ1X2Jsb2NrX3ZpcnRp
b19wcm9jZXNzX3JlcSh2b2lkICpvcGFxdWUpCiAgICAgc3RydWN0IGlvdmVjICpvdXRfaW92ID0g
ZWxlbS0+b3V0X3NnOwogICAgIHVuc2lnbmVkIGluX251bSA9IGVsZW0tPmluX251bTsKICAgICB1
bnNpZ25lZCBvdXRfbnVtID0gZWxlbS0+b3V0X251bTsKKwogICAgIC8qIHJlZmVyIHRvIGh3L2Js
b2NrL3ZpcnRpb19ibGsuYyAqLwogICAgIGlmIChlbGVtLT5vdXRfbnVtIDwgMSB8fCBlbGVtLT5p
bl9udW0gPCAxKSB7CiAgICAgICAgIGVycm9yX3JlcG9ydCgidmlydGlvLWJsayByZXF1ZXN0IG1p
c3NpbmcgaGVhZGVycyIpOwotICAgICAgICBmcmVlKGVsZW0pOwotICAgICAgICByZXR1cm47Cisg
ICAgICAgIGdvdG8gZXJyOwogICAgIH0KIAotICAgIHJlcSA9IGdfbmV3MChWdUJsb2NrUmVxLCAx
KTsKLSAgICByZXEtPnNlcnZlciA9IHNlcnZlcjsKLSAgICByZXEtPnZxID0gdnE7Ci0gICAgcmVx
LT5lbGVtID0gZWxlbTsKLQogICAgIGlmICh1bmxpa2VseShpb3ZfdG9fYnVmKG91dF9pb3YsIG91
dF9udW0sIDAsICZyZXEtPm91dCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
cmVxLT5vdXQpKSAhPSBzaXplb2YocmVxLT5vdXQpKSkgewogICAgICAgICBlcnJvcl9yZXBvcnQo
InZpcnRpby1ibGsgcmVxdWVzdCBvdXRoZHIgdG9vIHNob3J0Iik7CkBAIC0yMDIsMzYgKzE4NSwy
NyBAQCBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gdnVfYmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVx
KHZvaWQgKm9wYXF1ZSkKIAogZXJyOgogICAgIGZyZWUoZWxlbSk7Ci0gICAgZ19mcmVlKHJlcSk7
Ci0gICAgcmV0dXJuOwogfQogCiBzdGF0aWMgdm9pZCB2dV9ibG9ja19wcm9jZXNzX3ZxKFZ1RGV2
ICp2dV9kZXYsIGludCBpZHgpCiB7Ci0gICAgVnVTZXJ2ZXIgKnNlcnZlcjsKLSAgICBWdVZpcnRx
ICp2cTsKLSAgICBzdHJ1Y3QgcmVxX2RhdGEgKnJlcV9kYXRhOworICAgIFZ1U2VydmVyICpzZXJ2
ZXIgPSBjb250YWluZXJfb2YodnVfZGV2LCBWdVNlcnZlciwgdnVfZGV2KTsKKyAgICBWdVZpcnRx
ICp2cSA9IHZ1X2dldF9xdWV1ZSh2dV9kZXYsIGlkeCk7CiAKLSAgICBzZXJ2ZXIgPSBjb250YWlu
ZXJfb2YodnVfZGV2LCBWdVNlcnZlciwgdnVfZGV2KTsKLSAgICBhc3NlcnQoc2VydmVyKTsKLQot
ICAgIHZxID0gdnVfZ2V0X3F1ZXVlKHZ1X2RldiwgaWR4KTsKLSAgICBhc3NlcnQodnEpOwotICAg
IFZ1VmlydHFFbGVtZW50ICplbGVtOwogICAgIHdoaWxlICgxKSB7Ci0gICAgICAgIGVsZW0gPSB2
dV9xdWV1ZV9wb3AodnVfZGV2LCB2cSwgc2l6ZW9mKFZ1VmlydHFFbGVtZW50KSArCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoVnVCbG9ja1JlcSkpOwotICAgICAg
ICBpZiAoZWxlbSkgewotICAgICAgICAgICAgcmVxX2RhdGEgPSBnX25ldzAoc3RydWN0IHJlcV9k
YXRhLCAxKTsKLSAgICAgICAgICAgIHJlcV9kYXRhLT5zZXJ2ZXIgPSBzZXJ2ZXI7Ci0gICAgICAg
ICAgICByZXFfZGF0YS0+dnEgPSB2cTsKLSAgICAgICAgICAgIHJlcV9kYXRhLT5lbGVtID0gZWxl
bTsKLSAgICAgICAgICAgIENvcm91dGluZSAqY28gPSBxZW11X2Nvcm91dGluZV9jcmVhdGUodnVf
YmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVxLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXFfZGF0YSk7Ci0gICAgICAgICAgICBhaW9fY29fZW50ZXIo
c2VydmVyLT5pb2MtPmN0eCwgY28pOwotICAgICAgICB9IGVsc2UgeworICAgICAgICBWdUJsb2Nr
UmVxICpyZXE7CisKKyAgICAgICAgcmVxID0gdnVfcXVldWVfcG9wKHZ1X2RldiwgdnEsIHNpemVv
ZihWdUJsb2NrUmVxKSk7CisgICAgICAgIGlmICghcmVxKSB7CiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQorCisgICAgICAgIHJlcS0+c2VydmVyID0gc2VydmVyOworICAgICAgICByZXEt
PnZxID0gdnE7CisKKyAgICAgICAgQ29yb3V0aW5lICpjbyA9CisgICAgICAgICAgICBxZW11X2Nv
cm91dGluZV9jcmVhdGUodnVfYmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVxLCByZXEpOworICAgICAg
ICBxZW11X2Nvcm91dGluZV9lbnRlcihjbyk7CiAgICAgfQogfQogCi0tIAoyLjI2LjIKCg==


