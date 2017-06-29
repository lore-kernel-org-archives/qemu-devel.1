Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQaGs-0007eE-9u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQaGp-0005t4-4I
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQaGo-0005sI-VQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:11 -0400
Date: Thu, 29 Jun 2017 15:18:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629141805.GG32167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<6fac3c3d-9cf8-cb79-0141-908fe8160a5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fac3c3d-9cf8-cb79-0141-908fe8160a5b@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Jun 29, 2017 at 03:39:58PM +0200, Paolo Bonzini wrote:
> On 28/06/2017 11:05, Markus Armbruster wrote:
> > If foo() additionally returned an indication of success, you could write
> > 
> >       if (!foo(arg, errp)) {    // assuming foo() returns a bool
> >           handle the error...
> >       }
> > 
> > Nicely concise.
> > 
> > For what it's worth, this is how GLib wants GError to be used.  We
> > deviated from it, and it has turned out to be a self-inflicted wound.
> > 
> 
> I find Eduardo's proposal better.  With GLib's way it's easy to confuse
> functions that return 0/-1, 0/-errno, TRUE/FALSE, FALSE/TRUE or
> NULL/non-NULL.

NB, glib basically standardizes on just FALSE/TRUE and NULL/non-NULL,
avoiding anything returning -1, or errno values, so in their usage
there isn't really any confusion.

QEMU of course has lots of pre-existing code, but we could at least
declare a preferred approach, and work towards it.

Having the return value indicate error is slightly shorter, and it
avoids all the blackmagic with special Error values in Eduardo's
series. Most usefully, it lets you use __attribute__(return_check)
to get compile time checking of callers who forget to check for
failure.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
