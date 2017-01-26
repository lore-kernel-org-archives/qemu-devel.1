Received: from eggs.gnu.org ([2001:4830:134:3::10]:48181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWl2i-0005dX-A8
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWl2f-0000eq-85
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWl2f-0000ec-24
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:28:49 -0500
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
	<000e01d277d9$5d80dae0$188290a0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
Date: Thu, 26 Jan 2017 15:28:44 +0100
MIME-Version: 1.0
In-Reply-To: <000e01d277d9$5d80dae0$188290a0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com



On 26/01/2017 14:37, Pavel Dovgalyuk wrote:
>> Simpler:
>>
>> 	use_icount &&
>> 	((int32_t)cpu->icount_decr.u32 < 0 ||
>> 	 cpu->icount_decr.u16.low + cpu->icount_extra =3D=3D 0)
> Right.
>=20
>> But I'm not sure that you need to test u32.  After all you're not
> Checking u32 is needed, because sometimes it is less than zero.

If cpu->icount_decr.u32 is less than zero, the next translation block
would immediately exit with TB_EXIT_ICOUNT_EXPIRED, causing

            cpu->exception_index =3D EXCP_INTERRUPT;
            *last_tb =3D NULL;
            cpu_loop_exit(cpu);

from cpu_loop_exec_tb's "case TB_EXIT_ICOUNT_EXPIRED".

And the same is true for cpu->icount_decr.u16.low + cpu->icount_extra =3D=
=3D
0, so I don't understand why this part of the patch is necessary.

Paolo
