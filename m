Received: from eggs.gnu.org ([2001:4830:134:3::10]:43280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dv83c-0005I3-T5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 16:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dv83Z-0006yC-Ov
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 16:26:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45086
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dv83Z-0006xZ-JI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 16:26:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LKOUFK018935
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:26:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4fncq5qs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:26:42 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 14:26:41 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150601262807.14100.4805165453968988313@sif>
References: <20170921151446.40015-1-borntraeger@de.ibm.com>
	<20170921151446.40015-2-borntraeger@de.ibm.com>
	<20170921172142.1052a887.cohuck@redhat.com>
	<150601262807.14100.4805165453968988313@sif>
Date: Thu, 21 Sep 2017 15:26:31 -0500
Message-Id: <150602559136.14100.15716317748570889468@sif>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/ais: for 2.10 stable: disable
 ais facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Quoting Michael Roth (2017-09-21 11:50:28)
> Quoting Cornelia Huck (2017-09-21 10:21:42)
> > On Thu, 21 Sep 2017 17:14:46 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > =

> > > The migration interface for ais was introduced with kernel 4.13
> > > but the capability itself had been active since 4.12. As migration
> > > support is considered necessary lets disable ais in the 2.10
> > > stable version. A proper fix and re-enablement will be done
> > > for qemu 2.11.
> > =

> > Also now with qemu-devel on cc:
> > =

> > So, should I apply to s390-next? Or can this be applied just to stable?
> =

> Ideally we would get it in master or at least a branch that'll
> eventually get pulled so we can reference the upstream commit ID.
> It's not set in stone, but usually only patches specifically ported
> to stable are applied directly.

Somehow I missed the "for 2.10 stable" in the subject line. I can apply
this directly if it comes to that, but it seems safer to apply this
upstream as well in the meantime, IMO. If the proper fix didn't make
2.11 for whatever reason we'd still be okay with 2.10.1<->2.11, for
instance.

> =

> > =

> > > =

> > > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  target/s390x/kvm.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > > index c4c5791..eb0dbb3 100644
> > > --- a/target/s390x/kvm.c
> > > +++ b/target/s390x/kvm.c
> > > @@ -308,8 +308,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> > >          }
> > >      }
> > >  =

> > > -    /* Try to enable AIS facility */
> > > -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> > > +    /*
> > > +     * The migration interface for ais was introduced with kernel 4.=
13
> > > +     * but the capability itself had been active since 4.12. As migr=
ation
> > > +     * support is considered necessary let's disable ais in the 2.10
> > > +     * machine.
> > > +     */
> > > +    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> > >  =

> > >      qemu_mutex_init(&qemu_sigp_mutex);
> > >  =

> > =

> =

>=20
