Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A8122B4B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNL1/5v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A8122B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIog-00075j-Dx
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIoA-0006gn-W1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:23:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIo9-0003DF-0n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iXeCFKhJr5VHWF8iqZzpuXLLKSb9/Kc70vN+Jyf2Zzg=;
 b=VNL1/5v9NwSP50Xxu56l/lr61jRVIFeLbWNCg8njDVk9sKlETAcqyN5p9h72NntSghspqy
 PinIdKR4K2S2mRkMrRX0c5vkiz1oTh+mF1Idmyno4R9xOCZVtOOrDhO/XPtkErQ639UXGx
 IGOLmkVIWj1AUHfti/H8so20/YUv3XQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-rgZsz7FANa2Tp1pL6DmBbw-1; Thu, 27 Aug 2020 10:23:06 -0400
X-MC-Unique: rgZsz7FANa2Tp1pL6DmBbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F16718B9EC3;
 Thu, 27 Aug 2020 14:23:05 +0000 (UTC)
Received: from localhost (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 068145D9E8;
 Thu, 27 Aug 2020 14:23:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: fix SystemTap Unknown variable "exe_name"
Date: Thu, 27 Aug 2020 15:22:45 +0100
Message-Id: <20200827142245.108147-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIFN5c3RlbVRhcCB0YXBzZXQgZ2VuZXJhdGlvbiBjb2RlIHVzZWQgYSBzdGFsZSB2YXJpYWJs
ZSBuYW1lCidleGVfbmFtZScuIFRoaXMgY2F1c2VkIHRoZSBmb2xsb3dpbmcgbWVzb24gZXJyb3I6
CgogIFVua25vd24gdmFyaWFibGUgImV4ZV9uYW1lIgoKVGhlIHZhcmlhYmxlIHNob3VsZCBiZSBl
eGVbJ25hbWUnXS4gVGhpcyBmaXhlcyAuL2NvbmZpZ3VyZQotLWVuYWJsZS10cmFjZS1iYWNrZW5k
PWR0cmFjZSB3aXRoIFN5c3RlbVRhcC4KClJlcG9ydGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBtZXNvbi5idWlsZCB8IDggKysrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbWVz
b24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCBmMGZlNWY4Nzk5Li5mMmFhNWE3NzAwIDEwMDY0
NAotLS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMTAyOSwxNCArMTAyOSwx
NCBAQCBmb3JlYWNoIHRhcmdldCA6IHRhcmdldF9kaXJzCiAKICAgICBpZiAnQ09ORklHX1RSQUNF
X1NZU1RFTVRBUCcgaW4gY29uZmlnX2hvc3QKICAgICAgIGZvcmVhY2ggc3RwOiBbCi0gICAgICAg
IHsnZXh0JzogJy5zdHAtYnVpbGQnLCAnZm10JzogJ3N0YXAnLCAnYmluJzogbWVzb24uY3VycmVu
dF9idWlsZF9kaXIoKSAvIGV4ZV9uYW1lLCAnaW5zdGFsbCc6IGZhbHNlfSwKLSAgICAgICAgeydl
eHQnOiAnLnN0cCcsICdmbXQnOiAnc3RhcCcsICdiaW4nOiBnZXRfb3B0aW9uKCdwcmVmaXgnKSAv
IGdldF9vcHRpb24oJ2JpbmRpcicpIC8gZXhlX25hbWUsICdpbnN0YWxsJzogdHJ1ZX0sCisgICAg
ICAgIHsnZXh0JzogJy5zdHAtYnVpbGQnLCAnZm10JzogJ3N0YXAnLCAnYmluJzogbWVzb24uY3Vy
cmVudF9idWlsZF9kaXIoKSAvIGV4ZVsnbmFtZSddLCAnaW5zdGFsbCc6IGZhbHNlfSwKKyAgICAg
ICAgeydleHQnOiAnLnN0cCcsICdmbXQnOiAnc3RhcCcsICdiaW4nOiBnZXRfb3B0aW9uKCdwcmVm
aXgnKSAvIGdldF9vcHRpb24oJ2JpbmRpcicpIC8gZXhlWyduYW1lJ10sICdpbnN0YWxsJzogdHJ1
ZX0sCiAgICAgICAgIHsnZXh0JzogJy1zaW1wbGV0cmFjZS5zdHAnLCAnZm10JzogJ3NpbXBsZXRy
YWNlLXN0YXAnLCAnYmluJzogJycsICdpbnN0YWxsJzogdHJ1ZX0sCiAgICAgICAgIHsnZXh0Jzog
Jy1sb2cuc3RwJywgJ2ZtdCc6ICdsb2ctc3RhcCcsICdiaW4nOiAnJywgJ2luc3RhbGwnOiB0cnVl
fSwKICAgICAgIF0KLSAgICAgICAgY3VzdG9tX3RhcmdldChleGVfbmFtZSArIHN0cFsnZXh0J10s
CisgICAgICAgIGN1c3RvbV90YXJnZXQoZXhlWyduYW1lJ10gKyBzdHBbJ2V4dCddLAogICAgICAg
ICAgICAgICAgICAgICAgIGlucHV0OiB0cmFjZV9ldmVudHNfYWxsLAotICAgICAgICAgICAgICAg
ICAgICAgIG91dHB1dDogZXhlX25hbWUgKyBzdHBbJ2V4dCddLAorICAgICAgICAgICAgICAgICAg
ICAgIG91dHB1dDogZXhlWyduYW1lJ10gKyBzdHBbJ2V4dCddLAogICAgICAgICAgICAgICAgICAg
ICAgIGNhcHR1cmU6IHRydWUsCiAgICAgICAgICAgICAgICAgICAgICAgaW5zdGFsbDogc3RwWydp
bnN0YWxsJ10sCiAgICAgICAgICAgICAgICAgICAgICAgaW5zdGFsbF9kaXI6IGNvbmZpZ19ob3N0
WydxZW11X2RhdGFkaXInXSAvICcuLi9zeXN0ZW10YXAvdGFwc2V0JywKLS0gCjIuMjYuMgoK


