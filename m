Received: from eggs.gnu.org ([2001:4830:134:3::10]:60248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRMJC-0004gA-B0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRMJ9-0006Us-6H
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:40:22 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com
	([104.47.32.45]:4096
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fRMJ8-0006UR-LU
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:40:19 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 8 Jun 2018 18:40:16 +0000
Message-ID: <DM5PR12MB24717A9DD61F79F58D3E70F7957B0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-4-git-send-email-babu.moger@amd.com>
	<20180606223956.GD7451@localhost.localdomain>
In-Reply-To: <20180606223956.GD7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 3/4] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>

Hi Eduardo,=20
Sorry for the late response. Got pulled into something else.

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, June 6, 2018 5:40 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v12 3/4] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Wed, Jun 06, 2018 at 10:36:45AM -0400, Babu Moger wrote:
> > Enable TOPOEXT feature on EPYC CPU. This is required to support
> > hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> >
> > Disable TOPOEXT feature for legacy machines.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> Now, I just noticed we have a problem here:
>=20
> "-machine pc -cpu EPYC -smp 64" works today
>=20
> This patch makes it stop working, but it shouldn't.

No. It works fine. I have tested it.

>=20
> On the other hand, I believe you expect:
> * "-machine pc -cpu EPYC -smp 8" to automatically enable topoext.
Yes. Only on new machines-types
> * "-machine pc -cpu Opteron_G1 -smp 8" to not enable topoext.
Yes.
> * What about "-machine -cpu Opteron_G1 -smp 8,threads=3D2"?
No. This should not enable topoext.  Topoext is not supported by Opteron_G1=
.
This should warn about hyperthreading and continue.
>=20
>=20
> We also have other requirements, I will try to enumerate all of
> them below:
>=20
> 0) "-topoext" explicitly configured (any machine-type):
> * Must never enable topoext.
Yes.
>=20
> 1) "+topoext" explicitly configured (any machine-type):
> * Must validate topology and refuse to start if unsupported.

Yes.

>=20
> 2) Older machine-types:
> * Must never enable topoext automatically, even if using "EPYC"
>   or "threads=3D2"
>=20
Yes.

> 3) "EPYC" CPU model (on new machine-types):
> * Should enable topoext automatically, but only if topology is
>   supported.
> * Must not error out if topology is not supported.
In new machine types we will enable topoext for "EPYC" CPU model.
Right now(old machine type) we can disable for all the CPU models.=20
So, we don't need two bits(topoext and auto-topoext)

I thought we should error out if topology cannot be supported. But we can w=
arn(disable topoext) and continue that is another option.

> * Should this enable topoext automatically even if threads=3D1?

Yes. We should enable even with threads=3D1.

>=20
> 4) Other AMD CPU models with "threads=3D2" (on new machine-types):
> * We might want to make this enable topoext automatically, too.
>   What do you think?

  No. We should not enable topoext here. We should depend on CPU model tabl=
e here.

>=20
> Is the above description accurate?  Do you agree with these
> requirements?

With these requirements in mind, I will send that patches. We can start our=
 discussion.
We don't need one more bits. That is my opinion.=20


>=20
> We're trying to use the "topoext" property to cover all cases
> above, but it looks like we need at least 2 bits to represent all
> possible cases.
>=20
>=20
> Maybe we can represent the cases above with two properties:
> "topoext" and "auto-topoext".  Then each case would be
> represented by:
>=20
> 0) "-topoext" explicitly configured (any machine-type):
> * Will clear TOPOEXT on env->features and set TOPOEXT on
>   env->user_features
>   (already done today)
>=20
> 1) "+topoext" explicitly configured (any machine-type):
> * Will set TOPOEXT on both env->user_features and env->features
>   (already done today)
>=20
> 2) Older machine-types:
> * Will set auto-topoext=3Doff (can be done on compat_props)
> * Will set topoext=3Doff on EPYC CPU model (so TOPOEXT won't be set
>   by default on env->features) (can be done on compat_props)
>=20
> 3) "EPYC" CPU model (on new machine-types):
> * Will set auto-topoext=3Don (can be the default for all CPU
>   models)
> * Will set TOPOEXT on env->features) (can be done on CPU model table)
>=20
> 4) Other AMD CPU models with "threads=3D2" (on new machine-types):
> * Will set auto-topoext=3Don (can be the default on all CPU models)
> * Will keep TOPOEXT disabled on env->features (done on the CPU
>   model table)
>=20
>=20
> Then the rules would be:
>=20
>   if {auto_topoext && TOPOEXT not in env->user_features) {
>       if (supported_topology) {
>           if (threads > 1)
>               set TOPOEXT in env->features
>       } else
>           unset TOPOEXT in env->features
>   }
>=20
>   if (TOPOEXT in env->features && !supported_topology)
>       error;
>   }
>=20
> I think this would fulfill all the requirements above.  Please
> help me confirm that.
>=20
> --
> Eduardo
