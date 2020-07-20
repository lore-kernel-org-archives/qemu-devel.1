Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B31521775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8kpOS2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B31521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSdO-0004Hs-NX
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxScS-0003fm-9O
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxScM-0007jJ-90
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595239312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IYFN08AFXnRWf+5Ps86TQXspIdKFqgDww/qh8IKOHss=;
 b=P8kpOS2GMBhMSw1iOIPT7vJATp1A3r276+IfW89NGXLULMBGdqsT1sbjuB7wgzkLDbHDP4
 CuYZAPZeC62fhMw3jQVHTi7wdvpOSax76OIxM551aOp7ZarKDpFImHDM0BaPBwR53g3cGe
 PS1AeNhXWAJOCo7Gjx1vQFel3ULZUyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-zag3b9fSN36rLsDeDRpKgQ-1; Mon, 20 Jul 2020 06:01:48 -0400
X-MC-Unique: zag3b9fSN36rLsDeDRpKgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43057193F567;
 Mon, 20 Jul 2020 10:01:47 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF8D87303;
 Mon, 20 Jul 2020 10:01:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] block: fix bdrv_aio_cancel() for ENOMEDIUM requests
Date: Mon, 20 Jul 2020 11:01:41 +0100
Message-Id: <20200720100141.129739-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YmRydl9haW9fY2FuY2VsKCkgY2FsbHMgYWlvX3BvbGwoKSBvbiB0aGUgQWlvQ29udGV4dCBmb3Ig
dGhlIGdpdmVuIEkvTwpyZXF1ZXN0IHVudGlsIGl0IGhhcyBjb21wbGV0ZWQuIEVOT01FRElVTSBy
ZXF1ZXN0cyBhcmUgc3BlY2lhbCBiZWNhdXNlCnRoZXJlIGlzIG5vIEJsb2NrRHJpdmVyU3RhdGUg
d2hlbiB0aGUgZHJpdmUgaGFzIG5vIG1lZGl1bSEKCkRlZmluZSBhIC5nZXRfYWlvX2NvbnRleHQo
KSBmdW5jdGlvbiBmb3IgQmxrQWlvRW1BSU9DQiByZXF1ZXN0cyBzbyB0aGF0CmJkcnZfYWlvX2Nh
bmNlbCgpIGNhbiBmaW5kIHRoZSBBaW9Db250ZXh0IHdoZXJlIHRoZSBjb21wbGV0aW9uIEJIIGlz
CnBlbmRpbmcuIFdpdGhvdXQgdGhpcyBmdW5jdGlvbiBiZHJ2X2Fpb19jYW5jZWwoKSBhYm9ydHMg
b24gRU5PTUVESVVNCnJlcXVlc3RzIQoKbGliRnV6emVyIHRyaWdnZXJlZCB0aGUgZm9sbG93aW5n
IGFzc2VydGlvbjoKCiAgY2F0IDw8IEVPRiB8IHFlbXUtc3lzdGVtLWkzODYgLU0gcGMtcTM1LTUu
MCBcCiAgICAtbm9ncmFwaGljIC1tb25pdG9yIG5vbmUgLXNlcmlhbCBub25lIFwKICAgIC1xdGVz
dCBzdGRpbyAtdHJhY2UgaWRlXCoKICBvdXRsIDB4Y2Y4IDB4ODAwMGZhMjQKICBvdXRsIDB4Y2Zj
IDB4ZTEwNmMwMDAKICBvdXRsIDB4Y2Y4IDB4ODAwMGZhMDQKICBvdXR3IDB4Y2ZjIDB4NwogIG91
dGwgMHhjZjggMHg4MDAwZmIyMAogIHdyaXRlIDB4MCAweDMgMHgyNzgwZTcKICB3cml0ZSAweGUx
MDZjMjJjIDB4ZCAweDExMzBjMjE4MDIxMTMwYzIxODAyMTEzMGMyCiAgd3JpdGUgMHhlMTA2YzIx
OCAweDE1IDB4MTEwMDEwMTEwMDEwMTEwMDEwMTEwMDEwMTEwMDEwMTEwMDEwMTEwMDEwCiAgRU9G
CiAgaWRlX2V4ZWNfY21kIElERSBleGVjIGNtZDogYnVzIDB4NTYxNzBhNzdhMmI4OyBzdGF0ZSAw
eDU2MTcwYTc3YTM0MDsgY21kIDB4ZTcKICBpZGVfcmVzZXQgSURFc3RhdGUgMHg1NjE3MGE3N2Ez
NDAKICBBYm9ydGVkIChjb3JlIGR1bXBlZCkKCiAgKGdkYikgYnQKICAjMSAgMHgwMDAwN2ZmZmY0
ZjkzODk1IGluIGFib3J0ICgpIGF0IC9saWI2NC9saWJjLnNvLjYKICAjMiAgMHgwMDAwNTU1NTU1
ZGM2YzAwIGluIGJkcnZfYWlvX2NhbmNlbCAoYWNiPTB4NTU1NTU2NzY1NTUwKSBhdCBibG9jay9p
by5jOjI3NDUKICAjMyAgMHgwMDAwNTU1NTU1ZGFjMjAyIGluIGJsa19haW9fY2FuY2VsIChhY2I9
MHg1NTU1NTY3NjU1NTApIGF0IGJsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNTQ2CiAgIzQgIDB4MDAw
MDU1NTU1NWIxYmQ3NCBpbiBpZGVfcmVzZXQgKHM9MHg1NTU1NTcyMTMzNDApIGF0IGh3L2lkZS9j
b3JlLmM6MTMxOAogICM1ICAweDAwMDA1NTU1NTViMWUzYTEgaW4gaWRlX2J1c19yZXNldCAoYnVz
PTB4NTU1NTU3MjEzMmI4KSBhdCBody9pZGUvY29yZS5jOjI0MjIKICAjNiAgMHgwMDAwNTU1NTU1
YjJhYTI3IGluIGFoY2lfcmVzZXRfcG9ydCAocz0weDU1NTU1NzIwZWI1MCwgcG9ydD0yKSBhdCBo
dy9pZGUvYWhjaS5jOjY1MAogICM3ICAweDAwMDA1NTU1NTViMjlmZDcgaW4gYWhjaV9wb3J0X3dy
aXRlIChzPTB4NTU1NTU3MjBlYjUwLCBwb3J0PTIsIG9mZnNldD00NCwgdmFsPTE2KSBhdCBody9p
ZGUvYWhjaS5jOjM2MAogICM4ICAweDAwMDA1NTU1NTViMmE1NjQgaW4gYWhjaV9tZW1fd3JpdGUg
KG9wYXF1ZT0weDU1NTU1NzIwZWI1MCwgYWRkcj01NTYsIHZhbD0xNiwgc2l6ZT0xKSBhdCBody9p
ZGUvYWhjaS5jOjUxMwogICM5ICAweDAwMDA1NTU1NTU5ODQxNWIgaW4gbWVtb3J5X3JlZ2lvbl93
cml0ZV9hY2Nlc3NvciAobXI9MHg1NTU1NTcyMGViODAsIGFkZHI9NTU2LCB2YWx1ZT0weDdmZmZm
ZmZmYjgzOCwgc2l6ZT0xLCBzaGlmdD0wLCBtYXNrPTI1NSwgYXR0cnM9Li4uKSBhdCBzb2Z0bW11
L21lbW9yeS5jOjQ4MwoKTG9va2luZyBhdCBiZHJ2X2Fpb19jYW5jZWw6CgoyNzI4IC8qIGFzeW5j
IEkvT3MgKi8KMjcyOQoyNzMwIHZvaWQgYmRydl9haW9fY2FuY2VsKEJsb2NrQUlPQ0IgKmFjYikK
MjczMSB7CjI3MzIgICAgIHFlbXVfYWlvX3JlZihhY2IpOwoyNzMzICAgICBiZHJ2X2Fpb19jYW5j
ZWxfYXN5bmMoYWNiKTsKMjczNCAgICAgd2hpbGUgKGFjYi0+cmVmY250ID4gMSkgewoyNzM1ICAg
ICAgICAgaWYgKGFjYi0+YWlvY2JfaW5mby0+Z2V0X2Fpb19jb250ZXh0KSB7CjI3MzYgICAgICAg
ICAgICAgYWlvX3BvbGwoYWNiLT5haW9jYl9pbmZvLT5nZXRfYWlvX2NvbnRleHQoYWNiKSwgdHJ1
ZSk7CjI3MzcgICAgICAgICB9IGVsc2UgaWYgKGFjYi0+YnMpIHsKMjczOCAgICAgICAgICAgICAv
KiBxZW11X2Fpb19yZWYgYW5kIHFlbXVfYWlvX3VucmVmIGFyZSBub3QgdGhyZWFkLXNhZmUsIHNv
CjI3MzkgICAgICAgICAgICAgICogYXNzZXJ0IHRoYXQgd2UncmUgbm90IHVzaW5nIGFuIEkvTyB0
aHJlYWQuICBUaHJlYWQtc2FmZQoyNzQwICAgICAgICAgICAgICAqIGNvZGUgc2hvdWxkIHVzZSBi
ZHJ2X2Fpb19jYW5jZWxfYXN5bmMgZXhjbHVzaXZlbHkuCjI3NDEgICAgICAgICAgICAgICovCjI3
NDIgICAgICAgICAgICAgYXNzZXJ0KGJkcnZfZ2V0X2Fpb19jb250ZXh0KGFjYi0+YnMpID09IHFl
bXVfZ2V0X2Fpb19jb250ZXh0KCkpOwoyNzQzICAgICAgICAgICAgIGFpb19wb2xsKGJkcnZfZ2V0
X2Fpb19jb250ZXh0KGFjYi0+YnMpLCB0cnVlKTsKMjc0NCAgICAgICAgIH0gZWxzZSB7CjI3NDUg
ICAgICAgICAgICAgYWJvcnQoKTsgICAgIDw9PT09PT09PT09PT09PT0KMjc0NiAgICAgICAgIH0K
Mjc0NyAgICAgfQoyNzQ4ICAgICBxZW11X2Fpb191bnJlZihhY2IpOwoyNzQ5IH0KCkZpeGVzOiAw
MmM1MGVmZTA4NzM2MTE2MDQ4ZDVmYzM1NTA0MzA4MGY0ZDU4NTljICgiYmxvY2s6IEFkZCBiZHJ2
X2Fpb19jYW5jZWxfYXN5bmMiKQpSZXBvcnRlZC1ieTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5k
ckBidS5lZHU+CkJ1Z2xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L3FlbXUvK2J1Zy8x
ODc4MjU1Ck9yaWdpbmFsbHktYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNh
dC5vcmc+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiBibG9jay9ibG9jay1iYWNrZW5kLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxvY2stYmFja2VuZC5jIGIv
YmxvY2svYmxvY2stYmFja2VuZC5jCmluZGV4IDBiZjAxODgxMzMuLjNhMTNjYjVmMGIgMTAwNjQ0
Ci0tLSBhL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYworKysgYi9ibG9jay9ibG9jay1iYWNrZW5kLmMK
QEAgLTEzOTQsOCArMTM5NCwxNiBAQCB0eXBlZGVmIHN0cnVjdCBCbGtBaW9FbUFJT0NCIHsKICAg
ICBib29sIGhhc19yZXR1cm5lZDsKIH0gQmxrQWlvRW1BSU9DQjsKIAorc3RhdGljIEFpb0NvbnRl
eHQgKmJsa19haW9fZW1fYWlvY2JfZ2V0X2Fpb19jb250ZXh0KEJsb2NrQUlPQ0IgKmFjYl8pCit7
CisgICAgQmxrQWlvRW1BSU9DQiAqYWNiID0gY29udGFpbmVyX29mKGFjYl8sIEJsa0Fpb0VtQUlP
Q0IsIGNvbW1vbik7CisKKyAgICByZXR1cm4gYmxrX2dldF9haW9fY29udGV4dChhY2ItPnJ3Y28u
YmxrKTsKK30KKwogc3RhdGljIGNvbnN0IEFJT0NCSW5mbyBibGtfYWlvX2VtX2Fpb2NiX2luZm8g
PSB7CiAgICAgLmFpb2NiX3NpemUgICAgICAgICA9IHNpemVvZihCbGtBaW9FbUFJT0NCKSwKKyAg
ICAuZ2V0X2Fpb19jb250ZXh0ICAgID0gYmxrX2Fpb19lbV9haW9jYl9nZXRfYWlvX2NvbnRleHQs
CiB9OwogCiBzdGF0aWMgdm9pZCBibGtfYWlvX2NvbXBsZXRlKEJsa0Fpb0VtQUlPQ0IgKmFjYikK
LS0gCjIuMjYuMgoK


