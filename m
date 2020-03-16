Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8AC20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV5o8BbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtRf-0000Ss-0G
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrKU-0006Wp-2s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrKS-0005G6-9p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:06:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDrKR-00059L-Vq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:06:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id z12so9286167wmf.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RfBdw+Jc8iPllu/VVvwpOGuYiaEoYwZ5FKDfts2LRdY=;
 b=GV5o8BbPmveR2NgSfn4JrLQmvPaUFvlI2b3P0ZCi5ib8Q/cfzHmrJ7shE+6+cAHrLx
 VAHYw6GIvRYjc5ktj/8SQKWOpzajYB8GkJyNCYvieCjEOEoQvqAEYD1otMFanWJzw7EK
 p5arASQf3eC6t0b4L2pHwgH0W5TbKpls998MeJUUONgd/LrVBBLATDzKoGGNHX3A61Lc
 VHUlJUltnGM/p/562Uggv3y3ZXSMgD7p9kosv4rvZwkLQ1KRH5bPuqPZkugGUWODq1z4
 mSwDoIOhmEvcmr/IRzeg34ozDtFbhwjLvVcyMolqFIZHc9wXOHmUcJjPvuBLtuCNO6Pj
 IZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RfBdw+Jc8iPllu/VVvwpOGuYiaEoYwZ5FKDfts2LRdY=;
 b=Gw7GS1H0T6hXpRrkclEd1oUAn8Uk/273t6dFnbHgdhf+rqBEXDCCJqcB4Ou2mkPNin
 1PuhidxKKSHwxI/bESZqx8mfSJX8du+oFFiwvkPPiZFnWBR60MDVB3LHWepc+oZwC2/K
 N/3HVffmwAfethxf1KZMyDJdZZ00CW1sBkDxbzGkty5BL6IO7W9sNcmAwD5D+JHfjJ6T
 bbg4j6d6BQVFKUBsfpl6pcA7YzayPSYiprCdhFRHRxwmzJ0ESwHYrXyg2k1xCi3GrSen
 nP3IhmP8Pb56apbc/VhJxcBjZLpudESBTxvgAqAYBiTIJ5mANoM5Azq7vLo9g/Hnz3L/
 KVUQ==
X-Gm-Message-State: ANhLgQ0QvsEYJ6fNNnN20rEKxyL9o8dPTbuycB4eBajYL1nrK2qV8pVF
 BbaXaIjUqIzNy/MmSvwyoL3uQI4nLLX1i6CH4Ck=
X-Google-Smtp-Source: ADFU+vsb0tn4pVgO62n9o0Ny4Q3vNqDo0MCT0X0GPDABAmn4BRWSOZ1rhraPYuu0tPKkcTnpQR7sqP8+9fPOSCXnAjc=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr27093043wmi.37.1584371214779; 
 Mon, 16 Mar 2020 08:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-6-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-6-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 16:06:41 +0100
Message-ID: <CAJ+F1C+c+d3WRPLmBsLm73k4dESHCC-czUe9ME4okQsyynSvuw@mail.gmail.com>
Subject: Re: [PATCH v3 05/34] tests/test-qmp-cmds: Factor out qmp_dispatch()
 test helpers
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Hi

On Sun, Mar 15, 2020 at 3:48 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Checking the value of qmp_dispatch() is repetitive.  Factor out
> helpers do_qmp_dispatch() and do_qmp_dispatch_error().  Without this,
> the next commit would make things even more repetitive.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qmp-cmds.c | 72 +++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 37 deletions(-)

ASAN is unhappy:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D1870336=3D=3DERROR: LeakSanitizer: detected memory leaks

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de56=
)
    #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
    #2 0x560213f56dbb in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:238
    #3 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de56=
)
    #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
    #2 0x560213f56dd3 in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:240
    #3 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 55 byte(s) in 2 object(s) allocated from:
    #0 0x7fcdc9b8bc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc58=
)
    #1 0x7fcdc998e358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)
    #2 0x560213fbf065 in qstring_from_str
/home/elmarco/src/qemu/qobject/qstring.c:66
    #3 0x560213fc151a in qdict_put_str
/home/elmarco/src/qemu/qobject/qdict.c:143
    #4 0x560213f5747f in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:276
    #5 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de56=
)
    #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
    #2 0x560213fc0ee4 in qdict_put_obj
/home/elmarco/src/qemu/qobject/qdict.c:125
    #3 0x560213f56fca in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:254
    #4 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de56=
)
    #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
    #2 0x560213fc0ee4 in qdict_put_obj
/home/elmarco/src/qemu/qobject/qdict.c:125
    #3 0x560213fc147e in qdict_put_int
/home/elmarco/src/qemu/qobject/qdict.c:133
    #4 0x560213f573ea in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:274
    #5 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8bc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc58=
)
    #1 0x7fcdc998e358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)
    #2 0x560213fc1428 in qdict_put_int
/home/elmarco/src/qemu/qobject/qdict.c:133
    #3 0x560213f573ea in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:274
    #4 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de56=
)
    #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
    #2 0x560213fc0ee4 in qdict_put_obj
/home/elmarco/src/qemu/qobject/qdict.c:125
    #3 0x560213fc1570 in qdict_put_str
/home/elmarco/src/qemu/qobject/qdict.c:143
    #4 0x560213f56fe7 in test_dispatch_cmd_io
/home/elmarco/src/qemu/tests/test-qmp-cmds.c:255
    #5 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)

Indirect leak of 20 byte(s) in 3 object(s) allocated from:
    #0 0x7fcdc9b8bc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc58=
)
    #1 0x7fcdc998e358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)


>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 79507d9e54..b31064b064 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -145,34 +145,55 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org=
_qemu_x_EnumList *a,
>  }
>
>
> +static QObject *do_qmp_dispatch(QDict *req, bool allow_oob)
> +{
> +    QDict *resp;
> +    QObject *ret;
> +
> +    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
> +    g_assert(resp && !qdict_haskey(resp, "error"));
> +    ret =3D qdict_get(resp, "return");
> +    g_assert(ret);
> +
> +    qobject_ref(ret);
> +    qobject_unref(resp);
> +    return ret;
> +}
> +
> +static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass=
 cls)
> +{
> +    QDict *resp;
> +
> +    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
> +    g_assert(resp && qdict_haskey(resp, "error"));
> +
> +    qobject_unref(resp);
> +}
> +
>  /* test commands with no input and no return value */
>  static void test_dispatch_cmd(void)
>  {
>      QDict *req =3D qdict_new();
> -    QDict *resp;
> +    QObject *ret;
>
>      qdict_put_str(req, "execute", "user_def_cmd");
>
> -    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
> -    assert(resp !=3D NULL);
> -    assert(!qdict_haskey(resp, "error"));
> +    ret =3D do_qmp_dispatch(req, false);
>
> -    qobject_unref(resp);
> +    qobject_unref(ret);
>      qobject_unref(req);
>  }
>
>  static void test_dispatch_cmd_oob(void)
>  {
>      QDict *req =3D qdict_new();
> -    QDict *resp;
> +    QObject *ret;
>
>      qdict_put_str(req, "exec-oob", "test-flags-command");
>
> -    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), true);
> -    assert(resp !=3D NULL);
> -    assert(!qdict_haskey(resp, "error"));
> +    ret =3D do_qmp_dispatch(req, true);
>
> -    qobject_unref(resp);
> +    qobject_unref(ret);
>      qobject_unref(req);
>  }
>
> @@ -181,15 +202,11 @@ static void test_dispatch_cmd_failure(void)
>  {
>      QDict *req =3D qdict_new();
>      QDict *args =3D qdict_new();
> -    QDict *resp;
>
>      qdict_put_str(req, "execute", "user_def_cmd2");
>
> -    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
> -    assert(resp !=3D NULL);
> -    assert(qdict_haskey(resp, "error"));
> +    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
>
> -    qobject_unref(resp);
>      qobject_unref(req);
>
>      /* check that with extra arguments it throws an error */
> @@ -199,11 +216,8 @@ static void test_dispatch_cmd_failure(void)
>
>      qdict_put_str(req, "execute", "user_def_cmd");
>
> -    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
> -    assert(resp !=3D NULL);
> -    assert(qdict_haskey(resp, "error"));
> +    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
>
> -    qobject_unref(resp);
>      qobject_unref(req);
>  }
>
> @@ -218,20 +232,6 @@ static void test_dispatch_cmd_success_response(void)
>      qobject_unref(req);
>  }
>
> -static QObject *test_qmp_dispatch(QDict *req)
> -{
> -    QDict *resp;
> -    QObject *ret;
> -
> -    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
> -    assert(resp && !qdict_haskey(resp, "error"));
> -    ret =3D qdict_get(resp, "return");
> -    assert(ret);
> -    qobject_ref(ret);
> -    qobject_unref(resp);
> -    return ret;
> -}
> -
>  /* test commands that involve both input parameters and return values */
>  static void test_dispatch_cmd_io(void)
>  {
> @@ -254,7 +254,7 @@ static void test_dispatch_cmd_io(void)
>      qdict_put(req, "arguments", args);
>      qdict_put_str(req, "execute", "user_def_cmd2");
>
> -    ret =3D qobject_to(QDict, test_qmp_dispatch(req));
> +    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
>
>      assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
>      ret_dict =3D qdict_get_qdict(ret, "dict1");
> @@ -275,12 +275,10 @@ static void test_dispatch_cmd_io(void)
>      qdict_put(req, "arguments", args3);
>      qdict_put_str(req, "execute", "guest-get-time");
>
> -    ret3 =3D qobject_to(QNum, test_qmp_dispatch(req));
> +    ret3 =3D qobject_to(QNum, do_qmp_dispatch(req, false));
>      g_assert(qnum_get_try_int(ret3, &val));
>      g_assert_cmpint(val, =3D=3D, 66);
>      qobject_unref(ret3);
> -
> -    qobject_unref(req);
>  }
>
>  /* test generated dealloc functions for generated types */
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

