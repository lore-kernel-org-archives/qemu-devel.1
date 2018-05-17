Received: from eggs.gnu.org ([2001:4830:134:3::10]:40148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJH46-0001ya-Hw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJH43-0002Dk-8q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:27:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fJH43-0002DY-3m
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:27:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FDBE4201AEE
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:27:18 +0000 (UTC)
Date: Thu, 17 May 2018 13:27:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180517132716.55c886be@redhat.com>
In-Reply-To: <20180517100134.4e84c21a@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-12-git-send-email-imammedo@redhat.com>
	<20180516221230.GB1989@localhost.localdomain>
	<20180517100134.4e84c21a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 11/11] tests: functional tests for QMP
 command set-numa-node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

On Thu, 17 May 2018 10:01:34 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 16 May 2018 19:12:30 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Fri, May 04, 2018 at 10:37:49AM +0200, Igor Mammedov wrote: =20
> > >  * start QEMU with 2 unmapped cpus,
> > >  * while in preconfig state
> > >     * add 2 numa nodes
> > >     * assign cpus to them
> > >  * exit preconfig and in running state check that cpus
> > >    are mapped correctly.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > v6:
> > >   * replace 'cont' with 'exit-preconfig' command
> > > v5:
> > >   * s/qobject_to_qdict(/qobject_to(QDict,/
> > >   * s/-preconfig/--preconfig/
> > > v4:
> > >   * drop duplicate is_err() and reuse qmp_rsp_is_err() wich is moved
> > >     to generic file libqtest.c. (Eric Blake <eblake@redhat.com>)
> > >=20
> > > FIXUP! tests: functional tests for QMP command  set-numa-node
> > > ---
> > >  tests/libqtest.h  |  9 ++++++++
> > >  tests/libqtest.c  |  7 +++++++
> > >  tests/numa-test.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  tests/qmp-test.c  |  7 -------
> > >  4 files changed, 77 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/tests/libqtest.h b/tests/libqtest.h
> > > index cbe8df4..ac52872 100644
> > > --- a/tests/libqtest.h
> > > +++ b/tests/libqtest.h
> > > @@ -972,4 +972,13 @@ void qtest_qmp_device_add(const char *driver, co=
nst char *id, const char *fmt,
> > >   */
> > >  void qtest_qmp_device_del(const char *id);
> > > =20
> > > +/**
> > > + * qmp_rsp_is_err:
> > > + * @rsp: QMP response to check for error
> > > + *
> > > + * Test @rsp for error and discard @rsp.
> > > + * Returns 'true' if there is error in @rsp and 'false' otherwise.
> > > + */
> > > +bool qmp_rsp_is_err(QDict *rsp);
> > > +
> > >  #endif
> > > diff --git a/tests/libqtest.c b/tests/libqtest.c
> > > index 6f33a37..33426d5 100644
> > > --- a/tests/libqtest.c
> > > +++ b/tests/libqtest.c
> > > @@ -1098,3 +1098,10 @@ void qtest_qmp_device_del(const char *id)
> > >      QDECREF(response1);
> > >      QDECREF(response2);
> > >  }
> > > +
> > > +bool qmp_rsp_is_err(QDict *rsp)
> > > +{
> > > +    QDict *error =3D qdict_get_qdict(rsp, "error");
> > > +    QDECREF(rsp);   =20
> >=20
> >=20
> > Oops:
> >=20
> >   tests/libqtest.c: In function =E2=80=98qmp_rsp_is_err=E2=80=99:
> >   tests/libqtest.c:1105:5: error: implicit declaration of function =E2=
=80=98QDECREF=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> >        QDECREF(rsp);
> >        ^
> >   tests/libqtest.c:1105:5: error: nested extern declaration of =E2=80=
=98QDECREF=E2=80=99 [-Werror=3Dnested-externs]
> >=20
> > I've fixed this on numa-next, replaced QDECREF with object_unref. =20
> I guess QDECREF was removed while patch were sitting on the list.
change affected 8th and 11th patches make the last depended on 8th.
I'll post rebased v8 8,11th patches here so it would still bisectable
and include into 8th Eric's request for negative exit-preconfig testcase (+=
3LOC)
