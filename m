Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E372C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB72520409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QagQRrJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB72520409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtTi-0004DJ-30
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrPG-0008TX-U9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrPF-0003V0-GG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDrPF-0003MO-8R
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id 25so18081371wmk.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9IVBUdikDm11L9fCTpSgxrTnLXOrniaS4l7ApCDWwiM=;
 b=QagQRrJTXf13LOdzwMvP23vXAKqb0Yaxtq14QnMR1CfE2LIOTwwDAzmK5C3apJC3Q+
 41Y0UZrqQaU0squaFrwrCIQUAbKa+QLoBenisCa5IzCVlKMuapXw0tNnQfsWTAN7FuCC
 UO5FKVaAEMmqdCS3lCXUzIbOMpPNS563DyNtTzHZ3BsolY5dnhPf4rKjNLJulaPM0xAz
 IY3aUm8/VAJ1rCxGaHD73422PC3UUx6iNNYGnInMO1FQlixbnnRrlWnvmIhb2m2yQxjn
 +xmjbrMJXPKD91ExuRlxMtC4PsgOiRemJsCEqGqF76U3iZqReoXzZlBg8pNxwnFuanyJ
 aBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9IVBUdikDm11L9fCTpSgxrTnLXOrniaS4l7ApCDWwiM=;
 b=IWsXaAwS0qOD0eu+HOHV5/MzpC9Ue2eOva6bWsUfn8wOb2s7gm+0/3SwG0u6ydsuBg
 Gft7QMdzwHWjHHgLIVQBBHd0Dq5jPY4pdh/Xtz6h0X8Pey/Nv5yV9wKhGb9dXjNqQ2mb
 0IQ/WCuSniAnzRA7FoSMvyvHzayw1gOb161YZdEOiWlU9djbSXCPCJcyXBhokIBAqH0h
 x0r9den3QPrKJ7z0zoQnKZD6odfr8TZmixH3CAkO15gjQRzzEtEnPhrJaXD53C7VUPZw
 HG8UTSZ9z8/5lUEdR3F1Gb7VfVg0PX4z67tVYPDkcEbYWzVtGPd6FLkCniejrDMezWPP
 2D8A==
X-Gm-Message-State: ANhLgQ2LbSeEPSNRb2t1qXFiRrFMPwc+YlUDh60zV6JNytxkTo3JGlgD
 +BYdfz+gP6CYHGxGUWlBuGiwFZj0Gs1hMF3kgivdaUodT7Y=
X-Google-Smtp-Source: ADFU+vtNyG3llodxrAJAENFuYCGIfP1ScmpIWlntoIuJfZHLr9W/4s4Wa90PuN8Sy316MIdg8FsIHkgntkfB7I0Uxf0=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr29121339wmf.4.1584371512102; 
 Mon, 16 Mar 2020 08:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-9-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 16:11:39 +0100
Message-ID: <CAJ+F1C+CPtk+f58kLbOoWGWR6+_5EqzdS_Bv4hLj5eARdR2y0A@mail.gmail.com>
Subject: Re: [PATCH v3 08/34] tests/test-qmp-event: Simplify test data setup
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 3:55 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Building expected data with qdict_put() & friends is tedious to write
> and hard to read.  Parse them from string literals with
> qdict_from_jsonf_nofail() instead.
>
> While there, use initializers instead of assignments for initializing
> aggregate event arguments.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qmp-event.c | 93 ++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 66 deletions(-)
>
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index eee7e08ab6..430001e622 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -17,6 +17,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qmp-event.h"
> @@ -124,17 +125,13 @@ static void event_prepare(TestEventData *data,
>      /* Global variable test_event_data was used to pass the expectation,=
 so
>         test cases can't be executed at same time. */
>      g_mutex_lock(&test_event_lock);
> -
> -    data->expect =3D qdict_new();
>      test_event_data =3D data;
>  }
>
>  static void event_teardown(TestEventData *data,
>                             const void *unused)
>  {
> -    qobject_unref(data->expect);
>      test_event_data =3D NULL;
> -
>      g_mutex_unlock(&test_event_lock);
>  }
>
> @@ -152,90 +149,54 @@ static void event_test_add(const char *testpath,
>  static void test_event_a(TestEventData *data,
>                           const void *unused)
>  {
> -    QDict *d;
> -    d =3D data->expect;
> -    qdict_put_str(d, "event", "EVENT_A");
> +    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
>      qapi_event_send_event_a();
> +    qobject_unref(data->expect);
>  }
>
>  static void test_event_b(TestEventData *data,
>                           const void *unused)
>  {
> -    QDict *d;
> -    d =3D data->expect;
> -    qdict_put_str(d, "event", "EVENT_B");
> +    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
>      qapi_event_send_event_b();
> +    qobject_unref(data->expect);
>  }
>
>  static void test_event_c(TestEventData *data,
>                           const void *unused)
>  {
> -    QDict *d, *d_data, *d_b;
> -
> -    UserDefOne b;
> -    b.integer =3D 2;
> -    b.string =3D g_strdup("test1");
> -    b.has_enum1 =3D false;
> -
> -    d_b =3D qdict_new();
> -    qdict_put_int(d_b, "integer", 2);
> -    qdict_put_str(d_b, "string", "test1");
> -
> -    d_data =3D qdict_new();
> -    qdict_put_int(d_data, "a", 1);
> -    qdict_put(d_data, "b", d_b);
> -    qdict_put_str(d_data, "c", "test2");
> -
> -    d =3D data->expect;
> -    qdict_put_str(d, "event", "EVENT_C");
> -    qdict_put(d, "data", d_data);
> +    UserDefOne b =3D { .integer =3D 2, .string =3D (char *)"test1" };
>
> +    data->expect =3D qdict_from_jsonf_nofail(
> +        "{ 'event': 'EVENT_C', 'data': {"
> +        " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2'=
 } }");
>      qapi_event_send_event_c(true, 1, true, &b, "test2");
> -
> -    g_free(b.string);
> +    qobject_unref(data->expect);
>  }
>
>  /* Complex type */
>  static void test_event_d(TestEventData *data,
>                           const void *unused)
>  {
> -    UserDefOne struct1;
> -    EventStructOne a;
> -    QDict *d, *d_data, *d_a, *d_struct1;
> -
> -    struct1.integer =3D 2;
> -    struct1.string =3D g_strdup("test1");
> -    struct1.has_enum1 =3D true;
> -    struct1.enum1 =3D ENUM_ONE_VALUE1;
> -
> -    a.struct1 =3D &struct1;
> -    a.string =3D g_strdup("test2");
> -    a.has_enum2 =3D true;
> -    a.enum2 =3D ENUM_ONE_VALUE2;
> -
> -    d_struct1 =3D qdict_new();
> -    qdict_put_int(d_struct1, "integer", 2);
> -    qdict_put_str(d_struct1, "string", "test1");
> -    qdict_put_str(d_struct1, "enum1", "value1");
> -
> -    d_a =3D qdict_new();
> -    qdict_put(d_a, "struct1", d_struct1);
> -    qdict_put_str(d_a, "string", "test2");
> -    qdict_put_str(d_a, "enum2", "value2");
> -
> -    d_data =3D qdict_new();
> -    qdict_put(d_data, "a", d_a);
> -    qdict_put_str(d_data, "b", "test3");
> -    qdict_put_str(d_data, "enum3", "value3");
> -
> -    d =3D data->expect;
> -    qdict_put_str(d, "event", "EVENT_D");
> -    qdict_put(d, "data", d_data);
> +    UserDefOne struct1 =3D {
> +        .integer =3D 2, .string =3D (char *)"test1",
> +        .has_enum1 =3D true, .enum1 =3D ENUM_ONE_VALUE1,
> +    };
> +    EventStructOne a =3D {
> +        .struct1 =3D &struct1,
> +        .string =3D (char *)"test2",
> +        .has_enum2 =3D true,
> +        .enum2 =3D ENUM_ONE_VALUE2,
> +    };
>
> +    data->expect =3D qdict_from_jsonf_nofail(
> +        "{ 'event': 'EVENT_D', 'data': {"
> +        " 'a': {"
> +        "  'struct1': { 'integer': 2, 'string': 'test1', 'enum1': 'value=
1' },"
> +        "  'string': 'test2', 'enum2': 'value2' },"
> +        " 'b': 'test3', 'enum3': 'value3' } }");
>      qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VAL=
UE3);
> -
> -    g_free(struct1.string);
> -    g_free(a.string);
> +    qobject_unref(data->expect);
>  }
>
>  int main(int argc, char **argv)
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

