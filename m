Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5BE22250
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzMzzpwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5BE22250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZB2-0000WB-I6
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIZ9c-00088K-Qd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:15:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIZ9a-0004rJ-MZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600269325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Glyy05U7HMwiadYOzDcXSCP5pNfTc7CsfYnVHPHEZVY=;
 b=FzMzzpwI0VIC0ZucGkq3szjFWKrJp6WrTHXloiO/zbaYiL7gjCNFqeBXVz05+rbqdv3gkY
 xSGQTtHktbMejQdpxW6tz9iGWqztWNHHkifM13vSEij51VEFsYSviu1VRPVFatH1pOsAxq
 dvIL+Vzfott/si/5QptyhVdE6mqxx+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ndjcJvl0MoqL14JkcUsAWw-1; Wed, 16 Sep 2020 11:15:19 -0400
X-MC-Unique: ndjcJvl0MoqL14JkcUsAWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B794880EF8A
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 15:15:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC4255DEB5;
 Wed, 16 Sep 2020 15:15:11 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data()
 consumption
Date: Wed, 16 Sep 2020 17:15:10 +0200
Message-Id: <20200916151510.22767-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:15:25
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGRvY3VtZW50YXRpb24gb24gZ19ieXRlX2FycmF5X2ZyZWUoKQo8aHR0cHM6Ly9kZXZlbG9w
ZXIuZ25vbWUub3JnL2dsaWIvc3RhYmxlL2dsaWItQnl0ZS1BcnJheXMuaHRtbCNnLWJ5dGUtYXJy
YXktZnJlZT4Kc2F5czoKCj4gUmV0dXJucwo+Cj4gdGhlIGVsZW1lbnQgZGF0YSBpZiBmcmVlX3Nl
Z21lbnQgaXMgRkFMU0UsIG90aGVyd2lzZSBOVUxMLiBUaGUgZWxlbWVudAo+IGRhdGEgc2hvdWxk
IGJlIGZyZWVkIHVzaW5nIGdfZnJlZSgpLgoKQmVjYXVzZSB3ZSBjdXJyZW50bHkgY2FsbCBnX2J5
dGVfYXJyYXlfZnJlZSgpIHdpdGggZnJlZV9zZWdtZW50PVRSVUUsIHdlCmVuZCB1cCBwYXNzaW5n
IGRhdGE9TlVMTCB0byBmd19jZmdfYWRkX2ZpbGUoKS4KCk9uIHRoZSBwbHVzIHNpZGUsIGZ3X2Nm
Z19kYXRhX3JlYWQoKSBhbmQgZndfY2ZnX2RtYV90cmFuc2ZlcigpIGJvdGggZGVhbAp3aXRoIE5V
TEwgZGF0YSBncmFjZWZ1bGx5OiBRRU1VIGRvZXMgbm90IGNyYXNoIHdoZW4gdGhlIGd1ZXN0IHJl
YWRzIHN1Y2gKYW4gaXRlbSwgdGhlIGd1ZXN0IGp1c3QgZ2V0cyBhIHByb3Blcmx5IHNpemVkLCBi
dXQgemVyby1maWxsZWQgYmxvYi4KCkhvd2V2ZXIsIHRoZSBidWcgYnJlYWtzIFVFRkkgSFRUUFMg
Ym9vdCwgYXMgdGhlIElBTkFfVExTX0NJUEhFUiBhcnJheSwKZ2VuZXJhdGVkIG90aGVyd2lzZSBj
b3JyZWN0bHkgYnkgdGhlICJ0bHMtY2lwaGVyLXN1aXRlcyIgb2JqZWN0LCBpcyBpbgplZmZlY3Qg
cmVwbGFjZWQgd2l0aCBhIHplcm8gYmxvYi4KCkZpeCB0aGUgaXNzdWUgYnkgcGFzc2luZyBmcmVl
X3NlZ21lbnQ9RkFMU0UgdG8gZ19ieXRlX2FycmF5X2ZyZWUoKToKCi0gdGhlIGNhbGxlciAoZndf
Y2ZnX2FkZF9mcm9tX2dlbmVyYXRvcigpKSB0ZW1wb3JhcmlseSBhc3N1bWVzIG93bmVyc2hpcAog
IG9mIHRoZSBnZW5lcmF0ZWQgYnl0ZSBhcnJheSwKCi0gdGhlbiBvd25lcnNoaXAgb2YgdGhlIGJ5
dGUgYXJyYXkgaXMgdHJhbnNmZXJlZCB0byBmd19jZmcsIGFzCiAgZndfY2ZnX2FkZF9maWxlKCkg
bGlua3MgKG5vdCBjb3BpZXMpICJkYXRhIiBpbnRvIGZ3X2NmZy4KCkNjOiAiRGFuaWVsIFAuIEJl
cnJhbmfDqSIgPGJlcnJhbmdlQHJlZGhhdC5jb20+CkNjOiAiUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kiIDxwaGlsbWRAcmVkaGF0LmNvbT4KQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQu
Y29tPgpGaXhlczogMzIwMzE0ODkxN2QwMzViMDlmNzE5ODZhYzJlYWExOWEzNTJkNmQ5ZApTaWdu
ZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KIGh3L252cmFt
L2Z3X2NmZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaHcvbnZyYW0vZndfY2ZnLmMgYi9ody9udnJhbS9md19jZmcu
YwppbmRleCBmM2E0NzI4Mjg4ZWIuLjBlOTVkMDU3ZmQ1MSAxMDA2NDQKLS0tIGEvaHcvbnZyYW0v
ZndfY2ZnLmMKKysrIGIvaHcvbnZyYW0vZndfY2ZnLmMKQEAgLTEwNTYsNyArMTA1Niw3IEBAIGJv
b2wgZndfY2ZnX2FkZF9mcm9tX2dlbmVyYXRvcihGV0NmZ1N0YXRlICpzLCBjb25zdCBjaGFyICpm
aWxlbmFtZSwKICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgIH0KICAgICBzaXplID0gYXJyYXkt
PmxlbjsKLSAgICBmd19jZmdfYWRkX2ZpbGUocywgZmlsZW5hbWUsIGdfYnl0ZV9hcnJheV9mcmVl
KGFycmF5LCBUUlVFKSwgc2l6ZSk7CisgICAgZndfY2ZnX2FkZF9maWxlKHMsIGZpbGVuYW1lLCBn
X2J5dGVfYXJyYXlfZnJlZShhcnJheSwgRkFMU0UpLCBzaXplKTsKIAogICAgIHJldHVybiB0cnVl
OwogfQotLSAKMi4xOS4xLjMuZzMwMjQ3YWE1ZDIwMQoK


