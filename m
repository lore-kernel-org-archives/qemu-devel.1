Received: from eggs.gnu.org ([2001:4830:134:3::10]:56694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUaK-0001bu-FK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUaG-0008I1-6E
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:13:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erUaG-0008HV-0Y
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:13:44 -0500
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-27-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e11092fd-d332-8708-4dd2-38147dde83e9@redhat.com>
Date: Thu, 1 Mar 2018 14:13:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180228211028.83970-27-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 26/28] qmp: add query-sev-capabilities
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On 02/28/2018 03:10 PM, Brijesh Singh wrote:
> The command can be used by libvirt to query the SEV capabilities.
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   monitor.c             |  7 +++++++
>   qapi-schema.json      | 42 ++++++++++++++++++++++++++++++++++++++++++
>   target/i386/monitor.c |  5 +++++
>   3 files changed, 54 insertions(+)

And another rebase victim.


> +##
> +# @query-sev-capabilities:
> +#
> +# This command is used to get the SEV capabilities and supported on AM=
D

grammar suggestion: s/capabilities and/capabilities, and is/

> +# X86 platform only.

s/platform/platforms/

> +#
> +# Returns: a list of SevCapability objects.

This says it returns a list of objects...

> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "query-sev-capabilities" }

...but this says it returns a single object.

> +# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
> +#                  "cbitpos": 47, "reduced-phys-bits": 5}}
> +#
> +##
> +{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 577d50eebaaa..1b55dd0fff88 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -737,3 +737,8 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(=
Error **errp)
>  =20
>       return info;
>   }
> +
> +SevCapability *qmp_query_sev_capabilities(Error **errp)
> +{
> +    return NULL;

Should call error_setg() before returning NULL.

> +}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
