Received: from eggs.gnu.org ([209.51.188.92]:33062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h15ag-0006LG-LF
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h15ac-0003m5-UG
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:38:20 -0500
Date: Tue, 5 Mar 2019 09:38:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305093809.751f91b9.cohuck@redhat.com>
In-Reply-To: <5de5cda9-5db2-6207-5b90-52206be1da72@redhat.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-6-git-send-email-jjherne@linux.ibm.com>
	<20190304180742.486c8994.cohuck@redhat.com>
	<5de5cda9-5db2-6207-5b90-52206be1da72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 05/16] s390-bios: Factor
 finding boot device out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, alifm@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On Mon, 4 Mar 2019 20:26:17 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 04/03/2019 18.07, Cornelia Huck wrote:
> > On Fri,  1 Mar 2019 13:59:25 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >   
> >> Make a new routine find_boot_device to locate the boot device for all
> >> cases, not just virtio.
> >>
> >> The error message for the case where no boot device has been specified
> >> and a suitable boot device cannot be auto detected was specific to
> >> virtio devices. We update this message to remove virtio specific wording.  
> > 
> > ...and, consequently, need to tweak the serial output boot test.
> >   
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>  pc-bios/s390-ccw/main.c  | 85 ++++++++++++++++++++++++++----------------------
> >>  tests/boot-serial-test.c |  2 +-
> >>  2 files changed, 47 insertions(+), 40 deletions(-)
> >>  
> > (...)  
> >> -    IPL_assert(found, "No virtio device found");
> >> +    IPL_assert(found, "Boot device not found\n");  
> > 
> > You change the output in the bios here...
> > 
> > (...)  
> >> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> >> index 58a48f3..9daf2cb 100644
> >> --- a/tests/boot-serial-test.c
> >> +++ b/tests/boot-serial-test.c
> >> @@ -112,7 +112,7 @@ static testdef_t tests[] = {
> >>      { "sparc", "SS-4", "", "MB86904" },
> >>      { "sparc", "SS-600MP", "", "TMS390Z55" },
> >>      { "sparc64", "sun4u", "", "UltraSPARC" },
> >> -    { "s390x", "s390-ccw-virtio", "", "virtio device" },
> >> +    { "s390x", "s390-ccw-virtio", "", "device" },  
> > 
> > ...and therefore need to change the expected string here. Question: is
> > that ok ("device" looks a bit generic), or would "Boot device" be a
> > better match?  
> 
> Just "device" should be OK. The exact string in the boot-serial-test
> does not matter too much, as long as it comes from the same print statement.

Ok, makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
