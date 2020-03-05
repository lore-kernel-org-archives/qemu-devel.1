Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18009208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSz11OBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18009208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9u5T-0002Om-A9
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j9tz6-0000KT-73
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j9tz4-0003KL-Q7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j9tz4-0003K4-Mr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5VFQ32SjFxjxWH3wJ7PPjfM9vFVd7gH5+O/oGnhQVw=;
 b=bSz11OBdwfqvGotV9/lNBfHHtBHsKjWxLLQRuDqqiGKhueUWDuY67cdj6v/jCCyNpClKdn
 f/tTEFsST10L2ozTD+IVXvXFa3ZMAvUWMVHrl0fWjzhMyMqZqipji982LV2fDk4IYYduBQ
 0hq/IJv4Fg6PBMTk19p/S9DKTW016ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-fZRoV7a0PXeahsHwZUnUhA-1; Thu, 05 Mar 2020 12:08:27 -0500
X-MC-Unique: fZRoV7a0PXeahsHwZUnUhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 707A5107ACCA;
 Thu,  5 Mar 2020 17:08:26 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05BE890779;
 Thu,  5 Mar 2020 17:08:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] aio-posix: simplify FDMonOps->update() prototype
Date: Thu,  5 Mar 2020 17:08:03 +0000
Message-Id: <20200305170806.1313245-5-stefanha@redhat.com>
In-Reply-To: <20200305170806.1313245-1-stefanha@redhat.com>
References: <20200305170806.1313245-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIEFpb0hhbmRsZXIgKm5vZGUsIGJvb2wgaXNfbmV3IGFyZ3VtZW50cyBhcmUgbW9yZSBjb21w
bGljYXRlZCB0bwp0aGluayBhYm91dCB0aGFuIHNpbXBseSBiZWluZyBnaXZlbiBBaW9IYW5kbGVy
ICpvbGRfbm9kZSwgQWlvSGFuZGxlcgoqbmV3X25vZGUuCgpGdXJ0aGVybW9yZSwgdGhlIG5ldyBM
aW51eCBpb191cmluZyBmaWxlIGRlc2NyaXB0b3IgbW9uaXRvcmluZyBtZWNoYW5pc20KYWRkZWQg
YnkgdGhlIG5ldyBwYXRjaCByZXF1aXJlcyBhY2Nlc3MgdG8gYm90aCB0aGUgb2xkIGFuZCB0aGUg
bmV3Cm5vZGVzLiAgTWFrZSB0aGlzIGNoYW5nZSBub3cgaW4gcHJlcGFyYXRpb24uCgpTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVk
ZS9ibG9jay9haW8uaCB8IDEzICsrKysrKy0tLS0tLS0KIHV0aWwvYWlvLXBvc2l4LmMgICAgfCAg
NyArLS0tLS0tCiB1dGlsL2ZkbW9uLWVwb2xsLmMgIHwgMjEgKysrKysrKysrKysrLS0tLS0tLS0t
CiB1dGlsL2ZkbW9uLXBvbGwuYyAgIHwgIDQgKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Fp
by5oIGIvaW5jbHVkZS9ibG9jay9haW8uaAppbmRleCA5MGUwN2Q3NTA3Li5iZDc2YjA4ZjFhIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Fpby5oCisrKyBiL2luY2x1ZGUvYmxvY2svYWlvLmgK
QEAgLTU3LDE3ICs1NywxNiBAQCB0eXBlZGVmIHN0cnVjdCB7CiAgICAgLyoKICAgICAgKiB1cGRh
dGU6CiAgICAgICogQGN0eDogdGhlIEFpb0NvbnRleHQKLSAgICAgKiBAbm9kZTogdGhlIGhhbmRs
ZXIKLSAgICAgKiBAaXNfbmV3OiBpcyB0aGUgZmlsZSBkZXNjcmlwdG9yIGFscmVhZHkgYmVpbmcg
bW9uaXRvcmVkPworICAgICAqIEBvbGRfbm9kZTogdGhlIGV4aXN0aW5nIGhhbmRsZXIgb3IgTlVM
TCBpZiB0aGlzIGZpbGUgZGVzY3JpcHRvciBpcyBiZWluZworICAgICAqICAgICAgICAgICAgbW9u
aXRvcmVkIGZvciB0aGUgZmlyc3QgdGltZQorICAgICAqIEBuZXdfbm9kZTogdGhlIG5ldyBoYW5k
bGVyIG9yIE5VTEwgaWYgdGhpcyBmaWxlIGRlc2NyaXB0b3IgaXMgYmVpbmcKKyAgICAgKiAgICAg
ICAgICAgIHJlbW92ZWQKICAgICAgKgotICAgICAqIEFkZC9yZW1vdmUvbW9kaWZ5IGEgbW9uaXRv
cmVkIGZpbGUgZGVzY3JpcHRvci4gIFRoZXJlIGFyZSB0aHJlZSBjYXNlczoKLSAgICAgKiAxLiBu
b2RlLT5wZmQuZXZlbnRzID09IDAgbWVhbnMgcmVtb3ZlIHRoZSBmaWxlIGRlc2NyaXB0b3IuCi0g
ICAgICogMi4gIWlzX25ldyBtZWFucyBtb2RpZnkgYW4gYWxyZWFkeSBtb25pdG9yZWQgZmlsZSBk
ZXNjcmlwdG9yLgotICAgICAqIDMuIGlzX25ldyBtZWFucyBhZGQgYSBuZXcgZmlsZSBkZXNjcmlw
dG9yLgorICAgICAqIEFkZC9yZW1vdmUvbW9kaWZ5IGEgbW9uaXRvcmVkIGZpbGUgZGVzY3JpcHRv
ci4KICAgICAgKgogICAgICAqIENhbGxlZCB3aXRoIGN0eC0+bGlzdF9sb2NrIGFjcXVpcmVkLgog
ICAgICAqLwotICAgIHZvaWQgKCp1cGRhdGUpKEFpb0NvbnRleHQgKmN0eCwgQWlvSGFuZGxlciAq
bm9kZSwgYm9vbCBpc19uZXcpOworICAgIHZvaWQgKCp1cGRhdGUpKEFpb0NvbnRleHQgKmN0eCwg
QWlvSGFuZGxlciAqb2xkX25vZGUsIEFpb0hhbmRsZXIgKm5ld19ub2RlKTsKIAogICAgIC8qCiAg
ICAgICogd2FpdDoKZGlmZiAtLWdpdCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3Np
eC5jCmluZGV4IDRkOTdiNGM3ZGUuLjNiOWFhZDRjYTcgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBv
c2l4LmMKKysrIGIvdXRpbC9haW8tcG9zaXguYwpAQCAtMTM5LDEyICsxMzksNyBAQCB2b2lkIGFp
b19zZXRfZmRfaGFuZGxlcihBaW9Db250ZXh0ICpjdHgsCiAgICAgYXRvbWljX3NldCgmY3R4LT5w
b2xsX2Rpc2FibGVfY250LAogICAgICAgICAgICAgICAgYXRvbWljX3JlYWQoJmN0eC0+cG9sbF9k
aXNhYmxlX2NudCkgKyBwb2xsX2Rpc2FibGVfY2hhbmdlKTsKIAotICAgIGlmIChuZXdfbm9kZSkg
ewotICAgICAgICBjdHgtPmZkbW9uX29wcy0+dXBkYXRlKGN0eCwgbmV3X25vZGUsIGlzX25ldyk7
Ci0gICAgfSBlbHNlIGlmIChub2RlKSB7Ci0gICAgICAgIC8qIFVucmVnaXN0ZXIgZGVsZXRlZCBm
ZF9oYW5kbGVyICovCi0gICAgICAgIGN0eC0+ZmRtb25fb3BzLT51cGRhdGUoY3R4LCBub2RlLCBm
YWxzZSk7Ci0gICAgfQorICAgIGN0eC0+ZmRtb25fb3BzLT51cGRhdGUoY3R4LCBub2RlLCBuZXdf
bm9kZSk7CiAgICAgcWVtdV9sb2NrY250X3VubG9jaygmY3R4LT5saXN0X2xvY2spOwogICAgIGFp
b19ub3RpZnkoY3R4KTsKIApkaWZmIC0tZ2l0IGEvdXRpbC9mZG1vbi1lcG9sbC5jIGIvdXRpbC9m
ZG1vbi1lcG9sbC5jCmluZGV4IDI5YzE0NTQ0NjkuLmQ1NmI2OTQ2OGIgMTAwNjQ0Ci0tLSBhL3V0
aWwvZmRtb24tZXBvbGwuYworKysgYi91dGlsL2ZkbW9uLWVwb2xsLmMKQEAgLTMwLDIxICszMCwy
NCBAQCBzdGF0aWMgaW5saW5lIGludCBlcG9sbF9ldmVudHNfZnJvbV9wZmQoaW50IHBmZF9ldmVu
dHMpCiAgICAgICAgICAgIChwZmRfZXZlbnRzICYgR19JT19FUlIgPyBFUE9MTEVSUiA6IDApOwog
fQogCi1zdGF0aWMgdm9pZCBmZG1vbl9lcG9sbF91cGRhdGUoQWlvQ29udGV4dCAqY3R4LCBBaW9I
YW5kbGVyICpub2RlLCBib29sIGlzX25ldykKK3N0YXRpYyB2b2lkIGZkbW9uX2Vwb2xsX3VwZGF0
ZShBaW9Db250ZXh0ICpjdHgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWlvSGFu
ZGxlciAqb2xkX25vZGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWlvSGFuZGxl
ciAqbmV3X25vZGUpCiB7Ci0gICAgc3RydWN0IGVwb2xsX2V2ZW50IGV2ZW50OworICAgIHN0cnVj
dCBlcG9sbF9ldmVudCBldmVudCA9IHsKKyAgICAgICAgLmRhdGEucHRyID0gbmV3X25vZGUsCisg
ICAgICAgIC5ldmVudHMgPSBuZXdfbm9kZSA/IGVwb2xsX2V2ZW50c19mcm9tX3BmZChuZXdfbm9k
ZS0+cGZkLmV2ZW50cykgOiAwLAorICAgIH07CiAgICAgaW50IHI7Ci0gICAgaW50IGN0bDsKIAot
ICAgIGlmICghbm9kZS0+cGZkLmV2ZW50cykgewotICAgICAgICBjdGwgPSBFUE9MTF9DVExfREVM
OworICAgIGlmICghbmV3X25vZGUpIHsKKyAgICAgICAgciA9IGVwb2xsX2N0bChjdHgtPmVwb2xs
ZmQsIEVQT0xMX0NUTF9ERUwsIG9sZF9ub2RlLT5wZmQuZmQsICZldmVudCk7CisgICAgfSBlbHNl
IGlmICghb2xkX25vZGUpIHsKKyAgICAgICAgciA9IGVwb2xsX2N0bChjdHgtPmVwb2xsZmQsIEVQ
T0xMX0NUTF9BREQsIG5ld19ub2RlLT5wZmQuZmQsICZldmVudCk7CiAgICAgfSBlbHNlIHsKLSAg
ICAgICAgZXZlbnQuZGF0YS5wdHIgPSBub2RlOwotICAgICAgICBldmVudC5ldmVudHMgPSBlcG9s
bF9ldmVudHNfZnJvbV9wZmQobm9kZS0+cGZkLmV2ZW50cyk7Ci0gICAgICAgIGN0bCA9IGlzX25l
dyA/IEVQT0xMX0NUTF9BREQgOiBFUE9MTF9DVExfTU9EOworICAgICAgICByID0gZXBvbGxfY3Rs
KGN0eC0+ZXBvbGxmZCwgRVBPTExfQ1RMX01PRCwgbmV3X25vZGUtPnBmZC5mZCwgJmV2ZW50KTsK
ICAgICB9CiAKLSAgICByID0gZXBvbGxfY3RsKGN0eC0+ZXBvbGxmZCwgY3RsLCBub2RlLT5wZmQu
ZmQsICZldmVudCk7CiAgICAgaWYgKHIpIHsKICAgICAgICAgZmRtb25fZXBvbGxfZGlzYWJsZShj
dHgpOwogICAgIH0KZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24tcG9sbC5jIGIvdXRpbC9mZG1vbi1w
b2xsLmMKaW5kZXggNjc5OTIxMTZiOC4uMjgxMTRhMGYzOSAxMDA2NDQKLS0tIGEvdXRpbC9mZG1v
bi1wb2xsLmMKKysrIGIvdXRpbC9mZG1vbi1wb2xsLmMKQEAgLTkzLDcgKzkzLDkgQEAgc3RhdGlj
IGludCBmZG1vbl9wb2xsX3dhaXQoQWlvQ29udGV4dCAqY3R4LCBBaW9IYW5kbGVyTGlzdCAqcmVh
ZHlfbGlzdCwKICAgICByZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgdm9pZCBmZG1vbl9wb2xsX3Vw
ZGF0ZShBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRsZXIgKm5vZGUsIGJvb2wgaXNfbmV3KQorc3Rh
dGljIHZvaWQgZmRtb25fcG9sbF91cGRhdGUoQWlvQ29udGV4dCAqY3R4LAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQWlvSGFuZGxlciAqb2xkX25vZGUsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBBaW9IYW5kbGVyICpuZXdfbm9kZSkKIHsKICAgICAvKiBEbyBub3RoaW5n
LCBBaW9IYW5kbGVyIGFscmVhZHkgY29udGFpbnMgdGhlIHN0YXRlIHdlJ2xsIG5lZWQgKi8KIH0K
LS0gCjIuMjQuMQoK


