Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d7gFi-00082z-MI
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d7gFc-0007NT-Sq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:50:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33667
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d7gFc-0007NE-N7
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:50:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48Ae70o064775
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 06:50:47 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aaguvjf8k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:50:47 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 8 May 2017 11:50:45 +0100
Date: Mon, 8 May 2017 12:50:40 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170508051822.GC15974@bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-6-bjsdjshi@linux.vnet.ibm.com>
	<20170505141153.60d0d0bf.cornelia.huck@de.ibm.com>
	<20170508051822.GC15974@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170508125040.7dc4e1e2.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/13] s390x/css: realize css_create_sch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Mon, 8 May 2017 13:18:22 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-05 14:11:53 +0200]:
> 
> > On Fri,  5 May 2017 04:03:44 +0200
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> > > -SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
> > > +SubchDev *css_create_sch(CssDevId bus_id, bool is_virtio, bool squash_mcss,
> > > +                         Error **errp)
> > >  {
> > >      uint16_t schid = 0;
> > >      SubchDev *sch;
> > > 
> > >      if (bus_id.valid) {
> > > -        /* Enforce use of virtual cssid. */
> > > -        if (bus_id.cssid != VIRTUAL_CSSID) {
> > > -            error_setg(errp, "cssid %hhx not valid for virtual devices",
> > > -                       bus_id.cssid);
> > > +        if (is_virtio != (bus_id.cssid == VIRTUAL_CSSID)) {
> > > +            error_setg(errp, "cssid %hhx not valid for %s devices",
> > > +                       bus_id.cssid,
> > > +                       (is_virtio ? "virtio" : "non-virtio"));
> > 
> > This reminds me of something else: virtual 3270 devices will use the
> > virtual channel subsystem by default. I think this is fine: Even though
> > they are not virtio devices, they are fully virtual constructs, and it
> > does not make sense to artificially shove them into another css.
> VIRTUAL CSS (0xFE) is reserved for virtio devices only, no? This is what
> I understood... So we should not put any non-virtio devices into CSS
> 0xFE.
> 
> If my understanding is not right before, I agree that we put non-virtio
> (e.g. 3270) devices into CSS 0xFE, and ...
> 
> > 
> > But this means the distinction should be virtual vs. non-virtual and
> > not virtio vs. non-virtio, and the squashing is only applicable to
> > non-virtual devices. Mainly a naming thing.
> ... do the following modifications here:
> s/virtio/virtual
> s/non-virtio/non-virtual
> s/is_virtio/is_virtual

I realize that I wanted to treat css 0xfe as virtio-only initially; but
I think the virtual/non-virtual distinction actually makes more sense.

- For devices that don't have a hardware equivalent at all (like
virtio-ccw), it's clear that they should be in the virtual css.

- For devices that are always fully emulated (because there's no device
that could be passthroughed), I'd argue that they should be treated as
fully virtual as well. This means 3270, and would include things like a
card punch should anyone feel an urge to emulate that one :)

- An emulation of a device that could also be passthroughed is a bit of
a grey area. One could argue to put it either with the virtual devices
or with the non-virtual ones. But I think we can ignore that for now
(until someone decides that a dasd emulation is a thing qemu urgently
needs...)
