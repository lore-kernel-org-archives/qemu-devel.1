Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A369C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31199206F4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9Eslbi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31199206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaaWW-0001ZY-H4
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 03:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaaV8-0000vp-7E
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 03:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaaV4-0007oy-TK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 03:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604564405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvsdGK6VnjAxRYYsrHV13JbLjJnhO4iz/0QFijc9FS8=;
 b=R9Eslbi9OFMbuQKcHFORpWbMgd1s+XQM5ioHlSg4tucvVXpq31e+qPa5603RExp3zaosmG
 6aNfjwXKdr9kCL/CGIRaTYdGtznFQo+F0F8rmu8FalZi1l7NGw1WeI9crtHndyvjX09yc/
 VyUgS7FsmSP4ec3wY3lkXoF2iAivuNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-nHBo8I8AM-S9gZFzZM22BA-1; Thu, 05 Nov 2020 03:20:01 -0500
X-MC-Unique: nHBo8I8AM-S9gZFzZM22BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8173D101962A;
 Thu,  5 Nov 2020 08:20:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D145D98F;
 Thu,  5 Nov 2020 08:20:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 943401132BD6; Thu,  5 Nov 2020 09:19:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
Date: Thu, 05 Nov 2020 09:19:58 +0100
In-Reply-To: <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com> (Thomas Huth's
 message of "Wed, 4 Nov 2020 11:44:46 +0100")
Message-ID: <877dr0rz9t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: AlexChen <alex.chen@huawei.com>, lvivier@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 04/11/2020 11.23, AlexChen wrote:
>> We should use printf format specifier "%u" instead of "%d" for
>> argument of type "unsigned int".
>>=20
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>> ---
>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-featur=
es.c
>> index d20094d5a7..bc681a95d5 100644
>> --- a/tests/qtest/arm-cpu-features.c
>> +++ b/tests/qtest/arm-cpu-features.c
>> @@ -536,7 +536,7 @@ static void test_query_cpu_model_expansion_kvm(const=
 void *data)
>>          if (kvm_supports_sve) {
>>              g_assert(vls !=3D 0);
>>              max_vq =3D 64 - __builtin_clzll(vls);
>> -            sprintf(max_name, "sve%d", max_vq * 128);
>> +            sprintf(max_name, "sve%u", max_vq * 128);
>>=20
>>              /* Enabling a supported length is of course fine. */
>>              assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
>> @@ -556,7 +556,7 @@ static void test_query_cpu_model_expansion_kvm(const=
 void *data)
>>                   * unless all larger, supported vector lengths are also
>>                   * disabled.
>>                   */
>> -                sprintf(name, "sve%d", vq * 128);
>> +                sprintf(name, "sve%u", vq * 128);
>>                  error =3D g_strdup_printf("cannot disable %s", name);
>>                  assert_error(qts, "host", error,
>>                               "{ %s: true, %s: false }",
>> @@ -569,7 +569,7 @@ static void test_query_cpu_model_expansion_kvm(const=
 void *data)
>>               * we need at least one vector length enabled.
>>               */
>>              vq =3D __builtin_ffsll(vls);
>> -            sprintf(name, "sve%d", vq * 128);
>> +            sprintf(name, "sve%u", vq * 128);
>>              error =3D g_strdup_printf("cannot disable %s", name);
>>              assert_error(qts, "host", error, "{ %s: false }", name);
>>              g_free(error);
>> @@ -581,7 +581,7 @@ static void test_query_cpu_model_expansion_kvm(const=
 void *data)
>>                  }
>>              }
>>              if (vq <=3D SVE_MAX_VQ) {
>> -                sprintf(name, "sve%d", vq * 128);
>> +                sprintf(name, "sve%u", vq * 128);
>>                  error =3D g_strdup_printf("cannot enable %s", name);
>>                  assert_error(qts, "host", error, "{ %s: true }", name);
>>                  g_free(error);
>>=20
>
> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you wa=
nt

Not quite.  They are, but the product isn't.  Assuming it is is actually
a common misconception of how C works.

C99 =C2=A7 6.3.1.8 "Usual arithmetic conversions" applies.  Short summary:
first, both operands of * undergo integer promotion (=C2=A7 6.3.1.1 Boolean=
,
characters, and integers), then we find a "common" integer type, convert
the operands to it, and multiply in that type.

128 is int (=C2=A7 6.4.4.1 Integer constants).  Integer promotion does
nothing.

@vq is uint32_t per its declaration.  If int can represent any uint32_t
value, it promotes to int; else if unsigned int can represent, it
promotes to unsigned int; else it stays the same.

In QEMU practice, "stays the same" is impossible, because unsigned int
narrower than 32 bits is.  "Promotes to int" is unlikely, because int
wider than 32 bits is.

So, the "common" type is almost certainly unsigned int for us, but we
may want to do the right thing for the unlikely case of signed int.

It is uint32_t only when it's unsigned int, and the system makes
uint32_t an alias for unsigned int, say with typedef unsigned uint32_t.

> to fix this really really correctly, please use PRIu32 from inttypes.h in=
stead.

I wouldn't.

The PRI macros are required for integer types wider than signed /
unsigned int.

Narrower types promote to int or unsigned.

For equally wide types, it doesn't matter.


