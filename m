Received: from eggs.gnu.org ([2001:4830:134:3::10]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1U2L-0002U4-6U
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1U2G-00017q-6l
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:40:01 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:36210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1U2G-00017K-0x
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:39:56 -0400
Received: from player728.ha.ovh.net (unknown [10.109.122.16])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 66688B171F
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:39:54 +0200 (CEST)
Date: Thu, 29 Mar 2018 11:39:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180329113941.6eebc57f@bahia.lan>
In-Reply-To: <20180329112721.6c7ee3f3@redhat.com>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231460685.69730.14860451936216690693.stgit@bahia.lan>
	<20180329112721.6c7ee3f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/s390x: fix memory leak in
 s390_init_ipl_dev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-stable@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 29 Mar 2018 11:27:21 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 29 Mar 2018 11:10:06 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > The string returned by object_property_get_str() is dynamically allocated.
> > 
> > Fixes: 3c4e9baacf4d9
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/s390x/s390-virtio-ccw.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index 864145a7c6f3..435f7c99e77c 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -246,6 +246,7 @@ static void s390_init_ipl_dev(const char *kernel_filename,
> >  {
> >      Object *new = object_new(TYPE_S390_IPL);
> >      DeviceState *dev = DEVICE(new);
> > +    char *netboot_fw_prop;
> >  
> >      if (kernel_filename) {
> >          qdev_prop_set_string(dev, "kernel", kernel_filename);
> > @@ -256,9 +257,11 @@ static void s390_init_ipl_dev(const char *kernel_filename,
> >      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
> >      qdev_prop_set_string(dev, "firmware", firmware);
> >      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
> > -    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
> > +    netboot_fw_prop = object_property_get_str(new, "netboot_fw", &error_abort);
> > +    if (!strlen(netboot_fw_prop)) {  
> probably not really issue here but,
> is strlen really safe in case netboot_fw_prop == NULL?
> 

You're right, object_property_get_str() can theoretically return NULL and
strlen() would crash... Not sure how this would happen though. Anyway, the
current code doesn't check if object_property_get_str() returns NULL so
if this needs to be fixed as well, let's do it in a followup patch.

> >          qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
> >      }
> > +    g_free(netboot_fw_prop);
> >      object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
> >                                new, NULL);
> >      object_unref(new);
> > 
> >   
> 
