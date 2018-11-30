Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfrM-0001JE-AF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfrG-0001HT-E7
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:17:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSfrG-0001Gn-4u
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:17:14 -0500
Date: Fri, 30 Nov 2018 10:17:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130101705.GF8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <87r2f3nj80.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2f3nj80.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] What's our ABI promise for externally visible QOM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Nov 30, 2018 at 07:59:59AM +0100, Markus Armbruster wrote:
> QOM types and the QOM graph are externally visible:
> 
> * qom-list-types returns QOM type names and parents.
> 
>   Fine print: the result is limited to concrete types by default.
>   Aside: that's the only way to figure out whether a type is abstract.
>   Interface design fail.  The result can optionally be limited to
>   sub-types of a certain type.
> 
> * qom-list-properties returns a named type's static properties.
> 
> * qom-list returns an object's properties.  This lets clients traverse
>   the QOM graph.
> 
> * qom-get returns a property's value.
> 
> * qom-set changes a property's value.
> 
> * -object and object-add create a QOM object of a certain type with
>   certain property values.  The type must be a sub-type of
>   "user-creatable".
> 
> * Types are identified by name.
> 
> * Objects and properties are identified by QOM path.  An absolute QOM
>   paths is the path within the composition tree starting at the root.
>   Partial paths are a convenience you don't want to understand.
> 
> What promises do we make regarding the stability  / backward
> compatibility of these externally visible entities?
> 
> The QMP command documentation is silent on it.  A user could reasonably
> assume that the general QMP stability promise extends to all of QOM.
> Does it?

Since we've never declared this, perhaps we need to turn it around and
ask what aspects are current users of QMP relying on to be stable ?

If we expect the values passed to CLI args to be stable, then we have
to say that type names and property names that can be given to -device
and -object have an implied stability promise. This would cover any
type which implements the 'user-creatable' interface IIUC.

The qom-list-properties / qom-list commands return both property names
and property types. Apps reasonably expect the property names to be
stable since that's how they determine if the feature exists.

The type names listed here are questionable though. The names we give
to property types are surprisingly adhoc once you get awya from the
basic scalar types.

eg qom-list path=/machine shows some really questionable type names

 - struct tm
 - OnOffAuto
 - on|off|split


I think I'd say that non-user-creatable typenames for objects which
are not devices are considerd unstable. They're not usable with
-object and so should only be exposed to internal code, never QMP
or CLI.

Non-user-creatable typenames for devices though are trickier, as
they are exposed to the CLI via -global, so that effectively makes
them a public API.

CPU type names were historically internal only, but with the
query-cpu-definitions command, these type names are now exposed
to apps.  We could possibly claim the typenames are non-stable
as we'd expect apps to use the CPU model name instead ?

> Was that the intent when we created qom-list, qom-set, qom-get?
> Andreas, do you remember?
> 
> Is it practical given the current state of affairs?
> 
> Is it a good idea?

Keeping as much private as possible is obviously desirable, but
in most areas it looks like the horse has bolted given the combo
of -global, -device and -object, together with many QMP commands.

We could perhaps make some targetted efforts to declare certain
things unstable (CPU type names, object property type names).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
