Received: from eggs.gnu.org ([2001:4830:134:3::10]:41203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBK64-0003zh-KE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBK63-0000Nh-EX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBK63-0000NT-6X
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:59:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20E5647059
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 11:59:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170517212547.4767-1-ehabkost@redhat.com>
Date: Thu, 18 May 2017 13:59:53 +0200
In-Reply-To: <20170517212547.4767-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 17 May 2017 18:25:47 -0300")
Message-ID: <871srmtlxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Currently there's no way for QMP clients to get a list of device types
> that are really usable with -device.  This information would be useful
> for management software and test scripts (like the device-crash-test
> script I have submitted recently).  Interestingly, the "info qdm" HMP
> command provides this information, but no QMP command does.
>
> Add two new fields to the return value of qom-list-types:
> "user-creatable-device" and "hotpluggable-device".

Does the combination

    "user-creatable-device": false,
    "hotpluggable-device": true

make any sense?

Exposing information on user-creatable/hot-pluggable via QMP makes
sense.  The question is how.  This is a design question, and as so often
with design questions, I need more words to make my case than I'd like
to.  Please bear with me.

>                                                     Also, add extra
> arguments for filtering the list of types based on the new fields.

I consider the case for filtering weak.  Let's ignore this part for now.

We have a number of commands to introspect static information,
e.g. query-version, query-commands, query-qmp-schema, query-target,
query-machines, query-cpu-definitions, query-chardev-backends,
device-list-properties, qom-list-types.

Aside: us abandoning the convention to name such commands query-FOO is
regrettable.

In its basic form, i.e. without arguments, qom-list-types does what its
name suggests: it lists the QOM types.

It also permits finding out whether a type is abstract, but only in a
roundabout way: subtract the result of running it without arguments (or
with 'abstract':false) from the result with 'abstract':true.

It also permits finding the "implements" relation, but only in an even
more roundabout way: run it with 'implements':T for every abstract T,
then solve the resulting puzzle.

Unless there's a direct way to find both (and I'm not aware of any),
this is bad design.  The obvious fix is to extend its return type to
include the information.

With qom-list-types fixed that way, there's precedence for exposing
additional information on QOM types there.

Note that both the "abstract" bit and the "implements directly" list
apply to any QOM type, not just to certain subtypes.  As proposed,
"user-creatable-device' and "hotpluggable-device" apply only to the
"device" subtype.  There's no precedence for exposing information
specific to certain subtypes.

If we want to do it anyway, then qom-list-type should perhaps return a
union.  Taken to the logical conclusion, this becomes a nest of unions
mirroring the "direct subtype of" relation.  Hmm.

However, we already have a command to introspect device types:
device-list-properties.  Can we expose the information as read-only
property/ies of type "device" and be done?

But perhaps they aren't really specific to devices.  There are other QOM
types that can be created by users, e.g. with -object, so the
"user-creatable" bit applies more widely.  Are any of them only
creatable during initial startup?  If yes, then that applies more
widely, too.

> I'm not sure about the naming of the new command arguments.  Maybe the
> names are too long, but I believe that "user-creatable-devices-only=false"
> would have more obvious semantics than "user-creatable-devices=false"
> (the latter looks ambiguous: it could mean "return only
> non-user-creatable devices" or "return all devices").

I consider the filtering feature unnecessary complexity.  The filtering
we have got in against my objections.  I won't veto additional filtering
outright, but I will insist on test coverage.

The unfiltered output of qom-list-types is less than 10 KiB.  Even if we
extend it some, the need to filter it client-side seems dubious.  If a
management application really wants to save resources here, it should
cache the result and re-get it only when QEMU changes.
