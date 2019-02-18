Received: from eggs.gnu.org ([209.51.188.92]:54614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvjCk-0003fj-Qt
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 08:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvjCi-0000kv-TS
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 08:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gvjCi-0000gT-7V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 08:43:28 -0500
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
Date: Mon, 18 Feb 2019 14:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org

On 18/02/2019 07.07, Stephen Checkoway wrote:
> Hi all,
>=20
> I've been working on some improvements to the pflash_cfi02 block device=
 (interleaved flash devices similar to pflash_cfi01, multi-sector erase, =
nonuniform sector sizes, and some bug fixes and I'm planning on implement=
ing sector erase suspend/resume commands in the near future).
>=20
> There appear to be no existing tests for this device and I'm unsure wha=
t the appropriate way to add tests for sysbus devices is. -device can't b=
e used because sysbus devices aren't user-creatable (and even if they wer=
e, creating the device wouldn't be sufficient since it wouldn't connect i=
t to the sysbus).
>=20
> Any suggestions would be appreciated.

I think you could use one of the machines that has a cfi02 on board. For
example: Write some random data to a temporary file. Run qemu with:

 QTestState *qts;
 qts =3D qtest_initf(" qemu-system-arm -M musicpal,accel=3Dqtest "
                "-drive if=3Dpflash,file=3D%s,format=3Draw", filename);

Then you should be able to access the device with the qtest_read/write
functions, e.g. use "qtest_memread(qts, 0x100000000ULL, ...)" to read
the contents of the device. I haven't tried that though, that's just my
quick assumption from looking at hw/arm/musicpal.c ...

 Thomas
