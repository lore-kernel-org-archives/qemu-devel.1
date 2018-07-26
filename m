Received: from eggs.gnu.org ([2001:4830:134:3::10]:43551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fihs7-0001Ib-SB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fihs3-00079M-TI
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:08:07 -0400
Date: Thu, 26 Jul 2018 12:07:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180726150754.GL12380@localhost.localdomain>
References: <20180725091233.3300-1-david@redhat.com>
	<20180725170925.GE12380@localhost.localdomain>
	<a33a67eb-2fb6-31fd-f4ca-1d883a5a7b75@redhat.com>
	<20180725201438.GG12380@localhost.localdomain>
	<36882ae2-5a00-d842-0b0d-d1458b1f0654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36882ae2-5a00-d842-0b0d-d1458b1f0654@redhat.com>
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Thu, Jul 26, 2018 at 09:29:44AM +0200, David Hildenbrand wrote:
> On 25.07.2018 22:14, Eduardo Habkost wrote:
> > On Wed, Jul 25, 2018 at 07:50:21PM +0200, David Hildenbrand wrote:
> >> On 25.07.2018 19:09, Eduardo Habkost wrote:
> > [...]
> >>>> +    if (local_err) {
> >>>> +        g_assert(kvm_enabled());
> >>>> +        error_report_err(local_err);
> >>>> +        /* fallback to unsupported CPU models */
> >>>> +        return;
> >>>
> >>> What about moving this outside instance_init?
> >>
> >> To which place for example? We at least have to copy the CPU model
> >> for each and every CPU instance (so we can modify it without side
> >> effects using properties).
> > 
> > To any code that will look at cpu->model.
> > 
> > You are wrapping an interface that needs to report errors
> > (kvm_s390_get_host_cpu_model()) behind an interface that is not
> > able to report errors (object_new()).  There's nothing that
> > requires you to do that, does it?  You are free to provide an API
> > that is actually able to report errors, instead of relying on
> > object_new() only.
> 
> I see what you mean. One solution would be to preload and store the
> model somewhere globally (not locally). So in the init function, we
> would not have to handle errors.
> 
> But I am not even sure where we could do such a global initialization +
> be able to report errors easily. I remember that we had a hard time to
> get this running smoothly due to the dependency of
> kvm_s390_get_host_cpu_model() on:
> - accelerator
> - machine
> - KVM init state

If we had a S390KVMAccelerator object on machine->accelerator,
S390KVMAccelerator::host_model would be a good candidate?

> 
> And initializing cpu->model in realize() is too late, because all
> properties have to access it. Even a pre_plug handler will not work.

Yeah, the instance_init/realize abstraction seems insufficient
here.  instance_init has too many restrictions, realize is too
late.


> 
> On the other hand, I decided to ignore all errors back then and fallback
> to the "host CPU model unknown" case, because there are some corner
> cases where we still want to allow running the "host" model even though
> there was a problem detecting it.
> 
> So my summary would be: We ignore errors (and rather treat them like
> warnings) for a reason here and fallback to "unsupported CPU models",
> which allows to run + use QEMU even in environments where our CPU model
> detection fails (e.g. on a very strange new CPU model we could have in
> the future).
> 
> Especially "!cpu->model" does not imply that there was an error. It
> includes disabled CPU model support or unavailable CPU model support
> (KVM), which is perfectly fine. Replicating initialization attempts at
> all places where we access "cpu->model" does therefore not sound 100%
> clean to me and most likely makes the code way more complicated.
> 
> Right now the semantics are clear: if we have "!cpu->model" after the
> object has been created, details about the host CPU model are not
> available (models unavailable/unsupported). Modifying properties,
> baselining, expanding is not possible with that model then. But it can
> be used for execution.

This is interesting.  If most users of cpu->model don't care
about kvm_s390_get_host_cpu_model() errors at all, the current
solution sounds more reasonable.

Except for the error_report_err() call inside instance_init.
This still bothers me, but it's not a big deal.

-- 
Eduardo
