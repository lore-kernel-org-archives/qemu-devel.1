Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67716CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A87205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSnVaRVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A87205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaJb-0004XE-8x
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iMaIZ-0003cE-7z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iMaIX-0006Tl-PY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iMaIX-0006Tc-Lt
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571674364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RecJFlyUhcIH6EYaAp3d+0MMEZYWE8DIiJ9f4wba0o8=;
 b=YSnVaRVWpapI4Bxz2TQGI3NxEcTKV6+2aDn5DJPnD0FcrdFr9lxtgZ3gCoWj3mPEfEYLNA
 wH+2I/bA7fhrSkSQiztDF6+bdsOV5g6vcpWyNp3ZBPpmloj7f1ZLVY8MKqV22HSvGMP7Q/
 4D0EUlm9t8Ci5VHhA5bM7tvsrjnu7WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-pIq7-l6IO-a9d1uxHSiunQ-1; Mon, 21 Oct 2019 12:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A152476;
 Mon, 21 Oct 2019 16:12:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B01960BE2;
 Mon, 21 Oct 2019 16:12:29 +0000 (UTC)
Date: Mon, 21 Oct 2019 18:12:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
Message-ID: <20191021161226.mnm6eomghb37xlby@kamzik.brq.redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
 <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
 <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pIq7-l6IO-a9d1uxHSiunQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 04:43:22PM +0100, Peter Maydell wrote:
> On Mon, 21 Oct 2019 at 15:23, Andrew Jones <drjones@redhat.com> wrote:
> > Peter, would you mind running your test on the kvm32 machine with this
> > change before I send a v7?
>=20
> Still fails:
>=20
> pm215@pm-ct:~/qemu/build/arm$
> QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm tests/arm-cpu-features
> /arm/arm/query-cpu-model-expansion: OK
> /arm/arm/kvm/query-cpu-model-expansion: **
> ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:498:test_query_cpu_model_=
expansion_kvm:
> assertion failed: (resp_has_props(_resp))
> Aborted
>=20
> This is asserting on the line:
> 498             assert_has_not_feature(qts, "host", "sve");
>

Oh, I see. It's not failing the specific absence of 'sve', but the test
code (assert_has_not_feature()) is assuming at least one property is
present. This isn't the case for kvm32 'host' cpus. They apparently
have none. We need this patch too, then

diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 14100ebd8521..9aa728ed8469 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const char *f=
eature)
 ({                                                                     \
     QDict *_resp =3D do_query_no_props(qts, cpu_type);                   \
     g_assert(_resp);                                                   \
-    g_assert(resp_has_props(_resp));                                   \
-    g_assert(!qdict_get(resp_get_props(_resp), feature));              \
+    g_assert(!resp_has_props(_resp) ||                                 \
+             !qdict_get(resp_get_props(_resp), feature));              \
     qobject_unref(_resp);                                              \
 })
=20

Thanks,
drew


