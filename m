Received: from eggs.gnu.org ([2001:4830:134:3::10]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ea03o-000261-UL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ea03j-0007zb-4C
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:11:56 -0500
Date: Fri, 12 Jan 2018 12:11:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180112141119.GF6646@localhost.localdomain>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104192203.GD3407@localhost.localdomain>
	<20180108135122.637e478a@redhat.com>
	<395b6cff-e4be-1aa9-48f6-82cdbd9633b9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <395b6cff-e4be-1aa9-48f6-82cdbd9633b9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] qom: introduce TypeInfo name
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jan 08, 2018 at 11:10:37AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Igor,
>=20
> On 01/08/2018 09:51 AM, Igor Mammedov wrote:
> [...]
> > Though it seems easy and trivial, I'm a bit concerned about using
> > QOM types for the task though.
> > Also see commit 6acbe4c6f which labels aliases as a bad idea
> > and says that they are there only for compatibility and shouldn't
> > be used.
> > So far I agree with that statement, because it introduces
> > ambiguity in code used internally and more worrying is that
> > this ambiguity will increase user visible ABI (think of '-device_add =
FOO_ALIAS')
> > that we would need to maintain afterwards.
> > It would be nice to have unified alias API, but I think it should
> > be separate one and limited to the same scope (i.e. compat stuff),
> > and even that won't be easy as different alias impl. we have now
> > have a different needs.
> >=20
> > wrt this series targeted usage, I'd prefer that object_new/initialize
> > would use real type names when creating devices as it does currently
> >=20
> > FDT linux guest specific names wouldn't seep into device model
> > itself. Firmware (FDT or ACPI) should be separate from device
> > implementation.
>=20
> Good point.
>=20
> > If really there is need to dynamically scan present devices
> > and build FDT from result, then probably we should introduce
> > interface that devices could implement if necessary.
> > (I was thinking about such possibility for ACPI). But so far
> > it looked to me as too much overhead for what we do now.
>=20
> I see, I thought about something similar but TypeInfo.aliases was way
> too simple to not try this series first.
>=20
> What about adding a INTERFACE_FDT_DEVICE type (InterfaceInfo) and let
> the FDT devices implement something such:
>=20
> typedef struct {
>     /*< private >*/
>     InterfaceClass parent_class;
>     DeviceClass parent_class;
>     /*< public >*/
>     bool (*is_alias)(FDTDeviceIf *dev, const char *name);
>     bool (*set_prop...)(FDTDeviceIf *dev, const char *property, ...);
>     const void *(*get_prop)(FDTDeviceIf *dev, const char *property);

An interface common to FDT devices probably make sense, but I
don't know if the one you suggest above makes sense or not (a
description of each method would be useful to understand what
exactly they would do).

--=20
Eduardo
