Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZNHI-0007xw-Vv
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZNHH-0007GG-DF
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:42:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 02 Feb 2017 20:42:33 +0100
Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

= Introduction =

If you're familiar with prior discussion of non-flat arguments for
-object and -blockdev, you can probably skip ahead to "= Structured
option argument syntax =".

Structured option arguments use KEY=VALUE,... syntax.  Goes back many
years (at least to commit 7c9d8e0, Nov 2005).  Since 2009, the proper
way to do this is QemuOpts.

QemuOpts can be used in two ways.  You can either declare accepted keys
and their types, or accept arbitrary keys with string values.  The types
supported with declared keys are char *, bool, uint64_t.  Since none of
them is structured, an option argument is basically a flat dictionary.

QMP was created a few months after QemuOpts, and later on rebased onto
QAPI.  Its simple types are char * (JSON string), bool (JSON false,
true), {uint,int}{8,16,32,64}_t and double (JSON number).  Structured
types are dictionary (JSON object) and list (JSON array).  A QMP command
takes a dictionary as argument.  It need not be flat.

Fine print: the implementation currently can't read uint64_t values
above INT64_MAX from the wire, but that's fixable.

We expose a few things both as QMP command and as command line option:
netdev_add and -netdev, device_add and -device, chardev-add and
-chardev, ...

When the QMP command's argument dictionary happens to be flat,
translating it to QemuOpts is easy enough, if you're willing to map all
integers to uint64_t, and don't need floating-point.

However, many argument dictionaries aren't flat, and numeric types other
than uint64_t exist for a reason.  We need command line option arguments
that are just as expressive as QMP command arguments.  Moreover, having
to translate the argument type from QAPI to QemuOpts is dumb.

We actually have a way to use a QAPI type for an option argument without
translating it: the options visitor.  But it supports basically just the
intersection of QemuOpts and QMP.  Too limited.

We've hacked around the "flatness" of QemuOpts in various ways over the
years.  We abuse implementation details to express flat lists as
repeated keys (e.g. -semihosting-config, -spice, options visitor).  We
bolted on value syntax for lists of integers in places (options visitor,
string visitor).  We bolted on value syntax for arbitrary nesting in
another place (-drive file=json:...).  We bolted on key syntax for
arbitrary nesting in yet another place (block layer's dotted key
convention).  Most recently, Dan even created a fully functional bridge
between QemuOpts and QMP types based on the dotted key convention
(patches [1], not committed).

In my opinion, we need to stop hacking around QemuOpts design
limitations, and start replacing it.

Naturally, any replacement needs to remain sufficiently backward
compatible.  This memo is about the replacement's option argument
syntax.


= Brief recap of dotted key convention =

We'll discuss use of dotted key convention later, so let me explain it
briefly for the readers who don't know it already.

The dotted key convention interprets the KEY part as a sequence of names
separated by dots.  If a name looks like an integer *handwave*, it's an
array index, else it's an object member name.  The first name must be an
object member name, because the option argument is an object, not an
array.  Restriction: can't express member names that look like an
integer.

Example: port=5901 sets the option argument member "port" to the value
5901.

Example: foo.0.bar=bla updates the option argument member "foo", whose
value is an array.  The array's 0-th element is an object with a member
"bar".  That member's value is set to "bla".

The various KEYs need to be consistent in their use of array vs. object.
For instance, foo.0.bar=bla,foo.eek.bar=blubb isn't, because it uses the
value of member "foo" both as array and as object.


= Structured option argument syntax =

== JSON ==

The obvious way to provide the expressiveness of JSON on the command
line is JSON.  Easy enough[2].  However, besides not being compatible,
it's rather heavy on syntax, at least for simple cases.  Compare:

    -machine q35,accel=kvm
    -machine '{ "type": "q35", "accel": "kvm"}'

It compares a bit more favourably in cases that use our non-flat hacks.
Here's a flat list as KEY=VALUE,... with repeated keys, and as JSON:

    -semihosting-config enable,arg=eins,arg=zwei,arg=drei
    -semihosting-config '{ "enable": true, "arg": [ "eins", "zwei", "drei" ] }'

Arbitrary nesting with dotted key convention:

    -drive driver=qcow2,file.driver=gluster,
           file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
           file.server.0.type=tcp,
           file.server.0.host=1.2.3.4,
           file.server.0.port=24007,
           file.server.1.type=unix,
           file.server.1.socket=/var/run/glusterd.socket
    -drive '{ "driver": "qcow2",
              "file": {
                  "driver": "gluster", "volume": "testvol",
                  "path": "/path/a.qcow2", "debug": 9,
                  "server": [ { "type": "tcp",
                                "host": "1.2.3.4", "port": "24007"},
                              { "type": "unix",
                                "socket": "/var/run/glusterd.socket" } ] } }'

Lines broken and indented for legibility; you need to join them for
actual use.  Once you do, both variants are basically illegible.  This
is simply something that belongs into a config file rather than the
command line.  In a config file, JSON would be a better choice.

There's also the -drive file=json:... syntax.  It's a bad fit for
QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show you
if I could get it to work.

We obviously can't replace QemuOpts with JSON.  But accepting JSON in
addition to QemuOpts is a debatable feature: it lets management
applications reuse the code to build QMP arguments for option arguments.

Since structured option arguments are always dictionaries, a JSON option
argument always starts with '{'.  If no QemuOpts argument can ever start
with '{', accepting either QemuOpts or a JSON object is unambiguous.
For a more detailed discussion of the following argument, see [3].

A QemuOpts argument normally starts with KEY.  We need to outlaw KEYs
starting with '{'.  QAPI outlaws such names, see docs/qapi-code-gen.txt.
QOM doesn't, but no such keys exist as far as I know.

QemuOpts permit abbreviating KEY=VALUE to just VALUE for one specific
KEY (the "implied" key).  We need to limit this to KEYs whose VALUE
can't start with '{'.  Most implied keys can't have such values.
Troublemakers include qemu-img's use of implied "file" keys.  You'd have
to say "file={my-tastelessly-named-file}" instead of just
"{my-tastelessly-named-file}".

== Extensions of the traditional syntax ==

Even if we accept JSON in addition to the traditional KEY=VALUE,...
syntax, we might want to make the traditional syntax more expressive
anyway.  Do we?

Kevin brought up an argument for yes: without it, going from the simple,
flat case to the nested case involves a complete syntax change from
KEY=VALUE,... to JSON.

=== Dotted keys ===

One sufficiently powerful syntax extension already exists: the dotted
key convention.  It's syntactically unambiguous only when none of the
KEYs involved contains '.'  To adopt it across the board, we'd have to
outlaw '.' in KEYs.  QAPI outlaws '.' already, but we have a bunch of
QOM properties names with '.'.  We'd have to rename at least the ones
that need to be accessible in -object.

Dotted keys can't express member names that look like integers.  We'd
have to outlaw them at least for the objects that are accessible on the
command line.  Once again, QAPI outlaws such names already.  QOM is
anarchy when it comes to names, however.

The way dotted keys do arrays is inconsistent with how QOM's automatic
arrayification (commit 3396590) do them: foo.0 vs. foo[0].  Backward
compatibility makes changing the dotted key convention awkward.  Perhaps
we can still change QOM.

=== Structured values ===

The dotted key convention messes with KEY syntax to permit structured
values.  Works, but the more conventional way to support structured
values is a syntax for structured values.  

An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
... ] for arrays.  Looks like this:

    -drive 'driver=quorum,
            child=[{ driver=file, filename=disk1.img },
                   { driver=host_device, filename=/dev/sdb },
                   { driver=nbd, host=localhost } ]'

Again, lines broken and indented for legibility; you need to join them
for actual use.

There's a syntactic catch, though: a value of the form [ ... ] can
either be an array or a string.  Which one it is depends on the type of
the key.  To parse this syntax, you need to know the types, unlike JSON
or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
'[', which feels impractical.

But wait, there's another syntactic catch: in traditional QemuOpts, a
value ends at the next unescaped ',' or '\0'.  Inside an object, it now
also ends at the next unescaped '}', and inside an array, at the next
unescaped ']'.  Or perhaps at the next space (the example above assumes
it does).  That means we either have to provide a way to escape '}', ']'
and space, or find another way to delimit string values, say require '"'
around strings whenever the string contains "funny" characters.

So, if escaped ',' wasn't ugly and confusing enough for you...

=== Comparison ===

In my opinion, dotted keys are weird and ugly, but at least they don't
add to the quoting mess.  Structured values look better, except when
they do add to the quoting mess.

I'm having a hard time deciding which one I like less :)

Opinions?  Other ideas?




[1] [PATCH v14 00/21] QAPI/QOM work for non-scalar object properties
(actually v15)
Message-Id: <1475246744-29302-1-git-send-email-berrange@redhat.com>
http://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08238.html

[2] [RFC PATCH] block: Crude initial implementation of -blockdev
Message-Id: <1485968933-9162-1-git-send-email-armbru@redhat.com>
http://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00182.html

[3] Message-ID: <87h989ncse.fsf@dusky.pond.sub.org>
http://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04046.html
