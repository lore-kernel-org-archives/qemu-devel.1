Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRItX-0005mF-Na
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRItW-000842-5k
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRItV-00083G-V1
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1CAD7EA94
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 14:29:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171218144145.13579-1-famz@redhat.com>
Date: Tue, 19 Dec 2017 15:29:15 +0100
In-Reply-To: <20171218144145.13579-1-famz@redhat.com> (Fam Zheng's message of
	"Mon, 18 Dec 2017 22:41:45 +0800")
Message-ID: <87r2rqg5ac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC] error: Include hint everywhere
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Adding Eric for additonal QMP design expertise.

Fam Zheng <famz@redhat.com> writes:

> Previously we only print hint lines if we are in a command line context
> or HMP. However QMP errors are also eventually consumed by human and the
> hint could help.
>
> Append hint lines already in error_get_pretty() and do as said above
> consistently in CLI, HMP and QMP.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Problematic.

The intended use of the "hint" feature is to add hints on the *human*
user interface.  These need not make sense for QMP, which has different
syntax.  Please see
http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01991.html
(which I let fall through the cracks, sorry about that).

In practice, we've been using / abusing the feature for other purposes,
too, i.e. hints that do make sense for QMP.

If we decide we want to transmit such hints via QMP, we need to decide
how to (more on that below), and we need to examine the existing hints
one by one to decide whether they make sense for QMP.

If we determine that all of the existing hints make sense for QMP, and
expect that all future hints will, then we can repurpose
error_append_hint().  Else, we need two functions, one for each kind of
hint.

On to QMP design.  Quote qmp-spec.txt:

    2.4.2 error
    -----------

    The format of an error response is:

    { "error": { "class": json-string, "desc": json-string }, "id": json-value }

     Where,

    - The "class" member contains the error class name (eg. "GenericError")
    - The "desc" member is a human-readable error message. Clients should
      not attempt to parse this message.
    - The "id" member contains the transaction identification associated with
      the command execution if issued by the Client

Your patch changes "desc" from a short(ish) message without newline to a
multi-line message that may or may not end with a newline (I think).
Is that a good idea?

The conservative way to add hints is a new optional member.
