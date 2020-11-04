Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F175C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D532072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqCfDLPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D532072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKsn-000176-2o
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbJ-00083e-DF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKb9-0008Ll-Cj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Li0kacoWjiU1qKe4Pgxu8UAIlHC/67ypPcd5NsRWeKE=;
 b=YqCfDLPGl7MOgA4ikuaq46C5u0sJTz+IQFSPDjWw08/aadF2B1vyF0kLxLj2PWJB3BXFLm
 n9cjrd3ih7dKG0W/TKljn+9uHXXN6ckRFLeplytgZu5OD3AVhr8vGTNFrknRrOFWLqUQFa
 FKQn6xwDGrXuLkFsNzUog/WsFM9v80M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-mlYUIw-2Oq2pqX_53v-5ZA-1; Wed, 04 Nov 2020 10:21:14 -0500
X-MC-Unique: mlYUIw-2Oq2pqX_53v-5ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAA369CC05;
 Wed,  4 Nov 2020 15:21:12 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B6A460C84;
 Wed,  4 Nov 2020 15:21:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/33] block/nvme: Align iov's va and size on host page size
Date: Wed,  4 Nov 2020 15:18:19 +0000
Message-Id: <20201104151828.405824-25-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgoKTWFrZSBzdXJlIGlvdidz
IHZhIGFuZCBzaXplIGFyZSBwcm9wZXJseSBhbGlnbmVkIG9uIHRoZQpob3N0IHBhZ2Ugc2l6ZS4K
ClNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KUmV2aWV3
ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmV2aWV3
ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMjkw
OTMzMDYuMTA2Mzg3OS0yMy1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDE0ICsrKysrKysrLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCBlODA3ZGQ1NmRmLi5mMWUy
ZmQzNGNkIDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxvY2svbnZtZS5jCkBAIC0x
MDE1LDExICsxMDE1LDEyIEBAIHN0YXRpYyBjb3JvdXRpbmVfZm4gaW50IG52bWVfY21kX21hcF9x
aW92KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBOdm1lQ21kICpjbWQsCiAgICAgZm9yIChpID0gMDsg
aSA8IHFpb3YtPm5pb3Y7ICsraSkgewogICAgICAgICBib29sIHJldHJ5ID0gdHJ1ZTsKICAgICAg
ICAgdWludDY0X3QgaW92YTsKKyAgICAgICAgc2l6ZV90IGxlbiA9IFFFTVVfQUxJR05fVVAocWlv
di0+aW92W2ldLmlvdl9sZW4sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFl
bXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSk7CiB0cnlfbWFwOgogICAgICAgICByID0gcWVtdV92Zmlv
X2RtYV9tYXAocy0+dmZpbywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFpb3YtPmlv
dltpXS5pb3ZfYmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFpb3YtPmlvdltp
XS5pb3ZfbGVuLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgJmlvdmEpOwor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuLCB0cnVlLCAmaW92YSk7CiAgICAgICAg
IGlmIChyID09IC1FTk9NRU0gJiYgcmV0cnkpIHsKICAgICAgICAgICAgIHJldHJ5ID0gZmFsc2U7
CiAgICAgICAgICAgICB0cmFjZV9udm1lX2RtYV9mbHVzaF9xdWV1ZV93YWl0KHMpOwpAQCAtMTE2
Myw4ICsxMTY0LDkgQEAgc3RhdGljIGlubGluZSBib29sIG52bWVfcWlvdl9hbGlnbmVkKEJsb2Nr
RHJpdmVyU3RhdGUgKmJzLAogICAgIEJEUlZOVk1lU3RhdGUgKnMgPSBicy0+b3BhcXVlOwogCiAg
ICAgZm9yIChpID0gMDsgaSA8IHFpb3YtPm5pb3Y7ICsraSkgewotICAgICAgICBpZiAoIVFFTVVf
UFRSX0lTX0FMSUdORUQocWlvdi0+aW92W2ldLmlvdl9iYXNlLCBzLT5wYWdlX3NpemUpIHx8Ci0g
ICAgICAgICAgICAhUUVNVV9JU19BTElHTkVEKHFpb3YtPmlvdltpXS5pb3ZfbGVuLCBzLT5wYWdl
X3NpemUpKSB7CisgICAgICAgIGlmICghUUVNVV9QVFJfSVNfQUxJR05FRChxaW92LT5pb3ZbaV0u
aW92X2Jhc2UsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxZW11X3JlYWxfaG9z
dF9wYWdlX3NpemUpIHx8CisgICAgICAgICAgICAhUUVNVV9JU19BTElHTkVEKHFpb3YtPmlvdltp
XS5pb3ZfbGVuLCBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUpKSB7CiAgICAgICAgICAgICB0cmFj
ZV9udm1lX3Fpb3ZfdW5hbGlnbmVkKHFpb3YsIGksIHFpb3YtPmlvdltpXS5pb3ZfYmFzZSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWlvdi0+aW92W2ldLmlvdl9sZW4s
IHMtPnBhZ2Vfc2l6ZSk7CiAgICAgICAgICAgICByZXR1cm4gZmFsc2U7CkBAIC0xMTgwLDcgKzEx
ODIsNyBAQCBzdGF0aWMgaW50IG52bWVfY29fcHJ3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50
NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLAogICAgIGludCByOwogICAgIHVpbnQ4X3QgKmJ1
ZiA9IE5VTEw7CiAgICAgUUVNVUlPVmVjdG9yIGxvY2FsX3Fpb3Y7Ci0KKyAgICBzaXplX3QgbGVu
ID0gUUVNVV9BTElHTl9VUChieXRlcywgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKTsKICAgICBh
c3NlcnQoUUVNVV9JU19BTElHTkVEKG9mZnNldCwgcy0+cGFnZV9zaXplKSk7CiAgICAgYXNzZXJ0
KFFFTVVfSVNfQUxJR05FRChieXRlcywgcy0+cGFnZV9zaXplKSk7CiAgICAgYXNzZXJ0KGJ5dGVz
IDw9IHMtPm1heF90cmFuc2Zlcik7CkBAIC0xMTkwLDcgKzExOTIsNyBAQCBzdGF0aWMgaW50IG52
bWVfY29fcHJ3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90
IGJ5dGVzLAogICAgIH0KICAgICBzLT5zdGF0cy51bmFsaWduZWRfYWNjZXNzZXMrKzsKICAgICB0
cmFjZV9udm1lX3Byd19idWZmZXJlZChzLCBvZmZzZXQsIGJ5dGVzLCBxaW92LT5uaW92LCBpc193
cml0ZSk7Ci0gICAgYnVmID0gcWVtdV90cnlfbWVtYWxpZ24ocy0+cGFnZV9zaXplLCBieXRlcyk7
CisgICAgYnVmID0gcWVtdV90cnlfbWVtYWxpZ24ocWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplLCBs
ZW4pOwogCiAgICAgaWYgKCFidWYpIHsKICAgICAgICAgcmV0dXJuIC1FTk9NRU07Ci0tIAoyLjI4
LjAKCg==


