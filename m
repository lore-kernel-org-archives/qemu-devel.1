Received: from eggs.gnu.org ([2001:4830:134:3::10]:47179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFNxf-0007we-FX
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFNxc-00051c-JP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:23:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cFNxc-00050c-BE
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:23:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9GJjgC102541
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 11:23:46 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ymn9ph6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 11:23:45 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 09:23:44 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87oa0ohvq3.fsf@dusky.pond.sub.org>
References: <1481055300-14239-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481055300-14239-2-git-send-email-mdroth@linux.vnet.ibm.com>
	<87oa0ohvq3.fsf@dusky.pond.sub.org>
Date: Fri, 09 Dec 2016 10:23:34 -0600
Message-Id: <20161209162334.32716.5943@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.8 1/2] monitor: fix object_del for
 command-line-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, dgilbert@redhat.com, bharata.rao@gmail.com, david@gibson.dropbear.id.au

Quoting Markus Armbruster (2016-12-07 04:36:20)
> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
> =

> > Currently objects specified on the command-line are only partially
> > cleaned up when 'object_del' is issued in either HMP or QMP: the
> > object itself is fully finalized, but the QemuOpts are not removed.
> > This results in the following behavior:
> >
> >   x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
> >     -object memory-backend-ram,id=3Dram1,size=3D256M
> >
> >   QEMU 2.7.91 monitor - type 'help' for more information
> >   (qemu) object_del ram1
> >   (qemu) object_del ram1
> >   object 'ram1' not found
> >   (qemu) object_add memory-backend-ram,id=3Dram1,size=3D256M
> >   Duplicate ID 'ram1' for object
> >   Try "help object_add" for more information
> >
> > which can be an issue for use-cases like memory hotplug.
> >
> > This happens on the HMP side because hmp_object_add() attempts to
> > create a temporary QemuOpts entry with ID 'ram1', which ends up
> > conflicting with the command-line-created entry, since it was never
> > cleaned up during the previous hmp_object_del() call.
> >
> > We address this by adding a check in user_creatable_del(), which
> > is called by both qmp_object_del() and hmp_object_del() to handle
> > the actual object cleanup, to determine whether an option group entry
> > matching the object's ID is present and removing it if it is.
> >
> > Note that qmp_object_add() never attempts to create a temporary
> > QemuOpts entry, so it does not encounter the duplicate ID error,
> > which is why this isn't generally visible in libvirt.
> >
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Daniel Berrange <berrange@redhat.com>
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  qom/object_interfaces.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index ded4d84..23849f9 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -5,6 +5,7 @@
> >  #include "qapi-visit.h"
> >  #include "qapi/qobject-output-visitor.h"
> >  #include "qapi/opts-visitor.h"
> > +#include "qemu/config-file.h"
> >  =

> >  void user_creatable_complete(Object *obj, Error **errp)
> >  {
> > @@ -197,6 +198,7 @@ void user_creatable_del(const char *id, Error **err=
p)
> >  {
> >      Object *container;
> >      Object *obj;
> > +    QemuOptsList *opt_group;
> >  =

> >      container =3D object_get_objects_root();
> >      obj =3D object_resolve_path_component(container, id);
> > @@ -209,6 +211,15 @@ void user_creatable_del(const char *id, Error **er=
rp)
> >          error_setg(errp, "object '%s' is in use, can not be deleted", =
id);
> >          return;
> >      }
> > +
> > +    /* if object was defined on the command-line, remove its correspon=
ding
> > +     * option group entry
> > +     */
> > +    opt_group =3D qemu_find_opts_err("object", NULL);
> > +    if (opt_group) {
> =

> How can opt_group ever be null?
> =

> For what it's worth, we assume it can't in hmp_object_add() and main().

I was trying to avoid as many assumptions as possible since
user_creatable_complete() is kind of reaching out of it's scope here.
If we ever changed the behavior on the parsing side this could result in
a segfault that might slip through if this particular scenario isn't
specifically tested.

However, that's less of a concern now thanks to the unit tests that
Daniel suggested which would catch this breakage. So that kind of handles
my concerns. Will change it for v3.

> =

> > +        qemu_opts_del(qemu_opts_find(opt_group, id));
> > +    }
> > +
> >      object_unparent(obj);
> >  }
>=20
