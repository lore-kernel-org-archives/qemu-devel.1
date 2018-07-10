Received: from eggs.gnu.org ([2001:4830:134:3::10]:49309)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fcz4g-0006Yr-9v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fcz4b-0002n0-AW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:17:23 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34171 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fcz4b-0002mP-0M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:17:21 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <20180710153155.GM5852@localhost.localdomain>
Date: Tue, 10 Jul 2018 22:16:47 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <73DCB217-9027-4248-8C81-A83AD4512927@kamp.de>
References: <1531235146-6048-1-git-send-email-pl@kamp.de>
	<20180710153155.GM5852@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH V5] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



> Am 10.07.2018 um 17:31 schrieb Kevin Wolf <kwolf@redhat.com>:
>=20
> Am 10.07.2018 um 17:05 hat Peter Lieven geschrieben:
>> We currently don't enforce that the sparse segments we detect during conv=
ert are
>> aligned. This leads to unnecessary and costly read-modify-write cycles ei=
ther
>> internally in Qemu or in the background on the storage device as nearly a=
ll
>> modern filesystems or hardware have a 4k alignment internally.
>>=20
>> This patch modifies is_allocated_sectors so that its *pnum result will al=
ways
>> end at an alignment boundary. This way all requests will end at an alignm=
ent
>> boundary. The start of all requests will also be aligned as long as the r=
esults
>> of get_block_status do not lead to an unaligned offset.
>>=20
>> The number of RMW cycles when converting an example image [1] to a raw de=
vice that
>> has 4k sector size is about 4600 4k read requests to perform a total of a=
bout 15000
>> write requests. With this path the additional 4600 read requests are elim=
inated while
>> the number of total write requests stays constant.
>>=20
>> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-s=
erver-cloudimg-amd64-disk1.vmdk
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>=20
> It looked convincing, but I'm afraid this is still not correct.
> qemu-iotests 122 fails for me with this patch.

I will have a look, where and why exactly it fails, but the allocation patte=
rn might be slightly different due to the alignment. What counts is that the=
 output is byte identical or not?

Peter
