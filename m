Received: from eggs.gnu.org ([2001:4830:134:3::10]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosdS-0001gZ-Bx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosdR-0004km-3n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:18:14 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
	<20180222151210.GK4147@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
Date: Thu, 22 Feb 2018 16:17:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180222151210.GK4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WQU93nb39LTaBESQGQgFNszElQZbbEXgM"
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WQU93nb39LTaBESQGQgFNszElQZbbEXgM
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
Subject: Re: [PATCH v8 03/26] block: Add BDS.backing_overridden
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-4-mreitz@redhat.com>
 <20180222133956.GG4147@localhost.localdomain>
 <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
 <20180222151210.GK4147@localhost.localdomain>
In-Reply-To: <20180222151210.GK4147@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-22 16:12, Kevin Wolf wrote:
> Am 22.02.2018 um 15:55 hat Max Reitz geschrieben:
>> On 2018-02-22 14:39, Kevin Wolf wrote:
>>> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
>>>> If the backing file is overridden, this most probably does change th=
e
>>>> guest-visible data of a BDS. Therefore, we will need to consider thi=
s in
>>>> bdrv_refresh_filename().
>>>>
>>>> Adding a new field to the BDS is not nice, but it is very simple and=

>>>> exactly keeps track of whether the backing file has been overridden.=

>>>
>>> ...as long as we manage to actually keep it up to date all the time.
>>>
>>> First of all, what I'm missing here (or in fact in the comment in the=

>>> code) is a definition what "overridden" really means. "specified by t=
he
>>> user" is kind of vague: You consider the backing file relationship fo=
r
>>> snapshot=3Don as user specified, even though the user wasn't explicit=

>>> about this. On the other hand, creating a live snapshot results in a
>>> node that isn't user specified.
>>>
>>> Isn't the real question to ask whether the default backing file (take=
n
>>> from the image header) would result in the same tree? The answer to t=
his
>>> changes after more operations, like qmp_change_backing_file().
>>
>> With you so far.
>>
>>> Considering that there are so many ways to change the answer, I think=

>>> the simplest reliable option isn't a new BDS field that needs to upda=
ted
>>> everywhere, but looking at the current value of bs->options and
>>> bs->backing_file and see if they match.
>>
>> I don't see how that is simple.  First, bs->options does not necessari=
ly
>> reflect the "current options", those would be bs->full_open_options.
>> And for generating that, we need a way to determine whether the backin=
g
>> file has been overridden or not, so whether we need to put the backing=

>> options into it or whether we do not.
>=20
> For the purpose of this comparison, we need a set of options that
> contains the backing file options unconditionally.
>=20
>> (I am right that bs->backing_file is what the image header says, right=
?
>> So we need to compare it against something that reflects the runtime s=
tate.)
>=20
> I think so, yes.
>=20
>> What I could see would be comparing bs->backing_file to
>> bs->backing->bs->filename.  But this sounds very hacky to me.
>>
>> One thing the comes to mind is that it can break whenever
>> bdrv_refresh_filename() is clever.  So you specify
>> 'json:{"driver":"null-co"}' in the image header, and
>> bdrv_refresh_filename() optimizes that to "null-co://".  Now the
>> filenames differ even though it's still the original filename.  So thi=
s
>> wouldn't work very well either.
>=20
> On the other hand, the problem with your current approach is that it
> results in a JSON filename even if you override the backing file and
> specify the same file name as we already have in the image header.

Yes.

> In the future, libvirt is going to manually build the graph, so we will=

> always have the backing file overridden according to the logic in this
> patch. I don't think we want to get JSON filenames for all libvirt
> managed VMs, so can we realistically do without any kind of comparison?=


libvirt doesn't need to query the filename, though, does it?

In my mind, we wanted to phase out filenames and basically only present
them as convenience/legacy information to users who use qemu directly.

I really don't see the point of burdening qemu with simplifying and
niceifying filenames when you want to use node names for everything anywa=
y.

Max


--WQU93nb39LTaBESQGQgFNszElQZbbEXgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqO3xwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHkwH/R4ixwNd/es1V0rbtLkQCREF3jUdfTSq
tJBNBbiWeUmGyNxRPvEaDPcYYdQASVc7W92T/sTAG7FaMt+UTf56t524Ri+7FWEt
aPLSLDdjLWpbFaQM7BVP9M/SIO+Mcj9MxF2mZESAenFaqKeGdlxoB/S9mARfL+3p
aCra1hkEZO7+2uZ1H53thYde/Ge7PZfdh2FpyXHsI66l3+aK4/qwwut+Bojlu55N
tyhwX+3hosSJsVCXCBxW+1amJ7/dsnmVm+5O3BCh1TlWwKr7cCohmuTDNFGm58Ys
2py5z8G0xcUjtlVxU9GhJ7jWHTI74bOgyOG360TV35ick5fJUB066kg=
=jlCv
-----END PGP SIGNATURE-----

--WQU93nb39LTaBESQGQgFNszElQZbbEXgM--
