Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68265C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9722B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKbvMmnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9722B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tyc-0008M9-Aw
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twc-0005KQ-W6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twa-0007Kn-HU
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596535995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tNdK7Ca4i2liwy+NdcizhRAuTPr3rRoZ97wATJpZj8=;
 b=XKbvMmnFgdd+3kUFjxkQJMxlp+k/bUdTs2qFRrVly2vUaQUd+k2kJ4Yiiy8arBkzIr9eis
 c9be0xxK15cy1JfwisohuYejuwEj7/QhsUOEm2JRZ3dhTTpbiqboi2TYlOuEZLq/mSpBLK
 FelDQ7NkBKApj675xiRiA2Rsa1eozJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-52Qk7QNyNm6APlJG1uG3Jg-1; Tue, 04 Aug 2020 06:13:13 -0400
X-MC-Unique: 52Qk7QNyNm6APlJG1uG3Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 905FB19057A2;
 Tue,  4 Aug 2020 10:13:12 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 283B671797;
 Tue,  4 Aug 2020 10:13:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] nvdimm: honor -object memory-backend-file,
 readonly=on option
Date: Tue,  4 Aug 2020 11:12:44 +0100
Message-Id: <20200804101244.1283503-4-stefanha@redhat.com>
In-Reply-To: <20200804101244.1283503-1-stefanha@redhat.com>
References: <20200804101244.1283503-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBwcmVzZW50IHJlYWQtb25seSBmaWxlcyB0byB0aGUgZ3Vlc3Qg
YXMgInVuYXJtZWQiCk5WRElNTXMuIFRoZSBMaW51eCBOVkRJTU0gZGV2aWNlICgvZGV2L3BtZW1Y
KSBpcyByZWFkLW9ubHkuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQogZG9jcy9udmRpbW0udHh0IHwgOCArKysrKysrLQogaHcvbWVtL252
ZGltbS5jIHwgNCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kb2NzL252ZGltbS50eHQgYi9kb2NzL252ZGltbS50eHQK
aW5kZXggYzJjNmU0NDFiMy4uYzBiNTJkZTExMSAxMDA2NDQKLS0tIGEvZG9jcy9udmRpbW0udHh0
CisrKyBiL2RvY3MvbnZkaW1tLnR4dApAQCAtMTcsNyArMTcsNyBAQCBmb2xsb3dpbmcgY29tbWFu
ZCBsaW5lIG9wdGlvbnM6CiAKICAtbWFjaGluZSBwYyxudmRpbW0KICAtbSAkUkFNX1NJWkUsc2xv
dHM9JE4sbWF4bWVtPSRNQVhfU0laRQotIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1t
ZW0xLHNoYXJlPW9uLG1lbS1wYXRoPSRQQVRILHNpemU9JE5WRElNTV9TSVpFCisgLW9iamVjdCBt
ZW1vcnktYmFja2VuZC1maWxlLGlkPW1lbTEsc2hhcmU9b24sbWVtLXBhdGg9JFBBVEgsc2l6ZT0k
TlZESU1NX1NJWkUscmVhZG9ubHk9b2ZmCiAgLWRldmljZSBudmRpbW0saWQ9bnZkaW1tMSxtZW1k
ZXY9bWVtMQogCiBXaGVyZSwKQEAgLTQyLDYgKzQyLDEyIEBAIFdoZXJlLAogICAgInNoYXJlPW9m
ZiIsIHRoZW4gZ3Vlc3Qgd3JpdGVzIHdvbid0IGJlIGFwcGxpZWQgdG8gdGhlIGJhY2tlbmQKICAg
IGZpbGUgYW5kIHRodXMgd2lsbCBiZSBpbnZpc2libGUgdG8gb3RoZXIgZ3Vlc3RzLgogCisgICAi
cmVhZG9ubHk9b24vb2ZmIiBjb250cm9scyB3aGV0aGVyIHRoZSB0aGUgZmlsZSAkUEFUSCBpcyBv
cGVuZWQgcmVhZC1vbmx5IG9yCisgICByZWFkL3dyaXRlIChkZWZhdWx0KS4gInJlYWRvbmx5PW9u
IiBzZXRzIHRoZSBBQ1BJIE5GSVQgTlZESU1NIFJlZ2lvbiBNYXBwaW5nCisgICBTdHJ1Y3R1cmUg
Ik5WRElNTSBTdGF0ZSBGbGFncyIgQml0IDMgaW5kaWNhdGluZyB0aGF0IHRoZSBkZXZpY2UgaXMg
InVuYXJtZWQiCisgICBhbmQgY2Fubm90IGFjY2VwdCBwZXJzaXN0ZW50IHdyaXRlcy4gTGludXgg
Z3Vlc3QgZHJpdmVycyBzZXQgdGhlIGRldmljZSB0bworICAgcmVhZC1vbmx5IHdoZW4gdGhpcyBi
aXQgaXMgcHJlc2VudC4KKwogIC0gImRldmljZSBudmRpbW0saWQ9bnZkaW1tMSxtZW1kZXY9bWVt
MSIgY3JlYXRlcyBhIHZpcnR1YWwgTlZESU1NCiAgICBkZXZpY2Ugd2hvc2Ugc3RvcmFnZSBpcyBw
cm92aWRlZCBieSBhYm92ZSBtZW1vcnkgYmFja2VuZCBkZXZpY2UuCiAKZGlmZiAtLWdpdCBhL2h3
L21lbS9udmRpbW0uYyBiL2h3L21lbS9udmRpbW0uYwppbmRleCBlMTU3NGJjMDdjLi42OTQyMjM0
NTBlIDEwMDY0NAotLS0gYS9ody9tZW0vbnZkaW1tLmMKKysrIGIvaHcvbWVtL252ZGltbS5jCkBA
IC0xNTEsNiArMTUxLDEwIEBAIHN0YXRpYyB2b2lkIG52ZGltbV9wcmVwYXJlX21lbW9yeV9yZWdp
b24oTlZESU1NRGV2aWNlICpudmRpbW0sIEVycm9yICoqZXJycCkKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIm52ZGltbS1tZW1vcnkiLCBtciwgMCwgcG1lbV9zaXplKTsKICAgICBtZW1v
cnlfcmVnaW9uX3NldF9ub252b2xhdGlsZShudmRpbW0tPm52ZGltbV9tciwgdHJ1ZSk7CiAgICAg
bnZkaW1tLT5udmRpbW1fbXItPmFsaWduID0gYWxpZ247CisKKyAgICBpZiAobWVtb3J5X3JlZ2lv
bl9pc19yb20obXIpKSB7CisgICAgICAgIG52ZGltbS0+dW5hcm1lZCA9IHRydWU7IC8qIHRoaXMg
ZGV2aWNlIGlzIHJlYWQtb25seSAqLworICAgIH0KIH0KIAogc3RhdGljIE1lbW9yeVJlZ2lvbiAq
bnZkaW1tX21kX2dldF9tZW1vcnlfcmVnaW9uKE1lbW9yeURldmljZVN0YXRlICptZCwKLS0gCjIu
MjYuMgoK


