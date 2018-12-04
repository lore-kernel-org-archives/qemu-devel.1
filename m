Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dinechin@redhat.com>) id 1gUCxA-0004gy-GE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dinechin@redhat.com>) id 1gUCx6-0007DR-Cm
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:49:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1gUCx6-0007CV-5K
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:49:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so9799407wmd.2
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 07:49:35 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <3a17b878-9a1c-7cdc-0250-187e82e2faf3@redhat.com>
Date: Tue, 4 Dec 2018 16:49:29 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A78700E-A32B-42DC-90FA-F1501D434608@redhat.com>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
	<3a17b878-9a1c-7cdc-0250-187e82e2faf3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, KVM list <kvm@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Wei Wang <wei.w.wang@intel.com>, jiang.biao2@zte.com.cn, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Xiao Guangrong <xiaoguangrong@tencent.com>



> On 27 Nov 2018, at 14:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 27/11/18 13:49, Christophe de Dinechin wrote:
>> So this is not really
>> helping. Also, the ThreadLocal structure itself is not necessarily =
aligned
>> within struct Threads. Therefore, it=E2=80=99s possible that =
=E2=80=9Crequests=E2=80=9D for example
>> could be on the same cache line as request_fill_bitmap if planets =
align
>> the wrong way.
>=20
> I think this is a bit exaggerated.

Hence my =E2=80=9Cif planets align the wrong way=E2=80=9D :-)

But I understand that my wording came out too strong. My apologies.

I think the fix is to align ThreadLocal as well.


>  Linux and QEMU's own qht work just fine with compile-time directives.

Wouldn=E2=80=99t it work fine without any compile-time directive at all?
Alignment is just a performance optimization.

>=20
>> In order to mitigate these effects, I would group the data that the =
user
>> writes and the data that the thread writes, i.e. reorder =
declarations,
>> put request_fill_bitmap and request_valid_ev together, and try
>> to put them in the same cache line so that only one cache line is =
invalidated
>> from within mark_request_valid instead of two.
>>=20
>> Then you end up with a single alignment directive instead of 4, to
>> separate requests from completions.
>=20
> Yeah, I agree with this.
>=20
>> That being said, I=E2=80=99m not sure why you use a bitmap here. What =
is the
>> expected benefit relative to atomic lists (which would also make it =
really
>> lock-free)?
>>=20
>=20
> I don't think lock-free lists are easier.  Bitmaps smaller than 64
> elements are both faster and easier to manage.

I believe that this is only true if you use a linked list for both =
freelist
management and for thread notification (i.e. to replace the bitmaps).
However, if you use an atomic list only for the free list, and keep
bitmaps for signaling, then performance is at least equal, often better.
Plus you get the added benefit of having a thread-safe API, i.e.
something that is truly lock-free.

I did a small experiment to test / prove this. Last commit on branch:
=
https://github.com/c3d/recorder/commits/181122-xiao_guangdong_introduce-th=
readed-workqueue
Take with a grain of salt, microbenchmarks are always suspect ;-)

The code in =E2=80=9Cthread_test.c=E2=80=9D includes Xiao=E2=80=99s code =
with two variations,
plus some testing code lifted from the flight recorder library.
1. The FREE_LIST variation (sl_test) is what I would like to propose.
2. The BITMAP variation (bm_test) is the baseline
3. The DOUBLE_LIST variation (ll_test) is the slow double-list approach

To run it, you need to do =E2=80=9Cmake opt-test=E2=80=9D, then run =
=E2=80=9Ctest_script=E2=80=9D
which outputs a CSV file. The summary of my findings testing on
a ThinkPad, a Xeon machine and a MacBook is here:
https://imgur.com/a/4HmbB9K

Overall, the proposed approach:

- makes the API thread safe and lock free, addressing the one
drawback that Xiao was mentioning.

- delivers up to 30% more requests on the Macbook, while being
=E2=80=9Cwithin noise=E2=80=9D (sometimes marginally better) for the =
other two.
I suspect an optimization opportunity found by clang, because
the Macbook delivers really high numbers.

- spends less time blocking when all threads are busy, which
accounts for the higher number of client loops.

If you think that makes sense, then either Xiao can adapt the code
from the branch above, or I can send a follow-up patch.


Thanks
Christophe
