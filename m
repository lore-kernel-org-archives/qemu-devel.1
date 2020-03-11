Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACCEC3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B73621655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3bT0Hd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B73621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0kT-0006Ex-66
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0g2-0007Lj-CF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0g0-0000Mr-Ss
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0g0-0000Ml-Og
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOPPWZZHASZTVyNhgRUoBjPgRsVz4P/bYh4pQhKe7FM=;
 b=N3bT0Hd3y081TYA7WtInIVxor9JXbvPHs1MK7aRftsDCTMAV+I2Eb8s/8yKVvuxr3GzjX9
 kcPPTRDqdZH8/1FVdWTrNzMYdT21utg8CopCfi9gvbPKhGzzBFcqeRnMoY0J5cpWMi93m/
 tSI5EEu5j2XbUeZJymmRZ82cZvV3O4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-giofkviPMti6e68MzRXybA-1; Wed, 11 Mar 2020 08:41:26 -0400
X-MC-Unique: giofkviPMti6e68MzRXybA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63A20801E66;
 Wed, 11 Mar 2020 12:41:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 494D373880;
 Wed, 11 Mar 2020 12:41:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] aio-posix: support userspace polling of fd monitoring
Date: Wed, 11 Mar 2020 12:40:44 +0000
Message-Id: <20200311124045.277969-9-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
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
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDIwMDMwNTE3MDgwNi4xMzEzMjQ1LTctc3RlZmFuaGFAcmVkaGF0LmNvbQpNZXNzYWdlLUlkOiA8
MjAyMDAzMDUxNzA4MDYuMTMxMzI0NS03LXN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVk
ZS9ibG9jay9haW8uaCAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogdXRpbC9haW8tcG9zaXgu
YyAgICAgIHwgMTEgKysrKysrKystLS0KIHV0aWwvZmRtb24tZXBvbGwuYyAgICB8ICAxICsKIHV0
aWwvZmRtb24taW9fdXJpbmcuYyB8ICA2ICsrKysrKwogdXRpbC9mZG1vbi1wb2xsLmMgICAgIHwg
IDEgKwogNSBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYWlvLmggYi9pbmNsdWRlL2Jsb2NrL2Fpby5oCmlu
ZGV4IDgzZmM5Yjg0NGQuLmYwN2ViYjc2YjggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmxvY2svYWlv
LmgKKysrIGIvaW5jbHVkZS9ibG9jay9haW8uaApAQCAtNTUsNiArNTUsOSBAQCBzdHJ1Y3QgVGhy
ZWFkUG9vbDsKIHN0cnVjdCBMaW51eEFpb1N0YXRlOwogc3RydWN0IEx1cmluZ1N0YXRlOwogCisv
KiBJcyBwb2xsaW5nIGRpc2FibGVkPyAqLworYm9vbCBhaW9fcG9sbF9kaXNhYmxlZChBaW9Db250
ZXh0ICpjdHgpOworCiAvKiBDYWxsYmFja3MgZm9yIGZpbGUgZGVzY3JpcHRvciBtb25pdG9yaW5n
IGltcGxlbWVudGF0aW9ucyAqLwogdHlwZWRlZiBzdHJ1Y3QgewogICAgIC8qCkBAIC04NCw2ICs4
NywyMiBAQCB0eXBlZGVmIHN0cnVjdCB7CiAgICAgICogUmV0dXJuczogbnVtYmVyIG9mIHJlYWR5
IGZpbGUgZGVzY3JpcHRvcnMuCiAgICAgICovCiAgICAgaW50ICgqd2FpdCkoQWlvQ29udGV4dCAq
Y3R4LCBBaW9IYW5kbGVyTGlzdCAqcmVhZHlfbGlzdCwgaW50NjRfdCB0aW1lb3V0KTsKKworICAg
IC8qCisgICAgICogbmVlZF93YWl0OgorICAgICAqIEBjdHg6IHRoZSBBaW9Db250ZXh0CisgICAg
ICoKKyAgICAgKiBUZWxsIGFpb19wb2xsKCkgd2hlbiB0byBzdG9wIHVzZXJzcGFjZSBwb2xsaW5n
IGVhcmx5IGJlY2F1c2UgLT53YWl0KCkKKyAgICAgKiBoYXMgZmRzIHJlYWR5LgorICAgICAqCisg
ICAgICogRmlsZSBkZXNjcmlwdG9yIG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb25zIHRoYXQgY2Fu
bm90IHBvbGwgZmQgcmVhZGluZXNzCisgICAgICogZnJvbSB1c2Vyc3BhY2Ugc2hvdWxkIHVzZSBh
aW9fcG9sbF9kaXNhYmxlZCgpIGhlcmUuICBUaGlzIGVuc3VyZXMgdGhhdAorICAgICAqIGZpbGUg
ZGVzY3JpcHRvcnMgYXJlIG5vdCBzdGFydmVkIGJ5IGhhbmRsZXJzIHRoYXQgZnJlcXVlbnRseSBt
YWtlCisgICAgICogcHJvZ3Jlc3MgdmlhIHVzZXJzcGFjZSBwb2xsaW5nLgorICAgICAqCisgICAg
ICogUmV0dXJuczogdHJ1ZSBpZiAtPndhaXQoKSBzaG91bGQgYmUgY2FsbGVkLCBmYWxzZSBvdGhl
cndpc2UuCisgICAgICovCisgICAgYm9vbCAoKm5lZWRfd2FpdCkoQWlvQ29udGV4dCAqY3R4KTsK
IH0gRkRNb25PcHM7CiAKIC8qCmRpZmYgLS1naXQgYS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9h
aW8tcG9zaXguYwppbmRleCBmZmQ5Y2MzODFiLi43NTk5ODliNDViIDEwMDY0NAotLS0gYS91dGls
L2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAgLTIyLDYgKzIyLDExIEBACiAj
aW5jbHVkZSAidHJhY2UuaCIKICNpbmNsdWRlICJhaW8tcG9zaXguaCIKIAorYm9vbCBhaW9fcG9s
bF9kaXNhYmxlZChBaW9Db250ZXh0ICpjdHgpCit7CisgICAgcmV0dXJuIGF0b21pY19yZWFkKCZj
dHgtPnBvbGxfZGlzYWJsZV9jbnQpOworfQorCiB2b2lkIGFpb19hZGRfcmVhZHlfaGFuZGxlcihB
aW9IYW5kbGVyTGlzdCAqcmVhZHlfbGlzdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFp
b0hhbmRsZXIgKm5vZGUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcmV2ZW50cykK
QEAgLTQyMyw3ICs0MjgsNyBAQCBzdGF0aWMgYm9vbCBydW5fcG9sbF9oYW5kbGVycyhBaW9Db250
ZXh0ICpjdHgsIGludDY0X3QgbWF4X25zLCBpbnQ2NF90ICp0aW1lb3V0KQogICAgICAgICBlbGFw
c2VkX3RpbWUgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1FKSAtIHN0YXJ0
X3RpbWU7CiAgICAgICAgIG1heF9ucyA9IHFlbXVfc29vbmVzdF90aW1lb3V0KCp0aW1lb3V0LCBt
YXhfbnMpOwogICAgICAgICBhc3NlcnQoIShtYXhfbnMgJiYgcHJvZ3Jlc3MpKTsKLSAgICB9IHdo
aWxlIChlbGFwc2VkX3RpbWUgPCBtYXhfbnMgJiYgIWF0b21pY19yZWFkKCZjdHgtPnBvbGxfZGlz
YWJsZV9jbnQpKTsKKyAgICB9IHdoaWxlIChlbGFwc2VkX3RpbWUgPCBtYXhfbnMgJiYgIWN0eC0+
ZmRtb25fb3BzLT5uZWVkX3dhaXQoY3R4KSk7CiAKICAgICAvKiBJZiB0aW1lIGhhcyBwYXNzZWQg
d2l0aCBubyBzdWNjZXNzZnVsIHBvbGxpbmcsIGFkanVzdCAqdGltZW91dCB0bwogICAgICAqIGtl
ZXAgdGhlIHNhbWUgZW5kaW5nIHRpbWUuCkBAIC00NTEsNyArNDU2LDcgQEAgc3RhdGljIGJvb2wg
dHJ5X3BvbGxfbW9kZShBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgKnRpbWVvdXQpCiB7CiAgICAg
aW50NjRfdCBtYXhfbnMgPSBxZW11X3Nvb25lc3RfdGltZW91dCgqdGltZW91dCwgY3R4LT5wb2xs
X25zKTsKIAotICAgIGlmIChtYXhfbnMgJiYgIWF0b21pY19yZWFkKCZjdHgtPnBvbGxfZGlzYWJs
ZV9jbnQpKSB7CisgICAgaWYgKG1heF9ucyAmJiAhY3R4LT5mZG1vbl9vcHMtPm5lZWRfd2FpdChj
dHgpKSB7CiAgICAgICAgIHBvbGxfc2V0X3N0YXJ0ZWQoY3R4LCB0cnVlKTsKIAogICAgICAgICBp
ZiAocnVuX3BvbGxfaGFuZGxlcnMoY3R4LCBtYXhfbnMsIHRpbWVvdXQpKSB7CkBAIC01MDEsNyAr
NTA2LDcgQEAgYm9vbCBhaW9fcG9sbChBaW9Db250ZXh0ICpjdHgsIGJvb2wgYmxvY2tpbmcpCiAg
ICAgLyogSWYgcG9sbGluZyBpcyBhbGxvd2VkLCBub24tYmxvY2tpbmcgYWlvX3BvbGwgZG9lcyBu
b3QgbmVlZCB0aGUKICAgICAgKiBzeXN0ZW0gY2FsbC0tLWEgc2luZ2xlIHJvdW5kIG9mIHJ1bl9w
b2xsX2hhbmRsZXJzX29uY2Ugc3VmZmljZXMuCiAgICAgICovCi0gICAgaWYgKHRpbWVvdXQgfHwg
YXRvbWljX3JlYWQoJmN0eC0+cG9sbF9kaXNhYmxlX2NudCkpIHsKKyAgICBpZiAodGltZW91dCB8
fCBjdHgtPmZkbW9uX29wcy0+bmVlZF93YWl0KGN0eCkpIHsKICAgICAgICAgcmV0ID0gY3R4LT5m
ZG1vbl9vcHMtPndhaXQoY3R4LCAmcmVhZHlfbGlzdCwgdGltZW91dCk7CiAgICAgfQogCmRpZmYg
LS1naXQgYS91dGlsL2ZkbW9uLWVwb2xsLmMgYi91dGlsL2ZkbW9uLWVwb2xsLmMKaW5kZXggZDU2
YjY5NDY4Yi4uZmNkOTg5ZDQ3ZCAxMDA2NDQKLS0tIGEvdXRpbC9mZG1vbi1lcG9sbC5jCisrKyBi
L3V0aWwvZmRtb24tZXBvbGwuYwpAQCAtMTAwLDYgKzEwMCw3IEBAIG91dDoKIHN0YXRpYyBjb25z
dCBGRE1vbk9wcyBmZG1vbl9lcG9sbF9vcHMgPSB7CiAgICAgLnVwZGF0ZSA9IGZkbW9uX2Vwb2xs
X3VwZGF0ZSwKICAgICAud2FpdCA9IGZkbW9uX2Vwb2xsX3dhaXQsCisgICAgLm5lZWRfd2FpdCA9
IGFpb19wb2xsX2Rpc2FibGVkLAogfTsKIAogc3RhdGljIGJvb2wgZmRtb25fZXBvbGxfdHJ5X2Vu
YWJsZShBaW9Db250ZXh0ICpjdHgpCmRpZmYgLS1naXQgYS91dGlsL2ZkbW9uLWlvX3VyaW5nLmMg
Yi91dGlsL2ZkbW9uLWlvX3VyaW5nLmMKaW5kZXggZmI5OWI0YjYxZS4uODkzYjc5YjYyMiAxMDA2
NDQKLS0tIGEvdXRpbC9mZG1vbi1pb191cmluZy5jCisrKyBiL3V0aWwvZmRtb24taW9fdXJpbmcu
YwpAQCAtMjg4LDkgKzI4OCwxNSBAQCBzdGF0aWMgaW50IGZkbW9uX2lvX3VyaW5nX3dhaXQoQWlv
Q29udGV4dCAqY3R4LCBBaW9IYW5kbGVyTGlzdCAqcmVhZHlfbGlzdCwKICAgICByZXR1cm4gcHJv
Y2Vzc19jcV9yaW5nKGN0eCwgcmVhZHlfbGlzdCk7CiB9CiAKK3N0YXRpYyBib29sIGZkbW9uX2lv
X3VyaW5nX25lZWRfd2FpdChBaW9Db250ZXh0ICpjdHgpCit7CisgICAgcmV0dXJuIGlvX3VyaW5n
X2NxX3JlYWR5KCZjdHgtPmZkbW9uX2lvX3VyaW5nKTsKK30KKwogc3RhdGljIGNvbnN0IEZETW9u
T3BzIGZkbW9uX2lvX3VyaW5nX29wcyA9IHsKICAgICAudXBkYXRlID0gZmRtb25faW9fdXJpbmdf
dXBkYXRlLAogICAgIC53YWl0ID0gZmRtb25faW9fdXJpbmdfd2FpdCwKKyAgICAubmVlZF93YWl0
ID0gZmRtb25faW9fdXJpbmdfbmVlZF93YWl0LAogfTsKIAogYm9vbCBmZG1vbl9pb191cmluZ19z
ZXR1cChBaW9Db250ZXh0ICpjdHgpCmRpZmYgLS1naXQgYS91dGlsL2ZkbW9uLXBvbGwuYyBiL3V0
aWwvZmRtb24tcG9sbC5jCmluZGV4IDI4MTE0YTBmMzkuLjQ4ODA2N2I2NzkgMTAwNjQ0Ci0tLSBh
L3V0aWwvZmRtb24tcG9sbC5jCisrKyBiL3V0aWwvZmRtb24tcG9sbC5jCkBAIC0xMDMsNCArMTAz
LDUgQEAgc3RhdGljIHZvaWQgZmRtb25fcG9sbF91cGRhdGUoQWlvQ29udGV4dCAqY3R4LAogY29u
c3QgRkRNb25PcHMgZmRtb25fcG9sbF9vcHMgPSB7CiAgICAgLnVwZGF0ZSA9IGZkbW9uX3BvbGxf
dXBkYXRlLAogICAgIC53YWl0ID0gZmRtb25fcG9sbF93YWl0LAorICAgIC5uZWVkX3dhaXQgPSBh
aW9fcG9sbF9kaXNhYmxlZCwKIH07Ci0tIAoyLjI0LjEKCg==


