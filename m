Received: from eggs.gnu.org ([209.51.188.92]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1YYv-0004uH-Qj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1YYv-00037E-2o
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:34:29 -0500
Date: Wed, 6 Mar 2019 16:27:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190306162729.0698ccb5.cohuck@redhat.com>
In-Reply-To: <cf5e9c71-a78a-02b1-eaa8-4c8ba5c2c8a3@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
	<20190304144010.109e5ee1.cohuck@redhat.com>
	<cf5e9c71-a78a-02b1-eaa8-4c8ba5c2c8a3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/16] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 6 Mar 2019 09:55:40 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 3/4/19 8:40 AM, Cornelia Huck wrote:
> > On Fri,  1 Mar 2019 13:59:21 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> @@ -532,7 +559,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
> >>           !ipl->netboot &&
> >>           ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
> >>           is_virtio_scsi_device(&ipl->iplb)) {
> >> -        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
> >> +        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), &devtype);  
> > 
> > It feels wrong to have a variable that is not used later... what about
> > either
> > - making s390_get_ccw_device() capable of handling a NULL second
> >    parameter, or
> > - (what I think would be nicer) passing in the devtype as an optional
> >    parameter to gen_initial_iplb() so you don't need to do the casting
> >    dance twice?
> >   
> 
> I'm with you on everything suggested for this patch except this last item. I'm not sure 
> what you are suggesting here. I can easily visualize passing NULL for devtype when we want 
> to ignore it but I'm not sure what you mean by 'optional parameter'

Hm, actually you'd need the device as well :) Basically,

static bool s390_gen_initial_iplb(S390IPLState *ipl, CcwDevice *ccw_dev, int devtype)
{
(...)
    if (!ccw_dev) {
        //get ccw_dev, which also gives us the devtype
    }

    if (ccw_dev) {
        //as before; devtype is valid here
        (...)
        return true;
    }
    return false;
}

So you can call it with s390_gen_initial_iplb(ipl, NULL, 0) if you
don't have the values already.
