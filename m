Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5108C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26B7208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6f7kFkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B7208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSvB-0007v0-QK
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStX-0005xb-DQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStV-0003IC-1k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5RYeMON6vIyuF1dEBXjN+Z/Dnv69ZgDcVyLlBVyl/0=;
 b=a6f7kFkjVWVOvYPYU5nG1qfAkDbLWpVpHDVVN2yAMF60MMX6773xtgI+h6zjgj0wraWZNQ
 xQiCecnspT480AnAMzYOetQ1hyxsIO78ljHhB9iSngNFXhRKN5gy6OE9b9rnzqQb62BZCp
 +xfm0v2EOjErluHkpQM8aFyZ23BvCNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ygixxskVNPCglBhjqsEGlw-1; Tue, 27 Oct 2020 13:36:21 -0400
X-MC-Unique: ygixxskVNPCglBhjqsEGlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 564AC107466C;
 Tue, 27 Oct 2020 17:36:16 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4A9C19C4F;
 Tue, 27 Oct 2020 17:36:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] block/export: make vhost-user-blk config space
 little-endian
Date: Tue, 27 Oct 2020 17:35:19 +0000
Message-Id: <20201027173528.213464-4-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VklSVElPIDEuMCBkZXZpY2VzIGhhdmUgbGl0dGxlLWVuZGlhbiBjb25maWd1cmF0aW9uIHNwYWNl
LiBUaGUKdmhvc3QtdXNlci1ibGstc2VydmVyLmMgY29kZSBhbHJlYWR5IHVzZXMgbGl0dGxlLWVu
ZGlhbiBmb3IgdmlydHF1ZXVlCnByb2Nlc3NpbmcgYnV0IG5vdCBmb3IgdGhlIGNvbmZpZ3VyYXRp
b24gc3BhY2UgZmllbGRzLiBGaXggdGhpcyBzbyB0aGUKdmhvc3QtdXNlci1ibGsgZXhwb3J0IHdv
cmtzIG9uIGJpZy1lbmRpYW4gaG9zdHMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNl
cnZlci5jIHwgMjUgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9y
dC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1z
ZXJ2ZXIuYwppbmRleCA0MWY0OTMzZDZlLi4zM2NjMDgxOGI4IDEwMDY0NAotLS0gYS9ibG9jay9l
eHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVz
ZXItYmxrLXNlcnZlci5jCkBAIC0yNjQsNyArMjY0LDYgQEAgc3RhdGljIHVpbnQ2NF90IHZ1X2Js
a19nZXRfcHJvdG9jb2xfZmVhdHVyZXMoVnVEZXYgKmRldikKIHN0YXRpYyBpbnQKIHZ1X2Jsa19n
ZXRfY29uZmlnKFZ1RGV2ICp2dV9kZXYsIHVpbnQ4X3QgKmNvbmZpZywgdWludDMyX3QgbGVuKQog
ewotICAgIC8qIFRPRE8gYmxrY2ZnIG11c3QgYmUgbGl0dGxlLWVuZGlhbiBmb3IgVklSVElPIDEu
MCAqLwogICAgIFZ1U2VydmVyICpzZXJ2ZXIgPSBjb250YWluZXJfb2YodnVfZGV2LCBWdVNlcnZl
ciwgdnVfZGV2KTsKICAgICBWdUJsa0V4cG9ydCAqdmV4cCA9IGNvbnRhaW5lcl9vZihzZXJ2ZXIs
IFZ1QmxrRXhwb3J0LCB2dV9zZXJ2ZXIpOwogICAgIG1lbWNweShjb25maWcsICZ2ZXhwLT5ibGtj
ZmcsIGxlbik7CkBAIC0zNDMsMTggKzM0MiwxOCBAQCB2dV9ibGtfaW5pdGlhbGl6ZV9jb25maWco
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qg
YmxrX3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgbnVtX3F1ZXVlcykK
IHsKLSAgICBjb25maWctPmNhcGFjaXR5ID0gYmRydl9nZXRsZW5ndGgoYnMpID4+IEJEUlZfU0VD
VE9SX0JJVFM7Ci0gICAgY29uZmlnLT5ibGtfc2l6ZSA9IGJsa19zaXplOwotICAgIGNvbmZpZy0+
c2l6ZV9tYXggPSAwOwotICAgIGNvbmZpZy0+c2VnX21heCA9IDEyOCAtIDI7Ci0gICAgY29uZmln
LT5taW5faW9fc2l6ZSA9IDE7Ci0gICAgY29uZmlnLT5vcHRfaW9fc2l6ZSA9IDE7Ci0gICAgY29u
ZmlnLT5udW1fcXVldWVzID0gbnVtX3F1ZXVlczsKLSAgICBjb25maWctPm1heF9kaXNjYXJkX3Nl
Y3RvcnMgPSAzMjc2ODsKLSAgICBjb25maWctPm1heF9kaXNjYXJkX3NlZyA9IDE7Ci0gICAgY29u
ZmlnLT5kaXNjYXJkX3NlY3Rvcl9hbGlnbm1lbnQgPSBjb25maWctPmJsa19zaXplID4+IDk7Ci0g
ICAgY29uZmlnLT5tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMgPSAzMjc2ODsKLSAgICBjb25maWct
Pm1heF93cml0ZV96ZXJvZXNfc2VnID0gMTsKKyAgICBjb25maWctPmNhcGFjaXR5ID0gY3B1X3Rv
X2xlNjQoYmRydl9nZXRsZW5ndGgoYnMpID4+IEJEUlZfU0VDVE9SX0JJVFMpOworICAgIGNvbmZp
Zy0+YmxrX3NpemUgPSBjcHVfdG9fbGUzMihibGtfc2l6ZSk7CisgICAgY29uZmlnLT5zaXplX21h
eCA9IGNwdV90b19sZTMyKDApOworICAgIGNvbmZpZy0+c2VnX21heCA9IGNwdV90b19sZTMyKDEy
OCAtIDIpOworICAgIGNvbmZpZy0+bWluX2lvX3NpemUgPSBjcHVfdG9fbGUxNigxKTsKKyAgICBj
b25maWctPm9wdF9pb19zaXplID0gY3B1X3RvX2xlMzIoMSk7CisgICAgY29uZmlnLT5udW1fcXVl
dWVzID0gY3B1X3RvX2xlMTYobnVtX3F1ZXVlcyk7CisgICAgY29uZmlnLT5tYXhfZGlzY2FyZF9z
ZWN0b3JzID0gY3B1X3RvX2xlMzIoMzI3NjgpOworICAgIGNvbmZpZy0+bWF4X2Rpc2NhcmRfc2Vn
ID0gY3B1X3RvX2xlMzIoMSk7CisgICAgY29uZmlnLT5kaXNjYXJkX3NlY3Rvcl9hbGlnbm1lbnQg
PSBjcHVfdG9fbGUzMihjb25maWctPmJsa19zaXplID4+IDkpOworICAgIGNvbmZpZy0+bWF4X3dy
aXRlX3plcm9lc19zZWN0b3JzID0gY3B1X3RvX2xlMzIoMzI3NjgpOworICAgIGNvbmZpZy0+bWF4
X3dyaXRlX3plcm9lc19zZWcgPSBjcHVfdG9fbGUzMigxKTsKIH0KIAogc3RhdGljIHZvaWQgdnVf
YmxrX2V4cF9yZXF1ZXN0X3NodXRkb3duKEJsb2NrRXhwb3J0ICpleHApCi0tIAoyLjI2LjIKCg==


