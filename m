Received: from eggs.gnu.org ([2001:4830:134:3::10]:40660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqFLI-0005Lg-Qf
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 04:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqFLH-0004G7-Qa
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 04:40:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
Date: Tue, 21 Mar 2017 09:40:26 +0100
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 02 Feb 2017 20:42:33 +0100")
Message-ID: <87y3vzrpj9.fsf@dusky.pond.sub.org>
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

For the record, we went with "either dotted keys or JSON" for -blockdev
in 2.9.

Certain uses of QAPI become problematic with dotted keys, because

(1) it's untyped except for inner tree nodes, and therefore can't
express numbers, boolean, null, empty list, empty object, and

(2) The keyval variant of the QObject input visitor (the thing returned
by qobject_input_visitor_new_keyval()) can't fully hide this.

I don't like this at all, but the whole non-flat command line argument
design has been an exercise in picking what I dislike least.

Example: object-add's use of 'any' for properties

    QOM properties aren't specified in the QAPI schema (let's ignore the
    question whether they should be here).  object-add uses type 'any'
    to take a dictionary of them.  object-add obviously needs to do the
    type checking itself.  In C, type 'any' is QObject *.

    If object-add examines the QObject directly, it now needs to know
    whether it was made from dotted keys, so it can cope with dotted
    keys' "everything's a string".

    Probably the only sane way to do that is to use the appropriate
    visitor.  Perhaps we should represent 'any' as QObjectInputVisitor *
    instead of QObject *.

Example: TCP service name / port number as alternate of string, number

    We use string, just like getaddrinfo(): if the string is a decimal
    number, it's a port number, else a service name.

    An alternate of string and number would be more idiomatic QAPI
    (let's ignore compatibility here, it's just an example).  Works fine
    with JSON.  Breaks with dotted keys, because you always get the
    alternate's string variant there.

Possible ways forward:

* When it breaks, fall back to JSON

  Tolerable if it breaks pretty much only in obscure corner cases.

* More syntax

  Add syntax to disambiguate the type (key sigils?).  Has to be optional
  for backward compatibility reasons.  When omitting type information
  breaks, you have to supply it, or fall back to JSON.

  More syntax for use in obscure cases is about the last thing the QEMU
  command line needs.

* More magic

  Make the keyval variant of the QObject input visitor shift the
  breakage to hopefully less common cases.

  - Empty list magic

    When the visitor is asked for a list, and the list's key wasn't
    specified, return an empty list instead of failure.  Unbreaks empty
    list, breaks absent optional list.

  - Alternate magic

    When the visitor is asked for an alternate, pick the alternate's
    variant based on the value rather than the type for scalar values
    (the type is always 'str' then).  Unbreaks alternates when this
    picks the variant you want, breaks them when you really want 'str'.

  - Possibly more

  When the magic breaks, fall back to JSON.

  More magic in the QEMU command line feels even worse to me than more
  syntax.
