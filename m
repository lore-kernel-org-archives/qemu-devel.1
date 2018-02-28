Received: from eggs.gnu.org ([2001:4830:134:3::10]:60399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2bH-00011x-6K
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2bG-0007qr-A7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:20:55 -0500
References: <20180228131315.30194-1-mreitz@redhat.com>
	<20180228131315.30194-2-mreitz@redhat.com>
	<20180228133434.GL17774@redhat.com>
	<1fc55643-7ca6-26a5-7e2e-7d6b09a43a13@redhat.com>
	<20180228135305.GM17774@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e48d8dcd-e515-866c-7368-bfe8c64776cc@redhat.com>
Date: Wed, 28 Feb 2018 08:20:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180228135305.GM17774@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: "eblake@redhat.com Kevin Wolf" <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

On 02/28/2018 07:53 AM, Daniel P. Berrang=C3=A9 wrote:

>>>> @@ -1711,8 +1712,8 @@ static int raw_regular_truncate(int fd, int64_=
t offset, PreallocMode prealloc,
>>>>  =20
>>>>           buf =3D g_malloc0(65536);
>>>>  =20
>>>> -        result =3D lseek(fd, current_length, SEEK_SET);
>>>> -        if (result < 0) {
>>>> +        seek_result =3D lseek(fd, current_length, SEEK_SET);
>>>> +        if (seek_result < 0) {
>>>
>>> off_t is an unsigned type, so this comparison to "< 0" is bogus - onl=
y the
>>> exact value (off_t)-1 indicates an error. So this needs to be
>>>
>>>     if (seek_result =3D=3D (off_t)-1) {
>>>        ...
>>>     }

No, off_t is ALWAYS signed, even when it is 32-bit.  The cast helps code=20
that is written for 64-bit off_t to still work when compiled with the=20
small file model where a 32-bit value is used (but we don't have to=20
worry about that, as we always compile for large file mode with 64-bit=20
off_t).

>>
>> Hmmm... On my system, it appears to be a long int[1].  And
>> find_allocation() does an off_t < 0 comparison already.  And
>> "man 0p sys_types.h" says "blkcnt_t and off_t shall be signed integer
>> types."
>=20
> Hmm, that's odd then - lseek man page explicitly said it must be cast,
> which suggested to me it could be unsigned:
>=20
>     RETURN VALUE
>         Upon successful completion, lseek() returns the resulting offse=
t  loca=E2=80=90
>         tion  as  measured  in bytes from the beginning of the file.  O=
n error,
>         the value (off_t) -1 is returned and  errno  is  set  to  indic=
ate  the
>         error.
>=20
> CC'ing Eric for the "official" POSIX answer....

It MAY be that the man page mentions a cast because '-1' is an int but=20
'(off_t) -1' can be larger than an int.  But it may also be that you've=20
uncovered something worth reporting as a bug to the man page project.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
