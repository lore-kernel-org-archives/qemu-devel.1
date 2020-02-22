Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B75C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137D32071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEVX/cEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D32071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qdb-0004bj-88
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QXi-00016P-2L
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QXg-0000pk-Ev
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QXg-0000nU-7b
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDLFsvzVVFsarxb8tZwT/cflFz7/QKPD8bRQoo7WvnE=;
 b=TEVX/cEGGbx0i7htaLGb7PRo1/vIM0BTo6+22GoSi9FaSWseOO5MV6gFKbQbMdicmMH9Xg
 qDLtq1oL5oHK1k+zg7cZU3P1TUx8bHwzWlw3x+E5CKA361Yd9FO5YcoJ/gy3AIeyYg4YFS
 DItDYdxl0lf6m1IkK6e+kyKL3+eCVaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-t3PeEN15O_qXT2MssUeQeQ-1; Sat, 22 Feb 2020 03:53:35 -0500
X-MC-Unique: t3PeEN15O_qXT2MssUeQeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88D9184B121;
 Sat, 22 Feb 2020 08:53:33 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F36D1001B07;
 Sat, 22 Feb 2020 08:53:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] libqtest: make bufwrite rely on the TransportOps
Date: Sat, 22 Feb 2020 08:50:15 +0000
Message-Id: <20200222085030.1760640-17-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpXaGVuIHVzaW5nIHF0ZXN0
ICJpbi1wcm9jZXNzIiBjb21tdW5pY2F0aW9uLCBxdGVzdF9zZW5kZiBkaXJlY3RseSBjYWxscwph
IGZ1bmN0aW9uIGluIHRoZSBzZXJ2ZXIgKHF0ZXN0LmMpLiBQcmV2aW91c2x5LCBidWZ3cml0ZSB1
c2VkCnNvY2tldF9zZW5kLCB3aGljaCBieXBhc3NlcyB0aGUgVHJhbnNwb3J0T3BzIGVuYWJsaW5n
IHRoZSBjYWxsIGludG8KcXRlc3QuYy4gVGhpcyBjaGFuZ2UgcmVwbGFjZXMgdGhlIHNvY2tldF9z
ZW5kIGNhbGxzIHdpdGggb3BzLT5zZW5kLAptYWludGFpbmluZyB0aGUgYmVuZWZpdHMgb2YgdGhl
IGRpcmVjdCBzb2NrZXRfc2VuZCBjYWxsLCB3aGlsZSBhZGRpbmcKc3VwcG9ydCBmb3IgaW4tcHJv
Y2VzcyBxdGVzdCBjYWxscy4KClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxla292IDxhbHhu
ZHJAYnUuZWR1PgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogRGFycmVuIEtlbm55IDxkYXJyZW4ua2VubnlAb3JhY2xlLmNvbT4K
TWVzc2FnZS1pZDogMjAyMDAyMjAwNDExMTguMjMyNjQtOC1hbHhuZHJAYnUuZWR1ClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0cy9x
dGVzdC9saWJxdGVzdC5jIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tCiB0ZXN0cy9xdGVzdC9saWJxdGVzdC5oIHwgIDQgKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDczIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRl
c3QvbGlicXRlc3QuYyBiL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmMKaW5kZXggZTUwNTZhMWQwZi4u
NDkwNzViNTVhMSAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvbGlicXRlc3QuYworKysgYi90ZXN0
cy9xdGVzdC9saWJxdGVzdC5jCkBAIC0zNywxMCArMzcsMTggQEAKIAogCiB0eXBlZGVmIHZvaWQg
KCpRVGVzdFNlbmRGbikoUVRlc3RTdGF0ZSAqcywgY29uc3QgY2hhciAqYnVmKTsKK3R5cGVkZWYg
dm9pZCAoKkV4dGVybmFsU2VuZEZuKSh2b2lkICpzLCBjb25zdCBjaGFyICpidWYpOwogdHlwZWRl
ZiBHU3RyaW5nKiAoKlFUZXN0UmVjdkZuKShRVGVzdFN0YXRlICopOwogCiB0eXBlZGVmIHN0cnVj
dCBRVGVzdENsaWVudFRyYW5zcG9ydE9wcyB7CiAgICAgUVRlc3RTZW5kRm4gICAgIHNlbmQ7ICAg
ICAgLyogZm9yIHNlbmRpbmcgcXRlc3QgY29tbWFuZHMgKi8KKworICAgIC8qCisgICAgICogdXNl
IGV4dGVybmFsX3NlbmQgdG8gc2VuZCBxdGVzdCBjb21tYW5kIHN0cmluZ3MgdGhyb3VnaCBmdW5j
dGlvbnMgd2hpY2gKKyAgICAgKiBkbyBub3QgYWNjZXB0IGEgUVRlc3RTdGF0ZSBhcyB0aGUgZmly
c3QgcGFyYW1ldGVyLgorICAgICAqLworICAgIEV4dGVybmFsU2VuZEZuICBleHRlcm5hbF9zZW5k
OworCiAgICAgUVRlc3RSZWN2Rm4gICAgIHJlY3ZfbGluZTsgLyogZm9yIHJlY2VpdmluZyBxdGVz
dCBjb21tYW5kIHJlc3BvbnNlcyAqLwogfSBRVGVzdFRyYW5zcG9ydE9wczsKIApAQCAtMTA3OCw4
ICsxMDg2LDggQEAgdm9pZCBxdGVzdF9idWZ3cml0ZShRVGVzdFN0YXRlICpzLCB1aW50NjRfdCBh
ZGRyLCBjb25zdCB2b2lkICpkYXRhLCBzaXplX3Qgc2l6ZSkKIAogICAgIGJkYXRhID0gZ19iYXNl
NjRfZW5jb2RlKGRhdGEsIHNpemUpOwogICAgIHF0ZXN0X3NlbmRmKHMsICJiNjR3cml0ZSAweCUi
IFBSSXg2NCAiIDB4JXp4ICIsIGFkZHIsIHNpemUpOwotICAgIHNvY2tldF9zZW5kKHMtPmZkLCBi
ZGF0YSwgc3RybGVuKGJkYXRhKSk7Ci0gICAgc29ja2V0X3NlbmQocy0+ZmQsICJcbiIsIDEpOwor
ICAgIHMtPm9wcy5zZW5kKHMsIGJkYXRhKTsKKyAgICBzLT5vcHMuc2VuZChzLCAiXG4iKTsKICAg
ICBxdGVzdF9yc3AocywgMCk7CiAgICAgZ19mcmVlKGJkYXRhKTsKIH0KQEAgLTEzNjcsMyArMTM3
NSw2MiBAQCBzdGF0aWMgdm9pZCBxdGVzdF9jbGllbnRfc2V0X3J4X2hhbmRsZXIoUVRlc3RTdGF0
ZSAqcywgUVRlc3RSZWN2Rm4gcmVjdikKIHsKICAgICBzLT5vcHMucmVjdl9saW5lID0gcmVjdjsK
IH0KKy8qIEEgdHlwZS1zYWZlIHdyYXBwZXIgZm9yIHMtPnNlbmQoKSAqLworc3RhdGljIHZvaWQg
c2VuZF93cmFwcGVyKFFUZXN0U3RhdGUgKnMsIGNvbnN0IGNoYXIgKmJ1ZikKK3sKKyAgICBzLT5v
cHMuZXh0ZXJuYWxfc2VuZChzLCBidWYpOworfQorCitzdGF0aWMgR1N0cmluZyAqcXRlc3RfY2xp
ZW50X2lucHJvY19yZWN2X2xpbmUoUVRlc3RTdGF0ZSAqcykKK3sKKyAgICBHU3RyaW5nICpsaW5l
OworICAgIHNpemVfdCBvZmZzZXQ7CisgICAgY2hhciAqZW9sOworCisgICAgZW9sID0gc3RyY2hy
KHMtPnJ4LT5zdHIsICdcbicpOworICAgIG9mZnNldCA9IGVvbCAtIHMtPnJ4LT5zdHI7CisgICAg
bGluZSA9IGdfc3RyaW5nX25ld19sZW4ocy0+cngtPnN0ciwgb2Zmc2V0KTsKKyAgICBnX3N0cmlu
Z19lcmFzZShzLT5yeCwgMCwgb2Zmc2V0ICsgMSk7CisgICAgcmV0dXJuIGxpbmU7Cit9CisKK1FU
ZXN0U3RhdGUgKnF0ZXN0X2lucHJvY19pbml0KFFUZXN0U3RhdGUgKipzLCBib29sIGxvZywgY29u
c3QgY2hhciogYXJjaCwKKyAgICAgICAgICAgICAgICAgICAgdm9pZCAoKnNlbmQpKHZvaWQqLCBj
b25zdCBjaGFyKikpCit7CisgICAgUVRlc3RTdGF0ZSAqcXRzOworICAgIHF0cyA9IGdfbmV3MChR
VGVzdFN0YXRlLCAxKTsKKyAgICAqcyA9IHF0czsgLyogRXhwb3NlIHF0cyBlYXJseSBvbiwgc2lu
Y2UgdGhlIHF1ZXJ5IGVuZGlhbm5lc3MgcmVsaWVzIG9uIGl0ICovCisgICAgcXRzLT53c3RhdHVz
ID0gMDsKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IE1BWF9JUlE7IGkrKykgeworICAgICAgICBx
dHMtPmlycV9sZXZlbFtpXSA9IGZhbHNlOworICAgIH0KKworICAgIHF0ZXN0X2NsaWVudF9zZXRf
cnhfaGFuZGxlcihxdHMsIHF0ZXN0X2NsaWVudF9pbnByb2NfcmVjdl9saW5lKTsKKworICAgIC8q
IHNlbmQoKSBtYXkgbm90IGhhdmUgYSBtYXRjaGluZyBwcm90b3lwZSwgc28gdXNlIGEgdHlwZS1z
YWZlIHdyYXBwZXIgKi8KKyAgICBxdHMtPm9wcy5leHRlcm5hbF9zZW5kID0gc2VuZDsKKyAgICBx
dGVzdF9jbGllbnRfc2V0X3R4X2hhbmRsZXIocXRzLCBzZW5kX3dyYXBwZXIpOworCisgICAgcXRz
LT5iaWdfZW5kaWFuID0gcXRlc3RfcXVlcnlfdGFyZ2V0X2VuZGlhbm5lc3MocXRzKTsKKworICAg
IC8qCisgICAgICogU2V0IGEgZHVtbXkgcGF0aCBmb3IgUVRFU1RfUUVNVV9CSU5BUlkuIERvZXNu
J3QgbmVlZCB0byBleGlzdCwgYnV0IHRoaXMKKyAgICAgKiB3YXksIHF0ZXN0X2dldF9hcmNoIHdv
cmtzIGZvciBpbnByb2MgcXRlc3QuCisgICAgICovCisgICAgZ2NoYXIgKmJpbl9wYXRoID0gZ19z
dHJjb25jYXQoIi9xZW11LXN5c3RlbS0iLCBhcmNoLCBOVUxMKTsKKyAgICBzZXRlbnYoIlFURVNU
X1FFTVVfQklOQVJZIiwgYmluX3BhdGgsIDApOworICAgIGdfZnJlZShiaW5fcGF0aCk7CisKKyAg
ICByZXR1cm4gcXRzOworfQorCit2b2lkIHF0ZXN0X2NsaWVudF9pbnByb2NfcmVjdih2b2lkICpv
cGFxdWUsIGNvbnN0IGNoYXIgKnN0cikKK3sKKyAgICBRVGVzdFN0YXRlICpxdHMgPSAqKFFUZXN0
U3RhdGUgKiopb3BhcXVlOworCisgICAgaWYgKCFxdHMtPnJ4KSB7CisgICAgICAgIHF0cy0+cngg
PSBnX3N0cmluZ19uZXcoTlVMTCk7CisgICAgfQorICAgIGdfc3RyaW5nX2FwcGVuZChxdHMtPnJ4
LCBzdHIpOworICAgIHJldHVybjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmggYi90ZXN0cy9xdGVzdC9saWJxdGVzdC5oCmluZGV4IGM5ZTIxZTA1YjMuLmY1Y2Y5M2MzODYg
MTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmgKKysrIGIvdGVzdHMvcXRlc3QvbGli
cXRlc3QuaApAQCAtNzI5LDQgKzcyOSw4IEBAIGJvb2wgcXRlc3RfcHJvYmVfY2hpbGQoUVRlc3RT
dGF0ZSAqcyk7CiAgKi8KIHZvaWQgcXRlc3Rfc2V0X2V4cGVjdGVkX3N0YXR1cyhRVGVzdFN0YXRl
ICpzLCBpbnQgc3RhdHVzKTsKIAorUVRlc3RTdGF0ZSAqcXRlc3RfaW5wcm9jX2luaXQoUVRlc3RT
dGF0ZSAqKnMsIGJvb2wgbG9nLCBjb25zdCBjaGFyKiBhcmNoLAorICAgICAgICAgICAgICAgICAg
ICB2b2lkICgqc2VuZCkodm9pZCosIGNvbnN0IGNoYXIqKSk7CisKK3ZvaWQgcXRlc3RfY2xpZW50
X2lucHJvY19yZWN2KHZvaWQgKm9wYXF1ZSwgY29uc3QgY2hhciAqc3RyKTsKICNlbmRpZgotLSAK
Mi4yNC4xCgo=


