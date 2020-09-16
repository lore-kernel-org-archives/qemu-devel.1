Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5492220E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USJMFd8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5492220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUIU-0005ne-6D
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6t-0006BJ-Qr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6r-0000du-Ri
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgsgLUowiBqZlz5+WiOQFwOsVeKJ0sRt4MwusZZWNVI=;
 b=USJMFd8aeH1SEHIMAI5SR7WHcjDSRqtnDxWsagGWuDgLTLOkDo/ICYoiCdk9+wGoaF9Ehy
 Xdt7p0yJSNcMyy94NQccz3kdrGkC4x21tmBtzt0lQCGqKc+W3vCv8dURmr8YHxw/Y7BtQ1
 Xi0ABDOaokR+RXwJeenhc4tKPMy65Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-83ZCLrD9MBayvWt8Ww3O8g-1; Wed, 16 Sep 2020 05:52:15 -0400
X-MC-Unique: 83ZCLrD9MBayvWt8Ww3O8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14E848030CB;
 Wed, 16 Sep 2020 09:52:14 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A976560BFA;
 Wed, 16 Sep 2020 09:52:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hostmem-file: add readonly=on|off option
Date: Wed, 16 Sep 2020 10:51:49 +0100
Message-Id: <20200916095150.755714-3-stefanha@redhat.com>
In-Reply-To: <20200916095150.755714-1-stefanha@redhat.com>
References: <20200916095150.755714-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, eric.g.ernst@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TGV0IC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSB3b3JrIG9uIHJlYWQtb25seSBmaWxlcyB3
aGVuIHRoZQpyZWFkb25seT1vbiBvcHRpb24gaXMgZ2l2ZW4uIFRoaXMgY2FuIGJlIHVzZWQgdG8g
c2hhcmUgdGhlIGNvbnRlbnRzIG9mIGEKZmlsZSBiZXR3ZWVuIG11bHRpcGxlIGd1ZXN0cyB3aGls
ZSBwcmV2ZW50aW5nIHRoZW0gZnJvbSBjb25zdW1pbmcKQ29weS1vbi1Xcml0ZSBtZW1vcnkgaWYg
Z3Vlc3RzIGRpcnR5IHRoZSBwYWdlcywgZm9yIGV4YW1wbGUuCgpBY2tlZC1ieTogTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3pp
IDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGJhY2tlbmRzL2hvc3RtZW0tZmlsZS5jIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKysrKy0KIHFlbXUtb3B0aW9ucy5oeCAgICAgICAgIHwgIDUg
KysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9iYWNrZW5kcy9ob3N0bWVtLWZpbGUuYyBiL2JhY2tlbmRzL2hvc3RtZW0t
ZmlsZS5jCmluZGV4IGRmZmRmMTQyZTAuLmRhNTg1ZTQzMDAgMTAwNjQ0Ci0tLSBhL2JhY2tlbmRz
L2hvc3RtZW0tZmlsZS5jCisrKyBiL2JhY2tlbmRzL2hvc3RtZW0tZmlsZS5jCkBAIC0zMSw2ICsz
MSw3IEBAIHN0cnVjdCBIb3N0TWVtb3J5QmFja2VuZEZpbGUgewogICAgIHVpbnQ2NF90IGFsaWdu
OwogICAgIGJvb2wgZGlzY2FyZF9kYXRhOwogICAgIGJvb2wgaXNfcG1lbTsKKyAgICBib29sIHJl
YWRvbmx5OwogfTsKIAogc3RhdGljIHZvaWQKQEAgLTU4LDcgKzU5LDcgQEAgZmlsZV9iYWNrZW5k
X21lbW9yeV9hbGxvYyhIb3N0TWVtb3J5QmFja2VuZCAqYmFja2VuZCwgRXJyb3IgKiplcnJwKQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJhY2tlbmQtPnNpemUsIGZiLT5h
bGlnbiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYmFja2VuZC0+c2hh
cmUgPyBSQU1fU0hBUkVEIDogMCkgfAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChmYi0+aXNfcG1lbSA/IFJBTV9QTUVNIDogMCksCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZmItPm1lbV9wYXRoLCBmYWxzZSwgZXJycCk7CisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmItPm1lbV9wYXRoLCBmYi0+cmVhZG9ubHksIGVycnAp
OwogICAgIGdfZnJlZShuYW1lKTsKICNlbmRpZgogfQpAQCAtMTUzLDYgKzE1NCwyNiBAQCBzdGF0
aWMgdm9pZCBmaWxlX21lbW9yeV9iYWNrZW5kX3NldF9wbWVtKE9iamVjdCAqbywgYm9vbCB2YWx1
ZSwgRXJyb3IgKiplcnJwKQogICAgIGZiLT5pc19wbWVtID0gdmFsdWU7CiB9CiAKK3N0YXRpYyBi
b29sIGZpbGVfbWVtb3J5X2JhY2tlbmRfZ2V0X3JlYWRvbmx5KE9iamVjdCAqbywgRXJyb3IgKipl
cnJwKQoreworICAgIHJldHVybiBNRU1PUllfQkFDS0VORF9GSUxFKG8pLT5yZWFkb25seTsKK30K
Kworc3RhdGljIHZvaWQgZmlsZV9tZW1vcnlfYmFja2VuZF9zZXRfcmVhZG9ubHkoT2JqZWN0ICpv
LCBib29sIHZhbHVlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKQoreworICAgIEhvc3RNZW1vcnlCYWNrZW5kICpiYWNrZW5kID0gTUVN
T1JZX0JBQ0tFTkQobyk7CisgICAgSG9zdE1lbW9yeUJhY2tlbmRGaWxlICpmYiA9IE1FTU9SWV9C
QUNLRU5EX0ZJTEUobyk7CisKKyAgICBpZiAoaG9zdF9tZW1vcnlfYmFja2VuZF9tcl9pbml0ZWQo
YmFja2VuZCkpIHsKKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiY2Fubm90IGNoYW5nZSBwcm9w
ZXJ0eSAncmVhZG9ubHknIG9mICVzLiIsCisgICAgICAgICAgICAgICAgICAgb2JqZWN0X2dldF90
eXBlbmFtZShvKSk7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBmYi0+cmVhZG9ubHkg
PSB2YWx1ZTsKK30KKwogc3RhdGljIHZvaWQgZmlsZV9iYWNrZW5kX3VucGFyZW50KE9iamVjdCAq
b2JqKQogewogICAgIEhvc3RNZW1vcnlCYWNrZW5kICpiYWNrZW5kID0gTUVNT1JZX0JBQ0tFTkQo
b2JqKTsKQEAgLTE4NCw2ICsyMDUsOSBAQCBmaWxlX2JhY2tlbmRfY2xhc3NfaW5pdChPYmplY3RD
bGFzcyAqb2MsIHZvaWQgKmRhdGEpCiAgICAgICAgIE5VTEwsIE5VTEwpOwogICAgIG9iamVjdF9j
bGFzc19wcm9wZXJ0eV9hZGRfYm9vbChvYywgInBtZW0iLAogICAgICAgICBmaWxlX21lbW9yeV9i
YWNrZW5kX2dldF9wbWVtLCBmaWxlX21lbW9yeV9iYWNrZW5kX3NldF9wbWVtKTsKKyAgICBvYmpl
Y3RfY2xhc3NfcHJvcGVydHlfYWRkX2Jvb2wob2MsICJyZWFkb25seSIsCisgICAgICAgIGZpbGVf
bWVtb3J5X2JhY2tlbmRfZ2V0X3JlYWRvbmx5LAorICAgICAgICBmaWxlX21lbW9yeV9iYWNrZW5k
X3NldF9yZWFkb25seSk7CiB9CiAKIHN0YXRpYyB2b2lkIGZpbGVfYmFja2VuZF9pbnN0YW5jZV9m
aW5hbGl6ZShPYmplY3QgKm8pCmRpZmYgLS1naXQgYS9xZW11LW9wdGlvbnMuaHggYi9xZW11LW9w
dGlvbnMuaHgKaW5kZXggYjBmMDIwNTk0ZS4uM2RmYWFkZGQ2MiAxMDA2NDQKLS0tIGEvcWVtdS1v
cHRpb25zLmh4CisrKyBiL3FlbXUtb3B0aW9ucy5oeApAQCAtNDM2OSw3ICs0MzY5LDcgQEAgU1JT
VAogICAgIHRoZXkgYXJlIHNwZWNpZmllZC4gTm90ZSB0aGF0IHRoZSAnaWQnIHByb3BlcnR5IG11
c3QgYmUgc2V0LiBUaGVzZQogICAgIG9iamVjdHMgYXJlIHBsYWNlZCBpbiB0aGUgJy9vYmplY3Rz
JyBwYXRoLgogCi0gICAgYGAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUsaWQ9aWQsc2l6ZT1z
aXplLG1lbS1wYXRoPWRpcixzaGFyZT1vbnxvZmYsZGlzY2FyZC1kYXRhPW9ufG9mZixtZXJnZT1v
bnxvZmYsZHVtcD1vbnxvZmYscHJlYWxsb2M9b258b2ZmLGhvc3Qtbm9kZXM9aG9zdC1ub2Rlcyxw
b2xpY3k9ZGVmYXVsdHxwcmVmZXJyZWR8YmluZHxpbnRlcmxlYXZlLGFsaWduPWFsaWduYGAKKyAg
ICBgYC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1pZCxzaXplPXNpemUsbWVtLXBhdGg9
ZGlyLHNoYXJlPW9ufG9mZixkaXNjYXJkLWRhdGE9b258b2ZmLG1lcmdlPW9ufG9mZixkdW1wPW9u
fG9mZixwcmVhbGxvYz1vbnxvZmYsaG9zdC1ub2Rlcz1ob3N0LW5vZGVzLHBvbGljeT1kZWZhdWx0
fHByZWZlcnJlZHxiaW5kfGludGVybGVhdmUsYWxpZ249YWxpZ24scmVhZG9ubHk9b258b2ZmYGAK
ICAgICAgICAgQ3JlYXRlcyBhIG1lbW9yeSBmaWxlIGJhY2tlbmQgb2JqZWN0LCB3aGljaCBjYW4g
YmUgdXNlZCB0byBiYWNrCiAgICAgICAgIHRoZSBndWVzdCBSQU0gd2l0aCBodWdlIHBhZ2VzLgog
CkBAIC00NDUyLDYgKzQ0NTIsOSBAQCBTUlNUCiAgICAgICAgIDQuMTUpIGFuZCB0aGUgZmlsZXN5
c3RlbSBvZiBgYG1lbS1wYXRoYGAgbW91bnRlZCB3aXRoIERBWAogICAgICAgICBvcHRpb24uCiAK
KyAgICAgICAgVGhlIGBgcmVhZG9ubHlgYCBvcHRpb24gc3BlY2lmaWVzIHdoZXRoZXIgdGhlIGJh
Y2tpbmcgZmlsZSBpcyBvcGVuZWQKKyAgICAgICAgcmVhZC1vbmx5IG9yIHJlYWQtd3JpdGUgKGRl
ZmF1bHQpLgorCiAgICAgYGAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1pZCxtZXJnZT1v
bnxvZmYsZHVtcD1vbnxvZmYsc2hhcmU9b258b2ZmLHByZWFsbG9jPW9ufG9mZixzaXplPXNpemUs
aG9zdC1ub2Rlcz1ob3N0LW5vZGVzLHBvbGljeT1kZWZhdWx0fHByZWZlcnJlZHxiaW5kfGludGVy
bGVhdmVgYAogICAgICAgICBDcmVhdGVzIGEgbWVtb3J5IGJhY2tlbmQgb2JqZWN0LCB3aGljaCBj
YW4gYmUgdXNlZCB0byBiYWNrIHRoZQogICAgICAgICBndWVzdCBSQU0uIE1lbW9yeSBiYWNrZW5k
IG9iamVjdHMgb2ZmZXIgbW9yZSBjb250cm9sIHRoYW4gdGhlCi0tIAoyLjI2LjIKCg==


