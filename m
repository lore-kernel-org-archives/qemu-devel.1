Received: from eggs.gnu.org ([2001:4830:134:3::10]:46361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYpv8-0006il-2r
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYpv4-000400-TC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fYpv4-0003yy-Mm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:22 -0400
Date: Fri, 29 Jun 2018 10:42:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180629094213.GD2568@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
	<20180619073034.GA14814@xz-mi>
	<e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] migration: do not detect zero page
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>=20
> Hi Peter,
>=20
> Sorry for the delay as i was busy on other things.
>=20
> On 06/19/2018 03:30 PM, Peter Xu wrote:
> > On Mon, Jun 04, 2018 at 05:55:14PM +0800, guangrong.xiao@gmail.com wr=
ote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > >=20
> > > Detecting zero page is not a light work, we can disable it
> > > for compression that can handle all zero data very well
> >=20
> > Is there any number shows how the compression algo performs better
> > than the zero-detect algo?  Asked since AFAIU buffer_is_zero() might
> > be fast, depending on how init_accel() is done in util/bufferiszero.c=
.
>=20
> This is the comparison between zero-detection and compression (the targ=
et
> buffer is all zero bit):
>=20
> Zero 810 ns Compression: 26905 ns.
> Zero 417 ns Compression: 8022 ns.
> Zero 408 ns Compression: 7189 ns.
> Zero 400 ns Compression: 7255 ns.
> Zero 412 ns Compression: 7016 ns.
> Zero 411 ns Compression: 7035 ns.
> Zero 413 ns Compression: 6994 ns.
> Zero 399 ns Compression: 7024 ns.
> Zero 416 ns Compression: 7053 ns.
> Zero 405 ns Compression: 7041 ns.
>=20
> Indeed, zero-detection is faster than compression.
>=20
> However during our profiling for the live_migration thread (after rever=
ted this patch),
> we noticed zero-detection cost lots of CPU:
>=20
>  12.01%  kqemu  qemu-system-x86_64            [.] buffer_zero_sse2     =
                                                                         =
                                                                         =
                    =E2=97=86

Interesting; what host are you running on?
Some hosts have support for the faster buffer_zero_ss4/avx2

>   7.60%  kqemu  qemu-system-x86_64            [.] ram_bytes_total      =
                                                                         =
                                                                         =
                    =E2=96=92
>   6.56%  kqemu  qemu-system-x86_64            [.] qemu_event_set       =
                                                                         =
                                                                         =
                    =E2=96=92
>   5.61%  kqemu  qemu-system-x86_64            [.] qemu_put_qemu_file   =
                                                                         =
                                                                         =
                    =E2=96=92
>   5.00%  kqemu  qemu-system-x86_64            [.] __ring_put           =
                                                                         =
                                                                         =
                    =E2=96=92
>   4.89%  kqemu  [kernel.kallsyms]             [k] copy_user_enhanced_fa=
st_string                                                                =
                                                                         =
                    =E2=96=92
>   4.71%  kqemu  qemu-system-x86_64            [.] compress_thread_data_=
done                                                                     =
                                                                         =
                    =E2=96=92
>   3.63%  kqemu  qemu-system-x86_64            [.] ring_is_full         =
                                                                         =
                                                                         =
                    =E2=96=92
>   2.89%  kqemu  qemu-system-x86_64            [.] __ring_is_full       =
                                                                         =
                                                                         =
                    =E2=96=92
>   2.68%  kqemu  qemu-system-x86_64            [.] threads_submit_reques=
t_prepare                                                                =
                                                                         =
                    =E2=96=92
>   2.60%  kqemu  qemu-system-x86_64            [.] ring_mp_get          =
                                                                         =
                                                                         =
                    =E2=96=92
>   2.25%  kqemu  qemu-system-x86_64            [.] ring_get             =
                                                                         =
                                                                         =
                    =E2=96=92
>   1.96%  kqemu  libc-2.12.so                  [.] memcpy
>=20
> After this patch, the workload is moved to the worker thread, is it
> acceptable?
>=20
> >=20
> >  From compression rate POV of course zero page algo wins since it
> > contains no data (but only a flag).
> >=20
>=20
> Yes it is. The compressed zero page is 45 bytes that is small enough i =
think.

So the compression is ~20x slow and 10x the size;  not a great
improvement!

However, the tricky thing is that in the case of a guest which is mostly
non-zero, this patch would save that time used by zero detection, so it
would be faster.

> Hmm, if you do not like, how about move detecting zero page to the work=
 thread?

That would be interesting to try.

Dave

> Thanks!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
