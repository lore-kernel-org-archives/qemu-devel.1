Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxJZ-0001Bv-Fw
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxJY-0008IA-Cy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:40:57 -0500
References: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
	<151376591662.17755.1284403896485862270.malone@chaenomeles.canonical.com>
	<1a65c254-64b7-5a41-1c15-823f5d30779d@redhat.com>
	<20180131193613.3512fbaa@kitsune.suse.cz>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ed6f5b0-1a8c-4ac9-a2b1-8a8d8750521c@redhat.com>
Date: Wed, 31 Jan 2018 13:40:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180131193613.3512fbaa@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1739304] Re: Passing a directory to (eg.)
 -cdrom results in misleading error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Bug 1739304 <1739304@bugs.launchpad.net>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Qemu-block <qemu-block@nongnu.org>



On 01/31/2018 01:36 PM, Michal Such=C3=A1nek wrote:
> On Wed, 20 Dec 2017 21:57:00 -0500
> John Snow <jsnow@redhat.com> wrote:
>=20
>> On 12/20/2017 05:31 AM, Dr. David Alan Gilbert wrote:
>>> Yep, can repeat it here, it seems pretty random which error it
>>> gives:
>>>
>>> [dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64
>>> -cdrom /tmp qemu-system-x86_64: -cdrom /tmp: Could not refresh
>>> total sector count: Invalid argument [dgilbert@dgilbert-t530
>>> try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /var
>>> qemu-system-x86_64: -cdrom /var: Could not read image for
>>> determining its format: File too large
>>>
>>>
>>> ** Changed in: qemu
>>>        Status: New =3D> Confirmed
>>>  =20
>>
>> Looks like directories play funny games.
>>
>=20
> ...
>=20
>> specifically:
>>
>> (gdb) s
>> 1963	    size =3D lseek(s->fd, 0, SEEK_END);
>> (gdb) s
>> 1964	    if (size < 0) {
>> (gdb) print size
>> $37 =3D 9223372036854775807
>>
>> cool, cool, cool. This value is 0x7fffffffffffffff and errno isn't
>> set. cool and good function.
>=20
> Indeed: The behavior of lseek() on devices which are incapable of
> seeking is implementation-defined.
>=20
>>
>> so, lseek on a folder returns crazy nonsense. Perhaps we ought to
>> actually specifically disallow folders, we don't appear to.
>=20
> It probably returns -1 which it is supposed to do on error. It should
> also set errno in that case, though.
>=20
> So this is probably bug in the error handling code in lseek.
>=20
> Thanks
>=20
> Michal
>=20

Thanks. It looks like we can't make stronger guarantees about the
behavior of lseek, so I submitted a patch to ratchet down QEMU's
acceptable file types:

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05055.html

Thanks,
--John
