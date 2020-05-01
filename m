Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1162DC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0411206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWySuYZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0411206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWKq-0003xd-Vp
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWK0-0002cY-C6
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWJl-0005zw-MH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUWJl-0005zd-7f
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588342023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=St3vGR/TfylnPu/VCoYyYWbMTN4fy7N4JycQv2XtMpY=;
 b=SWySuYZGtU1cn+6mKCLWjwCI1qog31mr4n3SKxmd/iFjEofu4i/YANlgN00wxY7tlysNh1
 rThtl6q6TNtCwidC7wcGth/3fm3mbD1ifxg0lsHC2mWOvCsCfvAAnKdB25xeKyMPzArS1b
 4t2PWBz1YCoAUcvVFHNjWSiKnGc/IAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-oI1iWcftML24L2jY8C99fQ-1; Fri, 01 May 2020 10:07:01 -0400
X-MC-Unique: oI1iWcftML24L2jY8C99fQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3D08015CE
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 14:07:00 +0000 (UTC)
Received: from localhost (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE48196AE;
 Fri,  1 May 2020 14:06:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/2] virtiofsd: stay under fs.file-max sysctl limit
 (CVE-2020-10717)
Date: Fri,  1 May 2020 15:06:42 +0100
Message-Id: <20200501140644.220940-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 07:23:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyB0aGUgLS1ybGltaXQtbm9maWxlPU5VTSBvcHRp
b24gZm9yIHNldHRpbmcgdGhlDQpudW1iZXIgb2Ygb3BlbiBmaWxlcyBvbiB0aGUgdmlydGlvZnNk
IHByb2Nlc3MuICBUaGlzIGdpdmVzIHVzZXJzIGFuZCBtYW5hZ2VtZW50DQp0b29scyBtb3JlIGNv
bnRyb2wgb3ZlciByZXNvdXJjZSBsaW1pdHMuDQoNClByZXZpb3VzbHkgaXQgd2FzIHBvc3NpYmxl
IGZvciBGVVNFIGNsaWVudHMgb24gbWFjaGluZXMgd2l0aCBsZXNzIHRoYW4gfjEwIEdCDQpvZiBS
QU0gdG8gZXhoYXVzdCB0aGUgc3lzdGVtLXdpZGUgb3BlbiBmaWxlIGxpbWl0LiAgVGhpcyBpcyBh
IGRlbmlhbCBvZiBzZXJ2aWNlDQphdHRhY2sgYWdhaW5zdCBvdGhlciBwcm9jZXNzZXMgcnVubmlu
ZyBvbiB0aGUgaG9zdC4NCg0KVGhpcyBwYXRjaCBzZXJpZXMgdXBkYXRlcyB0aGUgZGVmYXVsdCBS
TElNSVRfTk9GSUxFIGNhbGN1bGF0aW9uIHRvIHRha2UgdGhlDQpmcy5maWxlLW1heCBzeXNjdGwg
dmFsdWUgaW50byBhY2NvdW50LiAgVGhpcyBzb2x2ZXMgdGhlIGZzLmZpbGUtbWF4IERvUy4NCg0K
U3RlZmFuIEhham5vY3ppICgyKToNCiAgdmlydGlvZnNkOiBhZGQgLS1ybGltaXQtbm9maWxlPU5V
TSBvcHRpb24NCiAgdmlydGlvZnNkOiBzdGF5IGJlbG93IGZzLmZpbGUtbWF4IHN5c2N0bCB2YWx1
ZSAoQ1ZFLTIwMjAtMTA3MTcpDQoNCiB0b29scy92aXJ0aW9mc2QvZnVzZV9sb3dsZXZlbC5oICB8
ICAxICsNCiB0b29scy92aXJ0aW9mc2QvaGVscGVyLmMgICAgICAgICB8IDQ3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMg
fCAyMiArKysrKystLS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyks
IDE0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjUuMw0KDQo=


