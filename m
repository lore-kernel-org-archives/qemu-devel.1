Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFFNF-000354-Kq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFFNE-0005zZ-Ia
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:18:13 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
Date: Thu, 16 Nov 2017 11:17:55 +0300
MIME-Version: 1.0
In-Reply-To: <01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com

16.11.2017 00:20, John Snow wrote:
>
> On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> There are three qmp commands, needed to implement external backup API.
>>
>> Using these three commands, client may do all needed bitmap management b=
y
>> hand:
>>
>> on backup start we need to do a transaction:
>>   {disable old bitmap, create new bitmap}
>>
>> on backup success:
>>   drop old bitmap
>>
>> on backup fail:
>>   enable old bitmap
>>   merge new bitmap to old bitmap
>>   drop new bitmap
>>
> Can you give me an example of how you expect these commands to be used,
> and why they're required?
>
> I'm a little weary about how error-prone these commands might be and the
> potential for incorrect usage seems... high. Why do we require them?

It is needed for incremental backup. It looks like bad idea to export=20
abdicate/reclaim functionality, it is simpler
and clearer to allow user to merge/enable/disable bitmaps by hand.

usage is like this:

1. we have dirty bitmap bitmap0 for incremental backup.

2. prepare image fleecing (create temporary image with backing=3Dour_disk)
3. in qmp transaction:
 =C2=A0=C2=A0=C2=A0 - disable bitmap0
 =C2=A0=C2=A0=C2=A0 - create bitmap1
 =C2=A0=C2=A0=C2=A0 - start image fleecing (backup sync=3Dnone our_disk -> =
temp_disk)
4. export temp_disk (it looks like a snapshot) and bitmap0 through NBD

=3D=3D=3D external tool can get bitmap0 and then copy some clusters through=
=20
NBD =3D=3D=3D

on successful backup external tool can drop bitmap0. or can save it and=20
reuse somehow

on failed backup external tool can do the following:
 =C2=A0 =C2=A0 - enable bitmap0
 =C2=A0 =C2=A0 - merge bitmap1 to bitmap0
 =C2=A0 =C2=A0 - drop bitmap1

--=20
Best regards,
Vladimir
