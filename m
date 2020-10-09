Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F378BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AB122282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/D0oCJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB122282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyGu-00079l-GS
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyBd-0000ti-47
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyBa-0002uk-8e
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/vM8uz2r0r9gdL4b3AEy4UiXb/2h/7H59pl5AF6Y+g=;
 b=Y/D0oCJ4z2fr6gQibKaEOlrr6fzYjQHGoE1gf0KJFCbWKBfF7bD2/CRK7eg0Z2M2Kxnx6k
 MjfqFFtGsift0p6kzGO82q+m6HfGmlo7CSs/karV+ifcTzOTmFZY4G1eAXq+20DezDnyTC
 sOr37ZzCWUIX7UCclKvJK8VZd5Ni+eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-DgavM5ilOTa9WDNkcqajrw-1; Fri, 09 Oct 2020 15:36:11 -0400
X-MC-Unique: DgavM5ilOTa9WDNkcqajrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13C46805EFB;
 Fri,  9 Oct 2020 19:36:10 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311DB5C1BB;
 Fri,  9 Oct 2020 19:36:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 05/30] block: move logical block size check function to a
 common utility function
Date: Fri,  9 Oct 2020 20:35:04 +0100
Message-Id: <20201009193529.322822-6-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQ29pYnkgWHUgPGNvaWJ5Lnh1QGdtYWlsLmNvbT4KCk1vdmUgdGhlIGNvbnN0YW50cyBm
cm9tIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmMgdG8KdXRpbC9ibG9jay1oZWxwZXJzLmggc28g
dGhhdCBrbm93bGVkZ2Ugb2YgdGhlIG1pbi9tYXggdmFsdWVzIGlzCgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IENvaWJ5
IFh1IDxjb2lieS54dUBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0
ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtv
c3RAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA5MTgwODA5MTIuMzIxMjk5LTUtY29pYnku
eHVAZ21haWwuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiB1dGlsL2Jsb2NrLWhlbHBlcnMuaCAgICAgICAgICAgICB8IDE5ICsrKysr
KysrKysrKysKIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5jIHwgMzEgKysrKy0tLS0t
LS0tLS0tLS0tLS0tCiB1dGlsL2Jsb2NrLWhlbHBlcnMuYyAgICAgICAgICAgICB8IDQ2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiB1dGlsL21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgICB8ICAxICsKIDQgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9ibG9jay1oZWxwZXJzLmgKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB1dGlsL2Jsb2NrLWhlbHBlcnMuYwoKZGlmZiAtLWdpdCBhL3V0aWwvYmxvY2st
aGVscGVycy5oIGIvdXRpbC9ibG9jay1oZWxwZXJzLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMC4uYjUzMjk1YTUyOQotLS0gL2Rldi9udWxsCisrKyBiL3V0aWwvYmxvY2st
aGVscGVycy5oCkBAIC0wLDAgKzEsMTkgQEAKKyNpZm5kZWYgQkxPQ0tfSEVMUEVSU19ICisjZGVm
aW5lIEJMT0NLX0hFTFBFUlNfSAorCisjaW5jbHVkZSAicWVtdS91bml0cy5oIgorCisvKiBsb3dl
ciBsaW1pdCBpcyBzZWN0b3Igc2l6ZSAqLworI2RlZmluZSBNSU5fQkxPQ0tfU0laRSAgICAgICAg
ICBJTlQ2NF9DKDUxMikKKyNkZWZpbmUgTUlOX0JMT0NLX1NJWkVfU1RSICAgICAgIjUxMiBCIgor
LyoKKyAqIHVwcGVyIGxpbWl0IGlzIGFyYml0cmFyeSwgMiBNaUIgbG9va3Mgc3VmZmljaWVudCBm
b3IgYWxsIHNlbnNpYmxlIHVzZXMsIGFuZAorICogbWF0Y2hlcyBxY293MiBjbHVzdGVyIHNpemUg
bGltaXQKKyAqLworI2RlZmluZSBNQVhfQkxPQ0tfU0laRSAgICAgICAgICAoMiAqIE1pQikKKyNk
ZWZpbmUgTUFYX0JMT0NLX1NJWkVfU1RSICAgICAgIjIgTWlCIgorCit2b2lkIGNoZWNrX2Jsb2Nr
X3NpemUoY29uc3QgY2hhciAqaWQsIGNvbnN0IGNoYXIgKm5hbWUsIGludDY0X3QgdmFsdWUsCisg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsKKworI2VuZGlmIC8qIEJMT0NLX0hF
TFBFUlNfSCAqLwpkaWZmIC0tZ2l0IGEvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMg
Yi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYwppbmRleCA0OWJkZDEyNTgxLi5iODFh
NGU4ZDE0IDEwMDY0NAotLS0gYS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYworKysg
Yi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYwpAQCAtMzAsNiArMzAsNyBAQAogI2lu
Y2x1ZGUgInN5c2VtdS9ibG9ja2Rldi5oIgogI2luY2x1ZGUgIm5ldC9uZXQuaCIKICNpbmNsdWRl
ICJody9wY2kvcGNpLmgiCisjaW5jbHVkZSAidXRpbC9ibG9jay1oZWxwZXJzLmgiCiAKIHN0YXRp
YyBib29sIGNoZWNrX3Byb3Bfc3RpbGxfdW5zZXQoRGV2aWNlU3RhdGUgKmRldiwgY29uc3QgY2hh
ciAqbmFtZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAq
b2xkX3ZhbCwgY29uc3QgY2hhciAqbmV3X3ZhbCwKQEAgLTU3NiwxNiArNTc3LDYgQEAgY29uc3Qg
UHJvcGVydHlJbmZvIHFkZXZfcHJvcF9sb3N0dGlja3BvbGljeSA9IHsKIAogLyogLS0tIGJsb2Nr
c2l6ZSAtLS0gKi8KIAotLyogbG93ZXIgbGltaXQgaXMgc2VjdG9yIHNpemUgKi8KLSNkZWZpbmUg
TUlOX0JMT0NLX1NJWkUgICAgICAgICAgNTEyCi0jZGVmaW5lIE1JTl9CTE9DS19TSVpFX1NUUiAg
ICAgICI1MTIgQiIKLS8qCi0gKiB1cHBlciBsaW1pdCBpcyBhcmJpdHJhcnksIDIgTWlCIGxvb2tz
IHN1ZmZpY2llbnQgZm9yIGFsbCBzZW5zaWJsZSB1c2VzLCBhbmQKLSAqIG1hdGNoZXMgcWNvdzIg
Y2x1c3RlciBzaXplIGxpbWl0Ci0gKi8KLSNkZWZpbmUgTUFYX0JMT0NLX1NJWkUgICAgICAgICAg
KDIgKiBNaUIpCi0jZGVmaW5lIE1BWF9CTE9DS19TSVpFX1NUUiAgICAgICIyIE1pQiIKLQogc3Rh
dGljIHZvaWQgc2V0X2Jsb2Nrc2l6ZShPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hh
ciAqbmFtZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJvciAq
KmVycnApCiB7CkBAIC01OTMsNiArNTg0LDcgQEAgc3RhdGljIHZvaWQgc2V0X2Jsb2Nrc2l6ZShP
YmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwKICAgICBQcm9wZXJ0eSAq
cHJvcCA9IG9wYXF1ZTsKICAgICB1aW50MzJfdCAqcHRyID0gcWRldl9nZXRfcHJvcF9wdHIoZGV2
LCBwcm9wKTsKICAgICB1aW50NjRfdCB2YWx1ZTsKKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVM
TDsKIAogICAgIGlmIChkZXYtPnJlYWxpemVkKSB7CiAgICAgICAgIHFkZXZfcHJvcF9zZXRfYWZ0
ZXJfcmVhbGl6ZShkZXYsIG5hbWUsIGVycnApOwpAQCAtNjAyLDI0ICs1OTQsMTEgQEAgc3RhdGlj
IHZvaWQgc2V0X2Jsb2Nrc2l6ZShPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAq
bmFtZSwKICAgICBpZiAoIXZpc2l0X3R5cGVfc2l6ZSh2LCBuYW1lLCAmdmFsdWUsIGVycnApKSB7
CiAgICAgICAgIHJldHVybjsKICAgICB9Ci0gICAgLyogdmFsdWUgb2YgMCBtZWFucyAidW5zZXQi
ICovCi0gICAgaWYgKHZhbHVlICYmICh2YWx1ZSA8IE1JTl9CTE9DS19TSVpFIHx8IHZhbHVlID4g
TUFYX0JMT0NLX1NJWkUpKSB7Ci0gICAgICAgIGVycm9yX3NldGcoZXJycCwKLSAgICAgICAgICAg
ICAgICAgICAiUHJvcGVydHkgJXMuJXMgZG9lc24ndCB0YWtlIHZhbHVlICUiIFBSSXU2NAotICAg
ICAgICAgICAgICAgICAgICIgKG1pbmltdW06ICIgTUlOX0JMT0NLX1NJWkVfU1RSCi0gICAgICAg
ICAgICAgICAgICAgIiwgbWF4aW11bTogIiBNQVhfQkxPQ0tfU0laRV9TVFIgIikiLAotICAgICAg
ICAgICAgICAgICAgIGRldi0+aWQgPyA6ICIiLCBuYW1lLCB2YWx1ZSk7CisgICAgY2hlY2tfYmxv
Y2tfc2l6ZShkZXYtPmlkID8gOiAiIiwgbmFtZSwgdmFsdWUsICZsb2NhbF9lcnIpOworICAgIGlm
IChsb2NhbF9lcnIpIHsKKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7
CiAgICAgICAgIHJldHVybjsKICAgICB9Ci0KLSAgICAvKiBXZSByZWx5IG9uIHBvd2VyLW9mLTIg
YmxvY2tzaXplcyBmb3IgYml0bWFza3MgKi8KLSAgICBpZiAoKHZhbHVlICYgKHZhbHVlIC0gMSkp
ICE9IDApIHsKLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLAotICAgICAgICAgICAgICAgICAgIlBy
b3BlcnR5ICVzLiVzIGRvZXNuJ3QgdGFrZSB2YWx1ZSAnJSIgUFJJZDY0ICInLCAiCi0gICAgICAg
ICAgICAgICAgICAiaXQncyBub3QgYSBwb3dlciBvZiAyIiwgZGV2LT5pZCA/OiAiIiwgbmFtZSwg
KGludDY0X3QpdmFsdWUpOwotICAgICAgICByZXR1cm47Ci0gICAgfQotCiAgICAgKnB0ciA9IHZh
bHVlOwogfQogCmRpZmYgLS1naXQgYS91dGlsL2Jsb2NrLWhlbHBlcnMuYyBiL3V0aWwvYmxvY2st
aGVscGVycy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLmM0ODUxNDMy
ZjUKLS0tIC9kZXYvbnVsbAorKysgYi91dGlsL2Jsb2NrLWhlbHBlcnMuYwpAQCAtMCwwICsxLDQ2
IEBACisvKgorICogQmxvY2sgdXRpbGl0eSBmdW5jdGlvbnMKKyAqCisgKiBDb3B5cmlnaHQgSUJN
LCBDb3JwLiAyMDExCisgKiBDb3B5cmlnaHQgKGMpIDIwMjAgQ29pYnkgWHUgPGNvaWJ5Lnh1QGdt
YWlsLmNvbT4KKyAqCisgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIgb3IgbGF0ZXIuCisgKiBTZWUgdGhlIENPUFlJTkcgZmls
ZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4KKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIgorI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKKyNpbmNsdWRlICJxYXBpL3FtcC9xZXJyb3Iu
aCIKKyNpbmNsdWRlICJibG9jay1oZWxwZXJzLmgiCisKKy8qKgorICogY2hlY2tfYmxvY2tfc2l6
ZToKKyAqIEBpZDogVGhlIHVuaXF1ZSBJRCBvZiB0aGUgb2JqZWN0CisgKiBAbmFtZTogVGhlIG5h
bWUgb2YgdGhlIHByb3BlcnR5IGJlaW5nIHZhbGlkYXRlZAorICogQHZhbHVlOiBUaGUgYmxvY2sg
c2l6ZSBpbiBieXRlcworICogQGVycnA6IEEgcG9pbnRlciB0byBhbiBhcmVhIHRvIHN0b3JlIGFu
IGVycm9yCisgKgorICogVGhpcyBmdW5jdGlvbiBjaGVja3MgdGhhdCB0aGUgYmxvY2sgc2l6ZSBt
ZWV0cyB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKiAxLiBBdCBsZWFzdCBNSU5fQkxPQ0tf
U0laRQorICogMi4gTm8gbGFyZ2VyIHRoYW4gTUFYX0JMT0NLX1NJWkUKKyAqIDMuIEEgcG93ZXIg
b2YgMgorICovCit2b2lkIGNoZWNrX2Jsb2NrX3NpemUoY29uc3QgY2hhciAqaWQsIGNvbnN0IGNo
YXIgKm5hbWUsIGludDY0X3QgdmFsdWUsCisgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKQoreworICAgIC8qIHZhbHVlIG9mIDAgbWVhbnMgInVuc2V0IiAqLworICAgIGlmICh2YWx1
ZSAmJiAodmFsdWUgPCBNSU5fQkxPQ0tfU0laRSB8fCB2YWx1ZSA+IE1BWF9CTE9DS19TSVpFKSkg
eworICAgICAgICBlcnJvcl9zZXRnKGVycnAsIFFFUlJfUFJPUEVSVFlfVkFMVUVfT1VUX09GX1JB
TkdFLAorICAgICAgICAgICAgICAgICAgIGlkLCBuYW1lLCB2YWx1ZSwgTUlOX0JMT0NLX1NJWkUs
IE1BWF9CTE9DS19TSVpFKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKworICAgIC8qIFdlIHJl
bHkgb24gcG93ZXItb2YtMiBibG9ja3NpemVzIGZvciBiaXRtYXNrcyAqLworICAgIGlmICgodmFs
dWUgJiAodmFsdWUgLSAxKSkgIT0gMCkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsCisgICAg
ICAgICAgICAgICAgICAgIlByb3BlcnR5ICVzLiVzIGRvZXNuJ3QgdGFrZSB2YWx1ZSAnJSIgUFJJ
ZDY0CisgICAgICAgICAgICAgICAgICAgIicsIGl0J3Mgbm90IGEgcG93ZXIgb2YgMiIsCisgICAg
ICAgICAgICAgICAgICAgaWQsIG5hbWUsIHZhbHVlKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0K
K30KZGlmZiAtLWdpdCBhL3V0aWwvbWVzb24uYnVpbGQgYi91dGlsL21lc29uLmJ1aWxkCmluZGV4
IDM5MjE5ODFjY2YuLjIyOTZlODFiMzQgMTAwNjQ0Ci0tLSBhL3V0aWwvbWVzb24uYnVpbGQKKysr
IGIvdXRpbC9tZXNvbi5idWlsZApAQCAtNjcsNiArNjcsNyBAQCBpZiBoYXZlX2Jsb2NrCiAgIHV0
aWxfc3MuYWRkKGZpbGVzKCdudmRpbW0tdXRpbHMuYycpKQogICB1dGlsX3NzLmFkZChmaWxlcygn
cWVtdS1jb3JvdXRpbmUuYycsICdxZW11LWNvcm91dGluZS1sb2NrLmMnLCAncWVtdS1jb3JvdXRp
bmUtaW8uYycpKQogICB1dGlsX3NzLmFkZCh3aGVuOiAnQ09ORklHX0xJTlVYJywgaWZfdHJ1ZTog
ZmlsZXMoJ3Zob3N0LXVzZXItc2VydmVyLmMnKSkKKyAgdXRpbF9zcy5hZGQoZmlsZXMoJ2Jsb2Nr
LWhlbHBlcnMuYycpKQogICB1dGlsX3NzLmFkZChmaWxlcygncWVtdS1jb3JvdXRpbmUtc2xlZXAu
YycpKQogICB1dGlsX3NzLmFkZChmaWxlcygncWVtdS1jby1zaGFyZWQtcmVzb3VyY2UuYycpKQog
ICB1dGlsX3NzLmFkZChmaWxlcygndGhyZWFkLXBvb2wuYycsICdxZW11LXRpbWVyLmMnKSkKLS0g
CjIuMjYuMgoK


