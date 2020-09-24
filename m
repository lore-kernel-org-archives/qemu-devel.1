Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA708C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACC12220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIAbqb0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC12220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTNR-0000xR-Rw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSz6-0006Nl-Tc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyz-0003wL-S8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Zau7i4WwA2sOzgmtuSsO1DFTPk1a1haFmHDmb8VWHk=;
 b=LIAbqb0wB2JKPPTaCehWcFBMU00CUNr7oaUmdN+aEplTRXCUv+17WatJ4zEzkfWWR0Zsv6
 WXr84MXk+uIkeASi327UBgHTFbGtCXbZT99I6tQI3+Aho5GBIUpmsZ9fISGU4qwEMF5Ul2
 TpFDVh7wDbLMAKQ3aI7za6jn0HaP7HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-PeEXmfD6Oeya1L0dTbydSQ-1; Thu, 24 Sep 2020 11:16:27 -0400
X-MC-Unique: PeEXmfD6Oeya1L0dTbydSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68EAD188C129;
 Thu, 24 Sep 2020 15:16:26 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC5260C04;
 Thu, 24 Sep 2020 15:16:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/13] block/export: report flush errors
Date: Thu, 24 Sep 2020 16:15:46 +0100
Message-Id: <20200924151549.913737-11-stefanha@redhat.com>
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UHJvcGFnYXRlIHRoZSBmbHVzaCByZXR1cm4gdmFsdWUgc2luY2UgZXJyb3JzIGFyZSBwb3NzaWJs
ZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
LS0tCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgfCAxMSArKysrKysrLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgYi9ibG9jay9leHBv
cnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKaW5kZXggYjYwOWEzZTRkNi4uNDRkM2M0NWZhMiAx
MDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCisrKyBiL2Js
b2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtNzgsMTEgKzc4LDExIEBAIHZ1
X2Jsb2NrX2Rpc2NhcmRfd3JpdGVfemVyb2VzKFZ1QmxvY2tSZXEgKnJlcSwgc3RydWN0IGlvdmVj
ICppb3YsCiAgICAgcmV0dXJuIC1FSU5WQUw7CiB9CiAKLXN0YXRpYyB2b2lkIGNvcm91dGluZV9m
biB2dV9ibG9ja19mbHVzaChWdUJsb2NrUmVxICpyZXEpCitzdGF0aWMgaW50IGNvcm91dGluZV9m
biB2dV9ibG9ja19mbHVzaChWdUJsb2NrUmVxICpyZXEpCiB7CiAgICAgVnVCbG9ja0RldiAqdmRl
dl9ibGsgPSBnZXRfdnVfYmxvY2tfZGV2aWNlX2J5X3NlcnZlcihyZXEtPnNlcnZlcik7CiAgICAg
QmxvY2tCYWNrZW5kICpiYWNrZW5kID0gdmRldl9ibGstPmJhY2tlbmQ7Ci0gICAgYmxrX2NvX2Zs
dXNoKGJhY2tlbmQpOworICAgIHJldHVybiBibGtfY29fZmx1c2goYmFja2VuZCk7CiB9CiAKIHN0
YXRpYyB2b2lkIGNvcm91dGluZV9mbiB2dV9ibG9ja192aXJ0aW9fcHJvY2Vzc19yZXEodm9pZCAq
b3BhcXVlKQpAQCAtMTUyLDggKzE1MiwxMSBAQCBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gdnVf
YmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVxKHZvaWQgKm9wYXF1ZSkKICAgICAgICAgYnJlYWs7CiAg
ICAgfQogICAgIGNhc2UgVklSVElPX0JMS19UX0ZMVVNIOgotICAgICAgICB2dV9ibG9ja19mbHVz
aChyZXEpOwotICAgICAgICByZXEtPmluLT5zdGF0dXMgPSBWSVJUSU9fQkxLX1NfT0s7CisgICAg
ICAgIGlmICh2dV9ibG9ja19mbHVzaChyZXEpID09IDApIHsKKyAgICAgICAgICAgIHJlcS0+aW4t
PnN0YXR1cyA9IFZJUlRJT19CTEtfU19PSzsKKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAg
IHJlcS0+aW4tPnN0YXR1cyA9IFZJUlRJT19CTEtfU19JT0VSUjsKKyAgICAgICAgfQogICAgICAg
ICBicmVhazsKICAgICBjYXNlIFZJUlRJT19CTEtfVF9HRVRfSUQ6IHsKICAgICAgICAgc2l6ZV90
IHNpemUgPSBNSU4oaW92X3NpemUoJmVsZW0tPmluX3NnWzBdLCBpbl9udW0pLAotLSAKMi4yNi4y
Cgo=


