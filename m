Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dwPGW-0002Fx-IL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dwPGT-0004SO-Vd
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dwPGT-0004Rs-ND
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:21 -0400
Date: Mon, 25 Sep 2017 10:01:09 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170925090109.GE20236@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-2-git-send-email-peterx@redhat.com>
	<4540074c-f523-41f4-3ce7-8b6514060fa4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4540074c-f523-41f4-3ce7-8b6514060fa4@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 25, 2017 at 09:14:21AM +0200, Andreas F=C3=A4rber wrote:
> Am 25.09.2017 um 08:37 schrieb Peter Xu:
> > We have object_get_objects_root() to keep user created objects, howev=
er
> > no place for objects that will be used internally.  Create such a
> > container for internal objects.
> >=20
> > CC: Andreas F=C3=A4rber <afaerber@suse.de>
> > CC: Markus Armbruster <armbru@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qom/object.h | 10 ++++++++++
> >  qom/object.c         |  5 +++++
> >  2 files changed, 15 insertions(+)
> >=20
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index f3e5cff..f567052 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
> >  Object *object_get_objects_root(void);
> > =20
> >  /**
> > + * object_get_internal_root:
> > + *
> > + * Get the container object that holds internally used object
> > + * instances. This is the object at path "/internal-objects"
> > + *
> > + * Returns: the internal object container
> > + */
> > +Object *object_get_internal_root(void);
> > +
> > +/**
> >   * object_get_canonical_path_component:
> >   *
> >   * Returns: The final component in the object's canonical path.  The=
 canonical
> > diff --git a/qom/object.c b/qom/object.c
> > index 3e18537..857cee7 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -1370,6 +1370,11 @@ Object *object_get_objects_root(void)
> >      return container_get(object_get_root(), "/objects");
> >  }
> > =20
> > +Object *object_get_internal_root(void)
> > +{
> > +    return container_get(object_get_root(), "/internal-objects");
>=20
> Whatever you expose in the QOM tree is no longer internal. Other name?

I guess the key concept trying to be expressed is that this will hold
objects created internally by QEMU code, in response to other configurati=
on
input, as distinct from objects created externally by the user via -objec=
t.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
