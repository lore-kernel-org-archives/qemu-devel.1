Received: from eggs.gnu.org ([2001:4830:134:3::10]:53174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1em05b-0004e9-T5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1em05X-00039B-WF
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:39:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1em05X-00037x-QZ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:39:19 -0500
Date: Wed, 14 Feb 2018 17:38:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180214173858.464f4c59.cohuck@redhat.com>
In-Reply-To: <20180214161213.7894-1-mdroth@linux.vnet.ibm.com>
References: <20180214161213.7894-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Bruce Rogers <brogers@suse.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, David Hildenbrand <david@redhat.com>

On Wed, 14 Feb 2018 10:12:13 -0600
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> This blog entry is intended as a follow-up to the original entry in
> January regarding Spectre/Meltdown and the proposed changes to address
> them in the upcoming 2.11.1 release.
>=20
> This entry is meant to accompany the 2.11.1 release (planned for
> 2018-02-14) and document how to make use of the new options for
> various architectures.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Bruce Rogers <brogers@suse.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> v2:
>  * s/by itself that/by itself for that/ (Bruce)
>  * make example formats more consistent (Bruce)
>  * clarify wording WRT to host-side security (Daniel, Paolo)
>  * general wording/formatting fix-ups (Thomas)
>  * s/options/feature bits/ (Cornelia)
>  * clarify s390x CPU feature defaults (Thomas/Cornelia/Christian/David)
>  * clarify s390x migration compatibility statement (Cornelia)
>=20
> Thank you for the review!

Thank you for writing this blog post!

>=20
>  .../2018-02-14-qemu-2-11-1-and-spectre-update.md   | 190 +++++++++++++++=
++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 _posts/2018-02-14-qemu-2-11-1-and-spectre-update.md

> +## Enabling mitigation features for s390x KVM guests
> +
> +For s390x guests there are 2 CPU feature bits relating to Spectre/Meltdo=
wn:
> +
> +* bpb: Branch prediction blocking
> +* ppa15: PPA15 is installed
> +
> +**bpb** requires a host kernel patched with:
> +
> +    commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
> +    KVM: s390: wire up bpb feature
> +
> +and both **bpb** and **ppa15** require a firmware with the appropriate s=
upport
> +level as well as guest kernel patches to enable the functionality within
> +guests. Please check with your distro/vendor to confirm.
> +
> +Both **bpb** and **ppa15** are enabled by default with newer/patched host
> +kernels, and can also be set manually. For example:
> +
> +    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
> +      -cpu zEC12,bpb=3Don,ppa15=3Don=20
> +
> +Both **bpb** and **ppa15** are enabled by default when using "-cpu host"
> +and when the host kernels supports these facilities. For other CPU
> +models, the flags have to be set manually. For example:
> +
> +    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
> +      -cpu zEC12,bpb=3Don,ppa15=3Don
> +
> +With regard to migration, enabling **bpb** or **ppa15** feature flags re=
quires
> +that the source/target also those flags enabled.=20

s/also those/also has those/

> Since this is enabled by
> +default for '-cpu host' (when available on the host), you must ensure th=
at
> +**bpb**=3Doff,**ppa15**=3Doff is used if you wish to maintain migration
> +compatibility with existing guests when using '-cpu host', or take steps=
 to
> +reboot guests with **bpb**/**ppa15** enabled prior to migration.

Otherwise, s390 part looks good to me.
