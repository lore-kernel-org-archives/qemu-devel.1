Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evECu-0003TZ-6c
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evECp-00040J-5n
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:33:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evECo-0003zr-W4
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:32:59 -0400
Date: Mon, 12 Mar 2018 11:32:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312033246.GA5234@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-2-peterx@redhat.com>
	<1eb00cad-0f88-4c62-15da-c209b1f9df8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eb00cad-0f88-4c62-15da-c209b1f9df8a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/23] docs: update QMP documents for
 OOB commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Mar 09, 2018 at 11:13:23AM -0600, Eric Blake wrote:
> On 03/09/2018 02:59 AM, Peter Xu wrote:
> > Update both the developer and spec for the new QMP OOB (Out-Of-Band)
> > command.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   docs/devel/qapi-code-gen.txt | 65 ++++++++++++++++++++++++++++++++++++++++----
> >   docs/interop/qmp-spec.txt    | 30 +++++++++++++++++---
> >   2 files changed, 86 insertions(+), 9 deletions(-)
> 
> If all goes well, I'm planning on taking this series through my QAPI tree,
> with a pull request either late today or early Monday in order to make the
> soft freeze deadline.  We'll see what my review turns up, but hopefully at
> this point it's either clean or minor enough tweaks that I can polish it
> without a v9.

That'll be great.  Thanks Eric!

[...]

> > @@ -102,10 +113,16 @@ The format for command execution is:
> >     required. Each command documents what contents will be considered
> >     valid when handling the json-argument
> >   - The "id" member is a transaction identification associated with the
> > -  command execution, it is optional and will be part of the response if
> > +  command execution.  It is required if OOB is enabled, and optional
> > +  if not.  The same "id" field will be part of the response if
> 
> Ambiguous on whether this is the per-command 'run-oob', or whether this is
> the generic QMP capability requested during qmp_capabilities.  I think the
> intent is that if you enabled the QMP capability up front, ALL commands must
> have an "id", even if they are run in-band without 'run-oob', because the
> 'id' in the response is what will distinguish whether a later OOB request
> overtook a pending in-band reply.

Yes, maybe I should use "OOB capability" to be explicit - exactly as
you explained.

> 
> >     provided. The "id" member can be any json-value, although most
> >     clients merely use a json-number incremented for each successive
> >     command
> > +- The "control" member is optional, and currently only used for
> > +  "out-of-band" execution ("oob" as shortcut). The handling or
> 
> A bit late to be introducing "oob" as shortcut, given that you've already
> used the abbreviation oob earlier in the document.
> 
> > +  response of an "oob" command can overtake prior in-band commands.
> > +  To enable "oob" handling of a particular command, just provide a
> > +  control field with: { "control": { "run-oob": true } }
> >   2.4 Commands Responses
> >   ----------------------
> > @@ -113,6 +130,11 @@ The format for command execution is:
> >   There are two possible responses which the Server will issue as the result
> >   of a command execution: success or error.
> > +As long as the commands were issued with a proper "id" field, then the
> > +same "id" field will be attached in the corresponding response message
> > +so that requests and responses can match.  Clients should drop all the
> > +responses that are with unknown "id" field.
> 
> s/are with/have an/
> 
> I've got quite a few wording tweaks, but the general concept is good. If you
> need to respin for other reasons, feel free to make those improvements, but
> I also don't mind making tweaks myself as part of queuing for a pull
> request, so:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

(I agree on all the rest of the review comments too)

Thanks!

-- 
Peter Xu
