Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gREZO-0000yL-Nw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gREZK-00043a-ME
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gREZK-000424-Gl
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:56:46 -0500
Date: Mon, 26 Nov 2018 10:56:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181126105622.GB2547@work-vm>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181123110239.GC2373@work-vm>
	<e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>=20
>=20
> On 11/23/18 7:02 PM, Dr. David Alan Gilbert wrote:
>=20
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/bitmap.h"
> > > +#include "qemu/threaded-workqueue.h"
> > > +
> > > +#define SMP_CACHE_BYTES 64
> >=20
> > That's architecture dependent isn't it?
> >=20
>=20
> Yes, it's arch dependent indeed.
>=20
> I just used 64 for simplification and i think it is <=3D 64 on most CPU=
 arch-es
> so that can work.
>=20
> Should i introduce statically defined CACHE LINE SIZE for all arch-es? =
:(

I think it depends why you need it; but we shouldn't have a constant
that is wrong, and we shouldn't define something architecture dependent
in here.

> > > +   /*
> > > +     * the bit in these two bitmaps indicates the index of the =EF=
=BC=A0requests
> > > +     * respectively. If it's the same, the corresponding request i=
s free
> > > +     * and owned by the user, i.e, where the user fills a request.=
 Otherwise,
> > > +     * it is valid and owned by the thread, i.e, where the thread =
fetches
> > > +     * the request and write the result.
> > > +     */
> > > +
> > > +    /* after the user fills the request, the bit is flipped. */
> > > +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> > > +    /* after handles the request, the thread flips the bit. */
> > > +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> >=20
> > Patchew complained about some type mismatches; I think those are beca=
use
> > you're using the bitmap_* functions on these; those functions always
> > operate on 'long' not on uint64_t - and on some platforms they're
> > unfortunately not the same.
>=20
> I guess you were taking about this error:
> ERROR: externs should be avoided in .c files
> #233: FILE: util/threaded-workqueue.c:65:
> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>=20
> The complained thing is "QEMU_ALIGNED(SMP_CACHE_BYTES)" as it gone
> when the aligned thing is removed...
>=20
> The issue you pointed out can be avoid by using type-casting, like:
> bitmap_xor(..., (void *)&thread->request_fill_bitmap)
> cannot we?

I thought the error was just due to long vs uint64_t ratehr than the
qemu_aligned.  I don't think it's just a casting problem, since I don't
think the long's are always 64bit.

Dave

> Thanks!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
