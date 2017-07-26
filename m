Received: from eggs.gnu.org ([2001:4830:134:3::10]:41588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHVP-0003PP-I9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHVL-0008Sd-Hp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daHVL-0008SI-Bf
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:17:15 -0400
Date: Wed, 26 Jul 2017 10:17:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170726101707.44e7b85b@gondolin>
In-Reply-To: <1b71d39d-602e-08fa-4805-81cbfeffd073@redhat.com>
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-4-cohuck@redhat.com>
	<1b71d39d-602e-08fa-4805-81cbfeffd073@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 26 Jul 2017 08:59:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 25.07.2017 17:33, Cornelia Huck wrote:
> > The nt2 event class is pci-only - don't look for events if pci is
> > not in the active cpu model.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c  |  4 ++--
> >  hw/s390x/s390-pci-bus.h  |  4 ++--
> >  hw/s390x/s390-pci-stub.c |  4 ++--
> >  target/s390x/ioinst.c    | 16 ++++++++++++++++
> >  4 files changed, 22 insertions(+), 6 deletions(-)

> > diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> > index 51fbea620d..3fa3301f50 100644
> > --- a/target/s390x/ioinst.c
> > +++ b/target/s390x/ioinst.c
> > @@ -599,6 +599,22 @@ static int chsc_sei_nt0_have_event(void)
> >      return 0;
> >  }
> >  
> > +static int chsc_sei_nt2_get_event(void *res)
> > +{
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        return pci_chsc_sei_nt2_get_event(res);
> > +    }
> > +    return 1;
> > +}
> > +
> > +static int chsc_sei_nt2_have_event(void)
> > +{
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        return pci_chsc_sei_nt2_have_event();
> > +    }
> > +    return 0;
> > +}  
> 
> Not sure whether it is nicer/better, but you could also do the check
> only once in ioinst_handle_chsc_sei() and then get along without these
> wrapper functions?

I prefer the wrapper functions, as it mirrors the nt0 wrappers and
nicely contains the fact that nt2 is pci specific.
