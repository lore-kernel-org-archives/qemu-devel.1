Received: from eggs.gnu.org ([2001:4830:134:3::10]:45242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clcvP-0002kP-4s
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clcvM-0005Je-JL
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:50:47 -0500
Date: Wed, 8 Mar 2017 11:50:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308145038.GF4694@thinpad.lan.raisama.net>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<CAFEAcA8VV-UW7M+W=KcN=XycPUS=FmFJmVhd0DpruzaoKEVjuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8VV-UW7M+W=KcN=XycPUS=FmFJmVhd0DpruzaoKEVjuQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Mar 08, 2017 at 03:31:01PM +0100, Peter Maydell wrote:
> On 3 March 2017 at 15:58, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> >> When running with KVM on POWER, we register some CPU types during
> >> the initialization function of the ppc64 KVM code (which unfortunately
> >> also can not be done via a type_init() like it is done on x86).
> >
> > Can you elaborate why it can't be done via type_init()? If the
> > QOM type hierarchy depends on any runtime data unavailable at
> > type_init(), we should fix that.
> 
> On ARM we (currently) have the KVM-only 'host' CPU type be
> added to the type hierarchy only at runtime in kvm_init(),
> but we deal with the '-help' problem by having arm_cpu_list() do
> 
> #ifdef CONFIG_KVM
>     /* The 'host' CPU type is dynamically registered only if KVM is
>      * enabled, so we have to special-case it here:
>      */
>     (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
> #endif
> 

We already have similar code at ppc_cpu_list():

#ifdef CONFIG_KVM
    cpu_fprintf(f, "\n");
    cpu_fprintf(f, "PowerPC %-16s\n", "host");
#endif

If I understood it correctly, the current problem is just
inaccurate alias information being printed because the alias
table is modified by the accelerator.

My current suggestion is to avoid printing anything that depends
on the current machine/accelerator at the help output.

-- 
Eduardo
