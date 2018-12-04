Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUEJf-0001DM-U4
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUEJb-0000NH-JR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:16:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUEJa-0000KF-9W
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:16:55 -0500
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
	<3a17b878-9a1c-7cdc-0250-187e82e2faf3@redhat.com>
	<3A78700E-A32B-42DC-90FA-F1501D434608@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a228d699-f7fc-3e32-b750-19225f95d8db@redhat.com>
Date: Tue, 4 Dec 2018 18:16:36 +0100
MIME-Version: 1.0
In-Reply-To: <3A78700E-A32B-42DC-90FA-F1501D434608@redhat.com>
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
To: Christophe de Dinechin <dinechin@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, KVM list <kvm@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Wei Wang <wei.w.wang@intel.com>, jiang.biao2@zte.com.cn, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Xiao Guangrong <xiaoguangrong@tencent.com>

On 04/12/18 16:49, Christophe de Dinechin wrote:
>>  Linux and QEMU's own qht work just fine with compile-time directives.
>=20
> Wouldn=E2=80=99t it work fine without any compile-time directive at all=
?

Yes, that's what I meant.  Though there are certainly cases in which the
difference without proper cacheline alignment is an order of magnitude
less throughput or something like that; it would certainly be noticeable.

>> I don't think lock-free lists are easier.  Bitmaps smaller than 64
>> elements are both faster and easier to manage.
>=20
> I believe that this is only true if you use a linked list for both free=
list
> management and for thread notification (i.e. to replace the bitmaps).
> However, if you use an atomic list only for the free list, and keep
> bitmaps for signaling, then performance is at least equal, often better=
.
> Plus you get the added benefit of having a thread-safe API, i.e.
> something that is truly lock-free.
>=20
> I did a small experiment to test / prove this. Last commit on branch:
> https://github.com/c3d/recorder/commits/181122-xiao_guangdong_introduce=
-threaded-workqueue
> Take with a grain of salt, microbenchmarks are always suspect ;-)
>=20
> The code in =E2=80=9Cthread_test.c=E2=80=9D includes Xiao=E2=80=99s cod=
e with two variations,
> plus some testing code lifted from the flight recorder library.
> 1. The FREE_LIST variation (sl_test) is what I would like to propose.
> 2. The BITMAP variation (bm_test) is the baseline
> 3. The DOUBLE_LIST variation (ll_test) is the slow double-list approach
>=20
> To run it, you need to do =E2=80=9Cmake opt-test=E2=80=9D, then run =E2=
=80=9Ctest_script=E2=80=9D
> which outputs a CSV file. The summary of my findings testing on
> a ThinkPad, a Xeon machine and a MacBook is here:
> https://imgur.com/a/4HmbB9K
>=20
> Overall, the proposed approach:
>=20
> - makes the API thread safe and lock free, addressing the one
> drawback that Xiao was mentioning.
>=20
> - delivers up to 30% more requests on the Macbook, while being
> =E2=80=9Cwithin noise=E2=80=9D (sometimes marginally better) for the ot=
her two.
> I suspect an optimization opportunity found by clang, because
> the Macbook delivers really high numbers.
>=20
> - spends less time blocking when all threads are busy, which
> accounts for the higher number of client loops.
>=20
> If you think that makes sense, then either Xiao can adapt the code
> from the branch above, or I can send a follow-up patch.

Having a follow-up patch would be best I think.  Thanks for
experimenting with this, it's always fun stuff. :)

Paolo
