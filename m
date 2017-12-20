Received: from eggs.gnu.org ([2001:4830:134:3::10]:60646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRXuB-0003xO-QP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRXu8-0003js-KZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRXu8-0003iY-Bz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:31:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5B107EA83
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 06:30:58 +0000 (UTC)
Date: Wed, 20 Dec 2017 14:30:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171220063056.GA3735@lemon>
References: <20171218144145.13579-1-famz@redhat.com>
	<87r2rqg5ac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2rqg5ac.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH RFC] error: Include hint everywhere
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Tue, 12/19 15:29, Markus Armbruster wrote:
> Adding Eric for additonal QMP design expertise.
> 
> Fam Zheng <famz@redhat.com> writes:
> 
> > Previously we only print hint lines if we are in a command line context
> > or HMP. However QMP errors are also eventually consumed by human and the
> > hint could help.
> >
> > Append hint lines already in error_get_pretty() and do as said above
> > consistently in CLI, HMP and QMP.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Problematic.
> 
> The intended use of the "hint" feature is to add hints on the *human*
> user interface.  These need not make sense for QMP, which has different
> syntax.  Please see
> http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01991.html
> (which I let fall through the cracks, sorry about that).
> 
> In practice, we've been using / abusing the feature for other purposes,
> too, i.e. hints that do make sense for QMP.
> 
> If we decide we want to transmit such hints via QMP, we need to decide
> how to (more on that below), and we need to examine the existing hints
> one by one to decide whether they make sense for QMP.
> 
> If we determine that all of the existing hints make sense for QMP, and
> expect that all future hints will, then we can repurpose
> error_append_hint().  Else, we need two functions, one for each kind of
> hint.
> 
> On to QMP design.  Quote qmp-spec.txt:
> 
>     2.4.2 error
>     -----------
> 
>     The format of an error response is:
> 
>     { "error": { "class": json-string, "desc": json-string }, "id": json-value }
> 
>      Where,
> 
>     - The "class" member contains the error class name (eg. "GenericError")
>     - The "desc" member is a human-readable error message. Clients should
>       not attempt to parse this message.
>     - The "id" member contains the transaction identification associated with
>       the command execution if issued by the Client
> 
> Your patch changes "desc" from a short(ish) message without newline to a
> multi-line message that may or may not end with a newline (I think).
> Is that a good idea?

Hmm, I didn't pay attention to the ending '\n', you are right we should keep it
consistent.

Multiline is not a big problem IMO. Because, I'm inclined to think that for
GenericError errors, desc are not for machines; the desc content is not part of
the API and we are free to update it.

That said, the case where my patch would be inappropriate is when the error
comes from a libvirt misconfiguration but the error message is QEMU-specific and
doesn't make sense in a libvirt (abstraction) context.

So you are probably right we still need to distinguish them in the QMP level.

Maybe the right thing to do is just convert any error_append_hint() to an
updated error_setg() and already include the "hint" in the error message proper.
So that we can document that error_append_hint() is specifically used for the
case said above, for example.

> 
> The conservative way to add hints is a new optional member.

I don't like that because it leaves the decision for how to handle the optional
information to the management layer, which, again, may not have the right
information (whether displaying the message to users makes any sense).

Fam
