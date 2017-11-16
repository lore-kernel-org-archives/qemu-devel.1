Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDAl-0003CF-Bx
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDAi-0007Q6-7a
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:57:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFDAi-0007Or-0X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:57:08 -0500
Date: Thu, 16 Nov 2017 13:56:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171116055654.GC30426@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-19-peterx@redhat.com>
	<20171115105015.GE8130@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171115105015.GE8130@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v3 18/27] qmp: add new event "request-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Nov 15, 2017 at 10:50:15AM +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 06, 2017 at 05:46:34PM +0800, Peter Xu wrote:
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 531fd4c0db..650714da06 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3222,3 +3222,38 @@
> >  # Since: 2.11
> >  ##
> >  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> > +
> > +##
> > +# @RequestDropReason:
> > +#
> > +# Reasons that caused one request to be dropped.
> 
> Please use "command" consistently.  QMP does not call it not "request".

Sure.

> 
> > +#
> > +# @queue-full: the queue of request is full.
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'enum': 'RequestDropReason',
> > +  'data': ['queue-full' ] }
> > +
> > +##
> > +# @REQUEST_DROPPED:
> > +#
> > +# Emitted when one QMP request is dropped due to some reason.
> 
> Please add:
> 
>   REQUEST_DROPPED is only emitted when the oob capability is enabled.
> 
> Rationale: old clients don't know about this event so they cannot be
> expected to handle it!

Added.

> 
> > +#
> > +# @id:    If the original request contains an string-typed "id" field,
> > +#         it'll be put into this field.  Otherwise it'll be an empty
> > +#         string.
> 
> Please change:
> 
>   @id: The dropped command's string-typed "id" field.

Ok.

> 
> Sending commands without the id field is likely to cause confusion since
> there are cases where the client is unable to determine which command
> was meant.  Since client code needs to be updated to enable the oob
> capability anyway, we might as well require that clients always include
> the id field with every command when the oob capability is enabled.
> Please mention this requirement where the oob capability is documented.

Will do.  Thanks!

-- 
Peter Xu
