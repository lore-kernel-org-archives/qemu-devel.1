Received: from eggs.gnu.org ([2001:4830:134:3::10]:59952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciIWj-00021Y-N6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciIWi-0001Yf-Oj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:27:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
Date: Mon, 27 Feb 2017 11:27:18 +0100
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 02 Feb 2017 20:42:33 +0100")
Message-ID: <87poi4c4jd.fsf@dusky.pond.sub.org>
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

Design flaw: there is no good way to denote an empty array or object
other than the root object.

Empty KEY=VALUE,... is valid and results in an empty root object.

Presence of a KEY that contains periods results in additional non-root
objects or arrays.  For instance, KEY a.b.c results in root object
member "a" that has member "b" that has (scalar) member "c".

These additional objects and arrays all have at least one member, by
construction.

Begs the question how to denote an empty object or array other than the
root.

A natural idea is to interpret "absent in KEY=VALUE,..." as empty.
After all, removing one key from it removes one member when there are
more, so why not when there aren't.

Sadly, it doesn't work: "absent in KEY=VALUE,..." already means
"optional object/array absent", which isn't the same as "empty
object/array present".

Without additional syntax, all we can do is choose what exactly to make
impossible:

* Absent key means absent, period.  No way to do empty array or object.
  This is what I implemented.

* Absent key means absent, except when the member is visited it means
  empty.  No way to do absent optional array or object.

* Likewise, but if the visit is preceeded by a test for presence with
  visit_optional(), it means absent again.  No way to do present
  optional empty array or object.  This requires keeping additional
  state.

Any bright ideas on how to avoid making things impossible?


[...]
