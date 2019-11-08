Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1265C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC7F2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiBaVW8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC7F2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSzr5-0003Bg-JP
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iSzq4-000252-Si
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iSzq3-0001D8-LZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iSzq3-0001Cs-Hy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573202510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lK73vBldzy45TyOYt4nGhczMiheqJQKwshiO9KzZjB4=;
 b=RiBaVW8YQ0OeLg3SPpoZOTQanML4hhhJ0H1L3zjmMyAJ/aLTDwvvzrpXJSWoBAzsCuB3/Z
 RS1S8gYGChyiO6GA5ppN44a1zcYBP/CRgbAjiszgquUdJL8OhXtgFqhzQT+odB96yx4C8A
 R+6ZBAYORw/9mpO55aFSr562xO8c7OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Et61Qa_QN2W4sTTHVoMC2g-1; Fri, 08 Nov 2019 03:41:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C49C107ACC3;
 Fri,  8 Nov 2019 08:41:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7DC5DA7C;
 Fri,  8 Nov 2019 08:41:40 +0000 (UTC)
Date: Fri, 8 Nov 2019 09:41:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
Message-ID: <20191108094138.0fcfb0c4@redhat.com>
In-Reply-To: <87lfsqbxnj.fsf@dusky.pond.sub.org>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
 <20191106205359.GR3812@habkost.net>
 <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
 <20191107133112.GS3812@habkost.net>
 <9ecafb7f-69b9-870b-b109-939fef47acde@intel.com>
 <87lfsqbxnj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Et61Qa_QN2W4sTTHVoMC2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 08 Nov 2019 09:05:52 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Tao Xu <tao3.xu@intel.com> writes:
>=20
> > On 11/7/2019 9:31 PM, Eduardo Habkost wrote: =20
> >> On Thu, Nov 07, 2019 at 02:24:52PM +0800, Tao Xu wrote: =20
> >>> On 11/7/2019 4:53 AM, Eduardo Habkost wrote: =20
> >>>> On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote: =20
> >>>>> Add tests for time input such as zero, around limit of precision,
> >>>>> signed upper limit, actual upper limit, beyond limits, time suffixe=
s,
> >>>>> and etc.
> >>>>>
> >>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>>>> --- =20
> >>>> [...] =20
> >>>>> +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set=
) */
> >>>>> +    qdict =3D keyval_parse("time1=3D9223372036854774784," /* 7ffff=
ffffffffc00 */
> >>>>> +                         "time2=3D9223372036854775295", /* 7ffffff=
ffffffdff */
> >>>>> +                         NULL, &error_abort);
> >>>>> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> >>>>> +    qobject_unref(qdict);
> >>>>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> >>>>> +    visit_type_time(v, "time1", &time, &error_abort);
> >>>>> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> >>>>> +    visit_type_time(v, "time2", &time, &error_abort);
> >>>>> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00); =20
> >>>>
> >>>> I'm confused by this test case and the one below[1].  Are these
> >>>> known bugs?  Shouldn't we document them as known bugs? =20
> >>>
> >>> Because do_strtosz() or do_strtomul() actually parse with strtod(), s=
o the
> >>> precision is 53 bits, so in these cases, 7ffffffffffffdff and
> >>> fffffffffffffbff are rounded. =20
> >>
> >> My questions remain: why isn't this being treated like a bug?
> >> =20
> > Hi Markus,
> >
> > I am confused about the code here too. Because in do_strtosz(), the
> > upper limit is
> >
> > val * mul >=3D 0xfffffffffffffc00
> >
> > So some data near 53 bit may be rounded. Is there a bug? =20
>=20
> No, but the design is surprising, and the functions lack written
> contracts, except for the do_strtosz() helper, which has one that sucks.
>=20
> qemu_strtosz() & friends are designed to accept fraction * unit
> multiplier.  Example: 1.5M means 1.5 * 1024 * 1024 with qemu_strtosz()
> and qemu_strtosz_MiB(), and 1.5 * 1000 * 1000 with
> qemu_strtosz_metric().  Whether supporting fractions is a good idea is
> debatable, but it's what we've got.
>=20
> The implementation limits the numeric part to the precision of double,
> i.e. 53 bits.  "8PiB should be enough for anybody."
>
> Switching it from double to long double raises the limit to the
> precision of long double.  At least 64 bit on common hosts, but hosts
> exist where it's the same 53 bits.  Do we support any such hosts?  If
> yes, then we'd make the precision depend on the host, which feels like a
> bad idea.
>=20
> A possible alternative is to parse the numeric part both as a double and
> as a 64 bit unsigned integer, then use whatever consumes more
> characters.  This enables providing full 64 bits unless you actually use
> a fraction.
>=20
> As far as I remember, the only problem we've ever had with the 53 bits
> limit is developer confusion :)

On CLI, we could (a)use full 64bit (-1) lat/bw to mark unreachable nodes.
Also it would be more consistent for both QMP and CLI to be able
handle the same range. This way what was configured over QMP could be
also configured using CLI.

> Patches welcome.


