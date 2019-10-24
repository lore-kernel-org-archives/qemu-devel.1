Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C192CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E0E20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APZ0OCVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E0E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbwu-0004JK-Ct
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iNbTa-0003gu-8i
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iNbTX-0004Ce-3C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:40:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iNbTW-0004C8-UY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571917216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FS6wWDrVL59YFy/x/AsMaG0JvH9bLquCtxHlR5belNM=;
 b=APZ0OCVIiHFqeazrmCeAbDQ8015oWvP+BiYTdAqTj+Fa7SG1BTRit7pmovK+nx+OHJKvVf
 l+MEMtGIpMNfLHHzR6I1aeoiv2LeL/xc6DI+LUSKCoriWEFz8IvF8yUyfiocCqlCObmFQm
 xqHZMAnD0wDcodGEZyGrxaAk42/qWqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-_wK-63zqOz6ZQ7aPZmwEbw-1; Thu, 24 Oct 2019 07:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC09100550E;
 Thu, 24 Oct 2019 11:40:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8858D60BF3;
 Thu, 24 Oct 2019 11:40:04 +0000 (UTC)
Date: Thu, 24 Oct 2019 13:40:02 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
Message-ID: <20191024114002.hmxesluufplkqert@kamzik.brq.redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
 <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
 <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
 <20191021161226.mnm6eomghb37xlby@kamzik.brq.redhat.com>
 <CAFEAcA-vHmtCi3HGqpu34sAaNxGeQwS_+0yZ5Hr4SbnGm+rjYA@mail.gmail.com>
 <CAFEAcA9o4G5yn0GzgdwvUnT_fEwRA7DChuV=miZaEvgavoU5xg@mail.gmail.com>
 <20191022134951.znjbk4piuiqwbveb@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191022134951.znjbk4piuiqwbveb@kamzik.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _wK-63zqOz6ZQ7aPZmwEbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 03:49:51PM +0200, Andrew Jones wrote:
> On Tue, Oct 22, 2019 at 11:29:05AM +0100, Peter Maydell wrote:
> > On Mon, 21 Oct 2019 at 17:18, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > >
> > > On Mon, 21 Oct 2019 at 17:12, Andrew Jones <drjones@redhat.com> wrote=
:
> > > >
> > > > On Mon, Oct 21, 2019 at 04:43:22PM +0100, Peter Maydell wrote:
> > > > > On Mon, 21 Oct 2019 at 15:23, Andrew Jones <drjones@redhat.com> w=
rote:
> > > > > > Peter, would you mind running your test on the kvm32 machine wi=
th this
> > > > > > change before I send a v7?
> > > > >
> > > > > Still fails:
> > > > >
> > > > > pm215@pm-ct:~/qemu/build/arm$
> > > > > QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm tests/arm-cpu-fea=
tures
> > > > > /arm/arm/query-cpu-model-expansion: OK
> > > > > /arm/arm/kvm/query-cpu-model-expansion: **
> > > > > ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:498:test_query_cp=
u_model_expansion_kvm:
> > > > > assertion failed: (resp_has_props(_resp))
> > > > > Aborted
> > > > >
> > > > > This is asserting on the line:
> > > > > 498             assert_has_not_feature(qts, "host", "sve");
> > > > >
> > > >
> > > > Oh, I see. It's not failing the specific absence of 'sve', but the =
test
> > > > code (assert_has_not_feature()) is assuming at least one property i=
s
> > > > present. This isn't the case for kvm32 'host' cpus. They apparently
> > > > have none. We need this patch too, then
> > > >
> > > > diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> > > > index 14100ebd8521..9aa728ed8469 100644
> > > > --- a/tests/arm-cpu-features.c
> > > > +++ b/tests/arm-cpu-features.c
> > > > @@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const=
 char *feature)
> > > >  ({                                                                =
     \
> > > >      QDict *_resp =3D do_query_no_props(qts, cpu_type);            =
       \
> > > >      g_assert(_resp);                                              =
     \
> > > > -    g_assert(resp_has_props(_resp));                              =
     \
> > > > -    g_assert(!qdict_get(resp_get_props(_resp), feature));         =
     \
> > > > +    g_assert(!resp_has_props(_resp) ||                            =
     \
> > > > +             !qdict_get(resp_get_props(_resp), feature));         =
     \
> > > >      qobject_unref(_resp);                                         =
     \
> > > >  })
> > >
> > > Yep, with that extra the test passes. I'm just rerunning the
> > > full 'make check'...
> >=20
> > ...which passed OK. For the record, the changes on top of the
> > patchset were:
> >=20
> > diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> > index 92668efb8f5..9aa728ed846 100644
> > --- a/tests/arm-cpu-features.c
> > +++ b/tests/arm-cpu-features.c
> > @@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const
> > char *feature)
> >  ({                                                                    =
 \
> >      QDict *_resp =3D do_query_no_props(qts, cpu_type);                =
   \
> >      g_assert(_resp);                                                  =
 \
> > -    g_assert(resp_has_props(_resp));                                  =
 \
> > -    g_assert(!qdict_get(resp_get_props(_resp), feature));             =
 \
> > +    g_assert(!resp_has_props(_resp) ||                                =
 \
> > +             !qdict_get(resp_get_props(_resp), feature));             =
 \
> >      qobject_unref(_resp);                                             =
 \
> >  })
> >=20
> > @@ -417,8 +417,6 @@ static void
> > test_query_cpu_model_expansion_kvm(const void *data)
> >=20
> >      qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
> >=20
> > -    assert_has_feature(qts, "host", "pmu");
> > -
> >      if (g_str_equal(qtest_get_arch(), "aarch64")) {
> >          bool kvm_supports_sve;
> >          char max_name[8], name[8];
> > @@ -428,6 +426,7 @@ static void
> > test_query_cpu_model_expansion_kvm(const void *data)
> >          char *error;
> >=20
> >          assert_has_feature(qts, "host", "aarch64");
> > +        assert_has_feature(qts, "host", "pmu");
> >=20
> >          assert_error(qts, "cortex-a15",
> >              "We cannot guarantee the CPU type 'cortex-a15' works "
> > @@ -497,9 +496,6 @@ static void
> > test_query_cpu_model_expansion_kvm(const void *data)
> >          }
> >      } else {
> >          assert_has_not_feature(qts, "host", "sve");
> > -        assert_error(qts, "host",
> > -                     "'pmu' feature not supported by KVM on this host"=
,
> > -                     "{ 'pmu': true }");
> >      }
> >=20
> >      qtest_quit(qts);
> >
>=20
> Thanks Peter!
>=20
> The changes look good to me. If we wanted to, we could also add
>=20
>  assert_has_not_feature(qts, "host", "pmu");
>=20
> in that kvm32 block where we have the
>=20
>  assert_has_not_feature(qts, "host", "sve");
>=20
> and we could even add
>=20
>  assert_has_not_feature(qts, "host", "aarch64");
>=20
> there as well.
>=20
> If I need to spin a v7, then I'll do that. I could also submit just those
> additions as another patch, though, or even just not worry too much about
> those cases and not add the tests...
>

I've decided to send a v7 because the changes above generate several
collisions, I want to add those two has-not tests, and because I have
more tags to pick up. I'll be sending it shortly.

Thanks,
drew


