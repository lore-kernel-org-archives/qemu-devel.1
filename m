Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32BC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE1B20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYkEJx43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE1B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7sM-0007pb-1t
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH7l6-0003ff-VS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH7l5-000824-Nt
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH7l5-00081c-JK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585149355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CG49YItTSEaAVIfoMfi80rCB2q1gTx6NKpDoWaq3WA0=;
 b=BYkEJx43o3KtNVyswFJMq2D/usuNcLDaea+TYt/8azpUKW+xHC44OLz/VnwR+NKUSWNYgF
 obdYrVnN45DUw6rxCaT6VyUvy7M2RrIwFQBtMK08CXxlq1spgDGIj9NRSMhYyNGpeAwgY4
 XYpFi/OjbrgJ51k/GQCWV8t/3JxFILg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-xoZoZvtDP2CbY0x_qO4E1Q-1; Wed, 25 Mar 2020 11:15:51 -0400
X-MC-Unique: xoZoZvtDP2CbY0x_qO4E1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 603131005510;
 Wed, 25 Mar 2020 15:15:50 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB86294B4F;
 Wed, 25 Mar 2020 15:15:45 +0000 (UTC)
Date: Wed, 25 Mar 2020 15:15:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
Message-ID: <20200325151542.GB2589@work-vm>
References: <20200325113138.20337-1-ovoshcha@redhat.com>
 <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
 <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
 <f644f1f2-90ab-0d6f-99c6-bae34f76df1f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f644f1f2-90ab-0d6f-99c6-bae34f76df1f@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Oksana Voshchana <ovoshcha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer Moschetta <wainersm@redhat.com>, Cleber Rosa Junior <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 3/25/20 3:10 PM, Oksana Voshchana wrote:
> > Hi=A0Philippe
> > Thanks for the review
> > I have some comments
> >=20
> > On Wed, Mar 25, 2020 at 2:30 PM Philippe Mathieu-Daud=E9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >=20
> >     Hi Oksana,
> >=20
> >     v2 was
> >     https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.html, =
so
> >     this is v3. Please increment the version in the patch subject.
> >=20
> >     You could also send a simple "ping" to the specific patch, instead =
of
> >     resending it.
> >=20
> >     On 3/25/20 12:31 PM, Oksana Vohchana wrote:
> >      > The exec migration test isn't run a whole test scenario.
> >      > This patch fixes it
> >      >
> >      > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com
> >     <mailto:ovoshcha@redhat.com>>
> >=20
> >     v1 of this patch has already received reviewers tags
> >     (https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.html)=
,
> >     please collect them and keep them when you resend the same patch:
> >=20
> > I have reposted patch without this fix because this change isn't relate=
d
> > to the series:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06919.html
> > Is it make sense to keep this fix as a separate patch?
> >=20
> >     Fixes: 2e768cb682bf
> >     Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com
> >     <mailto:philmd@redhat.com>>
> >     Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com
> >     <mailto:wainersm@redhat.com>>
> >=20
> >      > ---
> >      >=A0 =A0tests/acceptance/migration.py | 6 +++---
> >      >=A0 =A01 file changed, 3 insertions(+), 3 deletions(-)
> >      >
> >      > diff --git a/tests/acceptance/migration.py
> >     b/tests/acceptance/migration.py
> >      > index a8367ca023..0365289cda 100644
> >      > --- a/tests/acceptance/migration.py
> >      > +++ b/tests/acceptance/migration.py
> >      > @@ -70,8 +70,8 @@ class Migration(Test):
> >      >
> >      >=A0 =A0 =A0 =A0@skipUnless(find_command('nc', default=3DFalse), "=
'nc'
> >     command not found")
> >      >=A0 =A0 =A0 =A0def test_migration_with_exec(self):
> >      > -=A0 =A0 =A0 =A0 """
> >      > -=A0 =A0 =A0 =A0 The test works for both netcat-traditional and
> >     netcat-openbsd packages
> >      > -=A0 =A0 =A0 =A0 """
> >      > +=A0 =A0 =A0 =A0 """The test works for both netcat-traditional a=
nd
> >     netcat-openbsd packages."""
> >=20
> >     Btw why are you changing the comment style?
> >=20
> > I got failure=A0in PEP257
>=20
> OK, next time please add comment in the patch description too.
>=20
> >=20
> >=20
> >      >=A0 =A0 =A0 =A0 =A0 =A0free_port =3D self._get_free_port()
> >      >=A0 =A0 =A0 =A0 =A0 =A0dest_uri =3D 'exec:nc -l localhost %u' % f=
ree_port
> >      > +=A0 =A0 =A0 =A0 src_uri =3D 'exec:nc localhost %u' % free_port
> >      > +=A0 =A0 =A0 =A0 self.do_migrate(dest_uri, src_uri)
> >      >
> >=20
> >     Alex, if there is no Python testing pullreq, can you take this patc=
h
> >     via
> >     your testing tree?
>=20
> Cc'ing David since it is migration related.

I tend to leave the tests/acceptance to someone other than the migration
tree; so feel free to take them via testing or trivial given the size.

Dave

> >=20
> >     Thanks,
> >=20
> >     Phil.
> >=20
> > Thanks
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


