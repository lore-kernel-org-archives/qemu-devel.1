Received: from eggs.gnu.org ([2001:4830:134:3::10]:53548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eWOM5-0003nJ-2z
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eWOM1-0007wi-NC
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eWOM1-0007vV-Db
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:49 -0500
Date: Tue, 2 Jan 2018 15:19:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180102151938.GC2560@work-vm>
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
	<b3ccb2a7-efe3-2b0b-62ee-a3ab126e0205@virtuozzo.com>
	<20171228021931.GB22514@xz-mi>
	<223c3177-fae6-c218-1165-dc01e73c2e14@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <223c3177-fae6-c218-1165-dc01e73c2e14@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Peter Xu <peterx@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 28.12.2017 05:19, Peter Xu wrote:
> > On Wed, Dec 27, 2017 at 03:25:23PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> > > Hi all!
> > >=20
> > > Hmm, looks like leak is not fixed here: I've checked it while runni=
ng iotest
> > > 181, that
> > > migration_instance_finalize is not called.
> > >=20
> > > If I understand correct, to call it we need unref current_migration=
 object
> > > somewhere.
> > >=20
> > > Or, may be I'm missing something..
> > I think you are right.
> >=20
> > It does not matter much though since we don't dynamically allocate
> > migration object (there is only one and it lives forever).  Do you
> > want to post a patch?  I guess the safest place to unref it is at the
> > end of main() to make sure no one will be using it any more.
> >=20
> > (Hmm, the incoming migration state is still static)
> >=20
> > Thanks,
>=20
> Ok, I'll send a patch.

Be very very careful that it doesn't crash in cases like quit in the main=
 thread
while a migration is still running.

I have no problem with this object living forever and letting it just
die with exit().

Dave


> >=20
> > > 01.08.2017 19:04, Marc-Andr=E9 Lureau wrote:
> > > > Spotted thanks to valgrind and tests/device-introspect-test:
> > > >=20
> > > > =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss=
 record 6 of 14,537
> > > > =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:29=
9)
> > > > =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
> > > > =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
> > > > =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migrat=
ion.c:2226)
> > > > =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c=
:344)
> > > > =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (ob=
ject.c:375)
> > > > =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:=
483)
> > > > =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
> > > > =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp=
.c:542)
> > > > =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_propert=
ies (qmp-marshal.c:1425)
> > > > =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c=
:104)
> > > > =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:13=
1)
> > > >=20
> > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >    migration/migration.c | 10 ++++++++++
> > > >    1 file changed, 10 insertions(+)
> > > >=20
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index 085c32c994..c3fe0ed9ca 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -2214,6 +2214,15 @@ static void migration_class_init(ObjectCla=
ss *klass, void *data)
> > > >        dc->props =3D migration_properties;
> > > >    }
> > > > +static void migration_instance_finalize(Object *obj)
> > > > +{
> > > > +    MigrationState *ms =3D MIGRATION_OBJ(obj);
> > > > +    MigrationParameters *params =3D &ms->parameters;
> > > > +
> > > > +    g_free(params->tls_hostname);
> > > > +    g_free(params->tls_creds);
> > > > +}
> > > > +
> > > >    static void migration_instance_init(Object *obj)
> > > >    {
> > > >        MigrationState *ms =3D MIGRATION_OBJ(obj);
> > > > @@ -2282,6 +2291,7 @@ static const TypeInfo migration_type =3D {
> > > >        .class_size =3D sizeof(MigrationClass),
> > > >        .instance_size =3D sizeof(MigrationState),
> > > >        .instance_init =3D migration_instance_init,
> > > > +    .instance_finalize =3D migration_instance_finalize,
> > > >    };
> > > >    static void register_migration_types(void)
> > >=20
> > > --=20
> > > Best regards,
> > > Vladimir
> > >=20
> > >=20
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
