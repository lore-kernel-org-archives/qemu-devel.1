Received: from eggs.gnu.org ([2001:4830:134:3::10]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzloj-0002ZG-0s
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzloe-00045z-2F
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzlod-00045B-Rh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:31 -0400
Date: Wed, 4 Oct 2017 17:42:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004174227.4f7e88d9.cohuck@redhat.com>
In-Reply-To: <b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
	<b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Wed, 4 Oct 2017 17:18:57 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 04/10/2017 15:53, Thomas Huth wrote:
> > The "sclp" device is just an internal device that can not be instantiated
> > by the users. If they try to use it, they only get a simple error message:
> > 
> > $ qemu-system-s390x -nographic -device sclp
> > qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
> > handled by this machine
> > 
> > Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
> > a non-pluggable sysbus device, there is really no way that the "sclp"
> > device can be used by the user, so let's set the user_creatable = false
> > accordingly.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   hw/s390x/sclp.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index 30aefbf..9be0cb8 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void *data)
> >       dc->realize = sclp_realize;
> >       dc->hotpluggable = false;
> >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    /*
> > +     * Reason: Creates TYPE_SCLP_EVENT_FACILITY in sclp_init
> > +     * which is a non-pluggable sysbus device
> > +     */
> > +    dc->user_creatable = false;
> > 
> >       sc->read_SCP_info = read_SCP_info;
> >       sc->read_storage_element0_info = read_storage_element0_info;
> >   
> 
> I must miss something.
> Why is the sclp device not a SYS_BUS_DEVICE ?
> The problem seems to come from the heterogeneity of the sclp and sclp 
> generated devices.
> 

I think the problem is 'not pluggable' rather than whether it is or
is not a sysbus device, no?
