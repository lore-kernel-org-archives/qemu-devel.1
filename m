Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5023FC35672
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFA52071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="achSNj0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFA52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QW7-00060n-50
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QUy-0004Q6-MX
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QUx-0007ky-Gn
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QUx-0007ki-DA
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhBW9HFWne35mooFHP+yj4bfgYEh6WRtedZja5mcAbU=;
 b=achSNj0ufMOF4y9BLn5ywmaCfBikB5QLFDnUEdhjHp6+ka8ohAUCDy3wloVedPPoFowxC3
 W/xZe+vj1HBu/nlqCSOYcMGPaeBCTgmgHO0SZekvj0NPl+bODVCbO7KPc5PRbg4VsT14na
 8xgXJSS6sTzQUCI2k3KW/KtQyqlaqc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-FQc6l1ICODyu0hyblE6tzg-1; Sat, 22 Feb 2020 03:50:49 -0500
X-MC-Unique: FQc6l1ICODyu0hyblE6tzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A5D913E6;
 Sat, 22 Feb 2020 08:50:47 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88AD55C105;
 Sat, 22 Feb 2020 08:50:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/31] virtio: increase virtqueue size for virtio-scsi and
 virtio-blk
Date: Sat, 22 Feb 2020 08:50:00 +0000
Message-Id: <20200222085030.1760640-2-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+CgpUaGUgZ29h
bCBpcyB0byByZWR1Y2UgdGhlIGFtb3VudCBvZiByZXF1ZXN0cyBpc3N1ZWQgYnkgYSBndWVzdCBv
bgoxTSByZWFkcy93cml0ZXMuIFRoaXMgcmlzZXMgdGhlIHBlcmZvcm1hbmNlIHVwIHRvIDQlIG9u
IHRoYXQga2luZCBvZgpkaXNrIGFjY2VzcyBwYXR0ZXJuLgoKVGhlIG1heGltdW0gY2h1bmsgc2l6
ZSB0byBiZSB1c2VkIGZvciB0aGUgZ3Vlc3QgZGlzayBhY2Nlc3NpbmcgaXMKbGltaXRlZCB3aXRo
IHNlZ19tYXggcGFyYW1ldGVyLCB3aGljaCByZXByZXNlbnRzIHRoZSBtYXggYW1vdW50IG9mCnBp
Y2VzIGluIHRoZSBzY2F0dGVyLWdlYXRoZXIgbGlzdCBpbiBvbmUgZ3Vlc3QgZGlzayByZXF1ZXN0
LgoKU2luY2Ugc2VnX21heCBpcyB2aXJxdWV1ZV9zaXplIGRlcGVuZGVudCwgaW5jcmVhc2luZyB0
aGUgdmlydHF1ZXVlCnNpemUgaW5jcmVhc2VzIHNlZ19tYXgsIHdoaWNoLCBpbiB0dXJuLCBpbmNy
ZWFzZXMgdGhlIG1heGltdW0gc2l6ZQpvZiBkYXRhIHRvIGJlIHJlYWQvd3JpdGUgZnJvbSBhIGd1
ZXN0IGRpc2suCgpNb3JlIGRldGFpbHMgaW4gdGhlIG9yaWdpbmFsIHByb2JsZW0gc3RhdG1lbnQ6
Cmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE3LTEyL21z
ZzAzNzIxLmh0bWwKClN1Z2dlc3RlZC1ieTogRGVuaXMgVi4gTHVuZXYgPGRlbkBvcGVudnoub3Jn
PgpTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNv
bT4KTWVzc2FnZS1pZDogMjAyMDAyMTQwNzQ2NDguOTU4LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8u
Y29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
LS0tCiBody9ibG9jay92aXJ0aW8tYmxrLmMgfCAyICstCiBody9jb3JlL21hY2hpbmUuYyAgICAg
fCAyICsrCiBody9zY3NpL3ZpcnRpby1zY3NpLmMgfCAyICstCiAzIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9ibG9jay92aXJ0
aW8tYmxrLmMgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKaW5kZXggMDlmNDZlZDg1Zi4uMTQyODYz
YTNiMiAxMDA2NDQKLS0tIGEvaHcvYmxvY2svdmlydGlvLWJsay5jCisrKyBiL2h3L2Jsb2NrL3Zp
cnRpby1ibGsuYwpAQCAtMTI3Miw3ICsxMjcyLDcgQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19i
bGtfcHJvcGVydGllc1tdID0gewogICAgIERFRklORV9QUk9QX0JJVCgicmVxdWVzdC1tZXJnaW5n
IiwgVmlydElPQmxvY2ssIGNvbmYucmVxdWVzdF9tZXJnaW5nLCAwLAogICAgICAgICAgICAgICAg
ICAgICB0cnVlKSwKICAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1ZXMiLCBWaXJ0SU9C
bG9jaywgY29uZi5udW1fcXVldWVzLCAxKSwKLSAgICBERUZJTkVfUFJPUF9VSU5UMTYoInF1ZXVl
LXNpemUiLCBWaXJ0SU9CbG9jaywgY29uZi5xdWV1ZV9zaXplLCAxMjgpLAorICAgIERFRklORV9Q
Uk9QX1VJTlQxNigicXVldWUtc2l6ZSIsIFZpcnRJT0Jsb2NrLCBjb25mLnF1ZXVlX3NpemUsIDI1
NiksCiAgICAgREVGSU5FX1BST1BfQk9PTCgic2VnLW1heC1hZGp1c3QiLCBWaXJ0SU9CbG9jaywg
Y29uZi5zZWdfbWF4X2FkanVzdCwgdHJ1ZSksCiAgICAgREVGSU5FX1BST1BfTElOSygiaW90aHJl
YWQiLCBWaXJ0SU9CbG9jaywgY29uZi5pb3RocmVhZCwgVFlQRV9JT1RIUkVBRCwKICAgICAgICAg
ICAgICAgICAgICAgIElPVGhyZWFkICopLApkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMg
Yi9ody9jb3JlL21hY2hpbmUuYwppbmRleCA4NDgxMmExZDFjLi5jZTQwM2NjZWE5IDEwMDY0NAot
LS0gYS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hpbmUuYwpAQCAtMjgsNiAr
MjgsOCBAQAogI2luY2x1ZGUgImh3L21lbS9udmRpbW0uaCIKIAogR2xvYmFsUHJvcGVydHkgaHdf
Y29tcGF0XzRfMltdID0geworICAgIHsgInZpcnRpby1ibGstZGV2aWNlIiwgInF1ZXVlLXNpemUi
LCAiMTI4In0sCisgICAgeyAidmlydGlvLXNjc2ktZGV2aWNlIiwgInZpcnRxdWV1ZV9zaXplIiwg
IjEyOCJ9LAogICAgIHsgInZpcnRpby1ibGstZGV2aWNlIiwgIngtZW5hYmxlLXdjZS1pZi1jb25m
aWctd2NlIiwgIm9mZiIgfSwKICAgICB7ICJ2aXJ0aW8tYmxrLWRldmljZSIsICJzZWctbWF4LWFk
anVzdCIsICJvZmYifSwKICAgICB7ICJ2aXJ0aW8tc2NzaS1kZXZpY2UiLCAic2VnX21heF9hZGp1
c3QiLCAib2ZmIn0sCmRpZmYgLS1naXQgYS9ody9zY3NpL3ZpcnRpby1zY3NpLmMgYi9ody9zY3Np
L3ZpcnRpby1zY3NpLmMKaW5kZXggM2I2MTU2MzYwOS4uNDcyYmJkMjMzYiAxMDA2NDQKLS0tIGEv
aHcvc2NzaS92aXJ0aW8tc2NzaS5jCisrKyBiL2h3L3Njc2kvdmlydGlvLXNjc2kuYwpAQCAtOTY1
LDcgKzk2NSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19zY3NpX2RldmljZV91bnJlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogc3RhdGljIFByb3BlcnR5IHZpcnRpb19zY3Np
X3Byb3BlcnRpZXNbXSA9IHsKICAgICBERUZJTkVfUFJPUF9VSU5UMzIoIm51bV9xdWV1ZXMiLCBW
aXJ0SU9TQ1NJLCBwYXJlbnRfb2JqLmNvbmYubnVtX3F1ZXVlcywgMSksCiAgICAgREVGSU5FX1BS
T1BfVUlOVDMyKCJ2aXJ0cXVldWVfc2l6ZSIsIFZpcnRJT1NDU0ksCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9vYmouY29uZi52aXJ0cXVldWVfc2l6ZSwg
MTI4KSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50X29i
ai5jb25mLnZpcnRxdWV1ZV9zaXplLCAyNTYpLAogICAgIERFRklORV9QUk9QX0JPT0woInNlZ19t
YXhfYWRqdXN0IiwgVmlydElPU0NTSSwKICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfb2Jq
LmNvbmYuc2VnX21heF9hZGp1c3QsIHRydWUpLAogICAgIERFRklORV9QUk9QX1VJTlQzMigibWF4
X3NlY3RvcnMiLCBWaXJ0SU9TQ1NJLCBwYXJlbnRfb2JqLmNvbmYubWF4X3NlY3RvcnMsCi0tIAoy
LjI0LjEKCg==


