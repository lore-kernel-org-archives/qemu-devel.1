Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CCC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D17239D2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/gfX5mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D17239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKl4w-00070G-VW
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkxb-0008BC-OL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkxa-0007ul-6P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600791362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7V1hlg580q8ybpxd/zxqIbK2WCB7lCN7vK6A1tffNk=;
 b=h/gfX5mB8qkVtAMXuEFXnUnpX21zOnD4b64RHWLqmThoEPfV3cbklYrwz1Ot3K2csQniUT
 Qhznlubm7QkUMC1/K1fQY05leVQLdP26tmUNvYds74kSaDVea/rRDQbORuFgCxFuksLwwp
 o3Qts9MwH5WUR+e9YY0Xao6yIh/Gq00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Nv3MYijXO3CBzOgzsBvFIA-1; Tue, 22 Sep 2020 12:04:29 -0400
X-MC-Unique: Nv3MYijXO3CBzOgzsBvFIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A4DF57086;
 Tue, 22 Sep 2020 16:04:28 +0000 (UTC)
Received: from localhost (ovpn-115-55.ams2.redhat.com [10.36.115.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CE9F73689;
 Tue, 22 Sep 2020 16:04:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] util/vhost-user-server: fix memory leak in
 vu_message_read()
Date: Tue, 22 Sep 2020 17:03:57 +0100
Message-Id: <20200922160401.294055-8-stefanha@redhat.com>
In-Reply-To: <20200922160401.294055-1-stefanha@redhat.com>
References: <20200922160401.294055-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZmRzW10gaXMgbGVha2VkIHdoZW4gcWlvX2NoYW5uZWxfcmVhZHZfZnVsbCgpIGZhaWxzLgoKVXNl
IHZtc2ctPmZkc1tdIGluc3RlYWQgb2Yga2VlcGluZyBhIGxvY2FsIGZkc1tdIGFycmF5LiBUaGVu
IHdlIGNhbgpyZXVzZSBnb3RvIGZhaWwgdG8gY2xlYW4gdXAgZmRzLiB2bXNnLT5mZF9udW0gbXVz
dCBiZSB6ZXJvZWQgYmVmb3JlIHRoZQpsb29wIHRvIG1ha2UgdGhpcyBzYWZlLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvdmhv
c3QtdXNlci1zZXJ2ZXIuYyB8IDUwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMgYi91dGlsL3Zob3N0LXVzZXIt
c2VydmVyLmMKaW5kZXggODkyODE1ODI3ZC4uNWE2MGUyY2EyYSAxMDA2NDQKLS0tIGEvdXRpbC92
aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwpAQCAtMTAw
LDIxICsxMDAsMTEgQEAgdnVfbWVzc2FnZV9yZWFkKFZ1RGV2ICp2dV9kZXYsIGludCBjb25uX2Zk
LCBWaG9zdFVzZXJNc2cgKnZtc2cpCiAgICAgfTsKICAgICBpbnQgcmMsIHJlYWRfYnl0ZXMgPSAw
OwogICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOwotICAgIC8qCi0gICAgICogU3RvcmUgZmRz
L25mZHMgcmV0dXJuZWQgZnJvbSBxaW9fY2hhbm5lbF9yZWFkdl9mdWxsIGludG8KLSAgICAgKiB0
ZW1wb3JhcnkgdmFyaWFibGVzLgotICAgICAqCi0gICAgICogVmhvc3RVc2VyTXNnIGlzIGEgcGFj
a2VkIHN0cnVjdHVyZSwgZ2NjIHdpbGwgY29tcGxhaW4gYWJvdXQgcGFzc2luZwotICAgICAqIHBv
aW50ZXIgdG8gYSBwYWNrZWQgc3RydWN0dXJlIG1lbWJlciBpZiB3ZSBwYXNzICZWaG9zdFVzZXJN
c2cuZmRfbnVtCi0gICAgICogYW5kICZWaG9zdFVzZXJNc2cuZmRzIGRpcmVjdGx5IHdoZW4gY2Fs
bGluZyBxaW9fY2hhbm5lbF9yZWFkdl9mdWxsLAotICAgICAqIHRodXMgdHdvIHRlbXBvcmFyeSB2
YXJpYWJsZXMgbmZkcyBhbmQgZmRzIGFyZSB1c2VkIGhlcmUuCi0gICAgICovCi0gICAgc2l6ZV90
IG5mZHMgPSAwLCBuZmRzX3QgPSAwOwogICAgIGNvbnN0IHNpemVfdCBtYXhfZmRzID0gR19OX0VM
RU1FTlRTKHZtc2ctPmZkcyk7Ci0gICAgaW50ICpmZHNfdCA9IE5VTEw7CiAgICAgVnVTZXJ2ZXIg
KnNlcnZlciA9IGNvbnRhaW5lcl9vZih2dV9kZXYsIFZ1U2VydmVyLCB2dV9kZXYpOwogICAgIFFJ
T0NoYW5uZWwgKmlvYyA9IHNlcnZlci0+aW9jOwogCisgICAgdm1zZy0+ZmRfbnVtID0gMDsKICAg
ICBpZiAoIWlvYykgewogICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7CiAgICAg
ICAgIGdvdG8gZmFpbDsKQEAgLTEyMiw0MSArMTEyLDQ3IEBAIHZ1X21lc3NhZ2VfcmVhZChWdURl
diAqdnVfZGV2LCBpbnQgY29ubl9mZCwgVmhvc3RVc2VyTXNnICp2bXNnKQogCiAgICAgYXNzZXJ0
KHFlbXVfaW5fY29yb3V0aW5lKCkpOwogICAgIGRvIHsKKyAgICAgICAgc2l6ZV90IG5mZHMgPSAw
OworICAgICAgICBpbnQgKmZkcyA9IE5VTEw7CisKICAgICAgICAgLyoKICAgICAgICAgICogcWlv
X2NoYW5uZWxfcmVhZHZfZnVsbCBtYXkgaGF2ZSBzaG9ydCByZWFkcywga2VlcGluZyBjYWxsaW5n
IGl0CiAgICAgICAgICAqIHVudGlsIGdldHRpbmcgVkhPU1RfVVNFUl9IRFJfU0laRSBvciAwIGJ5
dGVzIGluIHRvdGFsCiAgICAgICAgICAqLwotICAgICAgICByYyA9IHFpb19jaGFubmVsX3JlYWR2
X2Z1bGwoaW9jLCAmaW92LCAxLCAmZmRzX3QsICZuZmRzX3QsICZsb2NhbF9lcnIpOworICAgICAg
ICByYyA9IHFpb19jaGFubmVsX3JlYWR2X2Z1bGwoaW9jLCAmaW92LCAxLCAmZmRzLCAmbmZkcywg
JmxvY2FsX2Vycik7CiAgICAgICAgIGlmIChyYyA8IDApIHsKICAgICAgICAgICAgIGlmIChyYyA9
PSBRSU9fQ0hBTk5FTF9FUlJfQkxPQ0spIHsKKyAgICAgICAgICAgICAgICBhc3NlcnQobG9jYWxf
ZXJyID09IE5VTEwpOwogICAgICAgICAgICAgICAgIHFpb19jaGFubmVsX3lpZWxkKGlvYywgR19J
T19JTik7CiAgICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgICB9IGVsc2Ugewog
ICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsKLSAgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgICAgICAgICAgZ290byBmYWlsOwogICAgICAgICAg
ICAgfQogICAgICAgICB9Ci0gICAgICAgIHJlYWRfYnl0ZXMgKz0gcmM7Ci0gICAgICAgIGlmIChu
ZmRzX3QgPiAwKSB7Ci0gICAgICAgICAgICBpZiAobmZkcyArIG5mZHNfdCA+IG1heF9mZHMpIHsK
KworICAgICAgICBpZiAobmZkcyA+IDApIHsKKyAgICAgICAgICAgIGlmICh2bXNnLT5mZF9udW0g
KyBuZmRzID4gbWF4X2ZkcykgewogICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiQSBtYXhp
bXVtIG9mICV6dSBmZHMgYXJlIGFsbG93ZWQsICIKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgImhvd2V2ZXIgZ290ICVsdSBmZHMgbm93IiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbWF4X2ZkcywgbmZkcyArIG5mZHNfdCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1heF9mZHMsIHZtc2ctPmZkX251bSArIG5mZHMpOworICAgICAgICAgICAgICAgIGdfZnJlZShm
ZHMpOwogICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsKICAgICAgICAgICAgIH0KLSAgICAgICAg
ICAgIG1lbWNweSh2bXNnLT5mZHMgKyBuZmRzLCBmZHNfdCwKLSAgICAgICAgICAgICAgICAgICBu
ZmRzX3QgKnNpemVvZih2bXNnLT5mZHNbMF0pKTsKLSAgICAgICAgICAgIG5mZHMgKz0gbmZkc190
OwotICAgICAgICAgICAgZ19mcmVlKGZkc190KTsKKyAgICAgICAgICAgIG1lbWNweSh2bXNnLT5m
ZHMgKyB2bXNnLT5mZF9udW0sIGZkcywgbmZkcyAqIHNpemVvZih2bXNnLT5mZHNbMF0pKTsKKyAg
ICAgICAgICAgIHZtc2ctPmZkX251bSArPSBuZmRzOworICAgICAgICAgICAgZ19mcmVlKGZkcyk7
CiAgICAgICAgIH0KLSAgICAgICAgaWYgKHJlYWRfYnl0ZXMgPT0gVkhPU1RfVVNFUl9IRFJfU0la
RSB8fCByYyA9PSAwKSB7Ci0gICAgICAgICAgICBicmVhazsKKworICAgICAgICBpZiAocmMgPT0g
MCkgeyAvKiBzb2NrZXQgY2xvc2VkICovCisgICAgICAgICAgICBnb3RvIGZhaWw7CiAgICAgICAg
IH0KLSAgICAgICAgaW92Lmlvdl9iYXNlID0gKGNoYXIgKil2bXNnICsgcmVhZF9ieXRlczsKLSAg
ICAgICAgaW92Lmlvdl9sZW4gPSBWSE9TVF9VU0VSX0hEUl9TSVpFIC0gcmVhZF9ieXRlczsKLSAg
ICB9IHdoaWxlICh0cnVlKTsKIAotICAgIHZtc2ctPmZkX251bSA9IG5mZHM7CisgICAgICAgIGlv
di5pb3ZfYmFzZSArPSByYzsKKyAgICAgICAgaW92Lmlvdl9sZW4gLT0gcmM7CisgICAgICAgIHJl
YWRfYnl0ZXMgKz0gcmM7CisgICAgfSB3aGlsZSAocmVhZF9ieXRlcyAhPSBWSE9TVF9VU0VSX0hE
Ul9TSVpFKTsKKwogICAgIC8qIHFpb19jaGFubmVsX3JlYWR2X2Z1bGwgd2lsbCBtYWtlIHNvY2tl
dCBmZHMgYmxvY2tpbmcsIHVuYmxvY2sgdGhlbSAqLwogICAgIHZtc2dfdW5ibG9ja19mZHModm1z
Zyk7CiAgICAgaWYgKHZtc2ctPnNpemUgPiBzaXplb2Yodm1zZy0+cGF5bG9hZCkpIHsKLS0gCjIu
MjYuMgoK


