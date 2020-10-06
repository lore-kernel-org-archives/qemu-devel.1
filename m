Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26048C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F80E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bINGIaTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F80E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjmN-0005pN-1R
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPjkU-0004LX-2g
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPjkR-0004Ik-FS
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ef4nEw92T7XryGjdWU85hpW8vouiPoI2HxKv7tDMlcM=;
 b=bINGIaTXGzr3dpWFul89zLPClE89pl2bH5Nbat/ZtQ8tlSr5VzU+H9AFLYORmrHtJmDsWi
 l8cV3tswa3yZrbtg0XgVNnXqSBLtIYqjC22udrggscHzCDyaru/oDh41uTmgO5UtToG54I
 6n+m49lMQ19sdxle8uTTDSjMYaBMZgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-uUA4l7IRPwGxYYRMrc-cxQ-1; Tue, 06 Oct 2020 05:59:04 -0400
X-MC-Unique: uUA4l7IRPwGxYYRMrc-cxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED72864080
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 09:59:03 +0000 (UTC)
Received: from localhost (ovpn-112-180.ams2.redhat.com [10.36.112.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA0473A40;
 Tue,  6 Oct 2020 09:58:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: avoid /proc/self/fd tempdir
Date: Tue,  6 Oct 2020 10:58:26 +0100
Message-Id: <20201006095826.59813-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gb3JkZXIgdG8gcHJldmVudCAvcHJvYy9zZWxmL2ZkIGVzY2FwZXMgYSB0ZW1wb3JhcnkgZGly
ZWN0b3J5IGlzCmNyZWF0ZWQgd2hlcmUgL3Byb2Mvc2VsZi9mZCBpcyBiaW5kLW1vdW50ZWQuIFRo
aXMgZG9lc24ndCB3b3JrIG9uCnJlYWQtb25seSBmaWxlIHN5c3RlbXMuCgpBdm9pZCB0aGUgdGVt
cG9yYXJ5IGRpcmVjdG9yeSBieSBiaW5kLW1vdW50aW5nIC9wcm9jL3NlbGYvZmQgb3ZlciAvcHJv
Yy4KVGhpcyBkb2VzIG5vdCBhZmZlY3Qgb3RoZXIgcHJvY2Vzc2VzIHNpbmNlIHdlIHJlbW91bnRl
ZCAvIHdpdGggTVNfUkVDIHwKTVNfU0xBVkUuIC9wcm9jIG11c3QgZXhpc3QgYW5kIHZpcnRpb2Zz
ZCBkb2VzIG5vdCB1c2UgaXQgc28gaXQncyBzYWZlIHRvCmRvIHRoaXMuCgpQYXRoIHRyYXZlcnNh
bCBjYW4gYmUgdGVzdGVkIHdpdGggdGhlIGZvbGxvd2luZyBmdW5jdGlvbjoKCiAgc3RhdGljIHZv
aWQgdGVzdF9wcm9jX2ZkX2VzY2FwZShzdHJ1Y3QgbG9fZGF0YSAqbG8pCiAgewogICAgICBpbnQg
ZmQ7CiAgICAgIGludCBsZXZlbCA9IDA7CiAgICAgIGlub190IGxhc3RfaW5vID0gMDsKCiAgICAg
IGZkID0gbG8tPnByb2Nfc2VsZl9mZDsKICAgICAgZm9yICg7OykgewogICAgICAgICAgc3RydWN0
IHN0YXQgc3Q7CgogICAgICAgICAgaWYgKGZzdGF0KGZkLCAmc3QpICE9IDApIHsKICAgICAgICAg
ICAgICBwZXJyb3IoImZzdGF0Iik7CiAgICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICAgfQog
ICAgICAgICAgaWYgKGxhc3RfaW5vICYmIHN0LnN0X2lubyA9PSBsYXN0X2lubykgewogICAgICAg
ICAgICAgIGZwcmludGYoc3RkZXJyLCAiaW5vZGUgbnVtYmVyIHVuY2hhbmdlZCwgc3RvcHBpbmdc
biIpOwogICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgIH0KICAgICAgICAgIGxhc3RfaW5v
ID0gc3Quc3RfaW5vOwoKICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiTGV2ZWwgJWQgZGV2ICVs
dSBpbm8gJWx1XG4iLCBsZXZlbCwKICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcpc3Qu
c3RfZGV2LAogICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylsYXN0X2lubyk7CiAgICAg
ICAgICBmZCA9IG9wZW5hdChmZCwgIi4uIiwgT19QQVRIIHwgT19ESVJFQ1RPUlkgfCBPX05PRk9M
TE9XKTsKICAgICAgICAgIGxldmVsKys7CiAgICAgIH0KICB9CgpCZWZvcmUgYW5kIGFmdGVyIHRo
aXMgcGF0Y2ggb25seSBMZXZlbCAwIGlzIGRpc3BsYXllZC4gV2l0aG91dAovcHJvYy9zZWxmL2Zk
IGJpbmQtbW91bnQgcHJvdGVjdGlvbiBpdCBpcyBwb3NzaWJsZSB0byB0cmF2ZXJzZSBwYXJlbnQK
ZGlyZWN0b3JpZXMuCgpGaXhlczogMzk3YWU5ODJmNGRmNCAoInZpcnRpb2ZzZDogamFpbCBsby0+
cHJvY19zZWxmX2ZkIikKQ2M6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgpD
YzogSmVucyBGcmVpbWFubiA8amZyZWltYW5uQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0b29scy92aXJ0aW9mc2Qv
cGFzc3Rocm91Z2hfbGwuYyB8IDM0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgYi90b29scy92aXJ0aW9mc2Qv
cGFzc3Rocm91Z2hfbGwuYwppbmRleCAwYjIyOWViZDU3Li42YWU3ZmZjZGQ3IDEwMDY0NAotLS0g
YS90b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYworKysgYi90b29scy92aXJ0aW9mc2Qv
cGFzc3Rocm91Z2hfbGwuYwpAQCAtMjM5Myw4ICsyMzkzLDYgQEAgc3RhdGljIHZvaWQgc2V0dXBf
d2FpdF9wYXJlbnRfY2FwYWJpbGl0aWVzKHZvaWQpCiBzdGF0aWMgdm9pZCBzZXR1cF9uYW1lc3Bh
Y2VzKHN0cnVjdCBsb19kYXRhICpsbywgc3RydWN0IGZ1c2Vfc2Vzc2lvbiAqc2UpCiB7CiAgICAg
cGlkX3QgY2hpbGQ7Ci0gICAgY2hhciB0ZW1wbGF0ZVtdID0gInZpcnRpb2ZzZC1YWFhYWFgiOwot
ICAgIGNoYXIgKnRtcGRpcjsKIAogICAgIC8qCiAgICAgICogQ3JlYXRlIGEgbmV3IHBpZCBuYW1l
c3BhY2UgZm9yICpjaGlsZCogcHJvY2Vzc2VzLiAgV2UnbGwgaGF2ZSB0bwpAQCAtMjQ1OCwzMyAr
MjQ1NiwyMyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9uYW1lc3BhY2VzKHN0cnVjdCBsb19kYXRhICps
bywgc3RydWN0IGZ1c2Vfc2Vzc2lvbiAqc2UpCiAgICAgICAgIGV4aXQoMSk7CiAgICAgfQogCi0g
ICAgdG1wZGlyID0gbWtkdGVtcCh0ZW1wbGF0ZSk7Ci0gICAgaWYgKCF0bXBkaXIpIHsKLSAgICAg
ICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAidG1wZGlyKCVzKTogJW1cbiIsIHRlbXBsYXRlKTsK
KyAgICAvKgorICAgICAqIFdlIG9ubHkgbmVlZCAvcHJvYy9zZWxmL2ZkLiBQcmV2ZW50ICIuLiIg
ZnJvbSBhY2Nlc3NpbmcgcGFyZW50CisgICAgICogZGlyZWN0b3JpZXMgb2YgL3Byb2Mvc2VsZi9m
ZCBieSBiaW5kLW1vdW50aW5nIGl0IG92ZXIgL3Byb2MuIFNpbmNlIC8gd2FzCisgICAgICogcHJl
dmlvdXNseSByZW1vdW50ZWQgd2l0aCBNU19SRUMgfCBNU19TTEFWRSB0aGlzIG1vdW50IGNoYW5n
ZSBvbmx5CisgICAgICogYWZmZWN0cyBvdXIgcHJvY2Vzcy4KKyAgICAgKi8KKyAgICBpZiAobW91
bnQoIi9wcm9jL3NlbGYvZmQiLCAiL3Byb2MiLCBOVUxMLCBNU19CSU5ELCBOVUxMKSA8IDApIHsK
KyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAibW91bnQoL3Byb2Mvc2VsZi9mZCwgTVNf
QklORCk6ICVtXG4iKTsKICAgICAgICAgZXhpdCgxKTsKICAgICB9CiAKLSAgICBpZiAobW91bnQo
Ii9wcm9jL3NlbGYvZmQiLCB0bXBkaXIsIE5VTEwsIE1TX0JJTkQsIE5VTEwpIDwgMCkgewotICAg
ICAgICBmdXNlX2xvZyhGVVNFX0xPR19FUlIsICJtb3VudCgvcHJvYy9zZWxmL2ZkLCAlcywgTVNf
QklORCk6ICVtXG4iLAotICAgICAgICAgICAgICAgICB0bXBkaXIpOwotICAgICAgICBleGl0KDEp
OwotICAgIH0KLQotICAgIC8qIE5vdyB3ZSBjYW4gZ2V0IG91ciAvcHJvYy9zZWxmL2ZkIGRpcmVj
dG9yeSBmaWxlIGRlc2NyaXB0b3IgKi8KLSAgICBsby0+cHJvY19zZWxmX2ZkID0gb3Blbih0bXBk
aXIsIE9fUEFUSCk7CisgICAgLyogR2V0IHRoZSAvcHJvYyAoYWN0dWFsbHkgL3Byb2Mvc2VsZi9m
ZCwgc2VlIGFib3ZlKSBmaWxlIGRlc2NyaXB0b3IgKi8KKyAgICBsby0+cHJvY19zZWxmX2ZkID0g
b3BlbigiL3Byb2MiLCBPX1BBVEgpOwogICAgIGlmIChsby0+cHJvY19zZWxmX2ZkID09IC0xKSB7
Ci0gICAgICAgIGZ1c2VfbG9nKEZVU0VfTE9HX0VSUiwgIm9wZW4oJXMsIE9fUEFUSCk6ICVtXG4i
LCB0bXBkaXIpOworICAgICAgICBmdXNlX2xvZyhGVVNFX0xPR19FUlIsICJvcGVuKC9wcm9jLCBP
X1BBVEgpOiAlbVxuIik7CiAgICAgICAgIGV4aXQoMSk7CiAgICAgfQotCi0gICAgaWYgKHVtb3Vu
dDIodG1wZGlyLCBNTlRfREVUQUNIKSA8IDApIHsKLSAgICAgICAgZnVzZV9sb2coRlVTRV9MT0df
RVJSLCAidW1vdW50MiglcywgTU5UX0RFVEFDSCk6ICVtXG4iLCB0bXBkaXIpOwotICAgICAgICBl
eGl0KDEpOwotICAgIH0KLQotICAgIGlmIChybWRpcih0bXBkaXIpIDwgMCkgewotICAgICAgICBm
dXNlX2xvZyhGVVNFX0xPR19FUlIsICJybWRpciglcyk6ICVtXG4iLCB0bXBkaXIpOwotICAgIH0K
IH0KIAogLyoKLS0gCjIuMjYuMgoK


