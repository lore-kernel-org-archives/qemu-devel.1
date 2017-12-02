Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eL93t-00041s-OD
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eL93r-0007AK-Lm
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:46:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39612
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@au1.ibm.com>) id 1eL93r-00079Q-H6
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:46:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB2Ei5Ya011953
	for <qemu-devel@nongnu.org>; Sat, 2 Dec 2017 09:46:31 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eks8a80py-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 02 Dec 2017 09:46:31 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <benh@au1.ibm.com>;
	Sat, 2 Dec 2017 14:46:29 -0000
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Sat, 02 Dec 2017 08:46:19 -0600
In-Reply-To: <1512225938.2224.69.camel@kernel.crashing.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
	<20171130044922.GC3023@umbus.fritz.box>
	<36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
	<20171201041015.GE30161@umbus.fritz.box>
	<1512225938.2224.69.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1512225979.2224.70.camel@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Sat, 2017-12-02 at 08:45 -0600, Benjamin Herrenschmidt wrote:
> On Fri, 2017-12-01 at 15:10 +1100, David Gibson wrote:
> > 
> > Hm, ok.  Guest endian (or at least, not definitively host-endian) data
> > in a plain uint32_t makes me uncomfortable.  Could we use char data[4]
> > instead, to make it clear it's a byte-ordered buffer, rather than a
> > number as far as the XIVE is concerned.
> > 
> > Hm.. except that doesn't quite work, because the hardware must define
> > which end that generation bit ends up in...
> 
> It also needs to be written atomically. Just say it's big endian.

Also the guest reads it using be32_to_cpup...

> 
> Cheers,
> Ben.
> 
> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write EQ data @0x%"
> > > > > +                      HWADDR_PRIx "\n", __func__, qaddr);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    qindex = (qindex + 1) % qentries;
> > > > > +    if (qindex == 0) {
> > > > > +        qgen ^= 1;
> > > > > +        eq->w1 = SETFIELD(EQ_W1_GENERATION, eq->w1, qgen);
> > > > > +    }
> > > > > +    eq->w1 = SETFIELD(EQ_W1_PAGE_OFF, eq->w1, qindex);
> > > > > +}
> > > > > +
> > > > >  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> > > > >  {
> > > > > +    XiveIVE *ive;
> > > > > +    XiveEQ *eq;
> > > > > +    uint32_t eq_idx;
> > > > > +    uint8_t priority;
> > > > > +
> > > > > +    ive = spapr_xive_get_ive(xive, lisn);
> > > > > +    if (!ive || !(ive->w & IVE_VALID)) {
> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
> > > > 
> > > > As mentioned on other patches, I'm a little concerned by these
> > > > guest-triggerable logs.  I guess the LOG_GUEST_ERROR mask will save
> > > > us, though.
> > > 
> > > I want to track 'invalid' interrupts but I haven't seen these show up 
> > > in my tests. I agree there are a little too much and some could just 
> > > be asserts.
> > 
> > Uh.. I don't think many can be assert()s.  assert() is only
> > appropriate if it being tripped definitely indicates a bug in qemu.
> > Nearly all these qemu_log()s I've seen can be tripped by the guest
> > doing something bad, which absolutely should not assert() qemu.
