Received: from eggs.gnu.org ([2001:4830:134:3::10]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e56rS-0000He-US
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e56rO-0000Gb-U5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e56rO-0000G6-NT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:11:26 -0400
Date: Thu, 19 Oct 2017 11:11:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171019111121.39b7a277.cohuck@redhat.com>
In-Reply-To: <20171019061445.GD4612@bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-6-pasic@linux.vnet.ibm.com>
	<20171019061445.GD4612@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x: refactor error handling for
 CSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 19 Oct 2017 14:14:45 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 16:04:51 +0200]:
> 
> > Simplify the error handling of the cSCH.  Let the code detecting the
> > condition tell (in a less ambiguous way) how it's to be handled. No
> > changes in behavior.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---  
> [...]
> 
> > diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> > index 4ad07e9181..fd659e77a5 100644
> > --- a/target/s390x/ioinst.c
> > +++ b/target/s390x/ioinst.c
> > @@ -60,8 +60,6 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
> >  {
> >      int cssid, ssid, schid, m;
> >      SubchDev *sch;
> > -    int ret = -ENODEV;
> > -    int cc;
> > 
> >      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> >          program_interrupt(&cpu->env, PGM_OPERAND, 4);
> > @@ -69,15 +67,11 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
> >      }
> >      trace_ioinst_sch_id("csch", cssid, ssid, schid);
> >      sch = css_find_subch(m, cssid, ssid, schid);
> > -    if (sch && css_subch_visible(sch)) {
> > -        ret = css_do_csch(sch);
> > -    }
> > -    if (ret == -ENODEV) {
> > -        cc = 3;
> > -    } else {
> > -        cc = 0;
> > +    if (!sch || !css_subch_visible(sch)) {
> > +        setcc(cpu, 3);  
> Same question here.
> 
> > +        return;
> >      }
> > -    setcc(cpu, cc);
> > +    setcc(cpu, css_do_csch(sch));
> >  }
> > 
> >  void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
> > -- 
> > 2.13.5
> >   
> 
> If we agree to replace 3 with IOINST_CC_NOT_OPERATIONAL, maybe Conny
> could fix it. Or we can do that in a following cleanup patch?

Switching it to IOINST_CC_NOT_OPERATIONAL is certainly good, but I
think I've already done enough editing for this series...

A patch on top would be the best way.

> 
> W/ or w/o the fix, for now:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
