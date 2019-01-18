Received: from eggs.gnu.org ([209.51.188.92]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1gkSCx-0007AB-Rh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1gkSCw-0003FY-GR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:21:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1gkSCw-0003Bt-7o
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:21:06 -0500
Date: Fri, 18 Jan 2019 12:11:50 +0100
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190118111150.GA28476@wheatley>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<20190118101638.GE20660@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190118101638.GE20660@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, brijesh.singh@amd.com, dinechin@redhat.com


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 10:16:38AM +0000, Daniel P. Berrang=E9 wrote:
>On Fri, Jan 18, 2019 at 10:39:35AM +0100, Erik Skultety wrote:
>> Hi,
>> this is a summary of a private discussion I've had with guys CC'd on thi=
s email
>> about finding a solution to [1] - basically, the default permissions on
>> /dev/sev (below) make it impossible to query for SEV platform capabiliti=
es,
>> since by default we run QEMU as qemu:qemu when probing for capabilities.=
 It's
>> worth noting is that this is only relevant to probing, since for a prope=
r QEMU
>> VM we create a mount namespace for the process and chown all the nodes (=
needs a
>> SEV fix though).
>>
>> # ll /dev/sev
>> crw-------. 1 root root
>>
>> I suggested either force running QEMU as root for probing (despite the o=
bvious
>> security implications) or using namespaces for probing too. Dan argued t=
hat
>> this would have a significant perf impact and suggested we ask systemd t=
o add a
>> global udev rule.
>

If the creation of namespaces is poses a performance impact, then why don't=
 we
special-case the probing in a sense that we create one namespace for probin=
g,
once, and probe all QEMU binaries in that one namespace?

>I've just realized there is a potential 3rd solution. Remember there is
>actually nothing inherantly special about the 'root' user as an account
>ID. 'root' gains its powers from the fact that it has many capabilities
>by default.  'qemu' can't access /dev/sev because it is owned by a
>different user (happens to be root) and 'qemu' does not have capabilities.
>
>So we can make probing work by using our capabilities code to grant
>CAP_DAC_OVERRIDE to the qemu process we spawn. So probing still runs
>as 'qemu', but can none the less access /dev/sev while it is owned
>by root.  We were not using 'qemu' for sake of security, as the probing
>process is not executing any untrusthworthy code, so we don't  loose any
>security protection by granting CAP_DAC_OVERRIDE.
>

IMHO CAP_DAC_OVERRIDE is a lot, especially on systems without SELinux.

>> I proceeded with cloning [1] to systemd and creating an udev rule that I=
 planned
>> on submitting to systemd upstream - the initial idea was to mimic /dev/k=
vm and
>> make it world accessible to which Brijesh from AMD expressed a concern t=
hat
>> regular users might deplete the resources (limit on the number of guests
>> allowed by the platform). But since the limit is claimed to be around 4,=
 Dan
>> discouraged me to continue with restricting the udev rule to only the 'k=
vm'
>> group which Laszlo suggested earlier as the limit is so small that a mal=
icious
>> QEMU could easily deplete this during probing. This fact also ruled out =
any
>> kind of ACL we could create dynamically. Instead, he suggested that we f=
ilter
>> out the kvm-capable QEMU and put only that one in the namespace without a
>> significant perf impact.
>
>Yes, my suggestion to mimic /dev/kvm was based on the mistaken mis-underst=
anding
>that there was not a finite resource limit. Given that there are one or mo=
re
>finite resource limits, we need access control on which unprivileged users=
, and
>/or which individual QEMU instances are permitted access. This means /dev/=
sev
>must remain with restrictive user/group/permissions that prevent any unpri=
vilegd
>account from having access. This means either root:root 0770/0700, or poss=
ibly
>having an 'sev' group and using root:sev 0770, so that users can be granted
>access via 'sev' group membership which (might?) allow unprivileged libvir=
td to
>use 'sev' if the user was added.
>
>>     - my take on this is that there could potentially be more than a sin=
gle
>>       kvm-enabled QEMU and therefore we'd need to create more than just a
>>       single namespace.
>
>True, I guess qemu-system-x86_64 and qemu-system-i386 both get KVM
>on an x86_64 host, and likewise for many other 64-bit archs supporting.
>32-bit apps.
>
>>     - I also argued that I can image that the same kind of DOS attack mi=
ght be
>>       possible from within the namespace, even if we created the /dev/se=
v node
>>       only in SEV-enabled guests (which we currently don't). All of us h=
ave
>>       agreed that allowing /dev/sev in the namespace for only SEV-enabled
>>       guests is worth doing nonetheless.
>
>There's never any perfect level of protection. We're just striving to
>minimize the attack surface by only exposing it where there's a genuine
>need to use it.
>
>> In the meantime, Christophe went through the kernel code to verify how t=
he SEV
>> resources are managed and what protection is currently in place to mitig=
ate the
>> chance of a process easily depleting the limit on SEV guests. He found t=
hat
>> ASID, which determines the encryption key, is allocated from a single AS=
ID
>> bitmap and essentially guarded by a single 'sev->active' flag.
>>
>> So, in conclusion, we absolutely need input from Brijesh (AMD) whether t=
here
>> was something more than the low limit on number of guests behind the def=
ault
>> permissions. Also, we'd like to get some details on how the limit is man=
aged,
>> helping to assess the approaches mentioned above.
>
>Regardless of this problem, I think it is important to have some docs
>in either libvirt or QEMU that describe the resource usage constraints
>so that management apps can decide how to best take advantage of SEV.
>
>>
>> Thanks and please do share your ideas,
>> Erik
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1665400
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1561113
>
>Regards,
>Daniel
>--=20
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrang=
e :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.co=
m :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrang=
e :|

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlxBtHYACgkQCB/CnyQX
ht33zg/+PoODXGubZNasqusHJbstu5Ks3tUH2hRM3fc5C5Sm2ZKdbusTPPptDybD
UuX5rV+VgMqYeyRh6RNDX2zkOVpUoJ4NJ70OPCUXVqRkE8b5bIISY8sBXJcD9wlf
aMZ3Bf7mZhKeoN5NKni7wDa7f7dD3uDQbVkW+h3eV9fEkOIq1kovieQwoYJavDse
kd20QsUSHqw3kiYpiAM61w5pms7UnoWakGQaUMnA5zVU2ESxrMQTBn2XYis6KmRp
l7Ht0rHR01GgpEiSKD+1OwKVQy/4+22dsUyV2UYOegH9d7DSXZZzjgJOpcjNKPnC
MhcFEeNAgGh6S10UAPFXsQXTC0BtGa/8E5ASR2cdGOCoAxY76apjM3R+2d4eb0p0
OijKoqtXZeBTnvMZulOmjNWtIrEON/kNMAltQn8EDCy7DhzmQnZa4wytBFKMEsAU
zA0EG344Z1F4qwKqoL3Hq9kNCjm4ns9z5mBep0OthkZBJcaDLsVJc8gZZCnUrcC1
9gS/VLkStnpBY16CTJX/WHq/Y5Ph3XVaxiJoG9Akxhj4IG7ouFRb0D/v1gMviUyw
910KLHOp/9jZWqsxvg7NJZ27nnam5eM3zcMFUusJPdSQzLykGJErkjLNGCLlLFpK
HxVw4y36+HM5tkoCTy5uA9+61p357SoWqjTrrt99a41oGhdjzb4=
=bCXI
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
