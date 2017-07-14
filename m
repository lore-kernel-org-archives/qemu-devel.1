Received: from eggs.gnu.org ([2001:4830:134:3::10]:34974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dW49H-0000Ir-Qr
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dW49G-0004A9-I4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:13:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 14 Jul 2017 19:12:52 +0200
Message-ID: <87379zhrhn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qapi: Stop abusing "special" values for something
 entirely different
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

Back in March, we discussed Dan's "[PATCH] migration: allow clearing
migration string parameters".  The patch extends command
migrate-set-parameters to interpret empty string arguments to parameters
tls-creds and tls-hostname specially:

    # @tls-creds: ID of the 'tls-creds' object that provides credentials
    #             for establishing a TLS connection over the migration data
    #             channel. On the outgoing side of the migration, the credentials
    #             must be for a 'client' endpoint, while for the incoming side the
    #             credentials must be for a 'server' endpoint. Setting this
    #             will enable TLS for all migrations. The default is unset,
    #             resulting in unsecured migration at the QEMU level. (Since 2.7)
--> #             An empty string means that QEMU will use plain text mode for
--> #             migration, rather than TLS (Since 2.9)
    #
    # @tls-hostname: hostname of the target host for the migration. This
    #                is required when using x509 based TLS credentials and the
    #                migration URI does not already include a hostname. For
    #                example if using fd: or exec: based migration, the
    #                hostname must be provided so that the server's x509
    #                certificate identity can be validated. (Since 2.7)
--> #                An empty string means that QEMU will use the hostname
--> #                associated with the migration URI, if any. (Since 2.9)

Works, since "" is not a valid TLS credentials ID, and not a valid host
name.

I objected:

    The command means "set parameter P to value V".  *Except* when V is
    "", it means something else, namely "reset parameter P to its
    default, whatever that may be".

    This is (a) not general, because it won't do for cases where "" may
    occur as value, and (b) ugly.

    Ugliness is the eye of the beholder.  Lack of generality isn't.

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02841.html

I proposed to instead add JSON null to the set of accepted values, using
an alternate type.

However, Dan needed this for 2.9, adding a first class null type to QAPI
takes a bit of work (~50 lines, plus tests), and the freeze was
literally tomorrow, so I relented, and let this pass in the hope of
deprecating it in favor of the cleaner solution in 2.10.  It became
commit 4af245d.

There's a minor complication with my deprecation plan: the
migrate-set-parameters parameters in question are *also* results of
query-migrate-parameters, because both are defined by reference to type
MigrationParameters.  So, unless we decouple the two by duplicating the
type, changing the parameters of migrate-set-parameters also changes the
results of query-migrate-parameters.  However:

1. *Actual* results don't change (query-migrate-parameters doesn't
   suddenly return null values), only the introspection value changes.

2. This isn't actually a new issue.  The members of MigrationParameters
   are all optional, because query-migrate-parameters needs them to be
   optional.  But they're not actually optional in
   query-migrate-parameters.  Sharing types can make introspection less
   tight than it could be.


Another, similar case has crept in without me noticing: BlockdevRef
(commit d26c9a1, Sep 2013, but declared stable only in 2.9).

# @reference:       references the ID of an existing block device. An
#                   empty string means that no block device should be
#                   referenced.

Works, since "" is not a valid block ID.

BlockdevRef occurs only within arguments of blockdev-add.  blockdev-add
accepts "" in just one place: optional member @backing of COW formats.
Semantics:

* Present means "use this block device" as backing storage

* Absent means "default to the one stored in the image"

* Except "" means "don't use backing storage at all"

The first two are perfectly normal: when the parameter is absent, it
defaults to an implied value, but the value's meaning is the same.

The third one overloads the parameter with a second meaning.  The
overloading *implicit*, i.e. it's not visible in the types.

This is really the same problem as migrate-set-parameters:

* we need a way to say "do something else entirely",

* but we can't use "absent", since it's already taken,

* so we pick one the QAPI schema already allows, but that is not
  actually valid: "".

Instead of the last part, I prefer either

* so we add a *new* value, such as JSON null.

or perhaps

* so we add a second optional parameter to ask for "do something else
  entirely" (since the command can do only one of the two things, you
  may give only one of the two optional parameters).


Here's what I propose to do:

1. Stop abusing values the schema accepts, but are invalid to mean "do
something else entirely".

2. Add a first class null type to QAPI.

3. Turn MigrationParameters members tls-creds and tls-hostname into
alternate of str and null.  Deprecate "".

4. Add a null member to alternate BlockdefRef.  Deprecate "".

I got patches for 2., and I intend to work on 3. and 4.

Since this is "only" about "less than general and ugly", we may decide
to leave things as they are if my patches turn out even uglier.

Meanwhile, opinions?
