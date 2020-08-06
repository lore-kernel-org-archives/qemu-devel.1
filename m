Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7BD2073E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW64m5sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7BD2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fom-0000Wp-8F
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmt-0005xN-IM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmr-0000W4-OS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596719905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBnCcqvshagZxJ9eD642lPMtu1oKXfNyyAUhMAFIIL4=;
 b=BW64m5sl7DFpeiqW5XUtWIueTQAeSZJzjE5kdhEvh6mj1nFq9KeEPWvWHhI0lon5MxQqJ1
 6IHl85hMFvMtcuG35CDZ9wmdiUW9g7fUm8eiuZxataM5NibRVdTBvhDDFNJljH+KEYBo3W
 xA2TYr6GZ7JyzdlJZTahsacJ3H8xv/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-LB7YYe4HMdeOePWpzHHtGg-1; Thu, 06 Aug 2020 09:18:23 -0400
X-MC-Unique: LB7YYe4HMdeOePWpzHHtGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51CBD800688;
 Thu,  6 Aug 2020 13:18:22 +0000 (UTC)
Received: from localhost (ovpn-114-7.ams2.redhat.com [10.36.114.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08CD15F9DC;
 Thu,  6 Aug 2020 13:18:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] aio-posix: keep aio_notify_me disabled during polling
Date: Thu,  6 Aug 2020 14:18:02 +0100
Message-Id: <20200806131802.569478-4-stefanha@redhat.com>
In-Reply-To: <20200806131802.569478-1-stefanha@redhat.com>
References: <20200806131802.569478-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UG9sbGluZyBvbmx5IG1vbml0b3JzIHRoZSBjdHgtPm5vdGlmaWVkIGZpZWxkIGFuZCBkb2VzIG5v
dCBuZWVkIHRoZQpjdHgtPm5vdGlmaWVyIEV2ZW50Tm90aWZpZXIgdG8gYmUgc2lnbmFsbGVkLiBL
ZWVwIGN0eC0+YWlvX25vdGlmeV9tZQpkaXNhYmxlZCB3aGlsZSBwb2xsaW5nIHRvIGF2b2lkIHVu
bmVjZXNzYXJ5IEV2ZW50Tm90aWZpZXIgc3lzY2FsbHMuCgpUaGlzIG9wdGltaXphdGlvbiBpbXBy
b3ZlcyB2aXJ0aW8tYmxrIDRLQiByYW5kb20gcmVhZCBwZXJmb3JtYW5jZSBieQoxOCUuIFRoZSBm
b2xsb3dpbmcgcmVzdWx0cyBhcmUgd2l0aCBhbiBJT1RocmVhZCBhbmQgdGhlIG51bGwtY28gYmxv
Y2sKZHJpdmVyOgoKVGVzdCAgICAgICAgIElPUFMgICBFcnJvcgpCZWZvcmUgIDI0NDUxOC42MiDC
sSAxLjIwJQpBZnRlciAgIDI5MDcwNi4xMSDCsSAwLjQ0JQoKU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCA0
NyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IDFiMmEzYWY2NWIuLmY3
ZjEzZWJmYzIgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRpbC9haW8tcG9z
aXguYwpAQCAtNDY0LDkgKzQ2NCw2IEBAIHN0YXRpYyBib29sIHJlbW92ZV9pZGxlX3BvbGxfaGFu
ZGxlcnMoQWlvQ29udGV4dCAqY3R4LCBpbnQ2NF90IG5vdykKICAqCiAgKiBQb2xscyBmb3IgYSBn
aXZlbiB0aW1lLgogICoKLSAqIE5vdGUgdGhhdCBjdHgtPm5vdGlmeV9tZSBtdXN0IGJlIG5vbi16
ZXJvIHNvIHRoaXMgZnVuY3Rpb24gY2FuIGRldGVjdAotICogYWlvX25vdGlmeSgpLgotICoKICAq
IE5vdGUgdGhhdCB0aGUgY2FsbGVyIG11c3QgaGF2ZSBpbmNyZW1lbnRlZCBjdHgtPmxpc3RfbG9j
ay4KICAqCiAgKiBSZXR1cm5zOiB0cnVlIGlmIHByb2dyZXNzIHdhcyBtYWRlLCBmYWxzZSBvdGhl
cndpc2UKQEAgLTQ3Niw3ICs0NzMsNiBAQCBzdGF0aWMgYm9vbCBydW5fcG9sbF9oYW5kbGVycyhB
aW9Db250ZXh0ICpjdHgsIGludDY0X3QgbWF4X25zLCBpbnQ2NF90ICp0aW1lb3V0KQogICAgIGJv
b2wgcHJvZ3Jlc3M7CiAgICAgaW50NjRfdCBzdGFydF90aW1lLCBlbGFwc2VkX3RpbWU7CiAKLSAg
ICBhc3NlcnQoY3R4LT5ub3RpZnlfbWUpOwogICAgIGFzc2VydChxZW11X2xvY2tjbnRfY291bnQo
JmN0eC0+bGlzdF9sb2NrKSA+IDApOwogCiAgICAgdHJhY2VfcnVuX3BvbGxfaGFuZGxlcnNfYmVn
aW4oY3R4LCBtYXhfbnMsICp0aW1lb3V0KTsKQEAgLTUyMCw4ICs1MTYsNiBAQCBzdGF0aWMgYm9v
bCBydW5fcG9sbF9oYW5kbGVycyhBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgbWF4X25zLCBpbnQ2
NF90ICp0aW1lb3V0KQogICogQHRpbWVvdXQ6IHRpbWVvdXQgZm9yIGJsb2NraW5nIHdhaXQsIGNv
bXB1dGVkIGJ5IHRoZSBjYWxsZXIgYW5kIHVwZGF0ZWQgaWYKICAqICAgIHBvbGxpbmcgc3VjY2Vl
ZHMuCiAgKgotICogY3R4LT5ub3RpZnlfbWUgbXVzdCBiZSBub24temVybyBzbyB0aGlzIGZ1bmN0
aW9uIGNhbiBkZXRlY3QgYWlvX25vdGlmeSgpLgotICoKICAqIE5vdGUgdGhhdCB0aGUgY2FsbGVy
IG11c3QgaGF2ZSBpbmNyZW1lbnRlZCBjdHgtPmxpc3RfbG9jay4KICAqCiAgKiBSZXR1cm5zOiB0
cnVlIGlmIHByb2dyZXNzIHdhcyBtYWRlLCBmYWxzZSBvdGhlcndpc2UKQEAgLTU1Niw2ICs1NTAs
NyBAQCBib29sIGFpb19wb2xsKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBibG9ja2luZykKICAgICBB
aW9IYW5kbGVyTGlzdCByZWFkeV9saXN0ID0gUUxJU1RfSEVBRF9JTklUSUFMSVpFUihyZWFkeV9s
aXN0KTsKICAgICBpbnQgcmV0ID0gMDsKICAgICBib29sIHByb2dyZXNzOworICAgIGJvb2wgdXNl
X25vdGlmeV9tZTsKICAgICBpbnQ2NF90IHRpbWVvdXQ7CiAgICAgaW50NjRfdCBzdGFydCA9IDA7
CiAKQEAgLTU2NiwzMyArNTYxLDM5IEBAIGJvb2wgYWlvX3BvbGwoQWlvQ29udGV4dCAqY3R4LCBi
b29sIGJsb2NraW5nKQogICAgICAqLwogICAgIGFzc2VydChpbl9haW9fY29udGV4dF9ob21lX3Ro
cmVhZChjdHgpKTsKIAotICAgIC8qIGFpb19ub3RpZnkgY2FuIGF2b2lkIHRoZSBleHBlbnNpdmUg
ZXZlbnRfbm90aWZpZXJfc2V0IGlmCisgICAgcWVtdV9sb2NrY250X2luYygmY3R4LT5saXN0X2xv
Y2spOworCisgICAgaWYgKGN0eC0+cG9sbF9tYXhfbnMpIHsKKyAgICAgICAgc3RhcnQgPSBxZW11
X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1FKTsKKyAgICB9CisKKyAgICB0aW1lb3V0
ID0gYmxvY2tpbmcgPyBhaW9fY29tcHV0ZV90aW1lb3V0KGN0eCkgOiAwOworICAgIHByb2dyZXNz
ID0gdHJ5X3BvbGxfbW9kZShjdHgsICZ0aW1lb3V0KTsKKyAgICBhc3NlcnQoISh0aW1lb3V0ICYm
IHByb2dyZXNzKSk7CisKKyAgICAvKgorICAgICAqIGFpb19ub3RpZnkgY2FuIGF2b2lkIHRoZSBl
eHBlbnNpdmUgZXZlbnRfbm90aWZpZXJfc2V0IGlmCiAgICAgICogZXZlcnl0aGluZyAoZmlsZSBk
ZXNjcmlwdG9ycywgYm90dG9tIGhhbHZlcywgdGltZXJzKSB3aWxsCiAgICAgICogYmUgcmUtZXZh
bHVhdGVkIGJlZm9yZSB0aGUgbmV4dCBibG9ja2luZyBwb2xsKCkuICBUaGlzIGlzCiAgICAgICog
YWxyZWFkeSB0cnVlIHdoZW4gYWlvX3BvbGwgaXMgY2FsbGVkIHdpdGggYmxvY2tpbmcgPT0gZmFs
c2U7CiAgICAgICogaWYgYmxvY2tpbmcgPT0gdHJ1ZSwgaXQgaXMgb25seSB0cnVlIGFmdGVyIHBv
bGwoKSByZXR1cm5zLAogICAgICAqIHNvIGRpc2FibGUgdGhlIG9wdGltaXphdGlvbiBub3cuCiAg
ICAgICovCi0gICAgaWYgKGJsb2NraW5nKSB7CisgICAgdXNlX25vdGlmeV9tZSA9IHRpbWVvdXQg
IT0gMDsKKyAgICBpZiAodXNlX25vdGlmeV9tZSkgewogICAgICAgICBhdG9taWNfc2V0KCZjdHgt
Pm5vdGlmeV9tZSwgYXRvbWljX3JlYWQoJmN0eC0+bm90aWZ5X21lKSArIDIpOwogICAgICAgICAv
KgotICAgICAgICAgKiBXcml0ZSBjdHgtPm5vdGlmeV9tZSBiZWZvcmUgY29tcHV0aW5nIHRoZSB0
aW1lb3V0Ci0gICAgICAgICAqIChyZWFkaW5nIGJvdHRvbSBoYWxmIGZsYWdzLCBldGMuKS4gIFBh
aXJzIHdpdGgKKyAgICAgICAgICogV3JpdGUgY3R4LT5ub3RpZnlfbWUgYmVmb3JlIHJlYWRpbmcg
Y3R4LT5ub3RpZmllZC4gIFBhaXJzIHdpdGgKICAgICAgICAgICogc21wX21iIGluIGFpb19ub3Rp
ZnkoKS4KICAgICAgICAgICovCiAgICAgICAgIHNtcF9tYigpOwotICAgIH0KLQotICAgIHFlbXVf
bG9ja2NudF9pbmMoJmN0eC0+bGlzdF9sb2NrKTsKIAotICAgIGlmIChjdHgtPnBvbGxfbWF4X25z
KSB7Ci0gICAgICAgIHN0YXJ0ID0gcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElN
RSk7CisgICAgICAgIC8qIERvbid0IGJsb2NrIGlmIGFpb19ub3RpZnkoKSB3YXMgY2FsbGVkICov
CisgICAgICAgIGlmIChhdG9taWNfcmVhZCgmY3R4LT5ub3RpZmllZCkpIHsKKyAgICAgICAgICAg
IHRpbWVvdXQgPSAwOworICAgICAgICB9CiAgICAgfQogCi0gICAgdGltZW91dCA9IGJsb2NraW5n
ID8gYWlvX2NvbXB1dGVfdGltZW91dChjdHgpIDogMDsKLSAgICBwcm9ncmVzcyA9IHRyeV9wb2xs
X21vZGUoY3R4LCAmdGltZW91dCk7Ci0gICAgYXNzZXJ0KCEodGltZW91dCAmJiBwcm9ncmVzcykp
OwotCiAgICAgLyogSWYgcG9sbGluZyBpcyBhbGxvd2VkLCBub24tYmxvY2tpbmcgYWlvX3BvbGwg
ZG9lcyBub3QgbmVlZCB0aGUKICAgICAgKiBzeXN0ZW0gY2FsbC0tLWEgc2luZ2xlIHJvdW5kIG9m
IHJ1bl9wb2xsX2hhbmRsZXJzX29uY2Ugc3VmZmljZXMuCiAgICAgICovCkBAIC02MDAsMTIgKzYw
MSwxNCBAQCBib29sIGFpb19wb2xsKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBibG9ja2luZykKICAg
ICAgICAgcmV0ID0gY3R4LT5mZG1vbl9vcHMtPndhaXQoY3R4LCAmcmVhZHlfbGlzdCwgdGltZW91
dCk7CiAgICAgfQogCi0gICAgaWYgKGJsb2NraW5nKSB7CisgICAgaWYgKHVzZV9ub3RpZnlfbWUp
IHsKICAgICAgICAgLyogRmluaXNoIHRoZSBwb2xsIGJlZm9yZSBjbGVhcmluZyB0aGUgZmxhZy4g
ICovCi0gICAgICAgIGF0b21pY19zdG9yZV9yZWxlYXNlKCZjdHgtPm5vdGlmeV9tZSwgYXRvbWlj
X3JlYWQoJmN0eC0+bm90aWZ5X21lKSAtIDIpOwotICAgICAgICBhaW9fbm90aWZ5X2FjY2VwdChj
dHgpOworICAgICAgICBhdG9taWNfc3RvcmVfcmVsZWFzZSgmY3R4LT5ub3RpZnlfbWUsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY19yZWFkKCZjdHgtPm5vdGlmeV9tZSkgLSAy
KTsKICAgICB9CiAKKyAgICBhaW9fbm90aWZ5X2FjY2VwdChjdHgpOworCiAgICAgLyogQWRqdXN0
IHBvbGxpbmcgdGltZSAqLwogICAgIGlmIChjdHgtPnBvbGxfbWF4X25zKSB7CiAgICAgICAgIGlu
dDY0X3QgYmxvY2tfbnMgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1FKSAt
IHN0YXJ0OwotLSAKMi4yNi4yCgo=


