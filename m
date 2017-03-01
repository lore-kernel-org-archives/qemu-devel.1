Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cj0VA-0006c3-Cr
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cj0V8-0000Mp-PP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:24:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
Date: Wed, 01 Mar 2017 10:24:41 +0100
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 02 Feb 2017 20:42:33 +0100")
Message-ID: <8737exuz6u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
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

Markus Armbruster <armbru@redhat.com> writes:

[...]
> == Extensions of the traditional syntax ==
>
> Even if we accept JSON in addition to the traditional KEY=VALUE,...
> syntax, we might want to make the traditional syntax more expressive
> anyway.  Do we?
>
> Kevin brought up an argument for yes: without it, going from the simple,
> flat case to the nested case involves a complete syntax change from
> KEY=VALUE,... to JSON.
>
> === Dotted keys ===
>
> One sufficiently powerful syntax extension already exists: the dotted
> key convention.  It's syntactically unambiguous only when none of the
> KEYs involved contains '.'  To adopt it across the board, we'd have to
> outlaw '.' in KEYs.  QAPI outlaws '.' already, but we have a bunch of
> QOM properties names with '.'.  We'd have to rename at least the ones
> that need to be accessible in -object.
>
> Dotted keys can't express member names that look like integers.  We'd
> have to outlaw them at least for the objects that are accessible on the
> command line.  Once again, QAPI outlaws such names already.  QOM is
> anarchy when it comes to names, however.
>
> The way dotted keys do arrays is inconsistent with how QOM's automatic
> arrayification (commit 3396590) do them: foo.0 vs. foo[0].  Backward
> compatibility makes changing the dotted key convention awkward.  Perhaps
> we can still change QOM.
>
> === Structured values ===
>
> The dotted key convention messes with KEY syntax to permit structured
> values.  Works, but the more conventional way to support structured
> values is a syntax for structured values.  
>
> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
> ... ] for arrays.  Looks like this:
>
>     -drive 'driver=quorum,
>             child=[{ driver=file, filename=disk1.img },
>                    { driver=host_device, filename=/dev/sdb },
>                    { driver=nbd, host=localhost } ]'
>
> Again, lines broken and indented for legibility; you need to join them
> for actual use.
>
> There's a syntactic catch, though: a value of the form [ ... ] can
> either be an array or a string.  Which one it is depends on the type of
> the key.  To parse this syntax, you need to know the types, unlike JSON
> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
> '[', which feels impractical.
>
> But wait, there's another syntactic catch: in traditional QemuOpts, a
> value ends at the next unescaped ',' or '\0'.  Inside an object, it now
> also ends at the next unescaped '}', and inside an array, at the next
> unescaped ']'.  Or perhaps at the next space (the example above assumes
> it does).  That means we either have to provide a way to escape '}', ']'
> and space, or find another way to delimit string values, say require '"'
> around strings whenever the string contains "funny" characters.
>
> So, if escaped ',' wasn't ugly and confusing enough for you...

=== Implicit value types ===

In JSON, the type of a value is syntactically obvious: "9", "true" and
"null" are strings.  9, true and null are of number, boolean and null
type, respectively

Except our internal representation of numbers maps JSON number either to
an integer (QInt) or a double (QFloat), depending on the value.  The
QObject input visitor masks this detail: a visit of a numeric type
succeeds when the value is representable in this type, regardless of
QInt vs. QFloat.  The detail remains visible when you use type 'any',
then examine the QObject yourself.  I'd recommend examining it with the
QObject input visitor.

Actually, the visitor's masking isn't tight around
visit_start_alternate().  You have to choose whether QInt values trigger
the integer alternative, or the float alternative.  The generated
visitors choose the former when it can work, i.e. when the alternate
contains an integer type.  Even when it can't actually represent the
value.  Perhaps I can improve this some day.

Traditional KEY=VALUE,... syntax does not distingish types.  With dotted
keys, all values are scalars, so this affects only string, number,
boolean and null.  With structured values, it also affects array and
object.

The obvious solution (proposed and implemented by Daniel Berrange) is to
resolve this type ambiguity just like the integer vs. float ambiguity:
you get what you ask for.  This leads to just the same issues with 'any'
and with alternates.

Code examining the QObject needs to be prepared for the difference
between a QObject parsed from JSON (or built that way) and a QObject
parsed from KEY=VALUE,...  You can't just pass a QObject around anymore,
you have to pass along whether it's from JSON or from KEY=VALUE.  A good
way to do that is to wrap the correct QObject input visitor around the
QObject, and pass that instead.

The alternate issue is more serious than with numbers.  Which
alternative should be picked if one of them is string?  Or an enum with
sufficiently funny values.

Possible solutions:

* Document as restriction, point to JSON

  This is what we do for the "no way to denote empty array or object"
  flaw.  I figure it's what we do for 2.9.  I'll make sure we have test
  coverage.

* Make the QAPI generator reject problematic alternates

  Knee-jerk reaction; there may well be uses of such alternates that are
  safely isolated from KEY=VALUE,... QObjects, and therefore perfectly
  unambiguous.

* Optional syntax to disamiguate types

  We discussed this in the context of empty objects and arrays.
