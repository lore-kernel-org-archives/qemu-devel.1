Received: from eggs.gnu.org ([209.51.188.92]:47188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRCk-0007ED-VJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRCj-0007v0-JM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkRCj-0007tf-AY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:49 -0500
Date: Fri, 18 Jan 2019 10:16:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118101638.GE20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118093935.GA1142@beluga.usersys.redhat.com>
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, brijesh.singh@amd.com, dinechin@redhat.com, mkletzan@redhat.com

On Fri, Jan 18, 2019 at 10:39:35AM +0100, Erik Skultety wrote:
> Hi,
> this is a summary of a private discussion I've had with guys CC'd on this email
> about finding a solution to [1] - basically, the default permissions on
> /dev/sev (below) make it impossible to query for SEV platform capabilities,
> since by default we run QEMU as qemu:qemu when probing for capabilities. It's
> worth noting is that this is only relevant to probing, since for a proper QEMU
> VM we create a mount namespace for the process and chown all the nodes (needs a
> SEV fix though).
> 
> # ll /dev/sev
> crw-------. 1 root root
> 
> I suggested either force running QEMU as root for probing (despite the obvious
> security implications) or using namespaces for probing too. Dan argued that
> this would have a significant perf impact and suggested we ask systemd to add a
> global udev rule.

I've just realized there is a potential 3rd solution. Remember there is
actually nothing inherantly special about the 'root' user as an account
ID. 'root' gains its powers from the fact that it has many capabilities
by default.  'qemu' can't access /dev/sev because it is owned by a
different user (happens to be root) and 'qemu' does not have capabilities.

So we can make probing work by using our capabilities code to grant
CAP_DAC_OVERRIDE to the qemu process we spawn. So probing still runs
as 'qemu', but can none the less access /dev/sev while it is owned
by root.  We were not using 'qemu' for sake of security, as the probing
process is not executing any untrusthworthy code, so we don't  loose any
security protection by granting CAP_DAC_OVERRIDE.

> I proceeded with cloning [1] to systemd and creating an udev rule that I planned
> on submitting to systemd upstream - the initial idea was to mimic /dev/kvm and
> make it world accessible to which Brijesh from AMD expressed a concern that
> regular users might deplete the resources (limit on the number of guests
> allowed by the platform). But since the limit is claimed to be around 4, Dan
> discouraged me to continue with restricting the udev rule to only the 'kvm'
> group which Laszlo suggested earlier as the limit is so small that a malicious
> QEMU could easily deplete this during probing. This fact also ruled out any
> kind of ACL we could create dynamically. Instead, he suggested that we filter
> out the kvm-capable QEMU and put only that one in the namespace without a
> significant perf impact.

Yes, my suggestion to mimic /dev/kvm was based on the mistaken mis-understanding
that there was not a finite resource limit. Given that there are one or more
finite resource limits, we need access control on which unprivileged users, and
/or which individual QEMU instances are permitted access. This means /dev/sev
must remain with restrictive user/group/permissions that prevent any unprivilegd
account from having access. This means either root:root 0770/0700, or possibly
having an 'sev' group and using root:sev 0770, so that users can be granted
access via 'sev' group membership which (might?) allow unprivileged libvirtd to
use 'sev' if the user was added.

>     - my take on this is that there could potentially be more than a single
>       kvm-enabled QEMU and therefore we'd need to create more than just a
>       single namespace.

True, I guess qemu-system-x86_64 and qemu-system-i386 both get KVM
on an x86_64 host, and likewise for many other 64-bit archs supporting.
32-bit apps.

>     - I also argued that I can image that the same kind of DOS attack might be
>       possible from within the namespace, even if we created the /dev/sev node
>       only in SEV-enabled guests (which we currently don't). All of us have
>       agreed that allowing /dev/sev in the namespace for only SEV-enabled
>       guests is worth doing nonetheless.

There's never any perfect level of protection. We're just striving to
minimize the attack surface by only exposing it where there's a genuine
need to use it.

> In the meantime, Christophe went through the kernel code to verify how the SEV
> resources are managed and what protection is currently in place to mitigate the
> chance of a process easily depleting the limit on SEV guests. He found that
> ASID, which determines the encryption key, is allocated from a single ASID
> bitmap and essentially guarded by a single 'sev->active' flag.
> 
> So, in conclusion, we absolutely need input from Brijesh (AMD) whether there
> was something more than the low limit on number of guests behind the default
> permissions. Also, we'd like to get some details on how the limit is managed,
> helping to assess the approaches mentioned above.

Regardless of this problem, I think it is important to have some docs
in either libvirt or QEMU that describe the resource usage constraints
so that management apps can decide how to best take advantage of SEV.

> 
> Thanks and please do share your ideas,
> Erik
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1665400
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1561113

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
