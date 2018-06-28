Received: from eggs.gnu.org ([2001:4830:134:3::10]:36760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZ6c-0000qG-3c
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZ6Y-0006Bt-Vl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:45:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYZ6Y-0006AN-Ox
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D0194010216
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:45:06 +0000 (UTC)
Date: Thu, 28 Jun 2018 16:45:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628154502.GO3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

This post is to raise question about helping use of named CPU models with
KVM ie any case not using -cpu host.

In the old days (ie before 2018), the world was innocent and we had a nice
set of named CPU models that corresponded to different Intel/AMD physical
CPU families/generations (lets temporarily ignore the -noTSX fiasco).

An application could query libvirt to determine what the host CPU model
was/is and use that model name in the guest XML and be fairly happy. If
they wanted to, they could explicitly include the extra features listed
by capabilities XML, or just rely on the host-model.

Then Spectre happened, and QEMU took the decision to almost double the
number of x86 models, adding in -IBRS / -IBPB variants for most CPU model,
so that applications could get the spec_ctrl / ibpb flags set without
having to manually list them.

In retrospect this was somewhat pointless, at least at the QEMU level,
because there is little difference in complexity between the two approaches:

   -cpu Westmere,+spec-ctrl
   -cpu Westmere-IBRS

At a higher level the extra named CPU models were slightly useful in so much
as many application developers had taken a lazy approach and not provided
users any way to explicitly turn on extra flags. This affected oVirt,
OpenStack and virt-manager, and probably more. Though OpenStack since added
ability to turn on arbitrary flags in response to the Spectre flaw, others
have not.

Then a recently along came the Speculative Store Bypass hardware vulnerability
requiring addition of yet another CPU flag to guest configs. This required use
of 'ssbd' on Intel and 'virt-ssbd' on AMD. While QEMU could have now added yet
more CPU models, eg Westmere-SSBD, this does not feel like a winning strategy
long term. Looking at the models how would a user have any clue whether the
-IBRS or -SSBD or -NEXT-FLAW or -YET-ANOTHER-FLAW suffix is "better" ? So QEMU
and libvirt took the joint decision to stop adding new named CPU models when
CPU vulnerabilities are discovered from this point forwards. Applications /
users would be expected to turn on CPU features explicitly as needed and are
considered broken if they don't provide this functionality.

As briefly mentioned above though, even before Spectre we had the pain of
dealing with the -noTSX CPU models working around brokenness in the Intel TSX
impl where they had to delete a CPU feature during microcode updates. This was
rather painful to roll out at the time.

An alternative to adding CPU models is to change meaning of existing CPU
models. QEMU has a way todo this by tieing the change to machine types, and
it has in fact been used to correct mistakes in the specification of CPU
models in the past, when those mistakes have not had dependancies on microcode
changes. This is not a particularly attractice way to deal with the errata.
Short life distros tend to stick with upstream QEMU machine types and won't
want to diverge by adding their own machine types. This gates them on having
upstream define the extra machine types which is tricky under embargo. Long
life distros do typically take on the burden of defining custom machine types,
but usually only add them when doing major updates.

The pain point with machine types is that the testing matrix grows at O(n^2)
Using machine types for CPU security errata would significant increase the
number of machine types and thus the testing matrix. eg if a security fix
is needed in rhel-7.3, 7.4, 7.5 we can't just add a pc-rhel-7.5.1 machine
with the fix, as it would not be possible to implement that in 7.3. So we
would need would need pc-rhel-7.3.1,  pc-rhel-7.4.1,  pc-rhel-7.5.1, machine
types, with 7.5 gaining all three. Finally CPU model changes have host
hardware dependancies and machine types need to be independant of the host,
since they are decided statically are build time. The only nice thing about
machine type is that it is reasonably obvious what the "best" machine type
is as they include a version number in the name, and users automatically get
the best if they use an unversioned name.


What if we can borrow the concept of versioning from machine types and apply
it to CPU models directly. For example, considering the history of "Haswell"
in QEMU, if we had versioned things, we would by now have:

     Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e7185de3ab60a)
     Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be2146a742a85212c_
     Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef737dad2acb05e6da03753)
     Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449a60ad8b11
     Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342d9b686e31ab87458)
     Haswell-3.0.0  - added 'ssbd' (never done)

If we followed the machine type approach, then a bare "Haswell" would
statically resolve at build time to the most recent Haswell-X.X.X version
associated with the QEMU release. This is unhelpful as we have a direct
dependancy on the host hardware features. Better would be for a bare
"Haswell" to be dynamically resolved at runtime, picking the most recent
version that is capable of launching given the current hardware, KVM/TCG impl
and QEMU version.

  ie -cpu  Haswell

should use Haswell-2.5.0  if on silicon with the TSX errata applied,
but use Haswell-2.12.0 if the Spectre errata is applied in microcode,
and use Haswell-3.0.0 once Intel finally releases SSBD microcode errata.

Versioning of CPU models as opposed to using arbitrary string suffixes
(-noTSX, -IBRS) has a number of usability improvements that we would
gain with versioned machine types, while avoiding exploding the machine
type matrix. With versioned CPU models we can

 - Automatically tailor the best model based on hardware support

 - Users always get the best model if they use the bare CPU name

 - It is obvious to users which is the "best" / "newest" CPU model

 - Avoid combinatorial expansion of machines since same CPU model
   version can be added to all releases without adding machine types.

 - Users can still force a specific downgraded model by using the
   fully versioned name.

Such versioning of CPU models would largely "just work" with existing
libvirt versions, but to libvirt would really want to expand the bare
CPU name to a versioned CPU name when recording new guest XML, so the
ABI is preserved long term.

An application like virt-manager which wants a simple UI can forever be
happy simply giving users a list of bare CPU model names, and allowing
libvirt / QEMU to automatically expand to the best versioned model for
their host.

An application like oVirt/OpenStack which wants direct control can allow
the admin to choice if a bare name, or explicitly picking a versioned name
if they need to cope with possibility of outdated hosts.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
