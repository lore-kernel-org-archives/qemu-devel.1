Received: from eggs.gnu.org ([2001:4830:134:3::10]:41545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chIMO-00023Y-92
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chIMN-0003F8-9O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:04:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
Date: Fri, 24 Feb 2017 17:04:34 +0100
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 02 Feb 2017 20:42:33 +0100")
Message-ID: <87o9xr60dp.fsf@dusky.pond.sub.org>
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
> outlaw '.' in KEYs.  QAPI outlaws '.' already,

*Except* in __RFQDN_ prefixes.

Say example.com needs to add a downstream extension to block driver
"raw".  Following QAPI rules, they add to to struct BlockdevOptionsRaw a
new optional member:

    '*__com.example_medium-rare': 'bool'

On the command line, this looks like

    -blockdev node-name=foo,driver=raw,__com.example_medium-rare=on,file.driver=file,file.filename=foo.img

Dotted keys parse this as a reference to member __com's member
example_medium-rare.

Possible solutions:

(a) Outlaw domain names with '_'.  If KEY starts with "__", everything
    up to the third '_' is an __RFQDN_ prefix.

(b) Outlaw '_' in the name part that follows __RFQDN_.  If KEY starts
    with "__", everything up to the last '_' is an __RFQDN_ prefix.

(c) Your bright idea.

I think (b) should do.  QAPI prefers '-' over '_' for new member names
anyway.

>                                                but we have a bunch of
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

[...]
