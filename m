Received: from eggs.gnu.org ([2001:4830:134:3::10]:51931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1Unp-0007sW-3e
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1Unl-0003sC-60
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:29:05 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:33614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1Unk-0003rj-WF
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:29:01 -0400
Received: from player729.ha.ovh.net (unknown [10.109.105.8])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2AFBD926C8
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 12:28:58 +0200 (CEST)
Date: Thu, 29 Mar 2018 12:27:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180329122724.5a15b489@bahia.lan>
In-Reply-To: <20180329112416.28b99184.cohuck@redhat.com>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231462116.69730.14119625999092384450.stgit@bahia.lan>
	<20180329112416.28b99184.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] sev/i386: fix memory leak in
 sev_guest_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Thu, 29 Mar 2018 11:24:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 29 Mar 2018 11:10:21 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > The string returned by object_property_get_str() is dynamically allocated.
> > 
> > Fixes: d8575c6c0242b
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  target/i386/sev.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 019d84cef2c7..c01167143f1c 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -748,9 +748,11 @@ sev_guest_init(const char *id)
> >      if (s->sev_fd < 0) {
> >          error_report("%s: Failed to open %s '%s'", __func__,
> >                       devname, strerror(errno));
> > -        goto err;
> >      }
> >      g_free(devname);
> > +    if (s->sev_fd < 0) {
> > +        goto err;
> > +    }
> >  
> >      ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
> >                               &fw_error);
> >   
> 
> I would probably add an extra g_free(devname) right before the goto
> err, but this works as well, obviously.
> 

An alternative could have been to use glib's g_autofree macro, which
is especially designed to handle the case where an allocated buffer is
put in a local variable and we want g_free() to be called when the
variable goes out of scope. Unfortunately it requires glib >= 2.44 and
we're still at 2.22 AFAIK.

https://developer.gnome.org/glib/unstable/glib-Miscellaneous-Macros.html#g-autofree

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
