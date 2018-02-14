Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elt0f-000554-6d
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elt0Z-0007Xd-Rq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:05:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elt0Z-0007WJ-La
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:05:43 -0500
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7052eafd-b231-bb93-298d-95913e825c45@redhat.com>
Date: Wed, 14 Feb 2018 10:05:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>

On 14.02.2018 01:11, Michael Roth wrote:
> This blog entry is intended as a follow-up to the original entry in
> January regarding Spectre/Meltdown and the proposed changes to address
> them in the upcoming 2.11.1 release.
>=20
> This entry is meant to accompany the 2.11.1 release (planned for
> 2018-02-14) and document how to make use of the new options for
> various architectures.

Thanks for writing this post, I think it will be quite helpful for the
users! Some comments below...

> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>=20
> The pseries/s390 bits have gotten some initial review (thanks Suraj/Chr=
istian),
> but it can definitely use some additional review on the x86 side of thi=
ngs.
>=20
> Also, Peter if think anything extra should to be mentioned on the ARM s=
ide just
> let me know what to add.
>=20
>  .../2018-02-14-qemu-2-11-1-and-spectre-update.md   | 180 +++++++++++++=
++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 _posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
>=20
> diff --git a/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md b/_pos=
ts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> new file mode 100644
> index 0000000..7cdea59
> --- /dev/null
> +++ b/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> @@ -0,0 +1,180 @@
> +---
> +layout: post
> +title:  "QEMU 2.11.1 and making use of Spectre/Meltdown mitigation for=
 KVM guests"
> +date: 2018-02-14 10:35:44 -0600
> +author: Michael Roth
> +categories: [meltdown, spectre, security, x86, ppc, s390, releases, 'q=
emu 2.11']

Maybe use "s390x" instead of "s390" ? ... we're using s390x as target
name in the sources, so this would be more consistent.

> +---
> +
> +In a [previous post](https://www.qemu.org/2018/01/04/spectre/) it was

I'm not a native speaker, so please simply ignore me if I write stupid
things, but I think I'd rather prefer active voice here:

A previous post described how QEMU/KVM might be ...

> +detailed how QEMU/KVM might be affected by Spectre/Meltdown attacks, a=
nd what
> +the plan was to mitigate them in QEMU 2.11.1 (and eventually QEMU 2.12=
).
> +
> +QEMU 2.11.1 is now available, and contains the aforementioned mitigati=
ons for
> +x86 guests, along with additional mitigation functionality for pseries=
 and
> +s390 guests (ARM guests do not currently require additional QEMU patch=
es).
> +However, enabling this functionality requires additional configuration=
 beyond
> +just updating QEMU, which we hope to address with this post.

"which we hope" sounds unconfident to me. Maybe rather write "which we
want" instead?

> +Please note that, as mentioned in the previous blog post, QEMU/KVM gen=
erally
> +has the same requirements as other unpriviledged processes running on =
the

s/unpriviledged/unprivileged/g

> +host WRT Spectre/Meltdown mitigation. What is being addressed here is

s/WRT/with regards to/g ... not every non-native speaker knows that
abbreviation.

> +enabling a guest operating system to enable the same (or similar) miti=
gations
> +to protect itself from unpriviledged guest processes. Thus, the

I'd maybe add a "running under the guest operating system" after the
"guest processes" to make it clear that we're not talking about
something like cross-VM exploits here.

> +patches/requirements listed here are specific to that goal and should =
not be
> +regarded as the full set of requirements to enable mitigations on the =
host
> +side (though in some cases there is some overlap between the two WRT r=
equired
> +patches/etc).
> +
> +Also please note that this is a best-effort from the QEMU/KVM communit=
y, and
> +these mitigations rely on a mix of additional kernel/firmware/microcod=
e
> +updates that are in some cases not available publically, or may not ye=
t be

Maybe: s/publically/publicly (yet)/ ?

> +implemented in some distros, so users are highly encouraged to consult=
 with
> +their respective vendors/distros to confirm whether all the required
> +components are in place. We do our best to highlight the requirements =
here,
> +but this may not be an exhaustive list.
> +
> +
> +## enabling mitigations for x86 KVM guests

Maybe: s/enabling/Enabling/ ?

Should we maybe also rather talk about "mitigation features" or
"mitigation flasgs" instead of "mitigations", since the mitigation
itself has rather to be enabled by the guest OS instead?

> +For x86 guests there are 2 additional CPU flags associated with
> +Spectre/Meltdown mitigation: **spec-ctrl**, and **ibpb**.

I think I'd rather move the bullet list below to this place here instead.=
..

> These flags
> +expose additional functionality made available through new microcode
> +updates for certain Intel/AMD processors that can be used to mitigate
> +various attack vectors related to Spectre. (Meltdown mitigation via KP=
TI
> +does not require additional CPU functionality or microcode, and does n=
ot
> +require an updated QEMU, only the related guest/host kernel patches).
> +
> +These CPU flags:
> +
> +* spec-ctrl: exposes Indirect Branch Restricted Speculation (IBRS)
> +* ibpb: exposes Indirect Branch Prediction Barriers

... and then simply start this sentence with "For being able to use both
CPU flags a guest and host kernel update is required ..." or so.

> +are both features requiring guest/host kernel updates, as well as
> +microcode updates for Intel and recent AMD processors. The status of
> +these kernel patches upstream is still in flux, but most supported
> +distros have some form of the patches that is sufficient to make use
> +of the features. The current status/availability of microcode updates
> +depends on your CPU architecture/model. Please check with your
> +vendor/distro to confirm these prerequisites are available/installed.
> +
> +Generally, for Intel CPUs with updated microcode, **spec-ctrl** will
> +enable both IBRS and IBPB functionality. For AMD EPYC processors,
> +**ibpb** can be used to enable IBPB specifically, and is thought to
> +be sufficient by itself that particular architecture.

s/itself that/itself on that/ ?

> +These flags can be set in a similar manner as other CPU flags, i.e.:
> +
> +    qemu-system-x86_64 -cpu qemu64,+spec-ctrl,... ...
> +    qemu-system-x86_64 -cpu IvyBridge,+spec-ctrl,... ...
> +    qemu-system-x86_64 -cpu EPYC,+ibpb
> +    etc...
> +
> +Additionally, for management stacks that lack support for setting
> +specific CPU flags, a set of new CPU types have been added which
> +enable the appropriate CPU flags automatically:
> +
> +    qemu-system-x86_64 -cpu Nehalem-IBRS ...
> +    qemu-system-x86_64 -cpu Westmere-IBRS ...
> +    qemu-system-x86_64 -cpu SandyBridge-IBRS ...
> +    qemu-system-x86_64 -cpu IvyBridge-IBRS ...
> +    qemu-system-x86_64 -cpu Haswell-IBRS ...
> +    qemu-system-x86_64 -cpu Haswell-noTSX-IBRS ...
> +    qemu-system-x86_64 -cpu Broadwell-IBRS ...
> +    qemu-system-x86_64 -cpu Broadwell-noTSX-IBRS ...
> +    qemu-system-x86_64 -cpu Skylake-Client-IBRS ...
> +    qemu-system-x86_64 -cpu Skylake-Server-IBRS ...
> +    qemu-system-x86_64 -cpu EPYC-IBPB ...
> +
> +With these settings enabled, guests may still require additional
> +configuration to enable IBRS/IBPB, which may vary somewhat from one
> +distro to another. For RHEL guests, the following resource may be
> +useful:
> +
> +* https://access.redhat.com/articles/3311301
> +
> +WRT migration compatibility, **spec-ctrl**/**ibrs** (or the correspond=
ing
> +CPU type) should be set the same on both source/target to maintain
> +compatibility. Thus, guests will need to be rebooted to make use of
> +the new features.
> +
> +
> +## enabling mitigations for pseries KVM guests
> +
> +For pseries guests there are 3 tri-state -machine options/capabilities
> +relating to Spectre/Meltdown mitigation: **cap-cfpc**, **cap-sbbc**,
> +**cap-ibs**, which each correspond to a set of host machine capabiliti=
es
> +advertised by the KVM kernel module in new/patched host kernels that c=
an
> +be used to mitigate various aspects of Spectre/Meltdown:
> +
> +* cap-cfpc: Cache Flush on Privilege Change
> +* cap-sbbc: Speculation Barrier Bounds Checking
> +* cap-ibs: Indirect Branch Serialisation
> +
> +Each option can be set to one of "broken", "workaround", or "fixed", w=
hich
> +correspond, respectively, to instructing the guest whether the host is
> +vulnerable, has OS-level workarounds available, or has hardware/firmwa=
re
> +that does not require OS-level workarounds. Based on these options, QE=
MU
> +will perform checks to validate whether the specified settings are ava=
ilable
> +on the current host and pass these settings on to the guest kernel. At=
 a
> +minimum, any setting other than "broken" will require a host kernel th=
at has
> +some form of the following patches:
> +
> +    commit 3214d01f139b7544e870fc0b7fcce8da13c1cb51
> +    KVM: PPC: Book3S: Provide information about hardware/firmware CVE =
workarounds
> + =20
> +    commit 191eccb1580939fb0d47deb405b82a85b0379070
> +    powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
> +
> +and whether a host will support "workaround" and "fixed" settings for =
each
> +option will depend on the hardware/firmware level of the host system.
> +
> +In turn, to make use of "workaround" or "fixed" settings for each opti=
on,
> +the guest kernel will require at least the following set of patches:
> +
> +* https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-January/167455.=
html
> +
> +These are available upstream and have been backported to a number of s=
table
> +kernels. Please check with your vendor/distro to confirm the required
> +hardware/firmware and guest kernel patches are available/installed.
> +
> +By default, all three options, **cap-cfpc**, **cap-sbbc**, and **cap-i=
bs**
> +default to "broken" to maintain compatibility with previous versions o=
f QEMU

"By default ... default to ..." - I'd suggest to drop the initial "By
default".

> +and unpatched host kernels. To enable them you must start QEMU with th=
e
> +desired mitigation strategy specified explicitly. For example:
> +
> +    qemu-system-ppc64 ... \
> +      -machine pseries-2.11,cap-cfpc=3Dworkaround,cap-sbbc=3Dworkaroun=
d,cap-ibs=3Dfixed
> +
> +WRT migration compatibility, setting any of these features to a value =
other
> +than "broken" will require an identical setting for that option on the
> +source/destination guest. To enable these settings your guests will ne=
ed to
> +be rebooted at some point.
> +
> +
> +## enabling mitigations for s390 KVM guests
> +
> +For s390 guests there are 2 CPU options relating to Spectre/Meltdown:
> +
> +* bpb: Branch prediction blocking
> +* ppa15: PPA15 is installed
> +
> +**bpb** requires a host kernel patched with:
> +
> +    commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
> +    KVM: s390: wire up bpb feature
> +
> +and both **bpb** and **ppa15** require a firmware with the appropriate=
 support
> +level as well as guest kernel patches to enable the functionality with=
in
> +guests. Please check with your distro/vendor to confirm.
> +
> +Both **bpb** and **ppa15** are enabled by default with newer/patched h=
ost
> +kernels, and can also be set manually. For example:
> +
> +    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
> +      -cpu zEC12,bpb=3Don,ppa15=3Don=20

IIRC we only enable them by default with "-cpu host" ? Cornelia, David,
Christian, can you confirm?
So maybe better rephrase the above to:

Both **bpb** and **ppa15** are enabled by default when using "-cpu host"
and when the host kernels supports these facilities. For other CPU
models, the flags have to be set manually. For example:

    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
      -cpu zEC12,bpb=3Don,ppa15=3Don

> +WRT to migration, enabling **bpb** requires the source/target also hav=
e **bpb**
> +enabled. Since this is enabled by default, you must ensure that **bpb*=
*=3Doff if

s/**bpb**=3Doff/**bpb**=3Doff is used/ ?

> +you wish to maintain migration compatibility with existing guests, or =
take
> +steps to reboot guests with **bpb** enabled prior to migrating them.

 Thomas
