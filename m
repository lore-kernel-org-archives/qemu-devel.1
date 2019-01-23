Received: from eggs.gnu.org ([209.51.188.92]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gmID4-0005PG-7z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gmI9t-0000bx-Rc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:01:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gmI9o-0000QO-ER
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:01:31 -0500
Date: Wed, 23 Jan 2019 13:55:06 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190123125506.GA2376@beluga.usersys.redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<65f933a2-f63c-962f-c503-43c7e84ab5e8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65f933a2-f63c-962f-c503-43c7e84ab5e8@amd.com>
Content-Transfer-Encoding: quoted-printable
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
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>, "dinechin@redhat.com" <dinechin@redhat.com>, "mkletzan@redhat.com" <mkletzan@redhat.com>

On Fri, Jan 18, 2019 at 12:51:50PM +0000, Singh, Brijesh wrote:
>
> On 1/18/19 3:39 AM, Erik Skultety wrote:
> > Hi,
> > this is a summary of a private discussion I've had with guys CC'd on =
this email
> > about finding a solution to [1] - basically, the default permissions =
on
> > /dev/sev (below) make it impossible to query for SEV platform capabil=
ities,
> > since by default we run QEMU as qemu:qemu when probing for capabiliti=
es. It's
> > worth noting is that this is only relevant to probing, since for a pr=
oper QEMU
> > VM we create a mount namespace for the process and chown all the node=
s (needs a
> > SEV fix though).
> >
> > # ll /dev/sev
> > crw-------. 1 root root
> >
> > I suggested either force running QEMU as root for probing (despite th=
e obvious
> > security implications) or using namespaces for probing too. Dan argue=
d that
> > this would have a significant perf impact and suggested we ask system=
d to add a
> > global udev rule.
> >
> > I proceeded with cloning [1] to systemd and creating an udev rule tha=
t I planned
> > on submitting to systemd upstream - the initial idea was to mimic /de=
v/kvm and
> > make it world accessible to which Brijesh from AMD expressed a concer=
n that
> > regular users might deplete the resources (limit on the number of gue=
sts
> > allowed by the platform).
>
>
> During private discussion I didn't realized that we are discussing a
> probe issue hence things I have said earlier may not be applicable
> during the probe. The /dev/sev is managed by the CCP (aka PSP) driver.
> The /dev/sev is used for communicating with the SEV FW running inside
> the PSP. The SEV FW offers platform and guest specific services. The
> guest specific services are used during the guest launch, these service=
s
> are available through KVM driver only. Whereas the platform services ca=
n
> be invoked at anytime. A typical platform specific services are:
>
> - importing certificates
>
> - exporting certificates
>
> - querying the SEV FW version etc etc
>
> In case of the probe we are not launch SEV guest hence we should not be
> worried about depleting the SEV ASID resources.
>
> IIRC, libvirt uses QEMP query-sev-capabilities to probe the SEV support=
.
> QEMU executes the below sequence to complete the request:
>
> 1. Exports the platform certificates=C2=A0 (this is when /dev/sev is ac=
cessed).
>
> 2. Read the host MSR to determine the C-bit and reduced phys-bit positi=
on
>
> I don't see any reason why we can't give world a 'read' permission to
> /dev/sev. Anyone should be able to export the certificates and query

Okay, makes sense to me. The problem I see is the sev_platform_ioctl func=
tion
in QEMU which makes an _IOWR request, therefore the file descriptor being
opened in sev_get_capabilities is O_RDWR. Now, I only understand ioctl fr=
om
what I've read in the man page, so I don't quite understand the need for =
IOWR
here - but my honest guess would be that it's because the commands like
SEV_PDH_CERT_EXPORT or SEV_PLATFORM_STATUS need to be copied from userspa=
ce to
kernel to instruct kernel which services we want, ergo _IOWR, is that rig=
ht?
In any case, a fix of some sort needs to land in QEMU first, because no u=
dev
rule would fix the current situation. Afterwards, I expect that having a =
rule
like this:

KERNEL=3D=3D"sev", GROUP=3D"kvm", MODE=3D"0644"

and a selinux policy rule adding the kvm_device_t label, we should be fin=
e, do
we agree on that?

> status etc. I think the main issue is reading MSR -- which I believe is
> putting a 'root' requirement. Am I missing something ?
>
>
> > But since the limit is claimed to be around 4, Dan
>
>
> FYI, the limit on EPYC is 15.

Thanks for correction.

Erik
