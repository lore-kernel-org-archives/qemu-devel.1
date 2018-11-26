Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRE8J-0005Fh-8I
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRE89-0005wd-VP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:28:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRE89-0005wB-OU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:28:41 -0500
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181124001734.GF17229@flamenco>
	<122f7c3b-ebaf-a2c0-3181-cce82d857058@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6a87a89-e667-5c8d-9016-1d6c2a65fc6a@redhat.com>
Date: Mon, 26 Nov 2018 11:28:28 +0100
MIME-Version: 1.0
In-Reply-To: <122f7c3b-ebaf-a2c0-3181-cce82d857058@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Cc: mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On 26/11/18 09:18, Xiao Guangrong wrote:
>>
>>> +static uint64_t get_free_request_bitmap(Threads *threads,
>>> ThreadLocal *thread)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint64_t request_fill_bitmap, request_done_bitmap=
, result_bitmap;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 request_fill_bitmap =3D
>>> atomic_rcu_read(&thread->request_fill_bitmap);
>>> +=C2=A0=C2=A0=C2=A0 request_done_bitmap =3D
>>> atomic_rcu_read(&thread->request_done_bitmap);
>>> +=C2=A0=C2=A0=C2=A0 bitmap_xor(&result_bitmap, &request_fill_bitmap,
>>> &request_done_bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 threads->thread_requests_nr);
>>
>> This is not wrong, but it's a big ugly. Instead, I would:
>>
>> - Introduce bitmap_xor_atomic in a previous patch
>> - Use bitmap_xor_atomic here, getting rid of the rcu reads
>=20
> Hmm, however, we do not need atomic xor operation here... that should b=
e
> slower than
> just two READ_ONCE calls.

Yeah, I'd just go with Guangrong's version.  Alternatively, add
find_{first,next}_{same,different}_bit functions (whatever subset of the
4 you need).

Paolo
