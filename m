Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA02C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9412072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfSYVqqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9412072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uCG-0004TU-Tp
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j9tzB-0000V5-AX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j9tz9-0003ND-Sx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j9tz9-0003MZ-No
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSd10YyDelIgpQ6PH9ngXWKEeTT2D1gh++ZXGYXUwgk=;
 b=PfSYVqqmnhsqtCpzAULQHlE15jG5CvU8ASP/pdinLX3oQzHQCSKyFeJtbfcaTCw2rZIt34
 vfzINU+v0S0E832M5RbHN3PdtsK9O/djPZJJ38G1RJF3t00RadPvELPlCLKWEeVOw6iYja
 6Iat8bzw0KCkMm5EriOcD4tP4ue1wKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-LuA6_eZCNmS9X8sajAILxA-1; Thu, 05 Mar 2020 12:08:34 -0500
X-MC-Unique: LuA6_eZCNmS9X8sajAILxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7391107ACC4;
 Thu,  5 Mar 2020 17:08:32 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF9E90796;
 Thu,  5 Mar 2020 17:08:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] aio-posix: support userspace polling of fd monitoring
Date: Thu,  5 Mar 2020 17:08:05 +0000
Message-Id: <20200305170806.1313245-7-stefanha@redhat.com>
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

VW5saWtlIHBwb2xsKDIpIGFuZCBlcG9sbCg3KSwgTGludXggaW9fdXJpbmcgY29tcGxldGlvbnMg
Y2FuIGJlIHBvbGxlZApmcm9tIHVzZXJzcGFjZS4gIFByZXZpb3VzbHkgdXNlcnNwYWNlIHBvbGxp
bmcgd2FzIG9ubHkgYWxsb3dlZCB3aGVuIGFsbApBaW9IYW5kbGVyJ3MgaGFkIGFuIC0+aW9fcG9s
bCgpIGNhbGxiYWNrLiAgVGhpcyBwcmV2ZW50ZWQgc3RhcnZhdGlvbiBvZgpmZHMgYnkgdXNlcnNw
YWNlIHBvbGxhYmxlIGhhbmRsZXJzLgoKQWRkIHRoZSBGRE1vbk9wcy0+bmVlZF93YWl0KCkgY2Fs
bGJhY2sgdGhhdCBlbmFibGVzIHVzZXJzcGFjZSBwb2xsaW5nCmV2ZW4gd2hlbiBzb21lIEFpb0hh
bmRsZXJzIGxhY2sgLT5pb19wb2xsKCkuCgpGb3IgZXhhbXBsZSwgaXQncyBub3cgcG9zc2libGUg
dG8gZG8gdXNlcnNwYWNlIHBvbGxpbmcgd2hlbiBhIFRDUC9JUApzb2NrZXQgaXMgbW9uaXRvcmVk
IHRoYW5rcyB0byBMaW51eCBpb191cmluZy4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2Jsb2NrL2Fpby5oICAgfCAxOSAr
KysrKysrKysrKysrKysrKysrCiB1dGlsL2Fpby1wb3NpeC5jICAgICAgfCAxMSArKysrKysrKy0t
LQogdXRpbC9mZG1vbi1lcG9sbC5jICAgIHwgIDEgKwogdXRpbC9mZG1vbi1pb191cmluZy5jIHwg
IDYgKysrKysrCiB1dGlsL2ZkbW9uLXBvbGwuYyAgICAgfCAgMSArCiA1IGZpbGVzIGNoYW5nZWQs
IDM1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9i
bG9jay9haW8uaCBiL2luY2x1ZGUvYmxvY2svYWlvLmgKaW5kZXggODNmYzliODQ0ZC4uZjA3ZWJi
NzZiOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ibG9jay9haW8uaAorKysgYi9pbmNsdWRlL2Jsb2Nr
L2Fpby5oCkBAIC01NSw2ICs1NSw5IEBAIHN0cnVjdCBUaHJlYWRQb29sOwogc3RydWN0IExpbnV4
QWlvU3RhdGU7CiBzdHJ1Y3QgTHVyaW5nU3RhdGU7CiAKKy8qIElzIHBvbGxpbmcgZGlzYWJsZWQ/
ICovCitib29sIGFpb19wb2xsX2Rpc2FibGVkKEFpb0NvbnRleHQgKmN0eCk7CisKIC8qIENhbGxi
YWNrcyBmb3IgZmlsZSBkZXNjcmlwdG9yIG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb25zICovCiB0
eXBlZGVmIHN0cnVjdCB7CiAgICAgLyoKQEAgLTg0LDYgKzg3LDIyIEBAIHR5cGVkZWYgc3RydWN0
IHsKICAgICAgKiBSZXR1cm5zOiBudW1iZXIgb2YgcmVhZHkgZmlsZSBkZXNjcmlwdG9ycy4KICAg
ICAgKi8KICAgICBpbnQgKCp3YWl0KShBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRsZXJMaXN0ICpy
ZWFkeV9saXN0LCBpbnQ2NF90IHRpbWVvdXQpOworCisgICAgLyoKKyAgICAgKiBuZWVkX3dhaXQ6
CisgICAgICogQGN0eDogdGhlIEFpb0NvbnRleHQKKyAgICAgKgorICAgICAqIFRlbGwgYWlvX3Bv
bGwoKSB3aGVuIHRvIHN0b3AgdXNlcnNwYWNlIHBvbGxpbmcgZWFybHkgYmVjYXVzZSAtPndhaXQo
KQorICAgICAqIGhhcyBmZHMgcmVhZHkuCisgICAgICoKKyAgICAgKiBGaWxlIGRlc2NyaXB0b3Ig
bW9uaXRvcmluZyBpbXBsZW1lbnRhdGlvbnMgdGhhdCBjYW5ub3QgcG9sbCBmZCByZWFkaW5lc3MK
KyAgICAgKiBmcm9tIHVzZXJzcGFjZSBzaG91bGQgdXNlIGFpb19wb2xsX2Rpc2FibGVkKCkgaGVy
ZS4gIFRoaXMgZW5zdXJlcyB0aGF0CisgICAgICogZmlsZSBkZXNjcmlwdG9ycyBhcmUgbm90IHN0
YXJ2ZWQgYnkgaGFuZGxlcnMgdGhhdCBmcmVxdWVudGx5IG1ha2UKKyAgICAgKiBwcm9ncmVzcyB2
aWEgdXNlcnNwYWNlIHBvbGxpbmcuCisgICAgICoKKyAgICAgKiBSZXR1cm5zOiB0cnVlIGlmIC0+
d2FpdCgpIHNob3VsZCBiZSBjYWxsZWQsIGZhbHNlIG90aGVyd2lzZS4KKyAgICAgKi8KKyAgICBi
b29sICgqbmVlZF93YWl0KShBaW9Db250ZXh0ICpjdHgpOwogfSBGRE1vbk9wczsKIAogLyoKZGlm
ZiAtLWdpdCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IGEyNGEz
M2MxNWEuLmVkZTA0YTRiYzIgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRp
bC9haW8tcG9zaXguYwpAQCAtMjIsNiArMjIsMTEgQEAKICNpbmNsdWRlICJ0cmFjZS5oIgogI2lu
Y2x1ZGUgImFpby1wb3NpeC5oIgogCitib29sIGFpb19wb2xsX2Rpc2FibGVkKEFpb0NvbnRleHQg
KmN0eCkKK3sKKyAgICByZXR1cm4gYXRvbWljX3JlYWQoJmN0eC0+cG9sbF9kaXNhYmxlX2NudCk7
Cit9CisKIHZvaWQgYWlvX2FkZF9yZWFkeV9oYW5kbGVyKEFpb0hhbmRsZXJMaXN0ICpyZWFkeV9s
aXN0LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgQWlvSGFuZGxlciAqbm9kZSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludCByZXZlbnRzKQpAQCAtNDIzLDcgKzQyOCw3IEBAIHN0
YXRpYyBib29sIHJ1bl9wb2xsX2hhbmRsZXJzKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCBtYXhf
bnMsIGludDY0X3QgKnRpbWVvdXQpCiAgICAgICAgIGVsYXBzZWRfdGltZSA9IHFlbXVfY2xvY2tf
Z2V0X25zKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpIC0gc3RhcnRfdGltZTsKICAgICAgICAgbWF4X25z
ID0gcWVtdV9zb29uZXN0X3RpbWVvdXQoKnRpbWVvdXQsIG1heF9ucyk7CiAgICAgICAgIGFzc2Vy
dCghKG1heF9ucyAmJiBwcm9ncmVzcykpOwotICAgIH0gd2hpbGUgKGVsYXBzZWRfdGltZSA8IG1h
eF9ucyAmJiAhYXRvbWljX3JlYWQoJmN0eC0+cG9sbF9kaXNhYmxlX2NudCkpOworICAgIH0gd2hp
bGUgKGVsYXBzZWRfdGltZSA8IG1heF9ucyAmJiAhY3R4LT5mZG1vbl9vcHMtPm5lZWRfd2FpdChj
dHgpKTsKIAogICAgIC8qIElmIHRpbWUgaGFzIHBhc3NlZCB3aXRoIG5vIHN1Y2Nlc3NmdWwgcG9s
bGluZywgYWRqdXN0ICp0aW1lb3V0IHRvCiAgICAgICoga2VlcCB0aGUgc2FtZSBlbmRpbmcgdGlt
ZS4KQEAgLTQ1MSw3ICs0NTYsNyBAQCBzdGF0aWMgYm9vbCB0cnlfcG9sbF9tb2RlKEFpb0NvbnRl
eHQgKmN0eCwgaW50NjRfdCAqdGltZW91dCkKIHsKICAgICBpbnQ2NF90IG1heF9ucyA9IHFlbXVf
c29vbmVzdF90aW1lb3V0KCp0aW1lb3V0LCBjdHgtPnBvbGxfbnMpOwogCi0gICAgaWYgKG1heF9u
cyAmJiAhYXRvbWljX3JlYWQoJmN0eC0+cG9sbF9kaXNhYmxlX2NudCkpIHsKKyAgICBpZiAobWF4
X25zICYmICFjdHgtPmZkbW9uX29wcy0+bmVlZF93YWl0KGN0eCkpIHsKICAgICAgICAgcG9sbF9z
ZXRfc3RhcnRlZChjdHgsIHRydWUpOwogCiAgICAgICAgIGlmIChydW5fcG9sbF9oYW5kbGVycyhj
dHgsIG1heF9ucywgdGltZW91dCkpIHsKQEAgLTUwMSw3ICs1MDYsNyBAQCBib29sIGFpb19wb2xs
KEFpb0NvbnRleHQgKmN0eCwgYm9vbCBibG9ja2luZykKICAgICAvKiBJZiBwb2xsaW5nIGlzIGFs
bG93ZWQsIG5vbi1ibG9ja2luZyBhaW9fcG9sbCBkb2VzIG5vdCBuZWVkIHRoZQogICAgICAqIHN5
c3RlbSBjYWxsLS0tYSBzaW5nbGUgcm91bmQgb2YgcnVuX3BvbGxfaGFuZGxlcnNfb25jZSBzdWZm
aWNlcy4KICAgICAgKi8KLSAgICBpZiAodGltZW91dCB8fCBhdG9taWNfcmVhZCgmY3R4LT5wb2xs
X2Rpc2FibGVfY250KSkgeworICAgIGlmICh0aW1lb3V0IHx8IGN0eC0+ZmRtb25fb3BzLT5uZWVk
X3dhaXQoY3R4KSkgewogICAgICAgICByZXQgPSBjdHgtPmZkbW9uX29wcy0+d2FpdChjdHgsICZy
ZWFkeV9saXN0LCB0aW1lb3V0KTsKICAgICB9CiAKZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24tZXBv
bGwuYyBiL3V0aWwvZmRtb24tZXBvbGwuYwppbmRleCBkNTZiNjk0NjhiLi5mY2Q5ODlkNDdkIDEw
MDY0NAotLS0gYS91dGlsL2ZkbW9uLWVwb2xsLmMKKysrIGIvdXRpbC9mZG1vbi1lcG9sbC5jCkBA
IC0xMDAsNiArMTAwLDcgQEAgb3V0Ogogc3RhdGljIGNvbnN0IEZETW9uT3BzIGZkbW9uX2Vwb2xs
X29wcyA9IHsKICAgICAudXBkYXRlID0gZmRtb25fZXBvbGxfdXBkYXRlLAogICAgIC53YWl0ID0g
ZmRtb25fZXBvbGxfd2FpdCwKKyAgICAubmVlZF93YWl0ID0gYWlvX3BvbGxfZGlzYWJsZWQsCiB9
OwogCiBzdGF0aWMgYm9vbCBmZG1vbl9lcG9sbF90cnlfZW5hYmxlKEFpb0NvbnRleHQgKmN0eCkK
ZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24taW9fdXJpbmcuYyBiL3V0aWwvZmRtb24taW9fdXJpbmcu
YwppbmRleCBmYjk5YjRiNjFlLi44OTNiNzliNjIyIDEwMDY0NAotLS0gYS91dGlsL2ZkbW9uLWlv
X3VyaW5nLmMKKysrIGIvdXRpbC9mZG1vbi1pb191cmluZy5jCkBAIC0yODgsOSArMjg4LDE1IEBA
IHN0YXRpYyBpbnQgZmRtb25faW9fdXJpbmdfd2FpdChBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRs
ZXJMaXN0ICpyZWFkeV9saXN0LAogICAgIHJldHVybiBwcm9jZXNzX2NxX3JpbmcoY3R4LCByZWFk
eV9saXN0KTsKIH0KIAorc3RhdGljIGJvb2wgZmRtb25faW9fdXJpbmdfbmVlZF93YWl0KEFpb0Nv
bnRleHQgKmN0eCkKK3sKKyAgICByZXR1cm4gaW9fdXJpbmdfY3FfcmVhZHkoJmN0eC0+ZmRtb25f
aW9fdXJpbmcpOworfQorCiBzdGF0aWMgY29uc3QgRkRNb25PcHMgZmRtb25faW9fdXJpbmdfb3Bz
ID0gewogICAgIC51cGRhdGUgPSBmZG1vbl9pb191cmluZ191cGRhdGUsCiAgICAgLndhaXQgPSBm
ZG1vbl9pb191cmluZ193YWl0LAorICAgIC5uZWVkX3dhaXQgPSBmZG1vbl9pb191cmluZ19uZWVk
X3dhaXQsCiB9OwogCiBib29sIGZkbW9uX2lvX3VyaW5nX3NldHVwKEFpb0NvbnRleHQgKmN0eCkK
ZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24tcG9sbC5jIGIvdXRpbC9mZG1vbi1wb2xsLmMKaW5kZXgg
MjgxMTRhMGYzOS4uNDg4MDY3YjY3OSAxMDA2NDQKLS0tIGEvdXRpbC9mZG1vbi1wb2xsLmMKKysr
IGIvdXRpbC9mZG1vbi1wb2xsLmMKQEAgLTEwMyw0ICsxMDMsNSBAQCBzdGF0aWMgdm9pZCBmZG1v
bl9wb2xsX3VwZGF0ZShBaW9Db250ZXh0ICpjdHgsCiBjb25zdCBGRE1vbk9wcyBmZG1vbl9wb2xs
X29wcyA9IHsKICAgICAudXBkYXRlID0gZmRtb25fcG9sbF91cGRhdGUsCiAgICAgLndhaXQgPSBm
ZG1vbl9wb2xsX3dhaXQsCisgICAgLm5lZWRfd2FpdCA9IGFpb19wb2xsX2Rpc2FibGVkLAogfTsK
LS0gCjIuMjQuMQoK


