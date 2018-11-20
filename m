Received: from eggs.gnu.org ([2001:4830:134:3::10]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPAkl-0008Lb-KT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPAkc-000283-Te
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPAkc-00023B-AH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:54 -0500
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
	<2c351ac2-ad51-13de-6aea-ffc014edeffe@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab141f24-4c6b-40f9-b603-1a080e5fe8e6@redhat.com>
Date: Tue, 20 Nov 2018 19:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <2c351ac2-ad51-13de-6aea-ffc014edeffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] migration: improve multithreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

On 12/11/18 04:07, Xiao Guangrong wrote:
>=20
> Hi,
>=20
> Ping...

Hi Guangrong, I think this isn't being reviewed because we're in freeze.

Paolo

> On 11/6/18 8:20 PM, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Changelog in v2:
>> These changes are based on Paolo's suggestion:
>> 1) rename the lockless multithreads model to threaded workqueue
>> 2) hugely improve the internal design, that make all the request be
>> =C2=A0=C2=A0=C2=A0 a large array, properly partition it, assign reques=
ts to threads
>> =C2=A0=C2=A0=C2=A0 respectively and use bitmaps to sync up threads and=
 the submitter,
>> =C2=A0=C2=A0=C2=A0 after that ptr_ring and spinlock are dropped
>> 3) introduce event wait for the submitter
>>
>> These changes are based on Emilio's review:
>> 4) make more detailed description for threaded workqueue
>> 5) add a benchmark for threaded workqueue
>>
>> The previous version can be found at
>> =C2=A0=C2=A0=C2=A0=C2=A0https://marc.info/?l=3Dkvm&m=3D153968821910007=
&w=3D2
>>
>> There's the simple performance measurement comparing these two version=
s,
>> the environment is the same as we listed in the previous version.
>>
>> Use 8 threads to compress the data in the source QEMU
>> - with compress-wait-thread =3D off
>>
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total time=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 busy-ratio
>> --------------------------------------------------
>> v1=C2=A0=C2=A0=C2=A0 125066=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.38
>> v2=C2=A0=C2=A0=C2=A0 120444=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.35
>>
>> - with compress-wait-thread =3D on
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total time=C2=A0=
=C2=A0=C2=A0 busy-ratio
>> --------------------------------------------------
>> v1=C2=A0=C2=A0=C2=A0 164426=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0
>> v2=C2=A0=C2=A0=C2=A0 142609=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0
>>
>> The v2 win slightly.
>>
>> Xiao Guangrong (5):
>> =C2=A0=C2=A0 bitops: introduce change_bit_atomic
>> =C2=A0=C2=A0 util: introduce threaded workqueue
>> =C2=A0=C2=A0 migration: use threaded workqueue for compression
>> =C2=A0=C2=A0 migration: use threaded workqueue for decompression
>> =C2=A0=C2=A0 tests: add threaded-workqueue-bench
>>
>> =C2=A0 include/qemu/bitops.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
>> =C2=A0 include/qemu/threaded-workqueue.h |=C2=A0 94 +++++++
>> =C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 538
>> ++++++++++++++------------------------
>> =C2=A0 tests/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>> =C2=A0 tests/threaded-workqueue-bench.c=C2=A0 | 256 ++++++++++++++++++
>> =C2=A0 util/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 util/threaded-workqueue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 466
>> +++++++++++++++++++++++++++++++++
>> =C2=A0 7 files changed, 1030 insertions(+), 343 deletions(-)
>> =C2=A0 create mode 100644 include/qemu/threaded-workqueue.h
>> =C2=A0 create mode 100644 tests/threaded-workqueue-bench.c
>> =C2=A0 create mode 100644 util/threaded-workqueue.c
>>
