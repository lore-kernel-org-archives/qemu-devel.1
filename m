Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evj04-0002Sh-Fa
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evj03-0001mX-2Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:25:52 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-8-kwolf@redhat.com>
	<11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
	<20180313113234.GB4642@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7241827-6ba4-3081-34de-6d97a21f23ed@redhat.com>
Date: Tue, 13 Mar 2018 13:25:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180313113234.GB4642@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X60GWsaiAv2QPX4ag0StVt3WSzIwe1YCi"
Subject: Re: [Qemu-devel] [PATCH 7/7] vpc: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X60GWsaiAv2QPX4ag0StVt3WSzIwe1YCi
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, den@openvz.org, jcody@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <f7241827-6ba4-3081-34de-6d97a21f23ed@redhat.com>
Subject: Re: [PATCH 7/7] vpc: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-8-kwolf@redhat.com>
 <11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
 <20180313113234.GB4642@localhost.localdomain>
In-Reply-To: <20180313113234.GB4642@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 12:32, Kevin Wolf wrote:
> Am 12.03.2018 um 22:49 hat Max Reitz geschrieben:
>> On 2018-03-09 22:46, Kevin Wolf wrote:
>>> This adds the .bdrv_co_create driver callback to vpc, which
>>> enables image creation over QMP.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/block-core.json |  33 ++++++++++-
>>>  block/vpc.c          | 152 ++++++++++++++++++++++++++++++++++++++---=
----------
>>>  2 files changed, 147 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 3a65909c47..ca645a0067 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3734,6 +3734,37 @@
>>>              '*block-state-zero':    'bool' } }
>>> =20
>>>  ##
>>> +# @BlockdevVpcSubformat:
>>> +#
>>> +# @dynamic: Growing image file
>>> +# @fixed:   Preallocated fixed-size imge file
>>
>> s/imge/image/
>>
>>> +#
>>> +# Since: 2.12
>>> +##
>>> +{ 'enum': 'BlockdevVpcSubformat',
>>> +  'data': [ 'dynamic', 'fixed' ] }
>>> +
>>> +##
>>> +# @BlockdevCreateOptionsVpc:
>>> +#
>>> +# Driver specific image creation options for vpc (VHD).
>>> +#
>>> +# @file             Node to create the image format on
>>> +# @size             Size of the virtual disk in bytes
>>> +# @subformat        vhdx subformat (default: dynamic)
>>> +# @force-size       Force use of the exact byte size instead of roun=
ding to the
>>> +#                   next size that can be represented in CHS geometr=
y
>>> +#                   (default: false)
>>
>> Now that's weird, again considering your previous approach of only
>> rounding things in the legacy path and instead throwing errors from
>> blockdev-create.  If you think this is OK to have here, than that's OK=

>> with me, but I'm not sure this is the ideal way.
>=20
> Hmm... That's a tough one.
>=20
> There are a two major differences between VHD and the other image
> formats: The first is that rounding is part of the VHD spec. The other
> is that while other drivers have reasonable alignment restrictions that=

> never cause a problem anyway (because people say just '8G' instead of
> some odd number), CHS alignment is not reasonable (because '8G' and
> similar things will most probably fail).

Well, if it's part of the spec, then I'll be OK with keeping the flag as
it is.

> And then there's the well-known problem that MS is inconsistent with
> itself, so force-size=3Doff is required to make images that work with
> Virtual PC, but force-size=3Don may be needed for unaligned image sizes=

> that HyperV allows, iirc.
>=20
>> Alternatives:
>>
>> 1. Swap the default, not sure this is such a good idea either.
>>
>> 2. Maybe add an enum instead.  Default: If the given size doesn't fit
>> CHS, generate an error.  Second choice: Use the given size, even if it=

>> doesn't fit.  Third choice: Round to CHS.
>=20
> Maybe we should keep force-size, but make it an error if the size isn't=

> already aligned (consistent with other block drivers).
>=20
> The legacy code path could still round, but print a deprecation warning=
=2E
> Once we get rid of the legacy path, users will have to specify sizes
> with correct alignment. The error message could suggest using the
> rounded value for Virtual PC compatibility or force-share=3Don otherwis=
e.
>=20
> That wouldn't be very nice to use, but maybe it's the best we can make
> out of a messed up format like VHD.

Sounds reasonable to me, although this would probably just result in
management tools copying qemu's code (or maybe it's code directly from
the spec?) to do the rounding so that qemu shuts up.

>> I don't want to be stuck up, but once it's a public interface...
>=20
> The good thing is that it's still x-blockdev-create.

Ah, right.

Max


--X60GWsaiAv2QPX4ag0StVt3WSzIwe1YCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqnwzsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7UUH/0SX7rkZkNB0MWLwPkRfESK8rWLx3c8U
ST1SbH3utlCjjRxZHCbRUXXNBXZg+KZznyK2ed0GEyEYTZucT4jOK4l8ZqO6dBcy
0Sd68sjvM/xzJoHIg49AKQHMBcpHmDUmoU+CwcTFxJqDzyyscEZqyJGHBc9TdbQm
0NVvGPyYw9iRSeygE46vP8sOOlW8mbRpGBWWxy4KANFG4N/8HwoKtFk3tzNCSX3/
AClaCam+Fj2IeFfhroHniLGW63iLz9m4s5osk95MRrV3+EYeHNYTyo8VjHvlexcN
z8+M9QKIWBW0Qa8bb61Ya5+0O8B/QqgoA/xI90FZtxtdNJmnRD9X6jQ=
=nNvy
-----END PGP SIGNATURE-----

--X60GWsaiAv2QPX4ag0StVt3WSzIwe1YCi--
