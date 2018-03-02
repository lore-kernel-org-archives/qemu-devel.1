Received: from eggs.gnu.org ([2001:4830:134:3::10]:42579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriSA-0001Wh-ER
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriS6-0002cL-Hq
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:02:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eriS6-0002bo-Cy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:02:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75B61E44B5
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 11:02:13 +0000 (UTC)
Date: Fri, 2 Mar 2018 11:02:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180302110209.GE26972@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-9-peterx@redhat.com>
	<20180301154638.GO14643@redhat.com>
	<ca243953-2f86-f73a-c3c3-95335f94bba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca243953-2f86-f73a-c3c3-95335f94bba2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/15] chardev: allow telnet gsource to
 switch gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 06:16:53PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 16:46, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Mar 01, 2018 at 04:44:31PM +0800, Peter Xu wrote:
> >> It was originally created by qio_channel_add_watch() so it's always
> >> assigning the task to main context.  Now we use the new API called
> >> qio_channel_add_watch_source() so that we get the GSource handle rat=
her
> >> than the tag ID.
> >>
> >> Meanwhile, caching the gsource in SocketChardev.telnet_source so tha=
t we
> >> can also do dynamic context switch when update read handlers.
> > I don't see why we would ever want to dynamically switch the
> > GMainContext in use while in middle of reading the telnet greeting.
>=20
> Maybe because the remote client hangs in the middle of the telnet
> greeting?  The user of the Chardev can't know that the initial handshak=
e
> hasn't been done yet.

NB, the chardev will emit the CHR_EVENT_OPENED event once the connection
is successfully established, which includes completion of the telnet
and/or TLS handshake.

I'm just not seeing what code in QEMU would actually trigger a decision
to change the GMainContext, in between the accept() of the socket, and
the CHR_EVENT_OPENED, since we don't tell anyone that the accept() has
actually taken place - they first they'll know of a new client being
connected is when the CHR_EVENT_OPENED is emitted.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
