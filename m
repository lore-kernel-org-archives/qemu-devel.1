Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWr6F-0000Pw-PV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 18:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWr6E-00039m-SE
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 18:05:59 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-3-jsnow@redhat.com>
	<59d3744f-8c61-724b-784d-43e5f2b0ae8e@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a30ba3e1-7a8f-c25d-28d7-54239869a0f4@redhat.com>
Date: Tue, 11 Dec 2018 18:05:49 -0500
MIME-Version: 1.0
In-Reply-To: <59d3744f-8c61-724b-784d-43e5f2b0ae8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>



On 12/7/18 11:25 AM, Eric Blake wrote:
> On 12/6/18 1:25 PM, John Snow wrote:
>> Especially outside of transactions, it is helpful to provide
>> all-or-nothing semantics for bitmap merges. This facilitates
>> the coalescing of multiple bitmaps into a single target for
>> the "checkpoint" interpretation when assembling bitmaps that
>> represent arbitrary points in time from component bitmaps.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 64 +++++++++++++++++++++++++++++---------------
>> =C2=A0 qapi/block-core.json | 22 +++++++--------
>> =C2=A0 2 files changed, 53 insertions(+), 33 deletions(-)
>>
>=20
>> +++ b/qapi/block-core.json
>> @@ -1818,14 +1818,14 @@
>> =C2=A0 #
>> =C2=A0 # @node: name of device/node which the bitmap is tracking
>> =C2=A0 #
>> -# @dst_name: name of the destination dirty bitmap
>> +# @target: name of the destination dirty bitmap
>> =C2=A0 #
>> -# @src_name: name of the source dirty bitmap
>> +# @bitmaps: name(s) of the source dirty bitmap(s)
>> =C2=A0 #
>> =C2=A0 # Since: 3.0
>> =C2=A0 ##
>> =C2=A0 { 'struct': 'BlockDirtyBitmapMerge',
>> -=C2=A0 'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' =
} }
>> +=C2=A0 'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] }=
 }
>=20
> Definitely worthwhile!
>=20
> I'll update my pending libvirt patches to use this.
>=20
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @block-dirty-bitmap-add:
>> @@ -1940,23 +1940,23 @@
>> =C2=A0 ##
>> =C2=A0 # @x-block-dirty-bitmap-merge:
>> =C2=A0 #
>> -# FIXME: Rename @src_name and @dst_name to src-name and dst-name.
>> -#
>> -# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name
>> dirty
>> -# bitmap is unchanged. On error, @dst_name is unchanged.
>> +# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
>> +# The @bitmaps dirty bitmaps are unchanged.
>=20
> Well, except in the corner case of when @bitmaps also lists the
> destination (I presume that merging a bitmap into itself silently
> succeeds with no further changes, but therefore the inclusion of the
> destination in the list of sources means that that particular source is
> changing due to merging in the other sources).=C2=A0 Not worth rewordin=
g this
> =C2=A0sentence, but does make you want to consider ensuring that the
> testsuite covers merging a bitmap into itself.
>=20

OK, noted.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
Thanks!
