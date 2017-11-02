Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAKb9-000748-8P
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAKb6-0004E9-2g
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAKb5-0004Cy-Q0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:52:12 -0400
References: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1508867404-18046-2-git-send-email-jan.dakinevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4b408b8-cd4c-a844-a877-a44a586ef717@redhat.com>
Date: Thu, 2 Nov 2017 13:52:02 -0500
MIME-Version: 1.0
In-Reply-To: <1508867404-18046-2-git-send-email-jan.dakinevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qBRqjRSHJXSnPcCLlFbta8drfciIf1pFo"
Subject: Re: [Qemu-devel] [RFC v5 1/2] virtio: introduce `query-virtio' QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qBRqjRSHJXSnPcCLlFbta8drfciIf1pFo
From: Eric Blake <eblake@redhat.com>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@virtuozzo.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4b408b8-cd4c-a844-a877-a44a586ef717@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 1/2] virtio: introduce `query-virtio' QMP
 command
References: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <1508867404-18046-2-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1508867404-18046-2-git-send-email-jan.dakinevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/24/2017 12:50 PM, Jan Dakinevich wrote:
> The command is intended for gathering virtio information such as status=
,
> feature bits, negotiation status. It is convenient and useful for debug=

> purpose.
>=20
> The commands returns generic virtio information for virtio such as
> common feature names and status bits names and information for all
> attached to current machine devices.
>=20
> Cc: Denis V. Lunev <den@virtuozzo.com>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---

> +++ b/qapi-schema.json
> @@ -3200,3 +3200,469 @@
>  # Since: 2.11
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogActio=
n'} }
> +
> +##
> +# @VirtioStatus:
> +#
> +# Virtio device status bits
> +#
> +# Since: 2.11

We've entered soft freeze, and this is a new feature, so it may be
better to propose this for 2.12 rather than trying to rush it in now.

> +#
> +##
> +{
> +    'enum': 'VirtioStatus',
> +    'data': [
> +        'acknowledge',
> +        'driver',
> +        'driver-ok',
> +        'features-ok',
> +        'status-reserved-4',
> +        'status-reserved-5',

Are we ever going to report a '*-reserved-NNN' enum value to the end
user?  I hope not, in which case, we don't need to expose it in the QAPI
enums.  Yes, that means you have to do some mapping between named bits
and enum strings (you would no longer have the property that
'status-reserved-4' is value 4, but would instead have to map that bit 6
translates to 'needs-reset' with enum value 4), but a clean
public-facing interface may be worth the hassle.  What's more, as newer
qemu learns new bit names down the road, then expanding the enums to
cover those new names is introspectible; whereas you can't rename an
existing enum value while still retaining back-compat.


> +##
> +# @VirtioFeatureName:
> +#
> +# Since: 2.11
> +#
> +##
> +{
> +    'union': 'VirtioFeatureName',
> +    'data': {
> +        'common': 'VirtioFeatureCommon',
> +        'net': 'VirtioFeatureNet',
> +        'blk': 'VirtioFeatureBlk',

Do we really need to abbreviate this one?

> +        'serial': 'VirtioFeatureSerial',
> +        'balloon': 'VirtioFeatureBalloon',
> +        'scsi': 'VirtioFeatureScsi',
> +        'virtfs': 'VirtioFeatureVirtfs',
> +        'gpu': 'VirtioFeatureGpu',
> +        'other': 'VirtioFeatureOther'
> +    }
> +}

This is a so-called "simple union" - but we do not want any more of
these in our code.  In fact, Markus and I are toying with the idea of
renaming it to "legacy union", and/or making the syntax more painful,
because we WANT to use "flat unions" in all new code (and make their
syntax easier to type).

So, a comparable flat union would be something like:

{ 'enum': 'VirtioFeatureCategory',
  'data': [ 'common', 'net', 'block', 'serial', 'balloon', 'scsi',
'virtfs', 'gpu', 'other' ] }
{ 'union': 'VirtioFeatureName',
  'base': { 'category': 'VirtioFeatureCategory' },
  'discriminator': 'category',
  'data': { 'common': 'VirtioFeatureCommon', ... } }

except that flat unions don't permit enum types (they require a struct
type).  Hmm.

> +
> +##
> +# @VirtioFeature:
> +#
> +# Feature bit with negotiation status
> +#
> +# @host: true if host exposes the feature
> +#
> +# @guest: true if guest acknowledges the feature
> +#
> +# Since: 2.11
> +#
> +##
> +{
> +    'struct': 'VirtioFeature',
> +    'data': {
> +        'host': 'bool',
> +        'guest': 'bool',
> +        'name': 'VirtioFeatureName'
> +    }
> +}

With your proposal, an example on the wire might be:

"feature": { "host": true, "guest": false, "name": { "type": "common",
"data": "notify-on-empty" } }

> +
> +##
> +# @VirtioInfo:
> +#
> +# Information about virtio device
> +#
> +# @qom-path: QOM path of the device
> +#
> +# @status: status bitmask
> +#
> +# @status-names: names of checked bits in status bitmask
> +#
> +# @host-features: bitmask of features, exposed by device
> +#
> +# @guest-features: bitmask of features, acknowledged by guest
> +#
> +# @features: negotiation status and names of device features
> +#
> +##
> +{
> +    'struct': 'VirtioInfo',
> +    'data': {
> +        'qom-path': 'str',
> +        'status': 'uint8',
> +        'status-names': ['VirtioStatus'],

Umm, isn't it better to just have 'status': 'VirtioStatus' (as we can
only ever have a single status value, so we don't really need an array
to tell us what all the other status values are named).

> +        'host-features': 'uint64',
> +        'guest-features': 'uint64',
> +        'features': ['VirtioFeature']

Do we really want to expose both a 64-bit number and an array of feature
names, where the array repeats the information on whether host and guest
support the bit?

I guess we first want to figure out WHAT we want to send over the wire.
Maybe:

"info": { "qom-path": "...", "status": "driver-ok",
          "host": [ { "common": "notify-on-empty" },
                    { "common": "any-layout" },
                    { "net": "csum" } ],
          "guest": [ { "common": "notify-on-empty" },
                     { "net": "csum" } ] }

or

"info": { "qom-path": "...", "status": "driver-ok",
          "host": [ { "type": "common", "value": "notify-on-empty" },
                    { "type": "common", "value": "any-layout" },
                    { "type": "net", "value": "csum" } ],
          "guest": [ { "type": "common", "value": "notify-on-empty" },
                     { "type": "net", "value": "csum" } ] }

or

"info": { "qom-path": "...", "status": "driver-ok",
          "host": { "common": [ "notify-on-empty", "any-layout" ],
                    "net": [ "csum" ] },
          "guest": { "common": [ "notify-on-empty" ] },
                     "net": [ "csum" ] } }

(some of those forms may be easier than others to express in our current
QAPI language; if we need to modify the qapi language to get our ideal
form supported, then that may be worth the effort).

> +
> +##
> +# @query-virtio:
> +#
> +# Returns virtio information such as device status and features
> +#
> +# Since: 2.11
> +#
> +##
> +{
> +    'command': 'query-virtio',
> +    'data': { '*path': 'str' },

Do we need filterable queries, or is it better to just have the command
return info on all virtio devices at once and let the client filter the
results as desired?

> +    'returns': ['VirtioInfo']
> +}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qBRqjRSHJXSnPcCLlFbta8drfciIf1pFo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7aVIACgkQp6FrSiUn
Q2rLTAf6A3fY1VsLcKE4D6L6kzk6Jdz41N7wphZx79lIB7cBOe9+YFtURXlgzBSq
PMTNEeNdszvJMgl5ADTIQKvdT1IaWg0d+PR8lVXctT8C4a8isOUvv99QadIuVlSs
FOvulgvCzirIBd1H9A+dh8oyipyI1tnfmz20sTZ3xiKanFuGTlKdOsdmW+iZKpwb
IWiDIZExYKFwityjs5AKJQsbNuWp1TWtjLgbBO/JXwy0ur0N4e79WQ3+sYEVewL5
i5cfAtQ1MoNB9lmX9MHNSs/6Qi8EPsHVKESWiVaBtWyARlb3Zq60HVJ2qLV2O7Bx
Q8TFlc0it2UIzg1hCju4vQCwZvax+Q==
=K70e
-----END PGP SIGNATURE-----

--qBRqjRSHJXSnPcCLlFbta8drfciIf1pFo--
