Received: from eggs.gnu.org ([209.51.188.92]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0pW7-0007Ps-NR
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0pW5-0007Ai-QK
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:28:35 -0500
Date: Mon, 4 Mar 2019 15:28:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304152811.GO4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304101911.GE4239@redhat.com>
	<87y35u3lth.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y35u3lth.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, david@gibson.dropbear.id.au

On Mon, Mar 04, 2019 at 12:45:14PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, Mar 04, 2019 at 08:13:53AM +0100, Markus Armbruster wrote:
> >> If we deprecate outdated NUMA configurations now, we can start rejec=
ting
> >> them with new machine types after a suitable grace period.
> >
> > How is libvirt going to know what machines it can use with the featur=
e ?
> > We don't have any way to introspect machine type specific logic, sinc=
e we
> > run all probing with "-machine none", and QEMU can't report anything =
about
> > machines without instantiating them.
>=20
> Fair point.  A practical way for management applications to decide whic=
h
> of the two interfaces they can use with which machine type may be
> required for deprecating one of the interfaces with new machine types.

We currently have  "qom-list-properties" which can report on the
existance of properties registered against object types. What it
can't do though is report on the default values of these properties.

What's interesting though is that qmp_qom_list_properties will actually
instantiate objects in order to query properties, if the type isn't an
abstract type.

IOW, even if you are running "$QEMU -machine none", then if at the qmp-sh=
ell
you do

   (QEMU) qom-list-properties typename=3Dpc-q35-2.6-machine

it will have actually instantiate the pc-q35-2.6-machine machine type.
Since it has instantiated the machine, the object initializer function
will have run and initialized the default values for various properties.

IOW, it is possible for qom-list-properties to report on default values
for non-abstract types.

I did a quick hack to PoC the theory:

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..906dfbf3b5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1368,7 +1368,8 @@
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str',
+            '*default': 'str'} }
=20
 ##
 # @qom-list:
diff --git a/qmp.c b/qmp.c
index b92d62cd5f..a45669032c 100644
--- a/qmp.c
+++ b/qmp.c
@@ -594,6 +594,11 @@ ObjectPropertyInfoList *qmp_qom_list_properties(cons=
t char *typename,
         info->has_description =3D !!prop->description;
         info->description =3D g_strdup(prop->description);
=20
+        if (obj && g_str_equal(info->type, "string")) {
+            info->q_default =3D g_strdup(object_property_get_str(obj, in=
fo->name, NULL));
+            info->has_q_default =3D info->q_default !=3D NULL;
+        }
+
         entry =3D g_malloc0(sizeof(*entry));
         entry->value =3D info;
         entry->next =3D prop_list;


If we could make this hack less of a hack, then perhaps this is good
enough to cope reporting machine types which forbid use of "mem" in
favour of "memdev" ? They would need to have a property registered
against them of course to identify the "memdev" requirement.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
