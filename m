Received: from eggs.gnu.org ([2001:4830:134:3::10]:50868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAYyZ-0006KT-IP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAYyV-0001v6-Kj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:45:39 -0400
Date: Mon, 23 Apr 2018 12:45:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180423124528.2eead1de.cohuck@redhat.com>
In-Reply-To: <ae3c3e54-8682-2f80-b54f-cceb29de7a8a@redhat.com>
References: <20180412192602.13430-1-david@redhat.com>
	<ae3c3e54-8682-2f80-b54f-cceb29de7a8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 18 Apr 2018 16:33:13 +0200
David Hildenbrand <david@redhat.com> wrote:

> >  static void s390_ipl_class_init(ObjectClass *klass, void *data)
> > diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> > index 0570d0ad75..102f1ea7af 100644
> > --- a/hw/s390x/ipl.h
> > +++ b/hw/s390x/ipl.h
> > @@ -87,7 +87,17 @@ int s390_ipl_set_loadparm(uint8_t *loadparm);
> >  void s390_ipl_update_diag308(IplParameterBlock *iplb);
> >  void s390_ipl_prepare_cpu(S390CPU *cpu);
> >  IplParameterBlock *s390_ipl_get_iplb(void);
> > -void s390_reipl_request(void);
> > +
> > +enum s390_reset {
> > +    /* default is a reset not triggered by a CPU e.g. issued by QMP */
> > +    S390_RESET_EXTERNAL = 0,
> > +    S390_RESET_REIPL,
> > +    S390_RESET_MODIFIED_CLEAR,
> > +    S390_RESET_LOAD_NORMAL,
> > +};
> > +void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
> > +void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
> > +void s390_ipl_clear_reset_request(void);
> >  
> >  #define QIPL_ADDRESS  0xcc
> >  
> > @@ -129,9 +139,11 @@ struct S390IPLState {
> >      bool enforce_bios;
> >      IplParameterBlock iplb;
> >      bool iplb_valid;
> > -    bool reipl_requested;
> >      bool netboot;
> >      QemuIplParameters qipl;
> > +    /* reset related properties don't have to be migrated or reset */
> > +    enum s390_reset reset_type;
> > +    CPUState *reset_cpu;  
> 
> Wondering if storing the cpu number would be nicer. Opinions?
> 

Is there any difference in the number of QOM operations?

Also, do you need to distinguish between 'specified cpu' and
'default/any cpu'? Should be deductible from the reset type, though.
