Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C6B22207
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt2CTBE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C6B22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUEL-0000cm-9m
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6k-0005qG-9C
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6i-0000d7-F1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YoBWOJ3skTgMMGECEY2gdzMICoZSvqHUaQ4IDMrjOrw=;
 b=gt2CTBE7k3aGC7LnYcy2RaxL/q9Sp8xdX8vFzvWpAKvrny7fuV32iY3EziOwrihpoifsfg
 Wl094EeE/a/3HXVfdQ9i0nYaGf6bxkUO/voNZRnrtWZDu3b75az/v5VNDAbQ9qlSHapxLw
 e8Wdx99lEqzq5W4W7ZEkWh7nUsJVAIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-uiKC3D6gPEC_2ck9i6NbCg-1; Wed, 16 Sep 2020 05:51:59 -0400
X-MC-Unique: uiKC3D6gPEC_2ck9i6NbCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB6AF107464B;
 Wed, 16 Sep 2020 09:51:57 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D24B47BE5B;
 Wed, 16 Sep 2020 09:51:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] nvdimm: read-only file support
Date: Wed, 16 Sep 2020 10:51:47 +0100
Message-Id: <20200916095150.755714-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, eric.g.ernst@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6CiAqIHMvdGhlIHRoZS90aGUvIGluIGRvY3VtZW50YXRpb24gW1BoaWxpcHBlXQogKiBBc3Np
Z24gbnZkaW1tLT51bmFybWVkIGVhcmxpZXIgW1BoaWxpcHBlXQoKVGhlcmUgaXMgY3VycmVudGx5
IG5vIHdheSB0byBiYWNrIGFuIE5WRElNTSB3aXRoIGEgcmVhZC1vbmx5IGZpbGUgc28gaXQgY2Fu
IGJlCnNhZmVseSBzaGFyZWQgYmV0d2VlbiB1bnRydXN0ZWQgZ3Vlc3RzLgoKSW50cm9kdWNlIGFu
IC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxyZWFkb25seT1vbnxvZmYgb3B0aW9uLgoKSnVs
aW8gTW9udGVzIHNlbnQgYW4gZWFybGllciBwYXRjaCBoZXJlOgpodHRwczovL3BhdGNoZXcub3Jn
L1FFTVUvMjAxOTA3MDgyMTE5MzYuODAzNy0xLWp1bGlvLm1vbnRlc0BpbnRlbC5jb20vCgpFcmlj
IEVybnN0IHJlcXVlc3RlZCB0aGlzIGZlYXR1cmUgYWdhaW4gZm9yIEthdGEgQ29udGFpbmVycyBz
byBJIGdhdmUgaXQgYSB0cnkuCgpTdGVmYW4gSGFqbm9jemkgKDMpOgogIG1lbW9yeTogYWRkIHJl
YWRvbmx5IHN1cHBvcnQgdG8gbWVtb3J5X3JlZ2lvbl9pbml0X3JhbV9mcm9tX2ZpbGUoKQogIGhv
c3RtZW0tZmlsZTogYWRkIHJlYWRvbmx5PW9ufG9mZiBvcHRpb24KICBudmRpbW06IGhvbm9yIC1v
YmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxyZWFkb25seT1vbiBvcHRpb24KCiBkb2NzL252ZGlt
bS50eHQgICAgICAgICAgIHwgIDggKysrKysrKy0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgICAg
fCAgMiArKwogaW5jbHVkZS9leGVjL3JhbV9hZGRyLmggICB8ICA1ICsrKy0tCiBpbmNsdWRlL3Fl
bXUvbW1hcC1hbGxvYy5oIHwgIDIgKysKIGJhY2tlbmRzL2hvc3RtZW0tZmlsZS5jICAgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrKysrLQogZXhlYy5jICAgICAgICAgICAgICAgICAgICB8IDE4
ICsrKysrKysrKysrLS0tLS0tLQogaHcvbWVtL252ZGltbS5jICAgICAgICAgICB8ICA0ICsrKysK
IHNvZnRtbXUvbWVtb3J5LmMgICAgICAgICAgfCAgNyArKysrKy0tCiB1dGlsL21tYXAtYWxsb2Mu
YyAgICAgICAgIHwgMTAgKysrKysrLS0tLQogdXRpbC9vc2xpYi1wb3NpeC5jICAgICAgICB8ICAy
ICstCiBxZW11LW9wdGlvbnMuaHggICAgICAgICAgIHwgIDUgKysrKy0KIDExIGZpbGVzIGNoYW5n
ZWQsIDcwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKLS0gCjIuMjYuMgoK


