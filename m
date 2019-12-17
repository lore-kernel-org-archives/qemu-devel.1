Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E21C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC3820733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hv5W3vOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC3820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBI3-0005F3-Ke
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 06:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ihBHK-0004pt-ER
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ihBHH-0000sP-PG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:44:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ihBHH-0000rZ-Dw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576583074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrf+wwRGXCYn6vxYupuF2/bD7Zs/DoC3vOee6mUiA+Y=;
 b=hv5W3vOInh713fkT7Kwv2d/jXq9dew5ctb7Ff52sDJknUC7OyCfHBAIcfCIGXq4+GmsNGq
 xHWG/O0GguCKFBPWYSmz/Fme3NnRYR6zfNKDHuDmlGRkY416PScVQHIFh4uUhdZUGHenPm
 7nOgI9AK/97SqZk2Db6kTHd/CKHLr1Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-cPv3XvI6Pxi3VzlRbo1BeQ-1; Tue, 17 Dec 2019 06:44:32 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so5270604wro.14
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=bqK/wiV7fo0MTZvthpg1Z0MdS4JOGlFJTfaZ7/5Y8G4=;
 b=XpCWhqfsk9vvi8gomNImiu7hgcc72jtetficxWqfmJPCD2y9Y5v315Na66gAz8a4k1
 lREoBJdcBJ1oZwcUCD5fVEthtyHW0a21Vliu904waAYuo588KeSLTiFK97Pi/GXh0GCj
 79QtDpLv78P3sJehrGU0KVyO62HKfL5ZTMPsJ/R8nFQiaCSX3G1vD0X1DmLiHej3lGVH
 iwMnMGJpcD2aTweRbB/VMrPSMODXE+wyNA/lBc49pm2u6854kD4t2mgGqjmOKKGRFAiu
 QdAYwAe2XtAuSKMDEnK/7PHHzP/eeiOwam/64/o7nmLxbN09c2zuycwiJML+fAraEDzh
 FZ0g==
X-Gm-Message-State: APjAAAVeFM1iqjfYmkBd1j1wMCyzGkwCiGF4HwQwULgD0VNDT9E9kvuU
 08ZRa8j0vXNcP4QQ+7jkNUunUt6mrQ1JjKUCfRmYaGfuRArt7JSNL6E3nyYe6VNXmy5ccUeskP/
 JAvXXphzc+c6rg3o=
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr5188851wmc.135.1576583071752; 
 Tue, 17 Dec 2019 03:44:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0dnzYbBVChm//PbBgoMRKEkK25Ezat1FAjqONopzaZ/MX1abi4ofsVXWeKSH/TlpLsWS0Tg==
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr5188822wmc.135.1576583071377; 
 Tue, 17 Dec 2019 03:44:31 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add?
 ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
 by smtp.gmail.com with ESMTPSA id t5sm24749998wrr.35.2019.12.17.03.44.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 03:44:30 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH RESEND v2] util/cutils: Expand do_strtosz parsing
 precision to 64 bits
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20191209083053.16402-1-tao3.xu@intel.com>
Date: Tue, 17 Dec 2019 12:44:29 +0100
Message-Id: <E002371E-11D7-4482-9213-DF2C8F12FC4B@redhat.com>
References: <20191209083053.16402-1-tao3.xu@intel.com>
To: Tao Xu <tao3.xu@intel.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: cPv3XvI6Pxi3VzlRbo1BeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 ehabkost@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 9 Dec 2019, at 09:30, Tao Xu <tao3.xu@intel.com> wrote:
>=20
> Parse input string both as a double and as a uint64_t, then use the
> method which consumes more characters. Update the related test cases.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v2:
>    - Resend to use double small than DBL_MIN
>    - Add more test case for double overflow and underflow.
>    - Set mul as int64_t (Markus)
>    - Restore endptr (Markus)
> ---
> tests/test-cutils.c    | 37 +++++++----------------
> tests/test-keyval.c    | 47 +++++------------------------
> tests/test-qemu-opts.c | 39 +++++-------------------
> util/cutils.c          | 67 +++++++++++++++++++++++++++++++-----------
> 4 files changed, 75 insertions(+), 115 deletions(-)
>=20
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 1aa8351520..49e495b8ba 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -1970,40 +1970,25 @@ static void test_qemu_strtosz_simple(void)
>     g_assert_cmpint(err, =3D=3D, 0);
>     g_assert_cmpint(res, =3D=3D, 12345);
>=20
> -    /* Note: precision is 53 bits since we're parsing with strtod() */
> -
> -    str =3D "9007199254740991"; /* 2^53-1 */
> -    err =3D qemu_strtosz(str, &endptr, &res);
> -    g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 0x1fffffffffffff);
> -    g_assert(endptr =3D=3D str + 16);
> -
> -    str =3D "9007199254740992"; /* 2^53 */
> -    err =3D qemu_strtosz(str, &endptr, &res);
> -    g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 0x20000000000000);
> -    g_assert(endptr =3D=3D str + 16);
> +    /* Note: precision is 64 bits (UINT64_MAX) */
>=20
>     str =3D "9007199254740993"; /* 2^53+1 */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 0x20000000000000); /* rounded to 53 bit=
s */
> +    g_assert_cmpint(res, =3D=3D, 0x20000000000001);
>     g_assert(endptr =3D=3D str + 16);
>=20
> -    str =3D "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) =
*/
> +    str =3D "18446744073709550591"; /* 0xfffffffffffffbff */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 0xfffffffffffff800);
> +    g_assert_cmpint(res, =3D=3D, 0xfffffffffffffbff);
>     g_assert(endptr =3D=3D str + 20);
>=20
> -    str =3D "18446744073709550591"; /* 0xfffffffffffffbff */
> +    str =3D "18446744073709551615"; /* 2^64-1 (UINT64_MAX) */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 0xfffffffffffff800); /* rounded to 53 b=
its */
> +    g_assert_cmpint(res, =3D=3D, 0xffffffffffffffff);
>     g_assert(endptr =3D=3D str + 20);
> -
> -    /* 0x7ffffffffffffe00..0x7fffffffffffffff get rounded to
> -     * 0x8000000000000000, thus -ERANGE; see test_qemu_strtosz_erange() =
*/
> }
>=20
> static void test_qemu_strtosz_units(void)
> @@ -2145,20 +2130,20 @@ static void test_qemu_strtosz_erange(void)
>     g_assert_cmpint(err, =3D=3D, -ERANGE);
>     g_assert(endptr =3D=3D str + 2);
>=20
> -    str =3D "18446744073709550592"; /* 0xfffffffffffffc00 */
> +    str =3D "18446744073709551616"; /* 2^64 */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, -ERANGE);
>     g_assert(endptr =3D=3D str + 20);
>=20
> -    str =3D "18446744073709551615"; /* 2^64-1 */
> +    str =3D "1.7976931348623158e+308"; /* DBL_MAX, double overflows */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, -ERANGE);
> -    g_assert(endptr =3D=3D str + 20);
> +    g_assert(endptr =3D=3D str + 23);
>=20
> -    str =3D "18446744073709551616"; /* 2^64 */
> +    str =3D "2.225e-308"; /* Small than DBL_MIN, double underflows */
>     err =3D qemu_strtosz(str, &endptr, &res);
>     g_assert_cmpint(err, =3D=3D, -ERANGE);
> -    g_assert(endptr =3D=3D str + 20);
> +    g_assert(endptr =3D=3D str + 10);
>=20
>     str =3D "20E";
>     err =3D qemu_strtosz(str, &endptr, &res);
> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index 09b0ae3c68..fad941fcb8 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -383,59 +383,26 @@ static void test_keyval_visit_size(void)
>     visit_end_struct(v, NULL);
>     visit_free(v);
>=20
> -    /* Note: precision is 53 bits since we're parsing with strtod() */
> +    /* Note: precision is 64 bits (UINT64_MAX) */
>=20
> -    /* Around limit of precision: 2^53-1, 2^53, 2^53+1 */
> -    qdict =3D keyval_parse("sz1=3D9007199254740991,"
> -                         "sz2=3D9007199254740992,"
> -                         "sz3=3D9007199254740993",
> +    /* Around limit of precision: UINT64_MAX - 1, UINT64_MAX */
> +    qdict =3D keyval_parse("sz1=3D18446744073709551614,"
> +                         "sz2=3D18446744073709551615",
>                          NULL, &error_abort);
>     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
>     qobject_unref(qdict);
>     visit_start_struct(v, NULL, NULL, 0, &error_abort);
>     visit_type_size(v, "sz1", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0x1fffffffffffff);
> +    g_assert_cmphex(sz, =3D=3D, 0xfffffffffffffffe);
>     visit_type_size(v, "sz2", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0x20000000000000);
> -    visit_type_size(v, "sz3", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0x20000000000000);
> -    visit_check_struct(v, &error_abort);
> -    visit_end_struct(v, NULL);
> -    visit_free(v);
> -
> -    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
> -    qdict =3D keyval_parse("sz1=3D9223372036854774784," /* 7ffffffffffff=
c00 */
> -                         "sz2=3D9223372036854775295", /* 7ffffffffffffdf=
f */
> -                         NULL, &error_abort);
> -    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> -    qobject_unref(qdict);
> -    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> -    visit_type_size(v, "sz1", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0x7ffffffffffffc00);
> -    visit_type_size(v, "sz2", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0x7ffffffffffffc00);
> -    visit_check_struct(v, &error_abort);
> -    visit_end_struct(v, NULL);
> -    visit_free(v);
> -
> -    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
> -    qdict =3D keyval_parse("sz1=3D18446744073709549568," /* ffffffffffff=
f800 */
> -                         "sz2=3D18446744073709550591", /* fffffffffffffb=
ff */
> -                         NULL, &error_abort);
> -    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> -    qobject_unref(qdict);
> -    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> -    visit_type_size(v, "sz1", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0xfffffffffffff800);
> -    visit_type_size(v, "sz2", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 0xfffffffffffff800);
> +    g_assert_cmphex(sz, =3D=3D, 0xffffffffffffffff);
>     visit_check_struct(v, &error_abort);
>     visit_end_struct(v, NULL);
>     visit_free(v);
>=20
>     /* Beyond limits */
>     qdict =3D keyval_parse("sz1=3D-1,"
> -                         "sz2=3D18446744073709550592", /* fffffffffffffc=
00 */
> +                         "sz2=3D18446744073709551616", /* 2^64 */
>                          NULL, &error_abort);
>     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
>     qobject_unref(qdict);
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index ef96e84aed..3a8b8c0168 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -650,50 +650,25 @@ static void test_opts_parse_size(void)
>     g_assert_cmpuint(opts_count(opts), =3D=3D, 1);
>     g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), =3D=3D, 0);
>=20
> -    /* Note: precision is 53 bits since we're parsing with strtod() */
> +    /* Note: precision is 64 bits (UINT64_MAX) */
>=20
> -    /* Around limit of precision: 2^53-1, 2^53, 2^54 */
> +    /* Around limit of precision: UINT64_MAX - 1, UINT64_MAX */
>     opts =3D qemu_opts_parse(&opts_list_02,
> -                           "size1=3D9007199254740991,"
> -                           "size2=3D9007199254740992,"
> -                           "size3=3D9007199254740993",
> -                           false, &error_abort);
> -    g_assert_cmpuint(opts_count(opts), =3D=3D, 3);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
> -                     =3D=3D, 0x1fffffffffffff);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 1),
> -                     =3D=3D, 0x20000000000000);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 1),
> -                     =3D=3D, 0x20000000000000);
> -
> -    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
> -    opts =3D qemu_opts_parse(&opts_list_02,
> -                           "size1=3D9223372036854774784," /* 7ffffffffff=
ffc00 */
> -                           "size2=3D9223372036854775295", /* 7ffffffffff=
ffdff */
> -                           false, &error_abort);
> -    g_assert_cmpuint(opts_count(opts), =3D=3D, 2);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
> -                     =3D=3D, 0x7ffffffffffffc00);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 1),
> -                     =3D=3D, 0x7ffffffffffffc00);
> -
> -    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
> -    opts =3D qemu_opts_parse(&opts_list_02,
> -                           "size1=3D18446744073709549568," /* ffffffffff=
fff800 */
> -                           "size2=3D18446744073709550591", /* ffffffffff=
fffbff */
> +                           "size1=3D18446744073709551614,"
> +                           "size2=3D18446744073709551615",
>                            false, &error_abort);
>     g_assert_cmpuint(opts_count(opts), =3D=3D, 2);
>     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
> -                     =3D=3D, 0xfffffffffffff800);
> +                     =3D=3D, 0xfffffffffffffffe);
>     g_assert_cmphex(qemu_opt_get_size(opts, "size2", 1),
> -                     =3D=3D, 0xfffffffffffff800);
> +                     =3D=3D, 0xffffffffffffffff);
>=20
>     /* Beyond limits */
>     opts =3D qemu_opts_parse(&opts_list_02, "size1=3D-1", false, &err);
>     error_free_or_abort(&err);
>     g_assert(!opts);
>     opts =3D qemu_opts_parse(&opts_list_02,
> -                           "size1=3D18446744073709550592", /* ffffffffff=
fffc00 */
> +                           "size1=3D18446744073709551616", /* 2^64 */
>                            false, &err);
>     error_free_or_abort(&err);
>     g_assert(!opts);
> diff --git a/util/cutils.c b/util/cutils.c
> index 77acadc70a..7c94ff2f0b 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -212,19 +212,39 @@ static int do_strtosz(const char *nptr, const char =
**end,
>                       const char default_suffix, int64_t unit,
>                       uint64_t *result)
> {
> -    int retval;
> -    const char *endptr;
> +    int retval, retd, retu;
> +    const char *endptr, *suffixd, *suffixu;
>     unsigned char c;
>     int mul_required =3D 0;
> -    double val, mul, integral, fraction;
> +    bool use_strtod;
> +    uint64_t valu;
> +    int64_t mul;
> +    double vald, integral, fraction;
> +
> +    /*
> +     * Parse @nptr both as a double and as a uint64_t, then use the meth=
od
> +     * which consumes more characters.
> +     */

Why do ever need to parse as double if you have uint64?

> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);

You could simply compare suffixd and suffixu:

use_strtod =3D suffixd > suffixu;

> +
> +    if (use_strtod) {
> +        endptr =3D suffixd;
> +        retval =3D retd;
> +    } else {
> +        endptr =3D suffixu;
> +        retval =3D retu;
> +    }
>=20
> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>     if (retval) {
>         goto out;
>     }
> -    fraction =3D modf(val, &integral);
> -    if (fraction !=3D 0) {
> -        mul_required =3D 1;
> +    if (use_strtod) {
> +        fraction =3D modf(vald, &integral);
> +        if (fraction !=3D 0) {
> +            mul_required =3D 1;
> +        }
>     }
>     c =3D *endptr;
>     mul =3D suffix_mul(c, unit);
> @@ -238,17 +258,30 @@ static int do_strtosz(const char *nptr, const char =
**end,
>         retval =3D -EINVAL;
>         goto out;
>     }
> -    /*
> -     * Values near UINT64_MAX overflow to 2**64 when converting to doubl=
e
> -     * precision.  Compare against the maximum representable double prec=
ision
> -     * value below 2**64, computed as "the next value after 2**64 (0x1p6=
4) in
> -     * the direction of 0".
> -     */
> -    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
> -        retval =3D -ERANGE;
> -        goto out;
> +
> +    if (use_strtod) {
> +        /*
> +         * Values near UINT64_MAX overflow to 2**64 when converting to d=
ouble
> +         * precision. Compare against the maximum representable double p=
recision
> +         * value below 2**64, computed as "the next value after 2**64 (0=
x1p64)
> +         * in the direction of 0".
> +         */
> +        if ((vald * mul > nextafter(0x1p64, 0)) || vald < 0) {
> +            retval =3D -ERANGE;
> +            goto out;
> +        }
> +        *result =3D vald * mul;
> +    } else {
> +        /* Reject negative input and overflow output */
> +        while (qemu_isspace(*nptr)) {
> +            nptr++;
> +        }
> +        if (*nptr =3D=3D '-' || UINT64_MAX / mul < valu) {
> +            retval =3D -ERANGE;
> +            goto out;
> +        }
> +        *result =3D valu * mul;
>     }
> -    *result =3D val * mul;
>     retval =3D 0;
>=20
> out:
> --=20
> 2.20.1
>=20
>=20


