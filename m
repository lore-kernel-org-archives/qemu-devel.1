Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5159020872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPWT1xQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5159020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGHi8-0005aK-9Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 04:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHg3-000235-FE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHg0-0002wZ-Jc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599725487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8sS8i4kWBPQwcuMdL8VeFf0XP6UvVF/A6wBf5rP+yY=;
 b=VPWT1xQHJETTxL/Xk/q2RVhrhx2EaBRrx/MJXWRG/3nVr68rnLEHRyvQ9A9dZ1p95FcZw0
 bKzcQ036PqZ0oTJhlLmwNS21aC1zAXPrEAYASIigNPICsyo5mCZWOC5A+1F8mZVTLR9I4s
 KFHSTLxQPBPNC/1FODlUFJeK/A79+68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-DP4fvGB2OIiy9oea3KFIXw-1; Thu, 10 Sep 2020 04:11:23 -0400
X-MC-Unique: DP4fvGB2OIiy9oea3KFIXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A21410051C3;
 Thu, 10 Sep 2020 08:11:23 +0000 (UTC)
Received: from localhost (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9BAB5C1CF;
 Thu, 10 Sep 2020 08:11:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 3/8] scripts/tracetool: Use void pointer for vcpu
Date: Thu, 10 Sep 2020 09:10:44 +0100
Message-Id: <20200910081049.38393-4-stefanha@redhat.com>
In-Reply-To: <20200910081049.38393-1-stefanha@redhat.com>
References: <20200910081049.38393-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUm9tYW4gQm9sc2hha292IDxyLmJvbHNoYWtvdkB5YWRyby5jb20+CgpkdHJhY2Ugb24g
bWFjT1MgY29tcGxhaW5zIHRoYXQgQ1BVU3RhdGUgKiBpcyB1c2VkIGZvciBhIGZldyBwcm9iZXM6
CgogIGR0cmFjZTogZmFpbGVkIHRvIGNvbXBpbGUgc2NyaXB0IHRyYWNlLWR0cmFjZS1yb290LmR0
cmFjZTogbGluZSAxMzA6IHN5bnRheCBlcnJvciBuZWFyICJDUFVTdGF0ZSIKCkEgY29tbWVudCBp
biBzY3JpcHRzL3RyYWNldG9vbC9fX2luaXRfXy5weSBtZW50aW9ucyB0aGF0OgoKICBXZSBvbmx5
IHdhbnQgdG8gYWxsb3cgc3RhbmRhcmQgQyB0eXBlcyBvciBmaXhlZCBzaXplZAogIGludGVnZXIg
dHlwZXMuIFdlIGRvbid0IHdhbnQgUUVNVSBzcGVjaWZpYyB0eXBlcwogIGFzIHdlIGNhbid0IGFz
c3VtZSB0cmFjZSBiYWNrZW5kcyBjYW4gcmVzb2x2ZSBhbGwgdGhlCiAgdHlwZWRlZnMKCkZpeGVz
OiAzZDIxMWQ5ZjRkYmVlICgidHJhY2U6IEFkZCAndmNwdScgZXZlbnQgcHJvcGVydHkgdG8gdHJh
Y2UgZ3Vlc3QgdkNQVSIpClJldmlld2VkLWJ5OiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5n
ZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBSb21hbiBCb2xzaGFrb3YgPHIuYm9sc2hha292QHlhZHJv
LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA3MTcwOTM1MTcuNzMzOTctMy1yLmJvbHNoYWtvdkB5YWRy
by5jb20KQ2M6IENhbWVyb24gRXNmYWhhbmkgPGRpcnR5QGFwcGxlLmNvbT4KU2lnbmVkLW9mZi1i
eTogUm9tYW4gQm9sc2hha292IDxyLmJvbHNoYWtvdkB5YWRyby5jb20+ClNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBzY3JpcHRzL3RyYWNl
dG9vbC92Y3B1LnB5IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy90cmFjZXRvb2wvdmNwdS5weSBiL3Njcmlw
dHMvdHJhY2V0b29sL3ZjcHUucHkKaW5kZXggYjU0ZTRmNGU3YS4uODY4YjRjYjA0YyAxMDA2NDQK
LS0tIGEvc2NyaXB0cy90cmFjZXRvb2wvdmNwdS5weQorKysgYi9zY3JpcHRzL3RyYWNldG9vbC92
Y3B1LnB5CkBAIC0yNCw3ICsyNCw3IEBAIGRlZiB0cmFuc2Zvcm1fZXZlbnQoZXZlbnQpOgogICAg
ICAgICBhc3NlcnQgInRjZy10cmFucyIgbm90IGluIGV2ZW50LnByb3BlcnRpZXMKICAgICAgICAg
YXNzZXJ0ICJ0Y2ctZXhlYyIgbm90IGluIGV2ZW50LnByb3BlcnRpZXMKIAotICAgICAgICBldmVu
dC5hcmdzID0gQXJndW1lbnRzKFsoIkNQVVN0YXRlICoiLCAiX19jcHUiKSwgZXZlbnQuYXJnc10p
CisgICAgICAgIGV2ZW50LmFyZ3MgPSBBcmd1bWVudHMoWygidm9pZCAqIiwgIl9fY3B1IiksIGV2
ZW50LmFyZ3NdKQogICAgICAgICBpZiAidGNnIiBpbiBldmVudC5wcm9wZXJ0aWVzOgogICAgICAg
ICAgICAgZm10ID0gIlwiY3B1PSVwIFwiIgogICAgICAgICAgICAgZXZlbnQuZm10ID0gW2ZtdCAr
IGV2ZW50LmZtdFswXSwKLS0gCjIuMjYuMgoK


