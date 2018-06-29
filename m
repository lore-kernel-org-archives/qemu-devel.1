Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYq6n-0005H2-Nd
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYq6m-0002Tr-B4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:54:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fYq6m-0002Rq-4O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:54:28 -0400
Date: Fri, 29 Jun 2018 10:54:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180629095418.GE2568@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
	<20180619073034.GA14814@xz-mi>
	<e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
	<20180628093650.GB3513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628093650.GB3513@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, pbonzini@redhat.com

* Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> On Thu, Jun 28, 2018 at 05:12:39PM +0800, Xiao Guangrong wrote:
> >=20
> > Hi Peter,
> >=20
> > Sorry for the delay as i was busy on other things.
> >=20
> > On 06/19/2018 03:30 PM, Peter Xu wrote:
> > > On Mon, Jun 04, 2018 at 05:55:14PM +0800, guangrong.xiao@gmail.com =
wrote:
> > > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > >=20
> > > > Detecting zero page is not a light work, we can disable it
> > > > for compression that can handle all zero data very well
> > >=20
> > > Is there any number shows how the compression algo performs better
> > > than the zero-detect algo?  Asked since AFAIU buffer_is_zero() migh=
t
> > > be fast, depending on how init_accel() is done in util/bufferiszero=
.c.
> >=20
> > This is the comparison between zero-detection and compression (the ta=
rget
> > buffer is all zero bit):
> >=20
> > Zero 810 ns Compression: 26905 ns.
> > Zero 417 ns Compression: 8022 ns.
> > Zero 408 ns Compression: 7189 ns.
> > Zero 400 ns Compression: 7255 ns.
> > Zero 412 ns Compression: 7016 ns.
> > Zero 411 ns Compression: 7035 ns.
> > Zero 413 ns Compression: 6994 ns.
> > Zero 399 ns Compression: 7024 ns.
> > Zero 416 ns Compression: 7053 ns.
> > Zero 405 ns Compression: 7041 ns.
> >=20
> > Indeed, zero-detection is faster than compression.
> >=20
> > However during our profiling for the live_migration thread (after rev=
erted this patch),
> > we noticed zero-detection cost lots of CPU:
> >=20
> >  12.01%  kqemu  qemu-system-x86_64            [.] buffer_zero_sse2   =
                                                                         =
                                                                         =
                      =E2=97=86
> >   7.60%  kqemu  qemu-system-x86_64            [.] ram_bytes_total    =
                                                                         =
                                                                         =
                      =E2=96=92
> >   6.56%  kqemu  qemu-system-x86_64            [.] qemu_event_set     =
                                                                         =
                                                                         =
                      =E2=96=92
> >   5.61%  kqemu  qemu-system-x86_64            [.] qemu_put_qemu_file =
                                                                         =
                                                                         =
                      =E2=96=92
> >   5.00%  kqemu  qemu-system-x86_64            [.] __ring_put         =
                                                                         =
                                                                         =
                      =E2=96=92
> >   4.89%  kqemu  [kernel.kallsyms]             [k] copy_user_enhanced_=
fast_string                                                              =
                                                                         =
                      =E2=96=92
> >   4.71%  kqemu  qemu-system-x86_64            [.] compress_thread_dat=
a_done                                                                   =
                                                                         =
                      =E2=96=92
> >   3.63%  kqemu  qemu-system-x86_64            [.] ring_is_full       =
                                                                         =
                                                                         =
                      =E2=96=92
> >   2.89%  kqemu  qemu-system-x86_64            [.] __ring_is_full     =
                                                                         =
                                                                         =
                      =E2=96=92
> >   2.68%  kqemu  qemu-system-x86_64            [.] threads_submit_requ=
est_prepare                                                              =
                                                                         =
                      =E2=96=92
> >   2.60%  kqemu  qemu-system-x86_64            [.] ring_mp_get        =
                                                                         =
                                                                         =
                      =E2=96=92
> >   2.25%  kqemu  qemu-system-x86_64            [.] ring_get           =
                                                                         =
                                                                         =
                      =E2=96=92
> >   1.96%  kqemu  libc-2.12.so                  [.] memcpy
> >=20
> > After this patch, the workload is moved to the worker thread, is it
> > acceptable?
>=20
> It depends on your point of view. If you have spare / idle CPUs on the =
host,
> then moving workload to a thread is ok, despite the CPU cost of compres=
sion
> in that thread being much higher what what was replaced, since you won'=
t be
> taking CPU resources away from other contending workloads.

It depends on teh VM as well; if the VM is mostly non-zero, the zero
checks happen and are over head (although if the pages are non-zero then
the zero check will mostly happen much faster unless you're unlucky and
the non-zero byte is the last one on the page).

> I'd venture to suggest though that we should probably *not* be optimizi=
ng for
> the case of idle CPUs on the host. More realistic is to expect that the=
 host
> CPUs are near fully committed to work, and thus the (default) goal shou=
ld be
> to minimize CPU overhead for the host as a whole. From this POV, zero-p=
age
> detection is better than compression due to > x10 better speed.

Note that this is only happening if compression is enabled.

> Given the CPU overheads of compression, I think it has fairly narrow us=
e
> in migration in general when considering hosts are often highly committ=
ed
> on CPU.

Also, this compression series was originally written by Intel for the
case where there's a compression accelerator hardware (that I've never
found to try); in that case I guess it saves that CPU overhead.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
