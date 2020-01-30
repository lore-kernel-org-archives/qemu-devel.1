Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 20:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2640D20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwXa7tp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixGdL-0004Ld-BT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 15:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ixGcj-0003ue-2B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 15:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ixGcg-0000pr-HL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 15:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ixGcg-0000pV-DY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 15:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580416869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Foc2GZa39Sm2J26LLvPfPNFS7g1jdb6opYdqG0rKB1I=;
 b=NwXa7tp1/Xk28YatkaevkX6LemNscBiGIPdN0/KsEFRSv1u0XwScvD8oXVhuHyTnhTxHnA
 pmsG4JpOJHxw4p1Cr8p1mhcuhLpzOIMNedyxMQowQ6ZJlOSn/CECTq+lEzm1wkaRw+loKM
 MenkvUa8M79FXFolVHY6VklmVedLvE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-N7Amii85M0y-MuVsHECQvA-1; Thu, 30 Jan 2020 15:41:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5A0B1005514;
 Thu, 30 Jan 2020 20:41:02 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF23ACFE1;
 Thu, 30 Jan 2020 20:40:57 +0000 (UTC)
Date: Thu, 30 Jan 2020 15:40:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to
 verify QEMU binary version
Message-ID: <20200130204056.GH25446@habkost.net>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-5-philmd@redhat.com>
 <20200130132625.533fb4ca.cohuck@redhat.com>
 <ee877d12-c0a4-4f82-5d59-2e0235158479@redhat.com>
 <20200130180859.43954c22.cohuck@redhat.com>
 <1eee2851-8b65-8343-2847-1e6634bae46f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1eee2851-8b65-8343-2847-1e6634bae46f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: N7Amii85M0y-MuVsHECQvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 06:18:22PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Markus
>=20
> On 1/30/20 6:08 PM, Cornelia Huck wrote:
> > On Thu, 30 Jan 2020 14:28:19 +0100
> > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> >=20
> > > On 1/30/20 1:26 PM, Cornelia Huck wrote:
> > > > On Wed, 29 Jan 2020 22:23:20 +0100
> > > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> > > > > Introduce the 'version-min' tag.
> > > > > Tests can set it to the minimum version of QEMU they require.
> > > > > If QEMU is older, the tests will be cancelled (skipped):
> > > > >=20
> > > > >     $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu=
_model_versions.py
> > > > >      (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CAN=
CEL: Test expects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
> > > > >      (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expe=
cts version '4.1' but QEMU binary is '3.1.1' (0.10 s)
> > > > >      (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test exp=
ects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
> > > > >      ...
> > > > >=20
> > > > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > ---
> > > > >    tests/acceptance/avocado_qemu/__init__.py | 18 +++++++++++++++=
+++
> > > > >    1 file changed, 18 insertions(+)
> > > >=20
> > > > Hm... this might cause headaches if someone tries to backport tests=
 on
> > > > distro versions; but we probably won't be able to test for the feat=
ure
> > > > in many cases anyway?
> > >=20
> > > Are you saying a distro version might not match upstream version when=
 a
> > > feature is introduced? Isn't it the point of versioning? If you are
> > > thinking of some case you point me at it so I can improve this patch?
> >=20
> > Something like the following:
> >=20
> > - a feature together with a test is introduced in QEMU version n
> > - a distro is using m (where m < n), but wants the new feature and
> >    backports it
> >=20
> > If that distro now wants to include the acceptance test as well (to run
> > in their internal testing), they need to adapt the version check as
> > well, or the test simply won't run. Depending on how this is reported,
> > it might not be easily noticed. If the test depends on another feature
> > (but the feature does not), it might get a bit more complicated.
> >=20
> > It's probably not a big problem, but I wanted to point it out.
>=20
> OK now I understand better.
>=20
> I wrote that patch having QAPI versioned features in mind, which are
> versioned/documented.
> For example:
>=20
>   ##
>   # @qom-list-types:
>   #
>   ...
>   #
>   # Since: 1.1
>=20
> Now it is true that we add a new feature to a device, we do not document
> that in QAPI, and I don't see how we can test it via QMP.

The features are documented as introduced in specific QEMU
versions to help humans, but the best way to test for their
existence is to check the QAPI schema.

--=20
Eduardo


