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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089FE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Lqz+b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089FE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsvd-00089X-6y
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrNi-0007j7-VB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrNh-0005WE-2N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDrNg-0005L2-Pm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id t2so11626094wrx.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kukfon5TaR/JRHFnX48GSK2ov1UKVe7Azn6CQLvNDVQ=;
 b=q6Lqz+b3Y8xm/gfLr/lsdUb/Jr30XtFcXlUea69EGgLVqEKH8cinUfBj7X0Bdq9bQw
 bNLeHY19Vo6j4F8THMcrU4pydxWWbdgqp4NnfRCq3p8tvUEBeXRXH19Yq/XW6QliiobW
 u5FLKppxFPHLv+EBkcKU0/G11VGKaTKQtFK4KsEAj5zaBWAtfwNwLPcg0N0cl4/nVv1t
 5lgVCiDMMLkB/NuMJ83TQPdI9MCrsTEQIqpN4dTqJ0uPqMQ7HuEY+TdE8kY+grWMj7OH
 gQ3TCAPARS+ed4kG22CbjVdbQtCJ7tdh2d9vTqpU2BN8U23jQGygUI2L+qCjs7b8DVg5
 l6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kukfon5TaR/JRHFnX48GSK2ov1UKVe7Azn6CQLvNDVQ=;
 b=r9D5jmS7mSaknaaiszSBHmmr37uXueOpn+DdFjB/wAj/Z0Gk7ZnUvGL9da94hzR5wA
 tmwRUnzjof4BY1MM7Vcd+OLQ6tts702uz8gs4pYMZDxrsWH6SaB1TyoH0d63/6N2qK61
 DvXl9aMxhtUGkgEYQpPz2o9gBwWbi6fskGunJuQiAJrjvPwZ+jsjMYx8/DPC3Dtz5g3+
 nWKwDh3SQy6uNyiZVJwpNKIVb4gsM96y6hTkeKZBRNM8eK3elJgK5/8EhKvWIygB6nn4
 phGRhaX5NT5ScqlVzhwb/pLEk3VnOAslmuGrPUZqL1XNKlSSDAnO94d/nK8jV04yeLUx
 TepQ==
X-Gm-Message-State: ANhLgQ0jDbdZvdiqZnXiLFlgkdsI6CCcXwcpY1cyPlDebI4ZYV1wTWr3
 e0KJQbUcbM1zn4rSFZiIIZSF0MIuRx84kdfCWXE=
X-Google-Smtp-Source: ADFU+vtTYs87v3rZSR++BCmLoLqnQlDQQ55P3Gw8PxnfAciZ7x4teKcplErC/XBMER1PqBboE53HG55snZOjnlswRZg=
X-Received: by 2002:a05:6000:4a:: with SMTP id
 k10mr34789107wrx.381.1584371415577; 
 Mon, 16 Mar 2020 08:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-8-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 16:10:03 +0100
Message-ID: <CAJ+F1CJk+tP33rkRd=qEToXQUTZNRhYOVkxN_2DZit0uXRAp_A@mail.gmail.com>
Subject: Re: [PATCH v3 07/34] tests/test-qmp-cmds: Simplify test data setup
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
> Building requests with qdict_put() & friends is tedious to write and
> hard to read.  Parse them from string literals with
> qdict_from_vjsonf_nofail() instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

& fixes the leak introduced in patch 5.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qmp-cmds.c | 93 ++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 55 deletions(-)
>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 464b370189..99013ff37b 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/error.h"
> @@ -145,11 +146,16 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org=
_qemu_x_EnumList *a,
>  }
>
>
> -static QObject *do_qmp_dispatch(QDict *req, bool allow_oob)
> +static QObject *do_qmp_dispatch(bool allow_oob, const char *template, ..=
.)
>  {
> -    QDict *resp;
> +    va_list ap;
> +    QDict *req, *resp;
>      QObject *ret;
>
> +    va_start(ap, template);
> +    req =3D qdict_from_vjsonf_nofail(template, ap);
> +    va_end(ap);
> +
>      resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
>      g_assert(resp);
>      ret =3D qdict_get(resp, "return");
> @@ -158,14 +164,21 @@ static QObject *do_qmp_dispatch(QDict *req, bool al=
low_oob)
>
>      qobject_ref(ret);
>      qobject_unref(resp);
> +    qobject_unref(req);
>      return ret;
>  }
>
> -static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass=
 cls)
> +static void do_qmp_dispatch_error(bool allow_oob, ErrorClass cls,
> +                                  const char *template, ...)
>  {
> -    QDict *resp;
> +    va_list ap;
> +    QDict *req, *resp;
>      QDict *error;
>
> +    va_start(ap, template);
> +    req =3D qdict_from_vjsonf_nofail(template, ap);
> +    va_end(ap);
> +
>      resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
>      g_assert(resp);
>      error =3D qdict_get_qdict(resp, "error");
> @@ -177,59 +190,43 @@ static void do_qmp_dispatch_error(QDict *req, bool =
allow_oob, ErrorClass cls)
>      g_assert(qdict_size(resp) =3D=3D 1);
>
>      qobject_unref(resp);
> +    qobject_unref(req);
>  }
>
>  /* test commands with no input and no return value */
>  static void test_dispatch_cmd(void)
>  {
> -    QDict *req =3D qdict_new();
>      QDict *ret;
>
> -    qdict_put_str(req, "execute", "user_def_cmd");
> -
> -    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
> +    ret =3D qobject_to(QDict,
> +                     do_qmp_dispatch(false,
> +                                     "{ 'execute': 'user_def_cmd' }"));
>      assert(ret && qdict_size(ret) =3D=3D 0);
> -
>      qobject_unref(ret);
> -    qobject_unref(req);
>  }
>
>  static void test_dispatch_cmd_oob(void)
>  {
> -    QDict *req =3D qdict_new();
>      QDict *ret;
>
> -    qdict_put_str(req, "exec-oob", "test-flags-command");
> -
> -    ret =3D qobject_to(QDict, do_qmp_dispatch(req, true));
> +    ret =3D qobject_to(QDict,
> +                     do_qmp_dispatch(true,
> +                                     "{ 'exec-oob': 'test-flags-command'=
 }"));
>      assert(ret && qdict_size(ret) =3D=3D 0);
> -
>      qobject_unref(ret);
> -    qobject_unref(req);
>  }
>
>  /* test commands that return an error due to invalid parameters */
>  static void test_dispatch_cmd_failure(void)
>  {
> -    QDict *req =3D qdict_new();
> -    QDict *args =3D qdict_new();
> -
> -    qdict_put_str(req, "execute", "user_def_cmd2");
> -
> -    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
> -
> -    qobject_unref(req);
> -
> -    /* check that with extra arguments it throws an error */
> -    req =3D qdict_new();
> -    qdict_put_int(args, "a", 66);
> -    qdict_put(req, "arguments", args);
> -
> -    qdict_put_str(req, "execute", "user_def_cmd");
> -
> -    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
> -
> -    qobject_unref(req);
> +    /* missing arguments */
> +    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR,
> +                          "{ 'execute': 'user_def_cmd2' }");
> +
> +    /* extra arguments */
> +    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR,
> +                          "{ 'execute': 'user_def_cmd',"
> +                          " 'arguments': { 'a': 66 } }");
>  }
>
>  static void test_dispatch_cmd_success_response(void)
> @@ -246,26 +243,15 @@ static void test_dispatch_cmd_success_response(void=
)
>  /* test commands that involve both input parameters and return values */
>  static void test_dispatch_cmd_io(void)
>  {
> -    QDict *req =3D qdict_new();
> -    QDict *args =3D qdict_new();
> -    QDict *args3 =3D qdict_new();
> -    QDict *ud1a =3D qdict_new();
> -    QDict *ud1b =3D qdict_new();
>      QDict *ret, *ret_dict, *ret_dict_dict, *ret_dict_dict_userdef;
>      QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
>      QNum *ret3;
>      int64_t val;
>
> -    qdict_put_int(ud1a, "integer", 42);
> -    qdict_put_str(ud1a, "string", "hello");
> -    qdict_put_int(ud1b, "integer", 422);
> -    qdict_put_str(ud1b, "string", "hello2");
> -    qdict_put(args, "ud1a", ud1a);
> -    qdict_put(args, "ud1b", ud1b);
> -    qdict_put(req, "arguments", args);
> -    qdict_put_str(req, "execute", "user_def_cmd2");
> -
> -    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false,
> +        "{ 'execute': 'user_def_cmd2', 'arguments': {"
> +        " 'ud1a': { 'integer': 42, 'string': 'hello' },"
> +        " 'ud1b': { 'integer': 422, 'string': 'hello2' } } }"));
>
>      assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
>      ret_dict =3D qdict_get_qdict(ret, "dict1");
> @@ -282,11 +268,8 @@ static void test_dispatch_cmd_io(void)
>      assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
>      qobject_unref(ret);
>
> -    qdict_put_int(args3, "a", 66);
> -    qdict_put(req, "arguments", args3);
> -    qdict_put_str(req, "execute", "guest-get-time");
> -
> -    ret3 =3D qobject_to(QNum, do_qmp_dispatch(req, false));
> +    ret3 =3D qobject_to(QNum, do_qmp_dispatch(false,
> +        "{ 'execute': 'guest-get-time', 'arguments': { 'a': 66 } }"));
>      g_assert(qnum_get_try_int(ret3, &val));
>      g_assert_cmpint(val, =3D=3D, 66);
>      qobject_unref(ret3);
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

