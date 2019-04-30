Received: from eggs.gnu.org ([209.51.188.92]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZVS-0002Jh-A1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZOH-0008Gc-Ac
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:30:14 -0400
Date: Tue, 30 Apr 2019 17:30:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190430203009.GJ28722@habkost.net>
References: <20190425132134.2839-1-cohuck@redhat.com>
	<20190425132134.2839-2-cohuck@redhat.com>
	<CAFEAcA8TvMqZRCrMF5orgaWy-CxTR8fr6yF2W_-Y6LYfi1pGng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8TvMqZRCrMF5orgaWy-CxTR8fr6yF2W_-Y6LYfi1pGng@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 01/19] s390 vfio-ccw: Add bootindex property
 and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Tue, Apr 30, 2019 at 05:54:49PM +0100, Peter Maydell wrote:
> On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:
[...]
> > -        SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> > -                                                            TYPE_SCSI_DEVICE);
> > -
> > -        if (sd) {
> > +        switch (devtype) {
> > +        case CCW_DEVTYPE_SCSI:
> > +            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> > +                                                           TYPE_SCSI_DEVICE);
> 
> Coverity doesn't like the use of object_dynamic_cast() without a
> check that the return value isn't NULL before we dereference
> it a few lines further down.
> 
> I think that if we know this cast must always succeed, we
> could instead just write
>   SCSIDevice *sd = SCSI_DEVICE(dev_st);
> 
> On the other hand if the cast might not succeed because dev_st
> isn't necessarily of the right type, then we should check it
> for NULL and handle that appropriately.

s390_get_ccw_device() will set devtype=CCW_DEVTYPE_SCSI only if
dev_st is TYPE_SCSI_DEVICE, so the cast must always succeed and
we should use SCSI_DEVICE(dev_st) here.

-- 
Eduardo
