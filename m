Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE60C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BB42072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIDLxp3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BB42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKqh-0005jD-Iy
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbD-0007xk-E0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKb6-0008LI-3V
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNv0TiZ4zapmbEnazkUflaFJKUKWSwL5ypDHx6qKNHE=;
 b=bIDLxp3udR5cfpnejRe6YPA94xUe8FwGOkfSMdcUnIXARxyVVsk62j8miWjOW3In5kIU5/
 Hcr+pf/q053hpHRTRVyFMz9+nE8ahSeveWn7YAOT18IXevspd8f++1G9j79TKntAGbl7oK
 Xe+o2ifb37wxoEWatdZMN5CGVn7wKf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-hchZ_auEOBu6uBGDy9Pwww-1; Wed, 04 Nov 2020 10:21:12 -0500
X-MC-Unique: hchZ_auEOBu6uBGDy9Pwww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10753101F005;
 Wed,  4 Nov 2020 15:21:11 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00E3960C84;
 Wed,  4 Nov 2020 15:21:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/33] block/nvme: Change size and alignment of prp_list_pages
Date: Wed,  4 Nov 2020 15:18:18 +0000
Message-Id: <20201104151828.405824-24-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgoKSW4gcHJlcGFyYXRpb24g
b2YgNjRrQiBob3N0IHBhZ2Ugc3VwcG9ydCwgbGV0J3MgY2hhbmdlIHRoZSBzaXplCmFuZCBhbGln
bm1lbnQgb2YgdGhlIHBycF9saXN0X3BhZ2VzIHNvIHRoYXQgdGhlIFZGSU8gRE1BIE1BUCBzdWNj
ZWVkcwp3aXRoIDY0a0IgaG9zdCBwYWdlIHNpemUuIFdlIGFsaWduIG9uIHRoZSBob3N0IHBhZ2Ug
c2l6ZS4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhh
dC5jb20+ClNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4K
UmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVk
LWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAy
MDEwMjkwOTMzMDYuMTA2Mzg3OS0yMi1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDExICsrKysrKy0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCA0YTg1ODlkMmQyLi5l
ODA3ZGQ1NmRmIDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxvY2svbnZtZS5jCkBA
IC0yMTUsNiArMjE1LDcgQEAgc3RhdGljIE5WTWVRdWV1ZVBhaXIgKm52bWVfY3JlYXRlX3F1ZXVl
X3BhaXIoQkRSVk5WTWVTdGF0ZSAqcywKICAgICBpbnQgaSwgcjsKICAgICBOVk1lUXVldWVQYWly
ICpxOwogICAgIHVpbnQ2NF90IHBycF9saXN0X2lvdmE7CisgICAgc2l6ZV90IGJ5dGVzOwogCiAg
ICAgcSA9IGdfdHJ5X25ldzAoTlZNZVF1ZXVlUGFpciwgMSk7CiAgICAgaWYgKCFxKSB7CkBAIC0y
MjIsMTkgKzIyMywxOSBAQCBzdGF0aWMgTlZNZVF1ZXVlUGFpciAqbnZtZV9jcmVhdGVfcXVldWVf
cGFpcihCRFJWTlZNZVN0YXRlICpzLAogICAgIH0KICAgICB0cmFjZV9udm1lX2NyZWF0ZV9xdWV1
ZV9wYWlyKGlkeCwgcSwgc2l6ZSwgYWlvX2NvbnRleHQsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBldmVudF9ub3RpZmllcl9nZXRfZmQocy0+aXJxX25vdGlmaWVyKSk7Ci0gICAg
cS0+cHJwX2xpc3RfcGFnZXMgPSBxZW11X3RyeV9tZW1hbGlnbihzLT5wYWdlX3NpemUsCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5wYWdlX3NpemUgKiBOVk1F
X05VTV9SRVFTKTsKKyAgICBieXRlcyA9IFFFTVVfQUxJR05fVVAocy0+cGFnZV9zaXplICogTlZN
RV9OVU1fUkVRUywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgcWVtdV9yZWFsX2hvc3RfcGFn
ZV9zaXplKTsKKyAgICBxLT5wcnBfbGlzdF9wYWdlcyA9IHFlbXVfdHJ5X21lbWFsaWduKHFlbXVf
cmVhbF9ob3N0X3BhZ2Vfc2l6ZSwgYnl0ZXMpOwogICAgIGlmICghcS0+cHJwX2xpc3RfcGFnZXMp
IHsKICAgICAgICAgZ290byBmYWlsOwogICAgIH0KLSAgICBtZW1zZXQocS0+cHJwX2xpc3RfcGFn
ZXMsIDAsIHMtPnBhZ2Vfc2l6ZSAqIE5WTUVfTlVNX1JFUVMpOworICAgIG1lbXNldChxLT5wcnBf
bGlzdF9wYWdlcywgMCwgYnl0ZXMpOwogICAgIHFlbXVfbXV0ZXhfaW5pdCgmcS0+bG9jayk7CiAg
ICAgcS0+cyA9IHM7CiAgICAgcS0+aW5kZXggPSBpZHg7CiAgICAgcWVtdV9jb19xdWV1ZV9pbml0
KCZxLT5mcmVlX3JlcV9xdWV1ZSk7CiAgICAgcS0+Y29tcGxldGlvbl9iaCA9IGFpb19iaF9uZXco
YWlvX2NvbnRleHQsIG52bWVfcHJvY2Vzc19jb21wbGV0aW9uX2JoLCBxKTsKLSAgICByID0gcWVt
dV92ZmlvX2RtYV9tYXAocy0+dmZpbywgcS0+cHJwX2xpc3RfcGFnZXMsCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgIHMtPnBhZ2Vfc2l6ZSAqIE5WTUVfTlVNX1JFUVMsCisgICAgciA9IHFlbXVf
dmZpb19kbWFfbWFwKHMtPnZmaW8sIHEtPnBycF9saXN0X3BhZ2VzLCBieXRlcywKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZmFsc2UsICZwcnBfbGlzdF9pb3ZhKTsKICAgICBpZiAocikgewog
ICAgICAgICBnb3RvIGZhaWw7Ci0tIAoyLjI4LjAKCg==


