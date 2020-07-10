Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD50C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB04A20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGZ3BAEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB04A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtucx-0002Vs-6Q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtucB-0001jH-Ge
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:07:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtuc7-0002Po-L6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:07:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so6519136wmg.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rqOmeLrwKKNLxr0lwXIx6nEo8Jp/EPVJoIhfXf0Y5Bs=;
 b=uGZ3BAEY5nXKJeKWKwOL0JiNgYNoCQXhKv/wfTXuGIJcTxt5djzowQ3K+ZpOvOo1Vf
 T5Fb/IDvxj/0BqU9/K5MlAVS//L3AdOCtKHTm+qX27+bPgq6KUj8fcHnNmi63KO+FGDS
 qUTg/Treo5NRgMJFB7hduS7EF6bJZ24OkxHGAvGxzEwHz0F7Lgli8DeatJElPf0aWqN0
 k0nUmQa7Ot5r65fRuGoJs53dbIY11R3gGGVcuOM8cIMHDWQxCvDC1LyM4DpfpAEdoh8w
 ScMxkX8iFx0pW4Lvzgey7lDeeAUN4UX60RyiBz/OV3FtojW6IwSNwzuPqfXRcrj2G3Su
 5x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rqOmeLrwKKNLxr0lwXIx6nEo8Jp/EPVJoIhfXf0Y5Bs=;
 b=owbCrxGmNlbQdZDdVkmAHKfbxBEGXW+htwObCvCYUskPXp7+jn5l+itth77v2lXJ8o
 Vwulfknk9vU1gsfnfmaViI/nAg58IQU9O9dbBEZgDqNnFxkdEa6x/q29eYJzWQXp34cF
 lA3g4O7MsQUYfIdODB0mmVjOK+6BvwdQ8eRdAYPdbZkqWO3sknOnkVo+DibPcVtnVq68
 DNOzqlI1Op6Hp2MP8dXqpQ1ojGFXJKzaSCu+jRjPYFpsIILX+EDIafirvcpB/PiZm2wf
 9Iawx50b0TNbhXJ693d+RyEvHVoBYtRCzluwYasEkNvUYvgf+RE2umcrl5jloU2Rzm6t
 rkXw==
X-Gm-Message-State: AOAM5337PUj5zHQYlWAJ9D/94FpQFj+yFk7K69jLmpbDKloJ8dltxg9J
 7zKQqjygtwH20iFLKs00KtH7oj3aZ6Q=
X-Google-Smtp-Source: ABdhPJxW+X95/i/itnF1+bdYPQ/BP630uTdZR21aiTKAU24fL6Ibn+ZSqRMHEv9967uVG5owTjdePw==
X-Received: by 2002:a1c:303:: with SMTP id 3mr5763032wmd.180.1594393615713;
 Fri, 10 Jul 2020 08:06:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d13sm10357208wrn.61.2020.07.10.08.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 08:06:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CCDDE1FF7E;
 Fri, 10 Jul 2020 16:06:52 +0100 (BST)
References: <20200710060719.22386-1-thuth@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] tests: improve performance of device-introspect-test
In-reply-to: <20200710060719.22386-1-thuth@redhat.com>
Date: Fri, 10 Jul 2020 16:06:52 +0100
Message-ID: <87wo3bjto3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Total execution time with "-m slow" and x86_64 QEMU, drops from 3
> minutes 15 seconds, down to 54 seconds.
>
> Individual tests drop from 17-20 seconds, down to 3-4 seconds.
>
> The cost of this change is that any QOM bugs resulting in the test
> failure will not be directly associated with the device that caused
> the failure. The test case is not frequently identifying such bugs
> though, and the cause is likely easily visible in the patch series
> that causes the failure. So overall the shorter running time is
> considered the more important factor.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> [thuth: Add the tree check to test_device_intro_none() and
>  test_device_intro_abstract(), too, just to be sure...]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to pr/100720-testing-and-misc-2 in lieu of gitlab: split
build-disabled into two phases, thanks.

> ---
>  v2: Add the tree check to test_device_intro_none() and
>      test_device_intro_abstract(), too
>
>  When I run the following command, the test time drops from more
>  than 20 minutes to 50 seconds now (wow!):
>=20=20
>  QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 \
>   time tests/qtest/device-introspect-test -m slow > /dev/null
>
>  tests/qtest/device-introspect-test.c | 60 ++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-in=
trospect-test.c
> index 9abb5ec889..d68b7856a7 100644
> --- a/tests/qtest/device-introspect-test.c
> +++ b/tests/qtest/device-introspect-test.c
> @@ -105,14 +105,9 @@ static void test_one_device(QTestState *qts, const c=
har *type)
>  {
>      QDict *resp;
>      char *help;
> -    char *qom_tree_start, *qom_tree_end;
> -    char *qtree_start, *qtree_end;
>=20=20
>      g_test_message("Testing device '%s'", type);
>=20=20
> -    qom_tree_start =3D qtest_hmp(qts, "info qom-tree");
> -    qtree_start =3D qtest_hmp(qts, "info qtree");
> -
>      resp =3D qtest_qmp(qts, "{'execute': 'device-list-properties',"
>                            " 'arguments': {'typename': %s}}",
>                 type);
> @@ -120,21 +115,6 @@ static void test_one_device(QTestState *qts, const c=
har *type)
>=20=20
>      help =3D qtest_hmp(qts, "device_add \"%s,help\"", type);
>      g_free(help);
> -
> -    /*
> -     * Some devices leave dangling pointers in QOM behind.
> -     * "info qom-tree" or "info qtree" have a good chance at crashing th=
en.
> -     * Also make sure that the tree did not change.
> -     */
> -    qom_tree_end =3D qtest_hmp(qts, "info qom-tree");
> -    g_assert_cmpstr(qom_tree_start, =3D=3D, qom_tree_end);
> -    g_free(qom_tree_start);
> -    g_free(qom_tree_end);
> -
> -    qtree_end =3D qtest_hmp(qts, "info qtree");
> -    g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
> -    g_free(qtree_start);
> -    g_free(qtree_end);
>  }
>=20=20
>  static void test_device_intro_list(void)
> @@ -213,16 +193,38 @@ static void test_qom_list_fields(void)
>  static void test_device_intro_none(void)
>  {
>      QTestState *qts =3D qtest_init(common_args);
> +    g_autofree char *qom_tree_start =3D qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end =3D NULL;
> +    g_autofree char *qtree_start =3D qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end =3D NULL;
>=20=20
>      test_one_device(qts, "nonexistent");
> +
> +    /* Make sure that really nothing changed in the trees */
> +    qom_tree_end =3D qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, =3D=3D, qom_tree_end);
> +    qtree_end =3D qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
> +
>      qtest_quit(qts);
>  }
>=20=20
>  static void test_device_intro_abstract(void)
>  {
>      QTestState *qts =3D qtest_init(common_args);
> +    g_autofree char *qom_tree_start =3D qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end =3D NULL;
> +    g_autofree char *qtree_start =3D qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end =3D NULL;
>=20=20
>      test_one_device(qts, "device");
> +
> +    /* Make sure that really nothing changed in the trees */
> +    qom_tree_end =3D qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, =3D=3D, qom_tree_end);
> +    qtree_end =3D qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
> +
>      qtest_quit(qts);
>  }
>=20=20
> @@ -231,9 +233,12 @@ static void test_device_intro_concrete(const void *a=
rgs)
>      QList *types;
>      QListEntry *entry;
>      const char *type;
> -    QTestState *qts;
> +    QTestState *qts =3D qtest_init(args);
> +    g_autofree char *qom_tree_start =3D qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end =3D NULL;
> +    g_autofree char *qtree_start =3D qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end =3D NULL;
>=20=20
> -    qts =3D qtest_init(args);
>      types =3D device_type_list(qts, false);
>=20=20
>      QLIST_FOREACH_ENTRY(types, entry) {
> @@ -243,6 +248,17 @@ static void test_device_intro_concrete(const void *a=
rgs)
>          test_one_device(qts, type);
>      }
>=20=20
> +    /*
> +     * Some devices leave dangling pointers in QOM behind.
> +     * "info qom-tree" or "info qtree" have a good chance at crashing th=
en.
> +     * Also make sure that the tree did not change.
> +     */
> +    qom_tree_end =3D qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, =3D=3D, qom_tree_end);
> +
> +    qtree_end =3D qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
> +
>      qobject_unref(types);
>      qtest_quit(qts);
>      g_free((void *)args);


--=20
Alex Benn=C3=A9e

