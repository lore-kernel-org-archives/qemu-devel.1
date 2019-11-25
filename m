Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73211C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1E220718
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ft41eAWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1E220718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZANJ-0006Q5-EJ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZAMR-0005rC-NZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZAMP-0001NF-2I
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:08:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZAMO-0001Mr-Uh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574672924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzUdxHnr9QwE/jEN/i380sqNmRwT0p4PiaK6CXs8P9o=;
 b=ft41eAWxHJPCYkZUKhEBEC8GMb23PpA1MsBWEb00CxE0iUbzfQBHAyP1CW1cGNUa3D1jwz
 Qenx8hCw+0qTYj5Knd6xRxZqfxwBi1ZFdmL/peMdwh/DDfzkAH9/m95L1EEqXtwG5wJJDl
 g1ms+QSicXARwTGz6bNjPOIStI7wi8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-YVfkSNh3PniDSAPLCIgJDw-1; Mon, 25 Nov 2019 04:08:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ACC51034AE0;
 Mon, 25 Nov 2019 09:08:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E425C1D4;
 Mon, 25 Nov 2019 09:08:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69F551138606; Mon, 25 Nov 2019 10:08:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 06/14] tests: Add test for QAPI builtin type time
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-7-tao3.xu@intel.com>
Date: Mon, 25 Nov 2019 10:08:34 +0100
In-Reply-To: <20191122074826.1373-7-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:18 +0800")
Message-ID: <877e3oiar1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YVfkSNh3PniDSAPLCIgJDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Add tests for time input such as zero, around limit of precision,
> signed upper limit, actual upper limit, beyond limits, time suffixes,
> and etc.
>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>
> No changes in v17.
>
> Changes in v16:
>     - Update the test cases
>
> Changes in v14:
>     - Drop time unit picosecond (Eric)
> ---
>  tests/test-keyval.c                | 89 ++++++++++++++++++++++++++++++
>  tests/test-qobject-input-visitor.c | 29 ++++++++++
>  2 files changed, 118 insertions(+)
>
> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index fad941fcb8..39443f7e0c 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -457,6 +457,94 @@ static void test_keyval_visit_size(void)
>      visit_free(v);
>  }
> =20
> +static void test_keyval_visit_time(void)
> +{
> +    Error *err =3D NULL;
> +    Visitor *v;
> +    QDict *qdict;
> +    uint64_t time;
> +
> +    /* Lower limit zero */
> +    qdict =3D keyval_parse("time1=3D0", NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &error_abort);
> +    g_assert_cmpuint(time, =3D=3D, 0);
> +    visit_check_struct(v, &error_abort);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Around limit of precision: UINT64_MAX - 1, UINT64_MAX */
> +    qdict =3D keyval_parse("time1=3D18446744073709551614,"
> +                         "time2=3D18446744073709551615",
> +                         NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0xfffffffffffffffe);
> +    visit_type_time(v, "time2", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0xffffffffffffffff);
> +    visit_check_struct(v, &error_abort);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Beyond limits */
> +    qdict =3D keyval_parse("time1=3D-1,"
> +                         "time2=3D18446744073709551616", /* 2^64 */
> +                         NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &err);
> +    error_free_or_abort(&err);
> +    visit_type_time(v, "time2", &time, &err);
> +    error_free_or_abort(&err);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Suffixes */
> +    qdict =3D keyval_parse("time1=3D2ns,time2=3D3.4us,time3=3D5ms,time4=
=3D600s",
> +                         NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &error_abort);
> +    g_assert_cmpuint(time, =3D=3D, 2);
> +    visit_type_time(v, "time2", &time, &error_abort);
> +    g_assert_cmpuint(time, =3D=3D, 3400);
> +    visit_type_time(v, "time3", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 5 * 1000 * 1000);
> +    visit_type_time(v, "time4", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 600 * 1000000000LL);
> +    visit_check_struct(v, &error_abort);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Beyond limit with suffix */
> +    qdict =3D keyval_parse("time1=3D1844674407370955s", NULL, &error_abo=
rt);

We want to test a value just above the limit, like
test_keyval_visit_size() does.  The limit is 2^64-1 ns =3D
1844674.407370955s.

Please use "1844675s".

> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &err);
> +    error_free_or_abort(&err);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Trailing crap */
> +    qdict =3D keyval_parse("time1=3D89ks,time2=3Dns", NULL, &error_abort=
);

"time1=3D89ks" tests empty suffix followed by crap "ks".  Matches
test_keyval_visit_size()'s "sz1=3D16E", except that test case got messed
up in commit 5e00984aef7 (I'll post a fix).

"time2=3Dns" doesn't test *trailing* crap, i.e. characters following valid
input.  There is no valid input.  Please use something like
"time2=3D123use".

> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &err);
> +    error_free_or_abort(&err);
> +    visit_type_time(v, "time2", &time, &err);;
> +    error_free_or_abort(&err);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +}
> +
>  static void test_keyval_visit_dict(void)
>  {
>      Error *err =3D NULL;
> @@ -645,6 +733,7 @@ int main(int argc, char *argv[])
>      g_test_add_func("/keyval/visit/bool", test_keyval_visit_bool);
>      g_test_add_func("/keyval/visit/number", test_keyval_visit_number);
>      g_test_add_func("/keyval/visit/size", test_keyval_visit_size);
> +    g_test_add_func("/keyval/visit/time", test_keyval_visit_time);
>      g_test_add_func("/keyval/visit/dict", test_keyval_visit_dict);
>      g_test_add_func("/keyval/visit/list", test_keyval_visit_list);
>      g_test_add_func("/keyval/visit/optional", test_keyval_visit_optional=
);
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index 6bacabf063..55138042b8 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -366,6 +366,31 @@ static void test_visitor_in_size_str_fail(TestInputV=
isitorData *data,
>      error_free_or_abort(&err);
>  }
> =20
> +static void test_visitor_in_time_str_keyval(TestInputVisitorData *data,
> +                                            const void *unused)
> +{
> +    uint64_t res, value =3D 265 * 1000 * 1000;
> +    Visitor *v;
> +
> +    v =3D visitor_input_test_init_full(data, true, "\"265ms\"");
> +
> +    visit_type_time(v, NULL, &res, &error_abort);
> +    g_assert_cmpfloat(res, =3D=3D, value);
> +}
> +
> +static void test_visitor_in_time_str_fail(TestInputVisitorData *data,
> +                                          const void *unused)
> +{
> +    uint64_t res =3D 0;
> +    Visitor *v;
> +    Error *err =3D NULL;
> +
> +    v =3D visitor_input_test_init(data, "\"265ms\"");
> +
> +    visit_type_time(v, NULL, &res, &err);
> +    error_free_or_abort(&err);
> +}
> +
>  static void test_visitor_in_string(TestInputVisitorData *data,
>                                     const void *unused)
>  {
> @@ -1311,6 +1336,10 @@ int main(int argc, char **argv)
>                             NULL, test_visitor_in_size_str_keyval);
>      input_visitor_test_add("/visitor/input/size_str_fail",
>                             NULL, test_visitor_in_size_str_fail);
> +    input_visitor_test_add("/visitor/input/time_str_keyval",
> +                           NULL, test_visitor_in_time_str_keyval);
> +    input_visitor_test_add("/visitor/input/time_str_fail",
> +                           NULL, test_visitor_in_time_str_fail);
>      input_visitor_test_add("/visitor/input/string",
>                             NULL, test_visitor_in_string);
>      input_visitor_test_add("/visitor/input/enum",


