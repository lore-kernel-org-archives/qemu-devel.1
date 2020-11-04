Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7293B2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0/El/KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7293B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKll-0006LK-FR
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKaD-0007BZ-97
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKa9-000832-SP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ulu5WTfKThvFXhMzWf4fb+RajwQ6zNcJy1DLo80GnU=;
 b=F0/El/KDBGMxtN1seDD3hqpc3FDcGZwK+/kj5WWTtvAQfjXOQa2LoFhaFNitzJHcMWb0in
 dBvdPnFxUsR61c342VADaLaTxG43Qk2ZuJBYqR1CLQVdoLsSdHujnYFQfdpjbhQMMRrMJH
 AdhfL7fSi/3hQpTrcAmTRhfDx/51aKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Z4_V7bn5OGqRVM8fS94deQ-1; Wed, 04 Nov 2020 10:20:12 -0500
X-MC-Unique: Z4_V7bn5OGqRVM8fS94deQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFD464164;
 Wed,  4 Nov 2020 15:20:10 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3AE05C3E1;
 Wed,  4 Nov 2020 15:20:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/33] block/nvme: Make nvme_init_queue() return boolean
 indicating error
Date: Wed,  4 Nov 2020 15:18:08 +0000
Message-Id: <20201104151828.405824-14-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKSnVzdCBm
b3IgY29uc2lzdGVuY3ksIGZvbGxvd2luZyB0aGUgZXhhbXBsZSBkb2N1bWVudGVkIHNpbmNlCmNv
bW1pdCBlM2ZlMzk4OGQ3ICgiZXJyb3I6IERvY3VtZW50IEVycm9yIEFQSSB1c2FnZSBydWxlcyIp
LApyZXR1cm4gYSBib29sZWFuIHZhbHVlIGluZGljYXRpbmcgYW4gZXJyb3IgaXMgc2V0IG9yIG5v
dC4KRGlyZWN0bHkgcGFzcyBlcnJwIGFzIHRoZSBsb2NhbF9lcnIgaXMgbm90IHJlcXVlc3RlZCBp
biBvdXIKY2FzZS4gVGhpcyBzaW1wbGlmaWVzIGEgYml0IG52bWVfY3JlYXRlX3F1ZXVlX3BhaXIo
KS4KClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRl
c3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6
IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMTItcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgfCAxNiArKysr
KysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCA5ODMz
NTAxMjQ1Li42ZWFiYTRlNzAzIDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxvY2sv
bnZtZS5jCkBAIC0xNjAsNyArMTYwLDggQEAgc3RhdGljIFFlbXVPcHRzTGlzdCBydW50aW1lX29w
dHMgPSB7CiAgICAgfSwKIH07CiAKLXN0YXRpYyB2b2lkIG52bWVfaW5pdF9xdWV1ZShCRFJWTlZN
ZVN0YXRlICpzLCBOVk1lUXVldWUgKnEsCisvKiBSZXR1cm5zIHRydWUgb24gc3VjY2VzcywgZmFs
c2Ugb24gZmFpbHVyZS4gKi8KK3N0YXRpYyBib29sIG52bWVfaW5pdF9xdWV1ZShCRFJWTlZNZVN0
YXRlICpzLCBOVk1lUXVldWUgKnEsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbmVudHJpZXMsIHNpemVfdCBlbnRyeV9ieXRlcywgRXJyb3IgKiplcnJwKQogewogICAgIHNp
emVfdCBieXRlczsKQEAgLTE3MSwxMyArMTcyLDE1IEBAIHN0YXRpYyB2b2lkIG52bWVfaW5pdF9x
dWV1ZShCRFJWTlZNZVN0YXRlICpzLCBOVk1lUXVldWUgKnEsCiAgICAgcS0+cXVldWUgPSBxZW11
X3RyeV9tZW1hbGlnbihzLT5wYWdlX3NpemUsIGJ5dGVzKTsKICAgICBpZiAoIXEtPnF1ZXVlKSB7
CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkNhbm5vdCBhbGxvY2F0ZSBxdWV1ZSIpOwotICAg
ICAgICByZXR1cm47CisgICAgICAgIHJldHVybiBmYWxzZTsKICAgICB9CiAgICAgbWVtc2V0KHEt
PnF1ZXVlLCAwLCBieXRlcyk7CiAgICAgciA9IHFlbXVfdmZpb19kbWFfbWFwKHMtPnZmaW8sIHEt
PnF1ZXVlLCBieXRlcywgZmFsc2UsICZxLT5pb3ZhKTsKICAgICBpZiAocikgewogICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJDYW5ub3QgbWFwIHF1ZXVlIik7CisgICAgICAgIHJldHVybiBmYWxz
ZTsKICAgICB9CisgICAgcmV0dXJuIHRydWU7CiB9CiAKIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9x
dWV1ZV9wYWlyKE5WTWVRdWV1ZVBhaXIgKnEpCkBAIC0yMTAsNyArMjEzLDYgQEAgc3RhdGljIE5W
TWVRdWV1ZVBhaXIgKm52bWVfY3JlYXRlX3F1ZXVlX3BhaXIoQkRSVk5WTWVTdGF0ZSAqcywKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkK
IHsKICAgICBpbnQgaSwgcjsKLSAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsKICAgICBOVk1l
UXVldWVQYWlyICpxOwogICAgIHVpbnQ2NF90IHBycF9saXN0X2lvdmE7CiAKQEAgLTI0NywxNiAr
MjQ5LDEyIEBAIHN0YXRpYyBOVk1lUXVldWVQYWlyICpudm1lX2NyZWF0ZV9xdWV1ZV9wYWlyKEJE
UlZOVk1lU3RhdGUgKnMsCiAgICAgICAgIHJlcS0+cHJwX2xpc3RfaW92YSA9IHBycF9saXN0X2lv
dmEgKyBpICogcy0+cGFnZV9zaXplOwogICAgIH0KIAotICAgIG52bWVfaW5pdF9xdWV1ZShzLCAm
cS0+c3EsIHNpemUsIE5WTUVfU1FfRU5UUllfQllURVMsICZsb2NhbF9lcnIpOwotICAgIGlmIChs
b2NhbF9lcnIpIHsKLSAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7Cisg
ICAgaWYgKCFudm1lX2luaXRfcXVldWUocywgJnEtPnNxLCBzaXplLCBOVk1FX1NRX0VOVFJZX0JZ
VEVTLCBlcnJwKSkgewogICAgICAgICBnb3RvIGZhaWw7CiAgICAgfQogICAgIHEtPnNxLmRvb3Ji
ZWxsID0gJnMtPmRvb3JiZWxsc1tpZHggKiBzLT5kb29yYmVsbF9zY2FsZV0uc3FfdGFpbDsKIAot
ICAgIG52bWVfaW5pdF9xdWV1ZShzLCAmcS0+Y3EsIHNpemUsIE5WTUVfQ1FfRU5UUllfQllURVMs
ICZsb2NhbF9lcnIpOwotICAgIGlmIChsb2NhbF9lcnIpIHsKLSAgICAgICAgZXJyb3JfcHJvcGFn
YXRlKGVycnAsIGxvY2FsX2Vycik7CisgICAgaWYgKCFudm1lX2luaXRfcXVldWUocywgJnEtPmNx
LCBzaXplLCBOVk1FX0NRX0VOVFJZX0JZVEVTLCBlcnJwKSkgewogICAgICAgICBnb3RvIGZhaWw7
CiAgICAgfQogICAgIHEtPmNxLmRvb3JiZWxsID0gJnMtPmRvb3JiZWxsc1tpZHggKiBzLT5kb29y
YmVsbF9zY2FsZV0uY3FfaGVhZDsKLS0gCjIuMjguMAoK


