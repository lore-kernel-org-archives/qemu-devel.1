Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f8o1Q-0004uQ-9W
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f8o1N-0001iY-2o
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:25:20 -0400
References: <1468901281-22858-1-git-send-email-eblake@redhat.com>
	<20160720073836.GF10539@ad.usersys.redhat.com>
	<1796238868.8815050.1469006377577.JavaMail.zimbra@redhat.com>
	<20160720123025.GO2031@devil.localdomain>
	<360732077.8875393.1469022006074.JavaMail.zimbra@redhat.com>
	<20160721124119.GR2031@devil.localdomain>
	<1072047668.9469836.1469111028358.JavaMail.zimbra@redhat.com>
	<20160722085857.GT2031@devil.localdomain>
	<1401857113.9662127.1469184084100.JavaMail.zimbra@redhat.com>
	<d01285ba-7431-2a4f-cd01-77bc9075202f@virtuozzo.com>
	<c823c94e-3fdb-51fb-f9bd-fca35c5b72b8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9abf1411-cd3c-871e-12af-df3944f3afe0@virtuozzo.com>
Date: Wed, 18 Apr 2018 17:25:08 +0300
MIME-Version: 1.0
In-Reply-To: <c823c94e-3fdb-51fb-f9bd-fca35c5b72b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] semantics of FIEMAP without FIEMAP_FLAG_SYNC (was
 Re: [PATCH v5 13/14] nbd: Implement NBD_CMD_WRITE_ZEROES on server)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Dave Chinner <dchinner@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, P@draigBrady.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Niels de Vos <ndevos@redhat.com>, Dmitry Monakhov <dmonakhov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>

15.02.2018 19:42, Paolo Bonzini wrote:
> On 15/02/2018 17:40, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Two years later, is there are any news on the topic?
>>
>> I can't understand the following thing:
>>
>>  =C2=A0- FIEMAP without FLAG_SYNC is unsafe
>>  =C2=A0- FIEMAP with FLAG_SYNC is safe but slow
>>  =C2=A0- so, we've dropped FIEMAP and use only lseek. So, it means that =
lseek
>> is safe _and_ fast (at least, faster than FIEMAP with FLAG_SYNC)...
>>
>> but how is it possible, if lseek and fiemap share same code in the kerne=
l?
> Do they?  Maybe not for all file systems.
>
>> Do your code with
>>
>>  =C2=A0=C2=A0=C2=A0 /* Found an extent, and we're inside it.=C2=A0 */
>>  =C2=A0=C2=A0=C2=A0 *next =3D f.fe.fe_logical + f.fe.fe_length;
>>  =C2=A0=C2=A0=C2=A0 if (f.fe.fe_flags & FIEMAP_EXTENT_UNWRITTEN) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_DATA|BDRV_=
BLOCK_ZERO;
>>  =C2=A0=C2=A0=C2=A0 } else {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_DATA;
>>  =C2=A0=C2=A0=C2=A0 }
>>
>> provide safe block_status based on FIEMAP without FLAG_SYNC?
> No, in fact we found data corruption with FIEMAP.

How to reproduce it? I've tried your code, looks like it shows all=20
"data" regions even if I didn't call "sync".


> Paolo
>
>> ------
>> may help: link to discussion start:
>> http://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04641.html
>>
>> 22.07.2016 13:41, Paolo Bonzini wrote:
>>>>>> i.e. the use of fiemap to duplicate the exact layout of a file
>>>>>> from userspace is only posisble if you can /guarantee/ the source
>>>>>> file has not changed in any way during the copy operation at the
>>>>>> pointin time you finalise the destination data copy.
>>>>> We don't do exactly that, exactly because it's messy when you have
>>>>> concurrent accesses (which shouldn't be done but you never know).
>>>> Which means you *cannot make the assumption it won't happen*.
>>>> FIEMAP is not guaranteed to tell you exactly where the data in the
>>>> file is that you need to copy is and that nothing you can do from
>>>> userspace changes that. I can't say it any clearer than that.
>>> You've said it very clearly.=C2=A0 But I'm not saying "fix the damn
>>> FIEMAP", I'm
>>> saying "this is what we need, lseek doesn't provide it, FIEMAP comes
>>> close but really doesn't".=C2=A0 If the solution is to fix FIEMAP, if i=
t's
>>> possible at all, that'd be great.=C2=A0 But any other solution is okay.
>>>
>>> Do you at least agree that it's possible to use the kind of information
>>> in struct fiemap_extent (extent start, length and flags) in a way that =
is
>>> not racy, or at least not any different from SEEK_DATA and SEEK_HOLE's
>>> raciness?=C2=A0 I'm not saying that you'd get that information from FIE=
MAP.
>>> It's just the kind of information that I'd like to get.
>>>
>>> (BTW, the documentation of FIEMAP is horrible.=C2=A0 It does not say at=
 all
>>> that FIEMAP_FLAG_SYNC is needed to return extents that match what
>>> SEEK_HOLE/SEEK_DATA would return.=C2=A0 The obvious reading is that
>>> FIEMAP_FLAG_SYNC would avoid returning FIEMAP_EXTENT_DELALLOC extents,
>>> and that in turn would not be a problem if you don't need fe_physical.
>>> Perhaps it would help if fiemap.txt said started with *why* would one
>>> use FIEMAP, not just what it does).
>>>
>>>>> When doing a copy, we use(d to use) FIEMAP the same way as you'd use
>>>>> lseek,
>>>>> querying one extent at a time.=C2=A0 If you proceed this way, all of =
these
>>>>> can cause the same races:
>>>>>
>>>>> - pread(ofs=3D10MB, len=3D10MB) returns all zeroes, so the 10MB..20MB=
 is
>>>>> not copied
>>>>>
>>>>> - pread(ofs=3D10MB, len=3D10MB) returns non-zero data, so the 10MB..2=
0MB is
>>>>> copied
>>>>>
>>>>> - lseek(SEEK_DATA, 10MB) returns 20MB, so the 10MB..20MB area is not
>>>>> copied
>>>>>
>>>>> - lseek(SEEK_HOLE, 10MB) returns 20MB, so the 10MB..20MB area is
>>>>> copied
>>>>>
>>>>> - ioctl(FIEMAP at 10MB) returns an extent starting at 20MB, so
>>>>> the 10MB..20MB area is not copied
>>>> No, FIEMAP is not guaranteed to behave like this. what is returned
>>>> is filesystem dependent. Fielsystems that don't support holes will
>>>> return data extents. Filesystems that support compression might
>>>> return a compressed data extent rather than a hole. Encrypted files
>>>> might not expose holes at all, so people can't easily find known
>>>> plain text regions in the encrypted data. Filesystems could report
>>>> holes as deduplicated data, etc.=C2=A0 What do you do when FIEMAP retu=
rns
>>>> "OFFLINE" to indicate that the data is located elsewhere and will
>>>> need to be retrieved by the HSM operating on top of the filesystem
>>>> before layout can be determined?
>>> lseek(SEEK_DATA) might also say you're not on a hole because the file
>>> is compressed/encrypted/deduplicated/offline/whatnot.=C2=A0 So lseek is
>>> also filesystem dependent, isn't it?=C2=A0 It also doesn't work on bloc=
k
>>> devices, so it's really file descriptor dependent.=C2=A0 That's not new=
s.
>>>
>>> Of course read, lseek and FIEMAP will not return exactly the same
>>> information.=C2=A0 The point is that they're subject to exactly the sam=
e
>>> races, and that struct fiemap_extent *can* be parsed conservatively.
>>> The code I attached to the previous message does that, if it finds any
>>> extent kind other than an unwritten extent it just treats it as data.
>>>
>>> Based on this it would be nice to understand the reason why FIEMAP need=
s
>>> FIEMAP_FLAG_SYNC to return meaningful values (the meaningful values
>>> are there, they're just what lseek or read use), or to have a more
>>> powerful function than just lseek(SEEK_DATA/SEEK_HOLE).=C2=A0 All we wa=
nt is
>>> to be able to distinguish between the three fallocate modes.
>>>
>>>> The assumptions being made about FIEMAP behaviour will only lead to
>>>> user data corruption, as they already have several times in the past.
>>> Indeed, FIEMAP as is ranks just above gets() in usability.=C2=A0 But th=
ere's
>>> no reason why it has to be that way.
>>>
>>> Paolo
>>>
>>


--=20
Best regards,
Vladimir
