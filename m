Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA64FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97746206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZnBDHsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97746206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcph-0004jI-NV
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoI-0002WS-GG
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoH-0007kW-Jx
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588605308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6izAc39XclI6yWRGdmTS6QgDssVoShYy45qY4EU02x4=;
 b=bZnBDHsz10KltBVQ+TVa59o9ozTyfOiFHgDUrR/L5KzwY+6lDBraX1CTaipdZeM48NbK4c
 mNag8uK91QuZhQcIbHBxeFbfsnzbzHVNQAWr/1whq8Y3FRWspY6/DpmKTIEjhlnmqscp+0
 eBgLly8bklflrwh/Hc52bwNqFqlZG1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-rPwD-vntPxO3yPxlUyaeBA-1; Mon, 04 May 2020 11:15:03 -0400
X-MC-Unique: rPwD-vntPxO3yPxlUyaeBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F6218FF665;
 Mon,  4 May 2020 15:15:02 +0000 (UTC)
Received: from localhost (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D05C663F81;
 Mon,  4 May 2020 15:14:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/4] fuzz: select fuzz target using executable name
Date: Mon,  4 May 2020 16:14:35 +0100
Message-Id: <20200504151438.362702-2-stefanha@redhat.com>
In-Reply-To: <20200504151438.362702-1-stefanha@redhat.com>
References: <20200504151438.362702-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpUaGUgZnV6emVycyBhcmUg
YnVpbHQgaW50byBhIGJpbmFyeSAoZS5nLiBxZW11LWZ1enotaTM4NikuIFRvIHNlbGVjdCB0aGUK
ZGV2aWNlIHRvIGZ1enovZnV6eiB0YXJnZXQsIHdlIHVzdWFsbHkgdXNlIHRoZSAtLWZ1enotdGFy
Z2V0PSBhcmd1bWVudC4KVGhpcyBjb21taXQgYWxsb3dzIHRoZSBmdXp6LXRhcmdldCB0byBiZSBz
cGVjaWZpZWQgdXNpbmcgdGhlIG5hbWUgb2YgdGhlCmV4ZWN1dGFibGUuIElmIHRoZSBleGVjdXRh
YmxlIG5hbWUgZW5kcyB3aXRoIC10YXJnZXQtRlVaWl9UQVJHRVQsIHRoZW4Kd2Ugc2VsZWN0IHRo
ZSBmdXp6IHRhcmdldCBiYXNlZCBvbiB0aGlzIG5hbWUsIHJhdGhlciB0aGFuIHRoZQotLWZ1enot
dGFyZ2V0IGFyZ3VtZW50LiBUaGlzIGlzIHVzZWZ1bCBmb3Igc3lzdGVtcyBzdWNoIGFzIG9zcy1m
dXp6CndoZXJlIHdlIGRvbid0IGhhdmUgY29udHJvbCBvZiB0aGUgYXJndW1lbnRzIHBhc3NlZCB0
byB0aGUgZnV6emVyLgoKW0ZpeGVkIGluY29ycmVjdCBpbmRlbnRhdGlvbi4KLS1TdGVmYW5dCgpT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQt
Ynk6IERhcnJlbiBLZW5ueSA8ZGFycmVuLmtlbm55QG9yYWNsZS5jb20+Ck1lc3NhZ2UtaWQ6IDIw
MjAwNDIxMTgyMjMwLjYzMTMtMS1hbHhuZHJAYnUuZWR1ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9mdXp6L2Z1enou
YyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovZnV6ei5j
IGIvdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMKaW5kZXggMGQ3OGFjOGQzNi4uZjVjOTIzODUyZSAx
MDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMKKysrIGIvdGVzdHMvcXRlc3QvZnV6
ei9mdXp6LmMKQEAgLTkxLDYgKzkxLDcgQEAgc3RhdGljIHZvaWQgdXNhZ2UoY2hhciAqcGF0aCkK
ICAgICAgICAgcHJpbnRmKCIgKiAlcyAgOiAlc1xuIiwgdG1wLT50YXJnZXQtPm5hbWUsCiAgICAg
ICAgICAgICAgICAgdG1wLT50YXJnZXQtPmRlc2NyaXB0aW9uKTsKICAgICB9CisgICAgcHJpbnRm
KCJBbHRlcm5hdGl2ZWx5LCBhZGQgLXRhcmdldC1GVVpaX1RBUkdFVCB0byB0aGUgZXhlY3V0YWJs
ZSBuYW1lXG4iKTsKICAgICBleGl0KDApOwogfQogCkBAIC0xNDMsMTggKzE0NCwyMCBAQCBpbnQg
TExWTUZ1enplckluaXRpYWxpemUoaW50ICphcmdjLCBjaGFyICoqKmFyZ3YsIGNoYXIgKioqZW52
cCkKICAgICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1FPTSk7CiAgICAgbW9kdWxlX2Nh
bGxfaW5pdChNT0RVTEVfSU5JVF9MSUJRT1MpOwogCi0gICAgaWYgKCphcmdjIDw9IDEpIHsKKyAg
ICB0YXJnZXRfbmFtZSA9IHN0cnN0cigqKmFyZ3YsICItdGFyZ2V0LSIpOworICAgIGlmICh0YXJn
ZXRfbmFtZSkgeyAgICAgICAgLyogVGhlIGJpbmFyeSBuYW1lIHNwZWNpZmllcyB0aGUgdGFyZ2V0
ICovCisgICAgICAgIHRhcmdldF9uYW1lICs9IHN0cmxlbigiLXRhcmdldC0iKTsKKyAgICB9IGVs
c2UgaWYgKCphcmdjID4gMSkgeyAgLyogVGhlIHRhcmdldCBpcyBzcGVjaWZpZWQgYXMgYW4gYXJn
dW1lbnQgKi8KKyAgICAgICAgdGFyZ2V0X25hbWUgPSAoKmFyZ3YpWzFdOworICAgICAgICBpZiAo
IXN0cnN0cih0YXJnZXRfbmFtZSwgIi0tZnV6ei10YXJnZXQ9IikpIHsKKyAgICAgICAgICAgIHVz
YWdlKCoqYXJndik7CisgICAgICAgIH0KKyAgICAgICAgdGFyZ2V0X25hbWUgKz0gc3RybGVuKCIt
LWZ1enotdGFyZ2V0PSIpOworICAgIH0gZWxzZSB7CiAgICAgICAgIHVzYWdlKCoqYXJndik7CiAg
ICAgfQogCiAgICAgLyogSWRlbnRpZnkgdGhlIGZ1enogdGFyZ2V0ICovCi0gICAgdGFyZ2V0X25h
bWUgPSAoKmFyZ3YpWzFdOwotICAgIGlmICghc3Ryc3RyKHRhcmdldF9uYW1lLCAiLS1mdXp6LXRh
cmdldD0iKSkgewotICAgICAgICB1c2FnZSgqKmFyZ3YpOwotICAgIH0KLQotICAgIHRhcmdldF9u
YW1lICs9IHN0cmxlbigiLS1mdXp6LXRhcmdldD0iKTsKLQogICAgIGZ1enpfdGFyZ2V0ID0gZnV6
el9nZXRfdGFyZ2V0KHRhcmdldF9uYW1lKTsKICAgICBpZiAoIWZ1enpfdGFyZ2V0KSB7CiAgICAg
ICAgIHVzYWdlKCoqYXJndik7Ci0tIAoyLjI1LjMKCg==


