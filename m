Received: from eggs.gnu.org ([2001:4830:134:3::10]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etz1y-0002IX-84
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etz1u-0007sx-AS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:08:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etz1u-0007sg-4N
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:08:34 -0500
Date: Thu, 8 Mar 2018 17:08:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308170824.GL4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-29-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On Thu, Mar 08, 2018 at 06:49:01AM -0600, Brijesh Singh wrote:
> Blacklist the following commands to fix the 'make check' failure.
>=20
> query-sev-launch-measure: it returns meaninful data only when we launch
> SEV guest otherwise the command returns an error.
>=20
> query-sev: it return an error when SEV is not available on host (e.g no=
n
> X86 platform or KVM is disabled at the build time)
>=20
> query-sev-capabilities: it returns an error when SEV feature is not
> available on host machine.

We generally expect 'make check' to succeed on every single patch
in a series, so that 'git bisect' doesn't break.

So you should add each command to the blacklist in the same commit
that introduced the failure in the first place.

>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  tests/qmp-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 22445d9ec258..7470c6b754bc 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -204,6 +204,11 @@ static bool query_is_blacklisted(const char *cmd)
>          "query-gic-capabilities", /* arm */
>          /* Success depends on target-specific build configuration: */
>          "query-pci",              /* CONFIG_PCI */
> +        /* Success depends on launching SEV guest */
> +        "query-sev-launch-measure",
> +        /* Success depends on Host or Hypervisor SEV support */
> +        "query-sev",
> +        "query-sev-capabilities",
>          NULL
>      };
>      int i;
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
