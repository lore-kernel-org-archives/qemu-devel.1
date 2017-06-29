Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQaDH-0004yP-CG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQaDD-0003Y2-SR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQaDD-0003XO-Ki
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:14:27 -0400
Date: Thu, 29 Jun 2017 15:14:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629141421.GF32167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9t8qy7d.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, Jun 28, 2017 at 11:05:26AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Rationale
> > ---------
> >
> > I'm often bothered by the fact that we can't write the following:
> >
> >     foo(arg, errp);
> >     if (*errp) {
> >         handle the error...
> >         error_propagate(errp, err);
> >     }
> >
> > because errp can be NULL.
> 
> If foo() additionally returned an indication of success, you could write
> 
>       if (!foo(arg, errp)) {    // assuming foo() returns a bool
>           handle the error...
>       }
> 
> Nicely concise.
> 
> For what it's worth, this is how GLib wants GError to be used.  We
> deviated from it, and it has turned out to be a self-inflicted wound.

FWIW, I took that approach for the io & crypto layers - except
returning 0 vs -1, rather than true/false, precisely because
it lead to simpler code by not having to use local errors and
propagation.

For added benefit you can potentially then also annotate the
method as  __attribute__(return_check)  to force the caller
to include a check for error conditions, which is often a
useful compile time protection to have.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
