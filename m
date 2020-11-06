Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A66C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF3C2078B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN7TgsLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF3C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kavL3-00006r-Jb
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 01:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kavK4-0007xO-GH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kavK0-0006TZ-P3
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604644440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzOd+lTVei+ZuKQOyDsGlIZXiCp6TlNaOj/bLla1OnM=;
 b=aN7TgsLfiKNGAvSyzROtG8YOiK+RYppSJH2eRzzOWYr2YNhYilO+YHGqenj42eHAULDPFX
 NTqQgkZzhJUSwJFI8EHLbLae1NULowV6VKvwJn81ONXhjMVR8Rq5eZWaEOG1oP8EB+2753
 Zjxf3aP7dm4YG1ClRJiHezIz6gXhiVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-KsQkpDxlPaeyD0ArvcAPgA-1; Fri, 06 Nov 2020 01:33:59 -0500
X-MC-Unique: KsQkpDxlPaeyD0ArvcAPgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA4C835B50;
 Fri,  6 Nov 2020 06:33:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04E5121E79;
 Fri,  6 Nov 2020 06:33:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4177F1132BD6; Fri,  6 Nov 2020 07:33:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
 <5FA38A32.2020008@huawei.com>
 <18690aa2-3de9-70ad-477f-934724b284a0@redhat.com>
Date: Fri, 06 Nov 2020 07:33:55 +0100
In-Reply-To: <18690aa2-3de9-70ad-477f-934724b284a0@redhat.com> (Thomas Huth's
 message of "Thu, 5 Nov 2020 06:58:31 +0100")
Message-ID: <87wnyzouy4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 21:51:30
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
Cc: AlexChen <alex.chen@huawei.com>, lvivier@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 05/11/2020 06.14, AlexChen wrote:
>> On 2020/11/4 18:44, Thomas Huth wrote:
>>> On 04/11/2020 11.23, AlexChen wrote:
>>>> We should use printf format specifier "%u" instead of "%d" for
>>>> argument of type "unsigned int".
>>>>
>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>>> ---
>>>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-feat=
ures.c
>>>> index d20094d5a7..bc681a95d5 100644
>>>> --- a/tests/qtest/arm-cpu-features.c
>>>> +++ b/tests/qtest/arm-cpu-features.c
>>>> @@ -536,7 +536,7 @@ static void test_query_cpu_model_expansion_kvm(con=
st void *data)
>>>>          if (kvm_supports_sve) {
>>>>              g_assert(vls !=3D 0);
>>>>              max_vq =3D 64 - __builtin_clzll(vls);
>>>> -            sprintf(max_name, "sve%d", max_vq * 128);
>>>> +            sprintf(max_name, "sve%u", max_vq * 128);
>>>>
>>>>              /* Enabling a supported length is of course fine. */
>>>>              assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name=
);
>>>> @@ -556,7 +556,7 @@ static void test_query_cpu_model_expansion_kvm(con=
st void *data)
>>>>                   * unless all larger, supported vector lengths are al=
so
>>>>                   * disabled.
>>>>                   */
>>>> -                sprintf(name, "sve%d", vq * 128);
>>>> +                sprintf(name, "sve%u", vq * 128);
>>>>                  error =3D g_strdup_printf("cannot disable %s", name);
>>>>                  assert_error(qts, "host", error,
>>>>                               "{ %s: true, %s: false }",
>>>> @@ -569,7 +569,7 @@ static void test_query_cpu_model_expansion_kvm(con=
st void *data)
>>>>               * we need at least one vector length enabled.
>>>>               */
>>>>              vq =3D __builtin_ffsll(vls);
>>>> -            sprintf(name, "sve%d", vq * 128);
>>>> +            sprintf(name, "sve%u", vq * 128);
>>>>              error =3D g_strdup_printf("cannot disable %s", name);
>>>>              assert_error(qts, "host", error, "{ %s: false }", name);
>>>>              g_free(error);
>>>> @@ -581,7 +581,7 @@ static void test_query_cpu_model_expansion_kvm(con=
st void *data)
>>>>                  }
>>>>              }
>>>>              if (vq <=3D SVE_MAX_VQ) {
>>>> -                sprintf(name, "sve%d", vq * 128);
>>>> +                sprintf(name, "sve%u", vq * 128);
>>>>                  error =3D g_strdup_printf("cannot enable %s", name);
>>>>                  assert_error(qts, "host", error, "{ %s: true }", name=
);
>>>>                  g_free(error);
>>>>
>>>
>>> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you =
want
>>> to fix this really really correctly, please use PRIu32 from inttypes.h =
instead.
>>>
>>=20
>> Hi Thomas,
>> Thanks for your review.
>> According to the definition of the macro PRIu32(# define PRIu32         =
"u"),
>> using PRIu32 works the same as using %u to print, and using PRIu32 to pr=
int
>> is relatively rare in QEMU(%u 720, PRIu32 only 120). Can we continue to =
use %u to
>> print max_vq and vq in this patch.
>> Of course, this is just my small small suggestion. If you think it is be=
tter to use
>> PRIu32 for printing, I will send patch V2.
>
> Well, %u happens to work since "int" is 32-bit with all current compilers
> that we support.

Yes, it works.

>                  But if there is ever a compiler where the size of int is
> different, you'll get a compiler warning here again.

No, we won't.

If we ever use a compiler where int is narrower than 32 bits, then the
type of the argument is actually uint32_t[1].  We can forget about this
case, because "int narrower than 32 bits" is not going to fly with our
code base.

If we ever use a compiler where int is wider than 32 bits, then the type
of the argument is *not* uint32_t[2].  PRIu32 will work anyway, because
it will actually retrieve an unsigned int argument, *not* an uint32_t
argument[3].

In other words "%" PRIu32 is just a less legible alias for "%u" in all
cases that matter.

And that's why I would simply use "%u".

>                                                      So if we now fix thi=
s
> up, then let's do it really right and use PRIu32, please.
>
>  Thomas


[1] Because promotion does nothing either argument, and the usual
arithmetic conversions convert to uint32_t.  See my first reply.

[2] Because uint32_t gets promoted to unsigned int.  See my first reply.

[3] Because variable arguments undergo default argument promotion (=C2=A7
6.5.2.2 Function calls), which promotes uint32_t to unsigned int.


