Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861B62065E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/qbgx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B62065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7XL-0008Kp-JV
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mr-0003wZ-PG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Ml-0006JH-QL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54KlbezTuaP+daYg3xYQzkrPbxPas9byKxqw0aodn0k=;
 b=Fi/qbgx+TFVXOaqmKwCZs94hdRFHrS97GYkejY03GUKDmrWzC/3NsABDPfqnLGhmJ+5l8+
 kvNT+0mYDJW3RYzhFKrfEF14sKaflxxIIktppFCqw8opMMUPs0wXJWePqS7s/VQDMxRr/q
 zX+eAhefkens+ORfzuLCv+NIrLn972E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-FU39U4GOOUODkkMTmLW0bA-1; Wed, 23 Sep 2020 12:11:31 -0400
X-MC-Unique: FU39U4GOOUODkkMTmLW0bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83219802B4A;
 Wed, 23 Sep 2020 16:11:30 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D059D10027AB;
 Wed, 23 Sep 2020 16:11:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/13] fdmon-poll: reset npfd when upgrading to fdmon-epoll
Date: Wed, 23 Sep 2020 17:10:29 +0100
Message-Id: <20200923161031.69474-12-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bnBmZCBrZWVwcyB0cmFjayBvZiBob3cgbWFueSBwb2xsZmRzIGFyZSBjdXJyZW50bHkgYmVpbmcg
bW9uaXRvcmVkLiBJdAptdXN0IGJlIHJlc2V0IHRvIDAgd2hlbiBmZG1vbl9wb2xsX3dhaXQoKSBy
ZXR1cm5zLgoKV2hlbiBucGZkIHJlYWNoZXMgYSB0cmVzaG9sZCB3ZSBzd2l0Y2ggdG8gZmRtb24t
ZXBvbGwgYmVjYXVzZSBpdCBzY2FsZXMKYmV0dGVyLgoKVGhpcyBwYXRjaCByZXNldHMgbnBmZCBp
biB0aGUgY2FzZSB3aGVyZSB3ZSBzd2l0Y2ggdG8gZmRtb24tZXBvbGwuCkZvcmdldHRpbmcgdG8g
ZG8gc28gcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIGFzc2VydGlvbiBmYWlsdXJlOgoKICB1dGls
L2ZkbW9uLXBvbGwuYzo2NTogZmRtb25fcG9sbF93YWl0OiBBc3NlcnRpb24gYG5wZmQgPT0gMCcg
ZmFpbGVkLgoKRml4ZXM6IDFmMDUwYTQ2OTBmNjJhMWU3ZGFiYzRmNDQxNDFlOWY3NjJjMzc2OWYg
KCJhaW8tcG9zaXg6IGV4dHJhY3QgcHBvbGwoMikgYW5kIGVwb2xsKDcpIGZkIG1vbml0b3Jpbmci
KQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+CkJ1
Z2xpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTg2OTk1
MgpNZXNzYWdlLUlkOiA8MjAyMDA5MTUxMjAzMzkuNzAyOTM4LTItc3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiB1dGlsL2ZkbW9uLXBvbGwuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvdXRpbC9mZG1vbi1wb2xsLmMgYi91dGlsL2ZkbW9uLXBvbGwu
YwppbmRleCA0ODgwNjdiNjc5Li41ZmUzYjQ3ODY1IDEwMDY0NAotLS0gYS91dGlsL2ZkbW9uLXBv
bGwuYworKysgYi91dGlsL2ZkbW9uLXBvbGwuYwpAQCAtNzMsNiArNzMsNyBAQCBzdGF0aWMgaW50
IGZkbW9uX3BvbGxfd2FpdChBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRsZXJMaXN0ICpyZWFkeV9s
aXN0LAogCiAgICAgLyogZXBvbGwoNykgaXMgZmFzdGVyIGFib3ZlIGEgY2VydGFpbiBudW1iZXIg
b2YgZmRzICovCiAgICAgaWYgKGZkbW9uX2Vwb2xsX3RyeV91cGdyYWRlKGN0eCwgbnBmZCkpIHsK
KyAgICAgICAgbnBmZCA9IDA7IC8qIHdlIHdvbid0IG5lZWQgcG9sbGZkc1tdLCByZXNldCBucGZk
ICovCiAgICAgICAgIHJldHVybiBjdHgtPmZkbW9uX29wcy0+d2FpdChjdHgsIHJlYWR5X2xpc3Qs
IHRpbWVvdXQpOwogICAgIH0KIAotLSAKMi4yNi4yCgo=


