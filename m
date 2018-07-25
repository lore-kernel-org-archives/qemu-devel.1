Received: from eggs.gnu.org ([2001:4830:134:3::10]:37538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fiIZ0-0006J6-58
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fiIYx-0000I2-4M
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:06:42 -0400
Date: Wed, 25 Jul 2018 14:06:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180725140631.54c1df1f.cohuck@redhat.com>
In-Reply-To: <12ec6fa8-aa28-f8d6-a6ad-df87824e89e9@redhat.com>
References: <20180725091233.3300-1-david@redhat.com>
	<20180725133640.3ea78c59.cohuck@redhat.com>
	<12ec6fa8-aa28-f8d6-a6ad-df87824e89e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, "Daniel P .
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 25 Jul 2018 13:58:16 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 25.07.2018 13:36, Cornelia Huck wrote:
> > On Wed, 25 Jul 2018 11:12:33 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> The "max" CPU model behaves like "-cpu host" when KVM is enabled, and like
> >> a CPU with the maximum possible feature set when TCG is enabled.
> >>
> >> While the "host" model can not be used under TCG ("kvm_required"), the
> >> "max" model can and "Enables all features supported by the accelerator in
> >> the current host".
> >>
> >> So we can treat "host" just as a special case of "max" (like x86 does).
> >> It differs to the "qemu" CPU model under TCG such that compatibility
> >> handling will not be performed and that some experimental CPU features
> >> not yet part of the "qemu" model might be indicated.
> >>
> >> These are right now under TCG (see "qemu_MAX"):
> >> - stfle53  
> > 
> > That's a z13 feature, so I think it's fine as we don't care about
> > machine generations for the max mode anyway, correct?  
> 
> Yes the max model really just is "give me anything you got and that you
> can expand to a static model (i.e. fully specify on the command line)".
> 
> >   
> >> - msa5-base  
> > 
> > That's just the warning, but as things are continuing to work, it's
> > fine as well.  
> 
> Yes, as these are z13 models we don't but them yet into our "stable"
> qemu model which is based on a z12.
> 
> >   
> >> - zpci  
> > 
> > That one theoretically has a dependency on CONFIG_PCI, but as that is
> > always set, I think it's fine as well.  
> 
> That is even already handled correctly, see
> 	target/s390x/cpu_models.c:register_types()
> 
> 1314 #ifndef CONFIG_USER_ONLY
> 1315     if (!pci_available) {
> 1316         clear_bit(S390_FEAT_ZPCI, qemu_max_cpu_feat);
> 1317     }
> 1318 #endif

Oh, I actually added that myself :)

> 
> [...]
> 
> > Maybe add a comment that for kvm we try the host model, and only that
> > can fail (i.e., for tcg this will always work)?  
> 
> "we expect only errors under KVM, when we actually query the kernel"

"We expect errors only under KVM, where we actually query the kernel"

?

If nobody else has further comments, I can squash in the change and
queue it for 3.1. I'll let it sit for a bit longer on the list, though.

> 
> >   
> >> +        error_report_err(local_err);
> >> +        /* fallback to unsupported CPU models */
> >> +        return;
> >> +    }
> >> +
> >> +    cpu->model = g_new(S390CPUModel, 1);
> >> +    /* copy the CPU model so we can modify it */
> >> +    memcpy(cpu->model, max_model, sizeof(*cpu->model));
> >> +}
> >> +
> >>  static void s390_cpu_model_finalize(Object *obj)
> >>  {
> >>      S390CPU *cpu = S390_CPU(obj);  
> > 
> > Looks sane to me.
> >   
> 
> Thanks!
> 
