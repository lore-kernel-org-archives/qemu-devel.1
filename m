Received: from eggs.gnu.org ([209.51.188.92]:39652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gkQjd-0006le-7V
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gkQjc-00038u-AQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gkQjc-00037i-2O
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:46:44 -0500
Date: Fri, 18 Jan 2019 10:39:35 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190118093935.GA1142@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU for
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, berrange@redhat.com, dinechin@redhat.com, mkletzan@redhat.com

Hi,
this is a summary of a private discussion I've had with guys CC'd on this email
about finding a solution to [1] - basically, the default permissions on
/dev/sev (below) make it impossible to query for SEV platform capabilities,
since by default we run QEMU as qemu:qemu when probing for capabilities. It's
worth noting is that this is only relevant to probing, since for a proper QEMU
VM we create a mount namespace for the process and chown all the nodes (needs a
SEV fix though).

# ll /dev/sev
crw-------. 1 root root

I suggested either force running QEMU as root for probing (despite the obvious
security implications) or using namespaces for probing too. Dan argued that
this would have a significant perf impact and suggested we ask systemd to add a
global udev rule.

I proceeded with cloning [1] to systemd and creating an udev rule that I planned
on submitting to systemd upstream - the initial idea was to mimic /dev/kvm and
make it world accessible to which Brijesh from AMD expressed a concern that
regular users might deplete the resources (limit on the number of guests
allowed by the platform). But since the limit is claimed to be around 4, Dan
discouraged me to continue with restricting the udev rule to only the 'kvm'
group which Laszlo suggested earlier as the limit is so small that a malicious
QEMU could easily deplete this during probing. This fact also ruled out any
kind of ACL we could create dynamically. Instead, he suggested that we filter
out the kvm-capable QEMU and put only that one in the namespace without a
significant perf impact.
    - my take on this is that there could potentially be more than a single
      kvm-enabled QEMU and therefore we'd need to create more than just a
      single namespace.
    - I also argued that I can image that the same kind of DOS attack might be
      possible from within the namespace, even if we created the /dev/sev node
      only in SEV-enabled guests (which we currently don't). All of us have
      agreed that allowing /dev/sev in the namespace for only SEV-enabled
      guests is worth doing nonetheless.

In the meantime, Christophe went through the kernel code to verify how the SEV
resources are managed and what protection is currently in place to mitigate the
chance of a process easily depleting the limit on SEV guests. He found that
ASID, which determines the encryption key, is allocated from a single ASID
bitmap and essentially guarded by a single 'sev->active' flag.

So, in conclusion, we absolutely need input from Brijesh (AMD) whether there
was something more than the low limit on number of guests behind the default
permissions. Also, we'd like to get some details on how the limit is managed,
helping to assess the approaches mentioned above.

Thanks and please do share your ideas,
Erik

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1665400
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1561113
