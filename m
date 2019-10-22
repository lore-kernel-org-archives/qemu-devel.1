Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6BD21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9155m/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6BD21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52991 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrQj-0002yO-59
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMrPj-0001to-UC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMrPi-0005RF-Fm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:29:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMrPi-0005Qe-7Y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:29:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id v186so912458oie.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f9SpE5RTTZ9ZFtnVBG8aQnaKHU7QG2XbFcYcpWytK8s=;
 b=Y9155m/vcXFPXIMF+Bpf1+RO1U45HDCFyjok1dDav+gTgGhT0AcDOsMJcZEo8SpvdF
 I60Vi5ALZ3w5dJ9s50osXofurJVtTLV3/H94ouYzIW0Zwk5blEEFW9XhXzIHYcjLLL4a
 bLbmZ0A64mGP1HC6HfPXQvCrxhHDeb2Ae6BJdYF1wC9Ba34Cj1Z8GDDE82EKGsvcJ3iV
 DoaFWbuhDoBBHumFjsu/PVLz1X7616jeiVIYPf6OxvFaPWrVhqyr9m6Ec2FCZTAF5Mgk
 XLfxxOcCS0Rf4ZwcM25rT1IVUHr4AR/YK4xF6AGgnF8yg9+dDI0y1pdHux0C9yIK+Jrx
 TciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f9SpE5RTTZ9ZFtnVBG8aQnaKHU7QG2XbFcYcpWytK8s=;
 b=A2ZGXMEwBAtUjmeWijhP1aF3IDlUjNV5v2l5kCSLwnBCs+UzqRlJBQbvT5oYj6M+YY
 TWbd0cz2hOwO5I1hKZMaEoZHxZS/Tt5nVm4syJwf3YlbYtDJeRNWtV51rzRqFVRMMuSH
 qusLnWykayaJgSKZjPsNG1m/EuDapuDkMwDLYdOEZxGYy41QhEQS21CGCg69H7N7hDj1
 irUL8Ni2aueL+xg0L+v8NYyqixaABolIXe0kE2TFlwHB5lFY7G6ZPPep5mlsIKo6C4t2
 sXHU6Sb6/3zcDlPcGpMuzjm2Es72uuVRzYaqT5LvSNIVypUdsmi7SwLniHW/AwjIgNmO
 BlfQ==
X-Gm-Message-State: APjAAAUSPZbiSN7T9KmYJHyD0hKehaIo7OOqxGp9J7QLL/IRqbJHWEDZ
 fhr2GDnfyxVC8pZDe3aj4wdCa0xJh9eNeUp0w9kMGg==
X-Google-Smtp-Source: APXvYqyVvBpryFNHl2V2uDrohuAXnWC9ZE3495cppPYaUgJ+hfuqsDdi1143t+oqAtc4dbplC23m7ANLgG3LXjIWt/M=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2339378oic.98.1571740157184; 
 Tue, 22 Oct 2019 03:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
 <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
 <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
 <20191021161226.mnm6eomghb37xlby@kamzik.brq.redhat.com>
 <CAFEAcA-vHmtCi3HGqpu34sAaNxGeQwS_+0yZ5Hr4SbnGm+rjYA@mail.gmail.com>
In-Reply-To: <CAFEAcA-vHmtCi3HGqpu34sAaNxGeQwS_+0yZ5Hr4SbnGm+rjYA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 11:29:05 +0100
Message-ID: <CAFEAcA9o4G5yn0GzgdwvUnT_fEwRA7DChuV=miZaEvgavoU5xg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 17:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 21 Oct 2019 at 17:12, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 04:43:22PM +0100, Peter Maydell wrote:
> > > On Mon, 21 Oct 2019 at 15:23, Andrew Jones <drjones@redhat.com> wrote:
> > > > Peter, would you mind running your test on the kvm32 machine with this
> > > > change before I send a v7?
> > >
> > > Still fails:
> > >
> > > pm215@pm-ct:~/qemu/build/arm$
> > > QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm tests/arm-cpu-features
> > > /arm/arm/query-cpu-model-expansion: OK
> > > /arm/arm/kvm/query-cpu-model-expansion: **
> > > ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:498:test_query_cpu_model_expansion_kvm:
> > > assertion failed: (resp_has_props(_resp))
> > > Aborted
> > >
> > > This is asserting on the line:
> > > 498             assert_has_not_feature(qts, "host", "sve");
> > >
> >
> > Oh, I see. It's not failing the specific absence of 'sve', but the test
> > code (assert_has_not_feature()) is assuming at least one property is
> > present. This isn't the case for kvm32 'host' cpus. They apparently
> > have none. We need this patch too, then
> >
> > diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> > index 14100ebd8521..9aa728ed8469 100644
> > --- a/tests/arm-cpu-features.c
> > +++ b/tests/arm-cpu-features.c
> > @@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const char *feature)
> >  ({                                                                     \
> >      QDict *_resp = do_query_no_props(qts, cpu_type);                   \
> >      g_assert(_resp);                                                   \
> > -    g_assert(resp_has_props(_resp));                                   \
> > -    g_assert(!qdict_get(resp_get_props(_resp), feature));              \
> > +    g_assert(!resp_has_props(_resp) ||                                 \
> > +             !qdict_get(resp_get_props(_resp), feature));              \
> >      qobject_unref(_resp);                                              \
> >  })
>
> Yep, with that extra the test passes. I'm just rerunning the
> full 'make check'...

...which passed OK. For the record, the changes on top of the
patchset were:

diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 92668efb8f5..9aa728ed846 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const
char *feature)
 ({                                                                     \
     QDict *_resp = do_query_no_props(qts, cpu_type);                   \
     g_assert(_resp);                                                   \
-    g_assert(resp_has_props(_resp));                                   \
-    g_assert(!qdict_get(resp_get_props(_resp), feature));              \
+    g_assert(!resp_has_props(_resp) ||                                 \
+             !qdict_get(resp_get_props(_resp), feature));              \
     qobject_unref(_resp);                                              \
 })

@@ -417,8 +417,6 @@ static void
test_query_cpu_model_expansion_kvm(const void *data)

     qts = qtest_init(MACHINE "-accel kvm -cpu host");

-    assert_has_feature(qts, "host", "pmu");
-
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
         char max_name[8], name[8];
@@ -428,6 +426,7 @@ static void
test_query_cpu_model_expansion_kvm(const void *data)
         char *error;

         assert_has_feature(qts, "host", "aarch64");
+        assert_has_feature(qts, "host", "pmu");

         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
@@ -497,9 +496,6 @@ static void
test_query_cpu_model_expansion_kvm(const void *data)
         }
     } else {
         assert_has_not_feature(qts, "host", "sve");
-        assert_error(qts, "host",
-                     "'pmu' feature not supported by KVM on this host",
-                     "{ 'pmu': true }");
     }

     qtest_quit(qts);


thanks
-- PMM

