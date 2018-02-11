Received: from eggs.gnu.org ([2001:4830:134:3::10]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ekkHR-0003c2-Aj
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 00:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ekkHO-0004ig-D1
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 00:34:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ekkHO-0004hs-74
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 00:34:22 -0500
Date: Sun, 11 Feb 2018 13:34:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180211053408.GB31261@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-2-peterx@redhat.com>
	<5df6f309-c865-7b7f-3a3e-afd23bc17694@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5df6f309-c865-7b7f-3a3e-afd23bc17694@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/23] docs: update QMP documents for
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

On Fri, Feb 09, 2018 at 08:10:53AM -0600, Eric Blake wrote:
> On 01/23/2018 11:39 PM, Peter Xu wrote:
> > Update both the developer and spec for the new QMP OOB (Out-Of-Band)
> > command.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   docs/devel/qapi-code-gen.txt | 68 ++++++++++++++++++++++++++++++++++++++++----
> >   docs/interop/qmp-spec.txt    | 30 ++++++++++++++++---
> >   2 files changed, 89 insertions(+), 9 deletions(-)
> > 
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index 06ab699066..4d3db0ad39 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -554,9 +554,12 @@ following example objects:
> >   === Commands ===
> > +--- General Command Layout ---
> > +
> >   Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
> >            '*returns': TYPE-NAME, '*boxed': true,
> > -         '*gen': false, '*success-response': false }
> > +         '*gen': false, '*success-response': false,
> > +         '*allow-oob': false }
> 
> Shouldn't this be '*allow-oob': true, as the only time you add the field is
> if you turn oob on (as it already defaults to off)?
> 
> >   Commands are defined by using a dictionary containing several members,
> >   where three members are most common.  The 'command' member is a
> > @@ -636,6 +639,59 @@ possible, the command expression should include the optional key
> >   'success-response' with boolean value false.  So far, only QGA makes
> >   use of this member.
> > +A command can be declared to support Out-Of-Band (OOB) execution.  By
> > +default, commands do not support OOB.  To declare a command to support
> 
> s/to support/that supports/
> 
> > +it, we need an extra 'allow-oob' field.  For example:
> > +
> > + { 'command': 'migrate_recover',
> > +   'data': { 'uri': 'str' }, 'allow-oob': true }
> > +
> > +To execute a command in Out-Of-Band way, we need to specify the
> > +"control" field in the request, with "run-oob" set to true. Example:
> > +
> > + => { "execute": "command-support-oob",
> > +      "arguments": { ... },
> > +      "control": { "run-oob": true } }
> > + <= { "return": { } }
> 
> This talks more about the QMP user protocol, while the rest of the document
> is about QAPI constructs.  But we do have an example of 'my-first-command'
> in the document, so I guess this is okay.
> 
> > +
> > +Without it, even the commands that support out-of-band execution will
> > +still be run In-Band.
> > +
> > +Please read the "Out-Of-Band Command Execution" section below for more
> > +information on how OOB execution works.
> > +
> > +--- About Out-Of-Band (OOB) Command Execution ---
> 
> Do we really need the paragraph mentioning a forward reference, when the
> very next thing is the item that was referenced?

Yeah, I can remove that paragraph.

For all the rest of comments (above or below, which I omitted), all of
them make sense, and I'll fix accordingly.  Thanks for reviewing.

-- 
Peter Xu
