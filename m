Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFO0q-0001B6-SJ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFO0l-00069i-JY
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:27:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44572
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cFO0l-00068a-ET
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:27:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9GOpBY053889
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 11:27:02 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ymjhxxu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 11:27:02 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 09:27:01 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87h96ghu4o.fsf@dusky.pond.sub.org>
References: <1481055300-14239-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481055300-14239-3-git-send-email-mdroth@linux.vnet.ibm.com>
	<20161207091227.GC21167@redhat.com> <87h96ghu4o.fsf@dusky.pond.sub.org>
Date: Fri, 09 Dec 2016 10:26:50 -0600
Message-Id: <20161209162650.32716.22289@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.8 2/2] tests: check-qom-proplist: add
 checks for cmdline-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, bharata.rao@gmail.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

Quoting Markus Armbruster (2016-12-07 05:10:47)
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> =

> > On Tue, Dec 06, 2016 at 02:15:00PM -0600, Michael Roth wrote:
> >> check-qom-proplist originally added tests for verifying that
> >> object-creation helpers object_new_with_{props,propv} behaved in
> >> similar fashion to the "traditional" method involving setting each
> >> individual property separately after object creation rather than
> >> in via a single call.
> >> =

> >> Another similar "helper" for creating Objects exists in the form of
> >> objects specified via -object command-line parameters. By that
> >> rationale, we extend check-qom-proplist to include similar checks
> >> for command-line-created objects by employing the same
> >> qemu_opts_parse()-based parsing the vl.c employs.
> >> =

> >> This parser has a side-effect of parsing the object's options into
> >> a QemuOpt structure and registering this in the global QemuOptsList
> >> using the Object's ID. This can conflict with future Object instances
> >> that attempt to use the same ID if we don't ensure this is cleaned
> >> up as part of Object finalization, so we add specific checks for this
> >> scenario in addition to the normal sanity checks.
> >> =

> >> Suggested-by: Daniel Berrange <berrange@redhat.com>
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Markus Armbruster <armbru@redhat.com>
> >> Cc: Eric Blake <eblake@redhat.com>
> >> Cc: Daniel Berrange <berrange@redhat.com>
> >> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> ---
> >>  tests/check-qom-proplist.c | 54 +++++++++++++++++++++++++++++++++++++=
++++++++-
> >>  1 file changed, 53 insertions(+), 1 deletion(-)
> >> =

> >> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> >> index a16cefc..087ce21 100644
> >> --- a/tests/check-qom-proplist.c
> >> +++ b/tests/check-qom-proplist.c
> >> @@ -23,6 +23,9 @@
> >>  #include "qapi/error.h"
> >>  #include "qom/object.h"
> >>  #include "qemu/module.h"
> >> +#include "qemu/option.h"
> >> +#include "qemu/config-file.h"
> >> +#include "qom/object_interfaces.h"
> >>  =

> >>  =

> >>  #define TYPE_DUMMY "qemu-dummy"
> >> @@ -162,6 +165,10 @@ static const TypeInfo dummy_info =3D {
> >>      .instance_finalize =3D dummy_finalize,
> >>      .class_size =3D sizeof(DummyObjectClass),
> >>      .class_init =3D dummy_class_init,
> >> +    .interfaces =3D (InterfaceInfo[]) {
> >> +        { TYPE_USER_CREATABLE },
> >> +        { }
> >> +    }
> >>  };
> >>  =

> >>  =

> >> @@ -291,7 +298,6 @@ static void dummy_backend_init(Object *obj)
> >>  {
> >>  }
> >>  =

> >> -
> >>  static const TypeInfo dummy_dev_info =3D {
> >>      .name          =3D TYPE_DUMMY_DEV,
> >>      .parent        =3D TYPE_OBJECT,
> >> @@ -320,6 +326,14 @@ static const TypeInfo dummy_backend_info =3D {
> >>      .class_size =3D sizeof(DummyBackendClass),
> >>  };
> >>  =

> >> +static QemuOptsList qemu_object_opts =3D {
> >> +    .name =3D "object",
> >> +    .implied_opt_name =3D "qom-type",
> >> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
> >> +    .desc =3D {
> >> +        { }
> >> +    },
> >> +};
> >>  =

> >>  =

> >>  static void test_dummy_createv(void)
> >> @@ -388,6 +402,43 @@ static void test_dummy_createlist(void)
> >>      object_unparent(OBJECT(dobj));
> >>  }
> >>  =

> >> +static void test_dummy_createcmdl(void)
> >> +{
> >> +    QemuOpts *opts;
> >> +    DummyObject *dobj;
> >> +    Error *err =3D NULL;
> >> +    const char *params =3D TYPE_DUMMY \
> >> +                         ",id=3Ddev0," \
> >> +                         "bv=3Dyes,sv=3DHiss hiss hiss,av=3Dplatypus";
> >> +
> >> +    qemu_add_opts(&qemu_object_opts);
> >> +    opts =3D qemu_opts_parse(&qemu_object_opts, params, true, &err);
> >> +    g_assert(err =3D=3D NULL);
> >> +    g_assert(opts);
> >> +
> >> +    dobj =3D DUMMY_OBJECT(user_creatable_add_opts(opts, &err));
> >> +    g_assert(err =3D=3D NULL);
> >> +    g_assert(dobj);
> >> +    g_assert_cmpstr(dobj->sv, =3D=3D, "Hiss hiss hiss");
> >> +    g_assert(dobj->bv =3D=3D true);
> >> +    g_assert(dobj->av =3D=3D DUMMY_PLATYPUS);
> >> +
> >> +    user_creatable_del("dev0", &err);
> >> +    g_assert(err =3D=3D NULL);
> >> +    error_free(err);
> >> +
> >> +    /* cmdline-parsing via qemu_opts_parse() results in a QemuOpts en=
try
> >> +     * corresponding to the Object's ID to be added to the QemuOptsLi=
st
> >> +     * for objects. To avoid having this entry conflict with future
> >> +     * Objects using the same ID (which can happen in cases where
> >> +     * qemu_opts_parse() is used to parse the object params, such as
> >> +     * with hmp_object_add() at the time of this comment), we check
> >> +     * for this in user_creatable_del() and remove the QemuOpts if it
> >> +     * is present. The below check ensures this works as expected.
> >> +     */
> >> +    g_assert(qemu_opts_find(&qemu_object_opts, "dev0") =3D=3D NULL);
> >> +}
> >> +
> >>  static void test_dummy_badenum(void)
> >>  {
> >>      Error *err =3D NULL;
> >> @@ -525,6 +576,7 @@ int main(int argc, char **argv)
> >>  =

> >>      g_test_add_func("/qom/proplist/createlist", test_dummy_createlist=
);
> >>      g_test_add_func("/qom/proplist/createv", test_dummy_createv);
> >> +    g_test_add_func("/qom/proplist/createcmdline", test_dummy_createc=
mdl);
> >>      g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
> >>      g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
> >>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
> >
> > Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> >
> >
> > except that this should be squashed into the previous commit - tests sh=
ould
> > always be in the same commit as the new code that they're verifying.
> =

> Not sure how particular we are about that.
> =

> When neither test nor fix is trivial, I personally like to commit the
> test first, defanged so it doesn't blow up make check, with a suitable
> FIXME comment.  The fix then resolves the FIXME.

I think this approach also makes sense here due to the fact that the
bulk of the checks added are pertaining to general sanity checks.
There's really only one assert here that checks the fix in question.
I'll switch it around and replace that check with a FIXME, then squash
the check into the fix patch.

>=20
