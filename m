Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQdXd-00072x-AW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQdXY-0007iY-AI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQdXY-0007fu-2R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:47:40 -0400
Date: Thu, 29 Jun 2017 14:47:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170629174734.GV12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<6fac3c3d-9cf8-cb79-0141-908fe8160a5b@redhat.com>
	<20170629141805.GG32167@redhat.com>
	<20170629170939.GU12152@localhost.localdomain>
	<20170629173850.GI32167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629173850.GI32167@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Jun 29, 2017 at 06:38:50PM +0100, Daniel P. Berrange wrote:
> On Thu, Jun 29, 2017 at 02:09:39PM -0300, Eduardo Habkost wrote:
> > On Thu, Jun 29, 2017 at 03:18:05PM +0100, Daniel P. Berrange wrote:
> > > On Thu, Jun 29, 2017 at 03:39:58PM +0200, Paolo Bonzini wrote:
> > > > On 28/06/2017 11:05, Markus Armbruster wrote:
> > > > > If foo() additionally returned an indication of success, you could write
> > > > > 
> > > > >       if (!foo(arg, errp)) {    // assuming foo() returns a bool
> > > > >           handle the error...
> > > > >       }
> > > > > 
> > > > > Nicely concise.
> > > > > 
> > > > > For what it's worth, this is how GLib wants GError to be used.  We
> > > > > deviated from it, and it has turned out to be a self-inflicted wound.
> > > > > 
> > > > 
> > > > I find Eduardo's proposal better.  With GLib's way it's easy to confuse
> > > > functions that return 0/-1, 0/-errno, TRUE/FALSE, FALSE/TRUE or
> > > > NULL/non-NULL.
> > > 
> > > NB, glib basically standardizes on just FALSE/TRUE and NULL/non-NULL,
> > > avoiding anything returning -1, or errno values, so in their usage
> > > there isn't really any confusion.
> > > 
> > > QEMU of course has lots of pre-existing code, but we could at least
> > > declare a preferred approach, and work towards it.
> > > 
> > > Having the return value indicate error is slightly shorter, and it
> > > avoids all the blackmagic with special Error values in Eduardo's
> > > series. Most usefully, it lets you use __attribute__(return_check)
> > > to get compile time checking of callers who forget to check for
> > > failure.
> > 
> > I agree it's better when the return value is obvious, but I still think
> > the Error value magic in IGNORE_ERRORS/ERR_IS_SET is preferable to the
> > existing 700+ error_propagate() calls in the tree.
> 
> Both approaches would let us kill the error_propagate() calls. I think
> we're all agreed those would be better off gone, no matter which
> approach is used.

Changing the return value of the 1500+ void functions that return errors
will take a very long while.  I would like to get rid of the
error_propagate() calls before that, even if the long term plan is to
eventually get rid of ERR_IS_SET.

-- 
Eduardo
