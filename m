Received: from eggs.gnu.org ([2001:4830:134:3::10]:37594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crAWH-0002s6-JA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crAWE-0006pR-Hf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crAWE-0006om-81
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 130B7569E
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 21:43:42 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
	<a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
Date: Thu, 23 Mar 2017 16:43:39 -0500
MIME-Version: 1.0
In-Reply-To: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lTUh8ax2ANHqa037qQ9bMWlGGvX2dGoOo"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lTUh8ax2ANHqa037qQ9bMWlGGvX2dGoOo
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com
Message-ID: <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-5-git-send-email-armbru@redhat.com>
 <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
 <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
In-Reply-To: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 03:59 PM, Eric Blake wrote:
> On 03/23/2017 01:10 PM, Eric Blake wrote:
>=20
>>>  # @RbdAuthMethod:
>>>  #
>>>  # An enumeration of rados auth_supported types
>>>  #
>>>  # Since: 2.9
>>>  ##
>>> -{ 'struct': 'RbdAuthMethod',
>>> -  'data': { 'auth': 'RbdAuthSupport' } }
>>> +{ 'enum': 'RbdAuthMethod',
>>> +  'data': [ 'cephx', 'none' ] }
>>
>> Changes BlockdevOptionsRbd from:
>>
>> ..., "auth-supported": [ { "auth": "none" } ],
>=20
> Another question - why does auth-supported take an array?  Can you
> really pass both 'none' and 'cephx' at the same time? Or can you only
> pass an array of at most one element, at which point why is it an array=
?

In fact, the more I look at this, the more I wonder if we really want
'auth' to be a flat union and move the 'password-secret' key to be part
of the cephx authorization scheme, since 'password-secret' only makes
sense with 'cephx', and not with 'none'.  Jeff pointed out to me that
libvirt is currently passing both at once; qemuBuildRBDSecinfoURI():

static int
qemuBuildRBDSecinfoURI(virBufferPtr buf,
                       qemuDomainSecretInfoPtr secinfo)
{
    char *base64secret =3D NULL;

    if (!secinfo) {
        virBufferAddLit(buf, ":auth_supported=3Dnone");
        return 0;
    }

    switch ((qemuDomainSecretInfoType) secinfo->type) {
    case VIR_DOMAIN_SECRET_INFO_TYPE_PLAIN:
        if (!(base64secret =3D virStringEncodeBase64(secinfo->s.plain.sec=
ret,

secinfo->s.plain.secretlen)))
            return -1;
        virBufferEscape(buf, '\\', ":", ":id=3D%s",
secinfo->s.plain.username);
        virBufferEscape(buf, '\\', ":",
                        ":key=3D%s:auth_supported=3Dcephx\\;none",
                        base64secret);

But maybe what that _really_ means is that librados is letting us say
"I'd really prefer cephx authorization, and here's my key; but if you
can't honor that, I'm also okay with a fallback to no auth".

That feels wrong to me. If you've gone to the bother of providing an
encryption key, falling back to none should probably be an error.

So my proposal is to have:

{ 'enum': 'RbdAuthSupport', 'data': [ 'cephx', 'none' ] }
{ 'struct': 'RbdAuthNone', 'data': { } }
{ 'struct': 'RbdAuthCephx', 'data': { 'password-secret': 'str' } }
{ 'union', 'RbdAuthMethod', 'base': { 'type': 'RbdAuthSupport' },
  'discriminator': 'type',
  'data': { 'none': 'RbdAuthNone',
            'cephx': 'RbdAuthCephx' } } }
{ 'struct': 'BlockdevOptionsRbd',
  'data': { 'pool': 'str',
            'image': 'str',
            '*conf': 'str',
            '*snapshot': 'str',
            '*user': 'str',
            '*server': ['InetSocketAddress'],
            '*auth': 'RbdAuthMethod' } }

so that you pass at most one auth method, looking like:

=2E.., "image": ..., "auth": { "type": "none" }

or like:

=2E.., "image": ..., "auth": { "type": "cephx", "password-secret": "..." =
}

note that password-secret is NOT at the same level as image, so from the
command line, supporting either old-style insecure 'key=3D' or new-style
'password-secret' at the top-level of the QemuOpts will have to have
glue code that maps it to the right nested location within the QAPI
type.  If we like it, we'd have to get it implemented before 2.9 bakes
in any other design.

We'd still have to allow libvirt's use of
":key=3D...:auth_supported=3Dcephx\\;none" on the command line, but from =
the
QMP side, we would support exactly one auth method, and libvirt will be
updated to match when it starts targetting blockdev-add instead of
legacy command line.

If librados really needs 'cephx;none' any time cephx authorization is
requested, then even though the QMP only requests 'cephx', we can still
map it to 'cephx;none' in qemu - but I'm hoping that setting
auth_supported=3Dcephx rather than auth_supported=3Dcephx;none on the
librados side gives us what we (and libvirt) really want in the first pla=
ce.

Jeff or Josh, if you could chime in, that would be helpful.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lTUh8ax2ANHqa037qQ9bMWlGGvX2dGoOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1EGLAAoJEKeha0olJ0NqQw4H/1ju6yUKZ6vTKBGVHH+2YG6T
mNWDA+KRR8IpdX4oiTw26wbUgSNR0nYilwqOF162gd20WiB/x0Ade61xsWULErOt
hViTAu7kG5I20Df3GP+ThADc6d9+tDMJbtJMbgR+0Aa2qtZygWrNs7FhVerUy/gy
0xCMRlKEIM0yrN3m55F0NY3pxUsAzBIuReE1q31I8rjKcZZRm8Sttwz4ed4leXFV
Uk2bdb+Lc1EiS+rbrbGFMBcJxmVK+68XszUoyGFL/Bow3pGRSN3hJI4NtIlamR9n
6g0TV13GlOa75WM7XCA/AmulhsRk4/dPgzUkFfiOdYK8u9Ad1PFN1FKBUJ3a6qg=
=qPJz
-----END PGP SIGNATURE-----

--lTUh8ax2ANHqa037qQ9bMWlGGvX2dGoOo--
