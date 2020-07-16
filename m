Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41722C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8B52070E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2FnTVNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8B52070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxep-0001KF-9s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvxcp-00083V-AF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:44:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvxcn-00085i-Fg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:44:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id 95so3390412otw.10
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gOuZKQXOIDviakryJwdKxW0yLjwEJWL/CqkfBpJdPSU=;
 b=l2FnTVNuONeJEX4jYIz+K/TiFLf6kpJDCNudh7P25/MOQvsWXszkpS3iUWP43aQAUR
 WdavSy/RujUZzOBhTbkf0HrDppfW4QmrefZxwlibVs6sToQGGT60OkUSVnMpeIEIVQWM
 MmlnWK+C7xqV7LtOq80qTjg4eCgDnDgIOefMCNyDS1VyuJL+Z0o4+EIkmZUXczmxrK/s
 zzlqqzIZKO6L4GywZf/Zzji/NU1N2+c7n1Mm+Xa/84G6+OBlm5psjIQkbY+/PjN4wb3F
 Ccg5ppyu5DhACyiSd5K6mPsoWn+9i0ss42tEWYf14+Osd4tZ4D1EZ7DBLvTSLl5HFOfC
 Fxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gOuZKQXOIDviakryJwdKxW0yLjwEJWL/CqkfBpJdPSU=;
 b=Jt+z2nVqq72aOwKH7wCPcPrycwb1aXyI492pjyiPJq9T5bNIIsT/niNiEbmAoh6j0g
 mUjKlL7Edp00KtqH7s2C/OHzN7nxNQkUzRnGPhMa88nBI6TBhGT1FNGFoP908lWIZNfh
 WMxz4OjSwYyqvxXaQo5ykL5W1HGJKS64J28+jc4xwrN34wCX+qnev0xBFeKLvI0brYrT
 nSYpye+gySuRMDO7ZHMG2CBCevqfYXfxKQPbC/eHlx64T9D/b4KH8g4UuJfObQrVMabd
 oaWcatPjW3aFWAjlQMaEbOkw2OhZqD4PlxwAypp4xo3+/jXJ3oHsm1uHcWvko4B5Do4q
 IrcA==
X-Gm-Message-State: AOAM530CXh8d+h7QK6mlqZMpAr+ExArqzClbM1lkZllwxCPPMkSlmfs0
 x0mxufXR0J4OPPefF+rbmswovH3yylDt7Kw379I=
X-Google-Smtp-Source: ABdhPJzkvmMx2Bx29AUfphTYhfldLMakheynnIKSR39V1sNG/uTeMAn5npaUC2OwQbTez2fpTHwX95tIVYV9AWBFVVk=
X-Received: by 2002:a9d:787:: with SMTP id 7mr3044151oto.333.1594881848131;
 Wed, 15 Jul 2020 23:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200715154117.15456-1-liq3ea@163.com>
 <874kq8roev.fsf@dusky.pond.sub.org>
In-Reply-To: <874kq8roev.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 16 Jul 2020 14:43:31 +0800
Message-ID: <CAKXe6S+CvQ1rmnWXi2_=kiCF4yG-2T3iPut=51G25qwL+oO2Pw@mail.gmail.com>
Subject: Re: [PATCH v2] tests: qmp-cmd-test: fix memory leak
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Li Qiang <liq3ea@163.com> writes:
>
> > Properly free each test response to avoid memory leak and separate
> > qtest_qmp() calls with spare lines, in a consistent manner.
> >
> > Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
> > qmp/object-add-failure-modes"
>
> The patch also fixes leaks introduced in 442b09b83d and 9fc719b869,
> actually.  At least it should, but the patch appears to be incomplete.
>
> >
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> > Change sincve v1: add detailed commit message
> >
> > tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> > index c68f99f659..f7b1aa7fdc 100644
> > --- a/tests/qtest/qmp-cmd-test.c
> > +++ b/tests/qtest/qmp-cmd-test.c
> > @@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
>    static void test_object_add_failure_modes(void)
>    {
>        QTestState *qts;
>        QDict *resp;
>
>        /* attempt to create an object without props */
>        qts =3D qtest_init(common_args);
>        resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
 } }");
>        g_assert_nonnull(resp);
>        qmp_assert_error_class(resp, "GenericError");
>
> Doesn't @resp leak here, too?

No, qmp_assert_error_class will call qobject_unref(rsp) will so will not le=
ak.
In fact, I think this is a inconsistent for 'qtest_qmp'.
I think we can apply this patch first and then change the
'qmp_assert_error_class' or/and others
to free resp. And just let the caller of 'qtest_qmp' frees unref the rsp.

What's your idea?

Thanks,
Li Qiang


>
>        /* attempt to create an object without qom-type */
>        resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'id': 'ram1' } }");
>        g_assert_nonnull(resp);
>        qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
>        /* attempt to delete an object that does not exist */
>        resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                         " {'id': 'ram1' } }");
>        g_assert_nonnull(resp);
>        qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
>        /* attempt to create 2 objects with duplicate id */
>        resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> >                       " 'props': {'size': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> > +
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> >                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> >                       " 'props': {'size': 1048576 } } }");
>        g_assert_nonnull(resp);
>        qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
>        /* delete ram1 object */
>        resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> > @@ -241,6 +243,7 @@ static void test_object_add_failure_modes(void)
> >                       " {'id': 'ram1' } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* attempt to create an object with a property of a wrong type */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
>                         " 'props': {'size': '1048576' } } }");
> > @@ -249,17 +252,20 @@ static void test_object_add_failure_modes(void)
> >      g_assert_nonnull(resp);
> >      /* now do it right */
> >      qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
> > +
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> >                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> >                       " 'props': {'size': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* delete ram1 object */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> >                       " {'id': 'ram1' } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* attempt to create an object without the id */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'qom-type': 'memory-backend-ram',"
> > @@ -267,18 +273,21 @@ static void test_object_add_failure_modes(void)
> >                       " 'props': {'size': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
> > +
> >      /* now do it right */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> >                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> >                       " 'props': {'size': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* delete ram1 object */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> >                       " {'id': 'ram1' } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* attempt to set a non existing property */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                         " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> > @@ -286,23 +295,27 @@ static void test_object_add_failure_modes(void)
> >                       " 'props': {'sized': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
> > +
> >      /* now do it right */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> >                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
,"
> >                       " 'props': {'size': 1048576 } } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* delete ram1 object without id */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> >                       " {'ida': 'ram1' } }");
> >      g_assert_nonnull(resp);
> > +    qobject_unref(resp);
> >
> >      /* delete ram1 object */
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> >                       " {'id': 'ram1' } }");
> >      g_assert_nonnull(resp);
> >      g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> >
> >      /* delete ram1 object that does not exist anymore*/
> >      resp =3D qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                         " {'id': 'ram1' } }");
>        g_assert_nonnull(resp);
>        qmp_assert_error_class(resp, "GenericError");
>
> Likewise.
>
>        qtest_quit(qts);
>    }
>

