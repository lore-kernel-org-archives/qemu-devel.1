Received: from eggs.gnu.org ([2001:4830:134:3::10]:42112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1U6e-00060V-C6
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1U6Z-0002nO-Kr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:44:28 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:37991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1U6Z-0002mv-Dy
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:44:23 -0400
Received: from player728.ha.ovh.net (unknown [10.109.122.24])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B716CD3B39
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:44:21 +0200 (CEST)
Date: Thu, 29 Mar 2018 11:44:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180329114411.5c96c586@bahia.lan>
In-Reply-To: <20180329111831.2ffad2bd.cohuck@redhat.com>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231458624.69730.1752893648612848392.stgit@bahia.lan>
	<20180329111831.2ffad2bd.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] exec: fix memory leak in
 find_max_supported_pagesize()
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

On Thu, 29 Mar 2018 11:18:31 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 29 Mar 2018 11:09:46 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > The string returned by object_property_get_str() is dynamically allocated.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  exec.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index c09bd93df31e..02b1efebb7c3 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1495,6 +1495,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
> >          mem_path = object_property_get_str(obj, "mem-path", NULL);
> >          if (mem_path) {
> >              long hpsize = qemu_mempath_getpagesize(mem_path);
> > +            g_free(mem_path);
> >              if (hpsize < *hpsize_min) {
> >                  *hpsize_min = hpsize;
> >              }
> >   
> 
> Personally, I'd probably do the g_free() at the end of the if
> (mem_path) branch, but this works as well.
> 

I usually prefer to free the string as soon as it isn't needed
anymore... matter of taste :)

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
