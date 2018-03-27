Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0ihT-0005UT-M9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0ihQ-000488-Fq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:07:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0ihQ-00047h-3P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:07:16 -0400
Date: Tue, 27 Mar 2018 15:07:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327070703.GI17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-3-xiaoguangrong@tencent.com>
	<20180321090644.GC20571@xz-mi>
	<044788cf-fd00-83b3-6cd2-7df605397418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <044788cf-fd00-83b3-6cd2-7df605397418@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, Mar 22, 2018 at 07:57:54PM +0800, Xiao Guangrong wrote:
>=20
>=20
> On 03/21/2018 05:06 PM, Peter Xu wrote:
> > On Tue, Mar 13, 2018 at 03:57:33PM +0800, guangrong.xiao@gmail.com wr=
ote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > >=20
> > > Current code uses compress2()/uncompress() to compress/decompress
> > > memory, these two function manager memory allocation and release
> > > internally, that causes huge memory is allocated and freed very
> > > frequently
> > >=20
> > > More worse, frequently returning memory to kernel will flush TLBs
> > > and trigger invalidation callbacks on mmu-notification which
> > > interacts with KVM MMU, that dramatically reduce the performance
> > > of VM
> > >=20
> > > So, we maintain the memory by ourselves and reuse it for each
> > > compression and decompression
> > >=20
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > ---
> > >   migration/qemu-file.c |  34 ++++++++++--
> > >   migration/qemu-file.h |   6 ++-
> > >   migration/ram.c       | 142 +++++++++++++++++++++++++++++++++++++=
-------------
> > >   3 files changed, 140 insertions(+), 42 deletions(-)
> > >=20
> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > > index 2ab2bf362d..1ff33a1ffb 100644
> > > --- a/migration/qemu-file.c
> > > +++ b/migration/qemu-file.c
> > > @@ -658,6 +658,30 @@ uint64_t qemu_get_be64(QEMUFile *f)
> > >       return v;
> > >   }
> > > +/* return the size after compression, or negative value on error *=
/
> > > +static int qemu_compress_data(z_stream *stream, uint8_t *dest, siz=
e_t dest_len,
> > > +                              const uint8_t *source, size_t source=
_len)
> > > +{
> > > +    int err;
> > > +
> > > +    err =3D deflateReset(stream);
> >=20
> > I'm not familiar with zlib, but I saw this in manual:
> >=20
> >   https://www.zlib.net/manual.html
> >=20
> >   This function is equivalent to deflateEnd followed by deflateInit,
> >   but does not free and reallocate the internal compression state. Th=
e
> >   stream will leave the compression level and any other attributes th=
at
> >   may have been set unchanged.
> >=20
> > I thought it was deflateInit() who is slow?  Can we avoid the reset a=
s
>=20
> deflateEnd() is worse as it frees memory to kernel which triggers
> TLB flush and mmu-notifier.
>=20
> > long as we make sure to deflateInit() before doing anything else?
>=20
> Actually, deflateReset() is cheap... :)
>=20
> >=20
> > Meanwhile, is there any performance number for this single patch?
> > Since I thought the old code is calling compress2() which contains
> > deflateInit() and deflateEnd() too, just like what current patch do?
>=20
> No, after the patch, we just call deflateInit() / deflateEnd() one
> time (in _setup() handler and _cleanup handler).
>=20
> Yes. This is the perf data from our production,
> after revert this patch:
> +  57.88%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpat=
h
> +  10.55%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
> +   4.83%  kqemu  [kernel.kallsyms]        [k] flush_tlb_func_common
>=20
> -   1.16%  kqemu  [kernel.kallsyms]        [k] lock_acquire            =
                           =E2=96=92
>    - lock_acquire                                                      =
                           =E2=96=92
>       - 15.68% _raw_spin_lock                                          =
                           =E2=96=92
>          + 29.42% __schedule                                           =
                           =E2=96=92
>          + 29.14% perf_event_context_sched_out                         =
                           =E2=96=92
>          + 23.60% tdp_page_fault                                       =
                           =E2=96=92
>          + 10.54% do_anonymous_page                                    =
                           =E2=96=92
>          + 2.07% kvm_mmu_notifier_invalidate_range_start               =
                           =E2=96=92
>          + 1.83% zap_pte_range                                         =
                           =E2=96=92
>          + 1.44% kvm_mmu_notifier_invalidate_range_end
>=20
>=20
> apply our work:
> +  51.92%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpat=
h
> +  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
> +   1.47%  kqemu  [kernel.kallsyms]        [k] mark_lock.clone.0
> +   1.46%  kqemu  [kernel.kallsyms]        [k] native_sched_clock
> +   1.31%  kqemu  [kernel.kallsyms]        [k] lock_acquire
> +   1.24%  kqemu  libc-2.12.so             [.] __memset_sse2
>=20
> -  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire          =
                           =E2=96=92
>    - __lock_acquire                                                    =
                           =E2=96=92
>       - 99.75% lock_acquire                                            =
                           =E2=96=92
>          - 18.38% _raw_spin_lock                                       =
                           =E2=96=92
>             + 39.62% tdp_page_fault                                    =
                           =E2=96=92
>             + 31.32% __schedule                                        =
                           =E2=96=92
>             + 27.53% perf_event_context_sched_out                      =
                           =E2=96=92
>             + 0.58% hrtimer_interrupt
>=20
>=20
> You can see the TLB flush and mmu-lock contention have gone after this =
patch.

Yes.  Obviously I misunderstood the documentation for deflateReset().
It's not really a combined "End+Init", a quick glance in zlib code
shows that deflateInit() will do the mallocs, then call deflateReset()
at last.  So the buffers should be kept for reset(), as you explained.

>=20
> >=20
> > It would be nice too if we can split the patch into two (decode,
> > encode) if you want, but that's optional.
>=20
> That's good to me, thank you, Peter.

Thanks for explaining.

--=20
Peter Xu
