Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7u6t-0007Rs-KL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7u6q-0006D8-GX
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:38:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38705
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d7u6q-0006D0-A1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:38:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v491YLHP070144
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 21:38:39 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aahm9j0f9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 21:38:38 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:38:38 -0600
Date: Tue, 9 May 2017 09:38:31 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-6-bjsdjshi@linux.vnet.ibm.com>
	<20170505141153.60d0d0bf.cornelia.huck@de.ibm.com>
	<20170508051822.GC15974@bjsdjshi@linux.vnet.ibm.com>
	<20170508125040.7dc4e1e2.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508125040.7dc4e1e2.cornelia.huck@de.ibm.com>
Message-Id: <20170509013831.GF15974@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/13] s390x/css: realize css_create_sch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-08 12:50:40 +0200]:

> On Mon, 8 May 2017 13:18:22 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-05 14:11:53 +0200]:
> > 
> > > On Fri,  5 May 2017 04:03:44 +0200
> > > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > > > -SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
> > > > +SubchDev *css_create_sch(CssDevId bus_id, bool is_virtio, bool squash_mcss,
> > > > +                         Error **errp)
> > > >  {
> > > >      uint16_t schid = 0;
> > > >      SubchDev *sch;
> > > > 
> > > >      if (bus_id.valid) {
> > > > -        /* Enforce use of virtual cssid. */
> > > > -        if (bus_id.cssid != VIRTUAL_CSSID) {
> > > > -            error_setg(errp, "cssid %hhx not valid for virtual devices",
> > > > -                       bus_id.cssid);
> > > > +        if (is_virtio != (bus_id.cssid == VIRTUAL_CSSID)) {
> > > > +            error_setg(errp, "cssid %hhx not valid for %s devices",
> > > > +                       bus_id.cssid,
> > > > +                       (is_virtio ? "virtio" : "non-virtio"));
> > > 
> > > This reminds me of something else: virtual 3270 devices will use the
> > > virtual channel subsystem by default. I think this is fine: Even though
> > > they are not virtio devices, they are fully virtual constructs, and it
> > > does not make sense to artificially shove them into another css.
> > VIRTUAL CSS (0xFE) is reserved for virtio devices only, no? This is what
> > I understood... So we should not put any non-virtio devices into CSS
> > 0xFE.
> > 
> > If my understanding is not right before, I agree that we put non-virtio
> > (e.g. 3270) devices into CSS 0xFE, and ...
> > 
> > > 
> > > But this means the distinction should be virtual vs. non-virtual and
> > > not virtio vs. non-virtio, and the squashing is only applicable to
> > > non-virtual devices. Mainly a naming thing.
> > ... do the following modifications here:
> > s/virtio/virtual
> > s/non-virtio/non-virtual
> > s/is_virtio/is_virtual
> 
> I realize that I wanted to treat css 0xfe as virtio-only initially;
Aha, here is the origination of my former understanding.

> but I think the virtual/non-virtual distinction actually makes more
> sense.
Agreed. And since we do not have legacy problem that stops us from doing
this, I will fix according to your comments.

> 
> - For devices that don't have a hardware equivalent at all (like
> virtio-ccw), it's clear that they should be in the virtual css.
Nod.

> 
> - For devices that are always fully emulated (because there's no device
> that could be passthroughed), I'd argue that they should be treated as
> fully virtual as well. This means 3270, and would include things like a
> card punch should anyone feel an urge to emulate that one :)
Nod.

> 
> - An emulation of a device that could also be passthroughed is a bit of
> a grey area. One could argue to put it either with the virtual devices
> or with the non-virtual ones. But I think we can ignore that for now
> (until someone decides that a dasd emulation is a thing qemu urgently
> needs...)
Ok.

-- 
Dong Jia Shi
