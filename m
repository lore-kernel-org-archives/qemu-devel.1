Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F69C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0DC20775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiAHd5/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0DC20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0Zf-0002X0-Ob
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw0Yw-0001VJ-Cv
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:52:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw0Yu-0006xT-1i
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594893138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/RhQm5bFXAXs8gAGrRUTLPFfDw67LI4nsCk2cX+WQw=;
 b=hiAHd5/9sJVi3W5nf214Gk1c1nnsEl6KYXG2vCJNBoKOnwpyaeNbyeaAGl0697bwpbO/ss
 iGTbGCepDAHAiFNt1XgfyiRGATl7737s5prsVDc0uERj4Bp9IFMVekAsHqoQVmUsVJPdSy
 8DDVwxhvKdYL/nIOFpgPojo7Ys4+j7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-FOGcY6y7NVa2tqD_TMkj_w-1; Thu, 16 Jul 2020 05:52:14 -0400
X-MC-Unique: FOGcY6y7NVa2tqD_TMkj_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853AAE92D;
 Thu, 16 Jul 2020 09:52:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BBC372AEE;
 Thu, 16 Jul 2020 09:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B5AF11385E0; Thu, 16 Jul 2020 11:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH v2] tests: qmp-cmd-test: fix memory leak
References: <20200715154117.15456-1-liq3ea@163.com>
 <874kq8roev.fsf@dusky.pond.sub.org>
 <CAKXe6S+CvQ1rmnWXi2_=kiCF4yG-2T3iPut=51G25qwL+oO2Pw@mail.gmail.com>
Date: Thu, 16 Jul 2020 11:52:07 +0200
In-Reply-To: <CAKXe6S+CvQ1rmnWXi2_=kiCF4yG-2T3iPut=51G25qwL+oO2Pw@mail.gmail.com>
 (Li Qiang's message of "Thu, 16 Jul 2020 14:43:31 +0800")
Message-ID: <87blkfpz20.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Qiang <liq3ea@gmail.com> writes:

> Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:59=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> Li Qiang <liq3ea@163.com> writes:
>>
>> > Properly free each test response to avoid memory leak and separate
>> > qtest_qmp() calls with spare lines, in a consistent manner.
>> >
>> > Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
>> > qmp/object-add-failure-modes"
>>
>> The patch also fixes leaks introduced in 442b09b83d and 9fc719b869,
>> actually.  At least it should, but the patch appears to be incomplete.

442b09b83d was fine, actually.

9fc719b869 wasn't, and your second patch hunk fixes it.  Please add a
"Fixes: 9fc719b869' line to the commit message.

>> >
>> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> > Signed-off-by: Li Qiang <liq3ea@163.com>
>> > ---
>> > Change sincve v1: add detailed commit message
>> >
>> > tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
>> > index c68f99f659..f7b1aa7fdc 100644
>> > --- a/tests/qtest/qmp-cmd-test.c
>> > +++ b/tests/qtest/qmp-cmd-test.c
>> > @@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
>>    static void test_object_add_failure_modes(void)
>>    {
>>        QTestState *qts;
>>        QDict *resp;
>>
>>        /* attempt to create an object without props */
>>        qts =3D qtest_init(common_args);
>>        resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>>                         " {'qom-type': 'memory-backend-ram', 'id': 'ram1=
' } }");
>>        g_assert_nonnull(resp);
>>        qmp_assert_error_class(resp, "GenericError");
>>
>> Doesn't @resp leak here, too?
>
> No, qmp_assert_error_class will call qobject_unref(rsp) will so will not =
leak.

You're right.

With the additional Fixes:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

> In fact, I think this is a inconsistent for 'qtest_qmp'.
> I think we can apply this patch first and then change the
> 'qmp_assert_error_class' or/and others
> to free resp. And just let the caller of 'qtest_qmp' frees unref the rsp.

Do you mean "not to free @resp"?

> What's your idea?

Rename it to qmp_expect_error_and_unref()?


