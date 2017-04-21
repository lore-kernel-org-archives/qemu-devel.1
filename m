Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1Z1C-0002yS-RK
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1Z18-0004DN-Rn
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:54:38 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:40464 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1Z18-0004Cm-J2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:54:34 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <ae879569-b0a0-0c99-f6a6-ec4853dd2fc0@redhat.com>
Date: Fri, 21 Apr 2017 15:54:28 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <270F4A3C-37FD-4B0D-9479-F9B2415A7DC4@kamp.de>
References: <1492765915-32253-1-git-send-email-pl@kamp.de>
	<ae879569-b0a0-0c99-f6a6-ec4853dd2fc0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com



> Am 21.04.2017 um 15:43 schrieb Eric Blake <eblake@redhat.com>:
>=20
>> On 04/21/2017 04:11 AM, Peter Lieven wrote:
>> img_convert has been around before there was an ImgConvertState or
>> a block backend, but it has never been modified to directly use
>> these structs. Change this by parsing parameters directly into
>> the ImgConvertState and directly use BlockBackend where possible.
>> Furthermore variable initialization has been reworked and sorted.
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> V1->V2: - fix s.target_has_backing [Fam]
>>        - remove compress and use s.compressed everywhere [Kevin]
>>        - Fix indent at one place
>>        - Fix typos in commit msg [Eric]
>>        - Further organize the local stack variables
>>=20
>=20
>> -    int c, bs_n, bs_i, compress, cluster_sectors, skip_create;
>> -    int64_t ret =3D 0;
>> -    int progress =3D 0, flags, src_flags;
>> -    bool writethrough, src_writethrough;
>> -    const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_fi=
lename;
>> +    int c, bs_i, flags, src_flags =3D 0;
>> +    const char *fmt =3D NULL, *out_fmt =3D "raw", *cache =3D "unsafe",
>> +               *src_cache =3D BDRV_DEFAULT_CACHE, *out_baseimg =3D NULL,=

>> +               *out_filename, *out_baseimg_param, *snapshot_name =3D NUL=
L;
>=20
> I'm not necessarily a fan of cramming as many variables as possible
> under one type declaration. It creates more churn (aka larger diffs)
> down the road if one of the variables has to change type, compared to
> the case where every variable has its own line.  But nothing in HACKING
> requires either crammed-together or one-per-line declarations, so it's
> not worth changing.
>=20
>>=20
>>=20
>> -    if (bs_n > 1 && out_baseimg) {
>> +    if (s.src_num > 1 && out_baseimg) {
>>         error_report("-B makes no sense when concatenating multiple input=
 "
>>                      "images");
>=20
>=20
> There's other patches on list that will conflict in this region.  But I
> think the plan is that Kevin will take your v2, then have those patches
> rebased on top of yours.
>=20
>> @@ -2224,9 +2204,10 @@ static int img_convert(int argc, char **argv)
>>     if (out_baseimg_param) {
>>         out_baseimg =3D out_baseimg_param;
>>     }
>> +    s.target_has_backing =3D (bool) out_baseimg;
>=20
> That's an unusual spelling. The compiler does the right thing without
> the cast, and if you are still worried, writing !!out_baseimg is less
> typing (and fewer casts) for the same effect.
>=20

The cast is exactly the same as before this patch. I thought there was a rea=
son for it.
Kevin, can you change it when applying?

Thanks,
Peter

> At any rate, it fixes the failures I'm seeing on iotests 019.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
