Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC425C3F2D8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AE524671
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8gQPL68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AE524671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9u42-000865-Oh
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j9tyu-0008C5-By
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j9tys-0003Bg-R1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j9tys-0003BN-N5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn5pfHyFieRx4tcNdpGnIlXvgQvmLlf3D2iVohA8EFI=;
 b=e8gQPL688ETZKbBq434LoXUdr8SrUoQjH4GHDth+Gt5fFkxxZoVIElnmLhi38+VQFFdwQ/
 meQw2c+He30YMTiZxZd+n0PS1zpRNRWgeWPIMrBYtIpHllBTaNsQ2HzRNYYGe/LoNwRt5w
 FEzPpQENUpHKGeh7OousFnhBIpVfyMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-5PhE3C4cMSisDjniv1SNpQ-1; Thu, 05 Mar 2020 12:08:16 -0500
X-MC-Unique: 5PhE3C4cMSisDjniv1SNpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97426107ACC4;
 Thu,  5 Mar 2020 17:08:15 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE0E31001902;
 Thu,  5 Mar 2020 17:08:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] aio-posix: completely stop polling when disabled
Date: Thu,  5 Mar 2020 17:08:00 +0000
Message-Id: <20200305170806.1313245-2-stefanha@redhat.com>
In-Reply-To: <20200305170806.1313245-1-stefanha@redhat.com>
References: <20200305170806.1313245-1-stefanha@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T25lIGl0ZXJhdGlvbiBvZiBwb2xsaW5nIGlzIGFsd2F5cyBwZXJmb3JtZWQgZXZlbiB3aGVuIHBv
bGxpbmcgaXMKZGlzYWJsZWQuICBUaGlzIGlzIGRvbmUgYmVjYXVzZToKMS4gVXNlcnNwYWNlIHBv
bGxpbmcgaXMgY2hlYXBlciB0aGFuIG1ha2luZyBhIHN5c2NhbGwuICBXZSBtaWdodCBnZXQKICAg
bHVja3kuCjIuIFdlIG11c3QgcG9sbCBvbmNlIG1vcmUgYWZ0ZXIgcG9sbGluZyBoYXMgc3RvcHBl
ZCBpbiBjYXNlIGFuIGV2ZW50CiAgIG9jY3VycmVkIHdoaWxlIHN0b3BwaW5nIHBvbGxpbmcuCgpI
b3dldmVyLCB0aGVyZSBhcmUgZG93bnNpZGVzOgoxLiBQb2xsaW5nIGJlY29tZXMgYSBib3R0bGVu
ZWNrIHdoZW4gdGhlIG51bWJlciBvZiBldmVudCBzb3VyY2VzIGlzIHZlcnkKICAgaGlnaC4gIEl0
J3MgbW9yZSBlZmZpY2llbnQgdG8gbW9uaXRvciBmZHMgaW4gdGhhdCBjYXNlLgoyLiBBIGhpZ2gt
ZnJlcXVlbmN5IHBvbGxpbmcgZXZlbnQgc291cmNlIGNhbiBzdGFydmUgbm9uLXBvbGxpbmcgZXZl
bnQKICAgc291cmNlcyBiZWNhdXNlIHBwb2xsKDIpL2Vwb2xsKDcpIGlzIG5ldmVyIGludm9rZWQu
CgpUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIGZvcmNlZCBwb2xsaW5nIGl0ZXJhdGlvbiBzbyB0aGF0
IHBvbGxfbnM9MCByZWFsbHkKbWVhbnMgbm8gcG9sbGluZy4KCklPUFMgaW5jcmVhc2VzIGZyb20g
MTBrIHRvIDYwayB3aGVuIHRoZSBndWVzdCBoYXMgMTAwCnZpcnRpby1ibGstcGNpLG51bS1xdWV1
ZXM9MzIgZGV2aWNlcyBhbmQgMSB2aXJ0aW8tYmxrLXBjaSxudW0tcXVldWVzPTEKZGV2aWNlIGJl
Y2F1c2UgdGhlIGxhcmdlIG51bWJlciBvZiBldmVudCBzb3VyY2VzIGJlaW5nIHBvbGxlZCBzbG93
cyBkb3duCnRoZSBldmVudCBsb29wLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCAyMiArKysrKysrKysr
KysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwpp
bmRleCA5ZTFiZWZjMGMwLi4wMjlmMTQ2NDU1IDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5j
CisrKyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAgLTM2MSwxMiArMzYxLDEzIEBAIHZvaWQgYWlvX3Nl
dF9ldmVudF9ub3RpZmllcl9wb2xsKEFpb0NvbnRleHQgKmN0eCwKICAgICAgICAgICAgICAgICAg
ICAgKElPSGFuZGxlciAqKWlvX3BvbGxfZW5kKTsKIH0KIAotc3RhdGljIHZvaWQgcG9sbF9zZXRf
c3RhcnRlZChBaW9Db250ZXh0ICpjdHgsIGJvb2wgc3RhcnRlZCkKK3N0YXRpYyBib29sIHBvbGxf
c2V0X3N0YXJ0ZWQoQWlvQ29udGV4dCAqY3R4LCBib29sIHN0YXJ0ZWQpCiB7CiAgICAgQWlvSGFu
ZGxlciAqbm9kZTsKKyAgICBib29sIHByb2dyZXNzID0gZmFsc2U7CiAKICAgICBpZiAoc3RhcnRl
ZCA9PSBjdHgtPnBvbGxfc3RhcnRlZCkgewotICAgICAgICByZXR1cm47CisgICAgICAgIHJldHVy
biBmYWxzZTsKICAgICB9CiAKICAgICBjdHgtPnBvbGxfc3RhcnRlZCA9IHN0YXJ0ZWQ7CkBAIC0z
ODgsOCArMzg5LDE1IEBAIHN0YXRpYyB2b2lkIHBvbGxfc2V0X3N0YXJ0ZWQoQWlvQ29udGV4dCAq
Y3R4LCBib29sIHN0YXJ0ZWQpCiAgICAgICAgIGlmIChmbikgewogICAgICAgICAgICAgZm4obm9k
ZS0+b3BhcXVlKTsKICAgICAgICAgfQorCisgICAgICAgIC8qIFBvbGwgb25lIGxhc3QgdGltZSBp
biBjYXNlIC0+aW9fcG9sbF9lbmQoKSByYWNlZCB3aXRoIHRoZSBldmVudCAqLworICAgICAgICBp
ZiAoIXN0YXJ0ZWQpIHsKKyAgICAgICAgICAgIHByb2dyZXNzID0gbm9kZS0+aW9fcG9sbChub2Rl
LT5vcGFxdWUpIHx8IHByb2dyZXNzOworICAgICAgICB9CiAgICAgfQogICAgIHFlbXVfbG9ja2Nu
dF9kZWMoJmN0eC0+bGlzdF9sb2NrKTsKKworICAgIHJldHVybiBwcm9ncmVzczsKIH0KIAogCkBA
IC02NzAsMTIgKzY3OCwxMiBAQCBzdGF0aWMgYm9vbCB0cnlfcG9sbF9tb2RlKEFpb0NvbnRleHQg
KmN0eCwgaW50NjRfdCAqdGltZW91dCkKICAgICAgICAgfQogICAgIH0KIAotICAgIHBvbGxfc2V0
X3N0YXJ0ZWQoY3R4LCBmYWxzZSk7CisgICAgaWYgKHBvbGxfc2V0X3N0YXJ0ZWQoY3R4LCBmYWxz
ZSkpIHsKKyAgICAgICAgKnRpbWVvdXQgPSAwOworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9
CiAKLSAgICAvKiBFdmVuIGlmIHdlIGRvbid0IHJ1biBidXN5IHBvbGxpbmcsIHRyeSBwb2xsaW5n
IG9uY2UgaW4gY2FzZSBpdCBjYW4gbWFrZQotICAgICAqIHByb2dyZXNzIGFuZCB0aGUgY2FsbGVy
IHdpbGwgYmUgYWJsZSB0byBhdm9pZCBwcG9sbCgyKS9lcG9sbF93YWl0KDIpLgotICAgICAqLwot
ICAgIHJldHVybiBydW5fcG9sbF9oYW5kbGVyc19vbmNlKGN0eCwgdGltZW91dCk7CisgICAgcmV0
dXJuIGZhbHNlOwogfQogCiBib29sIGFpb19wb2xsKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBibG9j
a2luZykKLS0gCjIuMjQuMQoK


