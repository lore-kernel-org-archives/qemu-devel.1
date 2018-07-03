Received: from eggs.gnu.org ([2001:4830:134:3::10]:44752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNzw-00039h-Ov
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNzs-0002xL-Et
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:17:48 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-3-eblake@redhat.com>
	<2e8ffc72-6487-79ef-7ce5-e18c712c4bd4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5166d2a0-318c-14a6-a3fa-4f1e89964d34@redhat.com>
Date: Tue, 3 Jul 2018 11:17:40 -0500
MIME-Version: 1.0
In-Reply-To: <2e8ffc72-6487-79ef-7ce5-e18c712c4bd4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: New test 223 for exporting
 dirty bitmap over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 07/03/2018 05:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> 02.07.2018 22:14, Eric Blake wrote:
>> Although this test is NOT a full test of image fleecing (as it
>> intentionally uses just a single block device directly exported
>> over NBD, rather than trying to set up a blockdev-backup job with
>> multiple BDS involved), it DOES prove that qemu as a server is
>> able to properly expose a dirty bitmap over NBD.
>>
>> When coupled with image fleecing, it is then possible for a
>> third-party client to do an incremental backup by using
>> qemu-img map with the x-dirty-bitmap option to learn which parts
>> of the file are dirty (perhaps confusingly, they are the portions
>> mapped as "data":false - which is part of the reason this is
>> still in the x- experimental namespace), along with another
>> normal client (perhaps 'qemu-nbd -c' to expose the server over
>> /dev/nbd0 and then just use normal I/O on that block device) to
>> read the dirty sections.
>>

>> +
>> +echo
>> +echo "=3D=3D=3D End NBD server =3D=3D=3D"
>> +echo
>> +
>> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
>> +=C2=A0 "arguments":{"name":"n"}}' "return"
>> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
>=20
> blockdev-del is not necessary?

I guess it's symmetric in that since we hotplugged the disk, we would=20
also make sure hotunplug works after everything else has quit using it.=20
But even the nbd-server-stop is not strictly necessary, since quitting=20
qemu should have the same effect.  At this point, I'm not too worried=20
about changing the test.

>=20
> with or without:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for the review; the pull request went through without your=20
notation being appended, but it never hurts to have additional review=20
(and we still have time even after 3.0 soft freeze to fix any important=20
bugs in what went in).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
