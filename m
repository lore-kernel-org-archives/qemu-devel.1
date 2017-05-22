Received: from eggs.gnu.org ([2001:4830:134:3::10]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCnp5-00063v-43
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCnp0-0004uh-Tu
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:56:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dCnp0-0004u1-Jw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A8578124F
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 13:56:29 +0000 (UTC)
Date: Mon, 22 May 2017 10:56:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170522135625.GE18350@thinpad.lan.raisama.net>
References: <20170517212547.4767-1-ehabkost@redhat.com>
	<871srmtlxi.fsf@dusky.pond.sub.org>
	<20170519192250.GV4748@thinpad.lan.raisama.net>
	<87vaot2wd5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vaot2wd5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC] qmp: Return 'user_creatable' &
 'hotpluggable' fields on qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Mon, May 22, 2017 at 09:17:58AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Thu, May 18, 2017 at 01:59:53PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > Currently there's no way for QMP clients to get a list of device types
> >> > that are really usable with -device.  This information would be useful
> >> > for management software and test scripts (like the device-crash-test
> >> > script I have submitted recently).  Interestingly, the "info qdm" HMP
> >> > command provides this information, but no QMP command does.
> >> >
> >> > Add two new fields to the return value of qom-list-types:
> >> > "user-creatable-device" and "hotpluggable-device".
> >> 
> >> Does the combination
> >> 
> >>     "user-creatable-device": false,
> >>     "hotpluggable-device": true
> >> 
> >> make any sense?
> >
> > It doesn't, and the code ensures this won't happen.
> 
> Would a single variable with three states be clearer?

I don't think it would, in this specific case.  I can't even see
how to document an enum in this case without being too verbose
and confusing.

If one day we add a different method to plug devices (e.g. by
building a composite QOM object first, and then plugging it), how
exactly would we extend the enum to indicate the new method is
supported by a device?


>                                                        I don't like
> entangled booleans much...

I tend to prefer booleans because each one describe a single fact
and nothing else.

> 
> >> Exposing information on user-creatable/hot-pluggable via QMP makes
> >> sense.  The question is how.  This is a design question, and as so often
> >> with design questions, I need more words to make my case than I'd like
> >> to.  Please bear with me.
> >> 
> >> >                                                     Also, add extra
> >> > arguments for filtering the list of types based on the new fields.
> >> 
> >> I consider the case for filtering weak.  Let's ignore this part for now.
> >
> > I considered sending a version that didn't include filtering.  I
> > will be happy to ignore it.  :)
> >
> >> 
> >> We have a number of commands to introspect static information,
> >> e.g. query-version, query-commands, query-qmp-schema, query-target,
> >> query-machines, query-cpu-definitions, query-chardev-backends,
> >> device-list-properties, qom-list-types.
> >> 
> >> Aside: us abandoning the convention to name such commands query-FOO is
> >> regrettable.
> >> 
> >> In its basic form, i.e. without arguments, qom-list-types does what its
> >> name suggests: it lists the QOM types.
> >> 
> >> It also permits finding out whether a type is abstract, but only in a
> >> roundabout way: subtract the result of running it without arguments (or
> >> with 'abstract':false) from the result with 'abstract':true.
> >> 
> >> It also permits finding the "implements" relation, but only in an even
> >> more roundabout way: run it with 'implements':T for every abstract T,
> >> then solve the resulting puzzle.
> >> 
> >> Unless there's a direct way to find both (and I'm not aware of any),
> >> this is bad design.  The obvious fix is to extend its return type to
> >> include the information.
> >
> > Agreed.
> >
> >> 
> >> With qom-list-types fixed that way, there's precedence for exposing
> >> additional information on QOM types there.
> >> 
> >> Note that both the "abstract" bit and the "implements directly" list
> >> apply to any QOM type, not just to certain subtypes.  As proposed,
> >> "user-creatable-device' and "hotpluggable-device" apply only to the
> >> "device" subtype.  There's no precedence for exposing information
> >> specific to certain subtypes.
> >> 
> >> If we want to do it anyway, then qom-list-type should perhaps return a
> >> union.  Taken to the logical conclusion, this becomes a nest of unions
> >> mirroring the "direct subtype of" relation.  Hmm.
> >
> > I don't think that's the logical conclusion.  The differences
> > between "object" and "device" are hardcoded in our interfaces: we
> > already have -object and -device.  Modelling our data to take
> > care of thoes differences doesn't mean we will also have to treat
> > the differences between other QOM types (e.g. between
> > "pci-device" and "usb-device") the same way.
> 
> *If* we make qom-list-type return a union to properly reflect which
> results apply to which devices, *then* the logical conclusion is a nest
> of unions mirroring the "direct subtype of" relation.
> 
> "Hmm" expresses my less than enthusiastic reaction to the thought of
> such a nest.
> 
> > Now, we could choose to encode that in different ways.  We could
> > have a single command for all QOM types (like qom-list-types or a
> > new query-qom-type command) that return an union, or have
> > separate commands for object types and device types.  I'm not
> > sure what's the better option here (see below for additional
> > comments on that).
> >
> >> 
> >> However, we already have a command to introspect device types:
> >> device-list-properties.  Can we expose the information as read-only
> >> property/ies of type "device" and be done?
> >
> > I don't think we should.  device-list-properties has a very
> > specific purpose: listing QOM properties that can be read or
> > written using qom-get and qom-set, or set in -device.  If there's
> > no use case for qom-get/qom-set on a property like "hotpluggable"
> > or "user-creatable", we shouldn't make them QOM properties (hence
> > they shouldn't appear on device-list-properties).
> 
> I figure your argument boils down to "we should distinguish between
> information about a device instance and a device type, and properties
> are for the former, but ...

Indirectly, yes: device-list-properties takes a device type as
argument, but its purpose is to list the names of QOM properties
we can set/get on device instances.

> 
> > But that doesn't mean we can't have something like a
> > "query-device-type" command that returns other information about
> > a given device type, in addition to the property list.
> 
> ... we still need something for the latter."

True.

> 
> > (In my specific use case (the device-crash-test script), I would
> > prefer to avoid having to fetch the full list of properties of
> > every single device type, just to find out which ones are
> > user-creatable.  But this is not really performance-critical
> > code, so I can live with that.)
> >
> > So, I see a few options here:
> >
> > 1) Including DeviceClass::user_creatable and
> >    DeviceClass::hotpluggable in qom-list-types output.  Probably
> >    using an union.
> >
> > 2) Adding a new "query-device-type" command, returning
> >    DeviceClass::user_creatable and DeviceClass::hotpluggable, and
> >    possibly other DeviceClass fields (like the list of
> >    properties)
> >
> > 3) Adding a new "query-qom-type" command, returning extended
> >    information about a QOM type.  This might include the list of
> >    properties supported by the type.  This might include
> >    device-specific data if the command return an union.
> 
> That way's a nest of unions.

I still don't think it means a nest of unions, but I prefer
option 2 to option 3+union anyway.  Having two separate commands
returning different structures sounds simpler and better than a
single command returning an union.

> 
> > Those options are not mutually exclusive.  e.g.: we might decide
> > that a small set of fields is useful if included in
> > qom-list-types too, even if we implement a query-device-type or
> > query-qom-type command.
> 
> Yes.  But let's start with just one.

I already submitted a RFC to extend qom-list-types.  I will
probably submit another RFC to add a query-device-type command.

> 
> >> But perhaps they aren't really specific to devices.  There are other QOM
> >> types that can be created by users, e.g. with -object, so the
> >> "user-creatable" bit applies more widely.  Are any of them only
> >> creatable during initial startup?  If yes, then that applies more
> >> widely, too.
> >
> > I prefer to have very specific semantics like "this type can be
> > used with -device" than something more generic and prone to
> > confusion like "this can be user-creatable, but the method used
> > to create it can vary".
> 
> Point taken.
> 
> We have user-creatable objects and user-creatable devices.  The latter
> are objects, but not user-creatable objects.  Aesthetically displeasing.

Also, support for -object is represented using the
"user-creatable" interface name.  So user-creatable devices do
not implement the "user-creatable" interface.

We need better names for all that.  I suggest we call objects
supported by -object "user-creatable backend objects" instead of
just "user-creatable objects".  Devices are objects, but they are
not backend objects.

> 
> >> > I'm not sure about the naming of the new command arguments.  Maybe the
> >> > names are too long, but I believe that "user-creatable-devices-only=false"
> >> > would have more obvious semantics than "user-creatable-devices=false"
> >> > (the latter looks ambiguous: it could mean "return only
> >> > non-user-creatable devices" or "return all devices").
> >> 
> >> I consider the filtering feature unnecessary complexity.  The filtering
> >> we have got in against my objections.  I won't veto additional filtering
> >> outright, but I will insist on test coverage.
> >> 
> >> The unfiltered output of qom-list-types is less than 10 KiB.  Even if we
> >> extend it some, the need to filter it client-side seems dubious.  If a
> >> management application really wants to save resources here, it should
> >> cache the result and re-get it only when QEMU changes.
> >
> > I don't think we really need filtering, and I will be happy to
> > remove that feature on the next version.
> 
> We can always add it later if we find a real need.

-- 
Eduardo
