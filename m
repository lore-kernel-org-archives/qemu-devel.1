Received: from eggs.gnu.org ([209.51.188.92]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2vTN-0004pG-Pl
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2vTK-0004k0-Du
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:14:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org> <20190304101911.GE4239@redhat.com>
	<87y35u3lth.fsf@dusky.pond.sub.org> <20190304152811.GO4239@redhat.com>
Date: Sun, 10 Mar 2019 11:14:08 +0100
In-Reply-To: <20190304152811.GO4239@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Mon, 4 Mar 2019 15:28:11 +0000")
Message-ID: <8736nvxci7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, david@gibson.dropbear.id.au

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Mar 04, 2019 at 12:45:14PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Mar 04, 2019 at 08:13:53AM +0100, Markus Armbruster wrote:
>> >> If we deprecate outdated NUMA configurations now, we can start reject=
ing
>> >> them with new machine types after a suitable grace period.
>> >
>> > How is libvirt going to know what machines it can use with the feature=
 ?
>> > We don't have any way to introspect machine type specific logic, since=
 we
>> > run all probing with "-machine none", and QEMU can't report anything a=
bout
>> > machines without instantiating them.
>>=20
>> Fair point.  A practical way for management applications to decide which
>> of the two interfaces they can use with which machine type may be
>> required for deprecating one of the interfaces with new machine types.
>
> We currently have  "qom-list-properties" which can report on the
> existance of properties registered against object types. What it
> can't do though is report on the default values of these properties.

Yes.

> What's interesting though is that qmp_qom_list_properties will actually
> instantiate objects in order to query properties, if the type isn't an
> abstract type.

If it's an abstract type, qom-list-properties returns the properties
created with object_class_property_add() & friends, typically by the
class_init method.  This is possible without instantiating the type.

If it's a concrete type, qom-list-properties additionally returns the
properties created with object_property_add(), typically by the
instance_init() method.  This requires instantiating the type.

Both kinds of properties can be added or deleted at any time.  For
instance, setting a property value with object_property_set() or similar
could create additional properties.

For historical reasons, we use often use object_property_add() where
object_class_property_add() would do.  Sad.

> IOW, even if you are running "$QEMU -machine none", then if at the qmp-sh=
ell
> you do
>
>    (QEMU) qom-list-properties typename=3Dpc-q35-2.6-machine
>
> it will have actually instantiate the pc-q35-2.6-machine machine type.
> Since it has instantiated the machine, the object initializer function
> will have run and initialized the default values for various properties.
>
> IOW, it is possible for qom-list-properties to report on default values
> for non-abstract types.

instance_init() also initializes the properties' values.
qom-list-properties could show these initial values (I hesitate calling
them default values).

Setting a property's value can change other properties' values by side
effect.

My point is: the properties qom-list-properties shows and the initial
values it could show are not necessarily final.  QOM is designed to be
maximally flexible, and flexibility brings along its bosom-buddy
complexity.

If you keep that in mind, qom-list-properties can be put to good use all
the same.

A way to report "default values" (really: whatever the values are after
object_new()) feels like a fair feature request to me, if backed by an
actual use case.

[...]
