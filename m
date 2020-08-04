Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25503C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149DC22B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYa4wQ5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149DC22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2txR-0006J7-5w
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twR-00050d-UY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twQ-0007K5-A9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596535985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1fPzUvS6eRDBVdjttkwzUYOjrjLy0bRRDhpKDFS4P8=;
 b=cYa4wQ5zIvQsNuHZ2Ofiim85NbuLH9/ph9+z0Xdt4lbTqoATlfmXojEJ4Ok1wQPQJ+pFNu
 bfuZvViFzbwYdl/nz3QuYDOmyGFOGUSioI0KLw9eBk7dYqCN5ZZrCyjswJs7qWnJr+F2c3
 2mjxgh117JJ6Gsi0SWXrEbTrzXHfRbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-_dRAI42UPCOVtkVoGuBtbg-1; Tue, 04 Aug 2020 06:13:03 -0400
X-MC-Unique: _dRAI42UPCOVtkVoGuBtbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA4281005510;
 Tue,  4 Aug 2020 10:13:02 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 502B1282C9;
 Tue,  4 Aug 2020 10:13:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hostmem-file: add readonly=on|off option
Date: Tue,  4 Aug 2020 11:12:43 +0100
Message-Id: <20200804101244.1283503-3-stefanha@redhat.com>
In-Reply-To: <20200804101244.1283503-1-stefanha@redhat.com>
References: <20200804101244.1283503-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

TGV0IC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSB3b3JrIG9uIHJlYWQtb25seSBmaWxlcyB3
aGVuIHRoZQpyZWFkb25seT1vbiBvcHRpb24gaXMgZ2l2ZW4uIFRoaXMgY2FuIGJlIHVzZWQgdG8g
c2hhcmUgdGhlIGNvbnRlbnRzIG9mIGEKZmlsZSBiZXR3ZWVuIG11bHRpcGxlIGd1ZXN0cyB3aGls
ZSBwcmV2ZW50aW5nIHRoZW0gZnJvbSBjb25zdW1pbmcKQ29weS1vbi1Xcml0ZSBtZW1vcnkgaWYg
Z3Vlc3RzIGRpcnR5IHRoZSBwYWdlcywgZm9yIGV4YW1wbGUuCgpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogYmFja2VuZHMvaG9zdG1lbS1m
aWxlLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQogcWVtdS1vcHRpb25zLmh4ICAg
ICAgICAgfCAgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2JhY2tlbmRzL2hvc3RtZW0tZmlsZS5jIGIvYmFja2Vu
ZHMvaG9zdG1lbS1maWxlLmMKaW5kZXggMzdjNzBhY2ZlMi4uNmJkNWJmOWI5MSAxMDA2NDQKLS0t
IGEvYmFja2VuZHMvaG9zdG1lbS1maWxlLmMKKysrIGIvYmFja2VuZHMvaG9zdG1lbS1maWxlLmMK
QEAgLTMwLDYgKzMwLDcgQEAgc3RydWN0IEhvc3RNZW1vcnlCYWNrZW5kRmlsZSB7CiAgICAgdWlu
dDY0X3QgYWxpZ247CiAgICAgYm9vbCBkaXNjYXJkX2RhdGE7CiAgICAgYm9vbCBpc19wbWVtOwor
ICAgIGJvb2wgcmVhZG9ubHk7CiB9OwogCiBzdGF0aWMgdm9pZApAQCAtNTcsNyArNTgsNyBAQCBm
aWxlX2JhY2tlbmRfbWVtb3J5X2FsbG9jKEhvc3RNZW1vcnlCYWNrZW5kICpiYWNrZW5kLCBFcnJv
ciAqKmVycnApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFja2VuZC0+
c2l6ZSwgZmItPmFsaWduLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChi
YWNrZW5kLT5zaGFyZSA/IFJBTV9TSEFSRUQgOiAwKSB8CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKGZiLT5pc19wbWVtID8gUkFNX1BNRU0gOiAwKSwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBmYi0+bWVtX3BhdGgsIGZhbHNlLCBlcnJwKTsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYi0+bWVtX3BhdGgsIGZiLT5yZWFk
b25seSwgZXJycCk7CiAgICAgZ19mcmVlKG5hbWUpOwogI2VuZGlmCiB9CkBAIC0xNTIsNiArMTUz
LDI2IEBAIHN0YXRpYyB2b2lkIGZpbGVfbWVtb3J5X2JhY2tlbmRfc2V0X3BtZW0oT2JqZWN0ICpv
LCBib29sIHZhbHVlLCBFcnJvciAqKmVycnApCiAgICAgZmItPmlzX3BtZW0gPSB2YWx1ZTsKIH0K
IAorc3RhdGljIGJvb2wgZmlsZV9tZW1vcnlfYmFja2VuZF9nZXRfcmVhZG9ubHkoT2JqZWN0ICpv
LCBFcnJvciAqKmVycnApCit7CisgICAgcmV0dXJuIE1FTU9SWV9CQUNLRU5EX0ZJTEUobyktPnJl
YWRvbmx5OworfQorCitzdGF0aWMgdm9pZCBmaWxlX21lbW9yeV9iYWNrZW5kX3NldF9yZWFkb25s
eShPYmplY3QgKm8sIGJvb2wgdmFsdWUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFcnJvciAqKmVycnApCit7CisgICAgSG9zdE1lbW9yeUJhY2tlbmQgKmJh
Y2tlbmQgPSBNRU1PUllfQkFDS0VORChvKTsKKyAgICBIb3N0TWVtb3J5QmFja2VuZEZpbGUgKmZi
ID0gTUVNT1JZX0JBQ0tFTkRfRklMRShvKTsKKworICAgIGlmIChob3N0X21lbW9yeV9iYWNrZW5k
X21yX2luaXRlZChiYWNrZW5kKSkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJjYW5ub3Qg
Y2hhbmdlIHByb3BlcnR5ICdyZWFkb25seScgb2YgJXMuIiwKKyAgICAgICAgICAgICAgICAgICBv
YmplY3RfZ2V0X3R5cGVuYW1lKG8pKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKworICAgIGZi
LT5yZWFkb25seSA9IHZhbHVlOworfQorCiBzdGF0aWMgdm9pZCBmaWxlX2JhY2tlbmRfdW5wYXJl
bnQoT2JqZWN0ICpvYmopCiB7CiAgICAgSG9zdE1lbW9yeUJhY2tlbmQgKmJhY2tlbmQgPSBNRU1P
UllfQkFDS0VORChvYmopOwpAQCAtMTgzLDYgKzIwNCw5IEBAIGZpbGVfYmFja2VuZF9jbGFzc19p
bml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkKICAgICAgICAgTlVMTCwgTlVMTCk7CiAg
ICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9ib29sKG9jLCAicG1lbSIsCiAgICAgICAgIGZp
bGVfbWVtb3J5X2JhY2tlbmRfZ2V0X3BtZW0sIGZpbGVfbWVtb3J5X2JhY2tlbmRfc2V0X3BtZW0p
OworICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfYm9vbChvYywgInJlYWRvbmx5IiwKKyAg
ICAgICAgZmlsZV9tZW1vcnlfYmFja2VuZF9nZXRfcmVhZG9ubHksCisgICAgICAgIGZpbGVfbWVt
b3J5X2JhY2tlbmRfc2V0X3JlYWRvbmx5KTsKIH0KIAogc3RhdGljIHZvaWQgZmlsZV9iYWNrZW5k
X2luc3RhbmNlX2ZpbmFsaXplKE9iamVjdCAqbykKZGlmZiAtLWdpdCBhL3FlbXUtb3B0aW9ucy5o
eCBiL3FlbXUtb3B0aW9ucy5oeAppbmRleCA3MDg1ODNiNGNlLi5kODM0ZTAwYjBkIDEwMDY0NAot
LS0gYS9xZW11LW9wdGlvbnMuaHgKKysrIGIvcWVtdS1vcHRpb25zLmh4CkBAIC00MzY5LDcgKzQz
NjksNyBAQCBTUlNUCiAgICAgdGhleSBhcmUgc3BlY2lmaWVkLiBOb3RlIHRoYXQgdGhlICdpZCcg
cHJvcGVydHkgbXVzdCBiZSBzZXQuIFRoZXNlCiAgICAgb2JqZWN0cyBhcmUgcGxhY2VkIGluIHRo
ZSAnL29iamVjdHMnIHBhdGguCiAKLSAgICBgYC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxp
ZD1pZCxzaXplPXNpemUsbWVtLXBhdGg9ZGlyLHNoYXJlPW9ufG9mZixkaXNjYXJkLWRhdGE9b258
b2ZmLG1lcmdlPW9ufG9mZixkdW1wPW9ufG9mZixwcmVhbGxvYz1vbnxvZmYsaG9zdC1ub2Rlcz1o
b3N0LW5vZGVzLHBvbGljeT1kZWZhdWx0fHByZWZlcnJlZHxiaW5kfGludGVybGVhdmUsYWxpZ249
YWxpZ25gYAorICAgIGBgLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPWlkLHNpemU9c2l6
ZSxtZW0tcGF0aD1kaXIsc2hhcmU9b258b2ZmLGRpc2NhcmQtZGF0YT1vbnxvZmYsbWVyZ2U9b258
b2ZmLGR1bXA9b258b2ZmLHByZWFsbG9jPW9ufG9mZixob3N0LW5vZGVzPWhvc3Qtbm9kZXMscG9s
aWN5PWRlZmF1bHR8cHJlZmVycmVkfGJpbmR8aW50ZXJsZWF2ZSxhbGlnbj1hbGlnbixyZWFkb25s
eT1vbnxvZmZgYAogICAgICAgICBDcmVhdGVzIGEgbWVtb3J5IGZpbGUgYmFja2VuZCBvYmplY3Qs
IHdoaWNoIGNhbiBiZSB1c2VkIHRvIGJhY2sKICAgICAgICAgdGhlIGd1ZXN0IFJBTSB3aXRoIGh1
Z2UgcGFnZXMuCiAKQEAgLTQ0NTIsNiArNDQ1Miw5IEBAIFNSU1QKICAgICAgICAgNC4xNSkgYW5k
IHRoZSBmaWxlc3lzdGVtIG9mIGBgbWVtLXBhdGhgYCBtb3VudGVkIHdpdGggREFYCiAgICAgICAg
IG9wdGlvbi4KIAorICAgICAgICBUaGUgYGByZWFkb25seWBgIG9wdGlvbiBzcGVjaWZpZXMgd2hl
dGhlciB0aGUgYmFja2luZyBmaWxlIGlzIG9wZW5lZAorICAgICAgICByZWFkLW9ubHkgb3IgcmVh
ZC13cml0ZSAoZGVmYXVsdCkuCisKICAgICBgYC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLGlk
PWlkLG1lcmdlPW9ufG9mZixkdW1wPW9ufG9mZixzaGFyZT1vbnxvZmYscHJlYWxsb2M9b258b2Zm
LHNpemU9c2l6ZSxob3N0LW5vZGVzPWhvc3Qtbm9kZXMscG9saWN5PWRlZmF1bHR8cHJlZmVycmVk
fGJpbmR8aW50ZXJsZWF2ZWBgCiAgICAgICAgIENyZWF0ZXMgYSBtZW1vcnkgYmFja2VuZCBvYmpl
Y3QsIHdoaWNoIGNhbiBiZSB1c2VkIHRvIGJhY2sgdGhlCiAgICAgICAgIGd1ZXN0IFJBTS4gTWVt
b3J5IGJhY2tlbmQgb2JqZWN0cyBvZmZlciBtb3JlIGNvbnRyb2wgdGhhbiB0aGUKLS0gCjIuMjYu
MgoK


