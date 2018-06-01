Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOkbk-0003Sg-D9
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOkbi-0007zt-T4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:00:44 -0400
Date: Fri, 1 Jun 2018 15:00:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601140032.GH3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
	<20180601124345.GC3458@redhat.com>
	<20180601133359.GA24752@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601133359.GA24752@lemon.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

On Fri, Jun 01, 2018 at 09:33:59PM +0800, Fam Zheng wrote:
> On Fri, 06/01 13:43, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
> > > When hot-plugging a block device fails due to image locking errors,
> > > users won't see the helpful 'Is another process using the image?'
> > > message in QMP because currently the error hint is not carried over
> > > there.
> > >=20
> > > Even though extending QMP to include hint is a conceivably easy tas=
k,
> > > Libvirt will need some change to consume that data.
> > >=20
> > > Before that is fully sorted out, let's just do the easy fix by join=
ing
> > > the two lines.
> >=20
> > There are many places in QEMU which uses error hints and these are al=
l
> > invisible to libvirt. Arbitrarily picking one hint to remove, while
> > leaving everything else unfixed is not a very satisfactory approach.
> >=20
> > If QEMU passes the hint in QMP, it is trivial for libvirt to be chang=
ed
> > to append the hint when reporting its own error message, so can we ju=
st
> > focus on fixing the root cause instead of special casing file-posix.c
>=20
> The plan was to work on the QMP change in parallel, while this simple p=
atch can
> mitigate the confusion caused by the relatively vague message (the text=
 itself
> is going a bit on the cryptic side for people who don't know QEMU inter=
nals).

I still don't think that it makes sense to remove the use of hints in the
block layer.

If we don't care about improved error messages for existing libvirt
versions, we can just add a 'hint' field in QMP and let new libvirt
use that:

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 935f9e159c..82eb823f1f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -132,9 +132,15 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QObject *request,
=20
 QObject *qmp_build_error_object(Error *err)
 {
-    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_str(error_get_class(err)),
-                              error_get_pretty(err));
+    const char *hint =3D error_get_hint(err);
+    if (hint)
+        return qobject_from_jsonf("{ 'class': %s, 'desc': %s, 'hint': %s=
 }",
+                                  QapiErrorClass_str(error_get_class(err=
)),
+                                  error_get_pretty(err), hint);
+    else
+        return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
+                                  QapiErrorClass_str(error_get_class(err=
)),
+                                  error_get_pretty(err));
 }
=20
 /*


there's no error_get_hint method right now, but its impl is essentially
the same as error_get_pretty.


If, however, we want to get better error messages for existing libvirt,
then, we should do:

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 935f9e159c..bf6f92375a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -132,9 +132,18 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QObject *request,
=20
 QObject *qmp_build_error_object(Error *err)
 {
-    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_str(error_get_class(err)),
-                              error_get_pretty(err));
+    const char *hint =3D error_get_hint(err);
+    const char *msg;
+    if (hint) {
+        msg =3D g_strdup_printf("%s: %s", error_get_pretty(), hint);
+    } else {
+        msg =3D g_strdup(error_get_pretty());
+    }
+    QObject *ret =3D qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
+                                      QapiErrorClass_str(error_get_class=
(err)),
+                                      msg);
+    g_free(msg);
+    return ret;
 }
=20
 /*

Personally I'd just go for the first case and only care about new libvirt=
s.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
