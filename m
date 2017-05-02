Received: from eggs.gnu.org ([2001:4830:134:3::10]:41929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fYe-000747-Jj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fYb-0007NP-SJ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5fYb-0007M0-II
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:42:05 -0400
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27580102-61c1-63e2-bf97-1e86cb1aaf25@redhat.com>
Date: Tue, 2 May 2017 16:42:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170502203115.22233-5-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wHSGbnunKpWE6DCQ2O7HF2QUp8IFi9HPt"
Subject: Re: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHSGbnunKpWE6DCQ2O7HF2QUp8IFi9HPt
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <27580102-61c1-63e2-bf97-1e86cb1aaf25@redhat.com>
Subject: Re: [PATCH 4/4] x86: Support feature=force on the command-line
References: <20170502203115.22233-1-ehabkost@redhat.com>
 <20170502203115.22233-5-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 03:31 PM, Eduardo Habkost wrote:
> Introduce a new CPUFeatureSetting QAPI data type, and use it to support=

> feature=3Dforce on -cpu.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi-schema.json              | 32 +++++++++++++++++++++++++
>  target/i386/cpu.h             |  2 ++
>  target/i386/cpu.c             | 55 +++++++++++++++++++++++++++++++++--=
--------
>  tests/test-x86-cpuid-compat.c | 14 ++++++++++-
>  4 files changed, 90 insertions(+), 13 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 01b087fa16..d716409114 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4250,6 +4250,38 @@
>  { 'command': 'query-machines', 'returns': ['MachineInfo'] }
> =20
>  ##
> +# @CPUFeatureSettingEnum:
> +#
> +# Additional valid values for a CPUFeatureSetting property.
> +#
> +# @force: Force feature to be enabled, even if the accelerator
> +#         reports the feature as unavailable. Should be used only
> +#         for testing or debugging purposes.
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'CPUFeatureSettingEnum',
> +  'data': ['force'] }
> +
> +##
> +# @CPUFeatureSetting:
> +#
> +# Values for a CPU feature property.
> +#
> +# @bool: If false, the feature is forcibly disabled.
> +#        If true, QEMU will try to enable the feature. QEMU will
> +#        refuse to start if the feature is unavailable and
> +#        'enforce' mode is enabled in the CPU.
> +#
> +# @enum: See @CPUFeatureSettingEnum.
> +#
> +# Since: 2.10
> +##
> +{ 'alternate': 'CPUFeatureSetting',
> +  'data': { 'bool': 'bool',
> +            'enum': 'CPUFeatureSettingEnum' } }
> +

Looks reasonable; I'm glad the suggestion for using an alternate worked.


> -    if (value) {
> -        cpu->env.features[fp->w] |=3D fp->mask;
> -    } else {
> -        cpu->env.features[fp->w] &=3D ~fp->mask;
> +    switch (value->type) {
> +    case QTYPE_QBOOL:
> +        if (value->u.q_bool) {
> +            cpu->env.features[fp->w] |=3D fp->mask;
> +        } else {
> +            cpu->env.features[fp->w] &=3D ~fp->mask;
> +        }
> +        cpu->env.forced_features[fp->w] &=3D ~fp->mask;
> +        cpu->env.user_features[fp->w] |=3D fp->mask;
> +    break;

Isn't the break supposed to be indented four more spaces?

> +    case QTYPE_QSTRING:
> +        switch (value->u.q_enum) {
> +        case CPU_FEATURE_SETTING_ENUM_FORCE:
> +            cpu->env.features[fp->w] |=3D fp->mask;
> +            cpu->env.forced_features[fp->w] |=3D fp->mask;
> +        break;

and again

> +        default:
> +            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
> +                       "CPUFeatureSetting");
> +        }
> +    break;

and again

> +    default:
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
> +                   "CPUFeatureSetting");
>      }
> -    cpu->env.user_features[fp->w] |=3D fp->mask;
> +
> +    qapi_free_CPUFeatureSetting(value);
>  }
> =20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wHSGbnunKpWE6DCQ2O7HF2QUp8IFi9HPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCP0qAAoJEKeha0olJ0NqpbUH/2Y+H4vUX9NXDJruJwm9//ey
tBrLBashZ6XFKiOrqYcIc75scYO0R/PK1A6urpvpZ2yH2+7FTsJu7wCw1rAKmwdV
PBf701vRnafU6ZrdfyPlfbKxgXwe19RNPqWsTOhxfXAV19stoO7xK+7FZt/UL1uQ
z9Uh7ngja9WoXtVx0bqiE9B6qWobMiZbeWyDjz+TsmT9TolLWurGMhusvbHAvaZI
g+IjoPCvWriOIdJZ2/aPn0kFnffp3NHWZSSesObeZSkxawDSSIL795T9ZmNAuoSO
XG0JkWU9Aecozmu2p6zvBsroe4d4/6EQOqhM5xzvsvfDA+ltoqkZEXq3tggyWXw=
=03Op
-----END PGP SIGNATURE-----

--wHSGbnunKpWE6DCQ2O7HF2QUp8IFi9HPt--
