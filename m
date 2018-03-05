Received: from eggs.gnu.org ([2001:4830:134:3::10]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1esnG7-0001Wb-Ez
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1esnG4-0005YK-B1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:22:19 -0500
Date: Mon, 5 Mar 2018 11:21:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305112156.2df08098.cohuck@redhat.com>
In-Reply-To: <7f36d2d3-df76-9627-8976-ff06a6729ef1@redhat.com>
References: <1519731154-3127-1-git-send-email-thuth@redhat.com>
	<3e8dd204-a07d-00bd-84f3-813dc35c18cd@redhat.com>
	<7f36d2d3-df76-9627-8976-ff06a6729ef1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] hw/s390x: Add the possibility
 to specify the netboot image on the command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed, 28 Feb 2018 13:24:35 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 28.02.2018 12:02, David Hildenbrand wrote:
> > On 27.02.2018 12:32, Thomas Huth wrote:  
> >> The file name of the netboot binary is currently hard-coded to
> >> "s390-netboot.img", without a possibility for the user to select
> >> an alternative firmware image here. That's unfortunate, especially
> >> since the basics are already there: The filename is a property of
> >> the s390-ipl device. So we just have to add a check whether the user
> >> already provided the property and only set the default if the string
> >> is still empty. Now it is possible to select a different firmware
> >> image with "-global s390-ipl.netboot_fw=/path/to/s390-netboot.img".
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 4abbe89..7b3fb5f 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -254,8 +254,10 @@ static void s390_init_ipl_dev(const char *kernel_filename,
> >>      }
> >>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
> >>      qdev_prop_set_string(dev, "firmware", firmware);
> >> -    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
> >>      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
> >> +    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {  
> > 
> > Isn't it the case that object_property_get_str() can return also NULL?
> > 
> > (looking at s390_ipl_set_loadparm())  
> 
> It can return NULL in case of errors (e.g. the property is not a string
> or not available at all). In this case, we know that the property is a
> string and that it is available, so IMHO no need to check for NULL here.
> 
> Not sure why s390_ipl_set_loadparm() explicitely checks for this ...
> maybe this was originally required to support the old s390-virtio
> (non-ccw) machine, too?

Probably, IIRC the loadparm patches are quite old. Potential cleanup?
