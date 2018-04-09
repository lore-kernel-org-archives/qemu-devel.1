Received: from eggs.gnu.org ([2001:4830:134:3::10]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5cVb-0000zH-T4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5cVY-00021m-Ip
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:31:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5cVY-000216-BR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:31:16 -0400
Date: Mon, 9 Apr 2018 20:30:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180409193052.GM2449@work-vm>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
	<c7f35243-3357-579b-3e68-40b0369dd1c7@gmail.com>
	<b8ec9404-b34f-bd4f-df02-8227683f0ef8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8ec9404-b34f-bd4f-df02-8227683f0ef8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] migration: improve and cleanup
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, Stefan Hajnoczi <stefanha@gmail.com>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 08/04/2018 05:19, Xiao Guangrong wrote:
> >=20
> > Hi Paolo, Michael, Stefan and others,
> >=20
> > Could anyone merge this patchset if it is okay to you guys?
>=20
> Hi Guangrong,
>=20
> Dave and Juan will take care of merging it.  However, right now QEMU is
> in freeze so they may wait a week or two.  If they have reviewed it,
> it's certainly on their radar!

Yep, one of us will get it at the start of 2.13.

Dave

> Thanks,
>=20
> Paolo
>=20
> > On 03/30/2018 03:51 PM, guangrong.xiao@gmail.com wrote:
> >> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> >>
> >> Changelog in v3:
> >> Following changes are from Peter's review:
> >> 1) use comp_param[i].file and decomp_param[i].compbuf to indicate if
> >> =C2=A0=C2=A0=C2=A0 the thread is properly init'd or not
> >> 2) save the file which is used by ram loader to the global variable
> >> =C2=A0=C2=A0=C2=A0 instead it is cached per decompression thread
> >>
> >> Changelog in v2:
> >> Thanks to the review from Dave, Peter, Wei and Jiang Biao, the chang=
es
> >> in this version are:
> >> 1) include the performance number in the cover letter
> >> 2=EF=BC=89add some comments to explain how to use z_stream->opaque i=
n the
> >> =C2=A0=C2=A0=C2=A0 patchset
> >> 3) allocate a internal buffer for per thread to store the data to
> >> =C2=A0=C2=A0=C2=A0 be compressed
> >> 4) add a new patch that moves some code to ram_save_host_page() so
> >> =C2=A0=C2=A0=C2=A0 that 'goto' can be omitted gracefully
> >> 5) split the optimization of compression and decompress into two
> >> =C2=A0=C2=A0=C2=A0 separated patches
> >> 6) refine and correct code styles
> >>
> >>
> >> This is the first part of our work to improve compression to make it
> >> be more useful in the production.
> >>
> >> The first patch resolves the problem that the migration thread spend=
s
> >> too much CPU resource to compression memory if it jumps to a new blo=
ck
> >> that causes the network is used very deficient.
> >>
> >> The second patch fixes the performance issue that too many VM-exits
> >> happen during live migration if compression is being used, it is cau=
sed
> >> by huge memory returned to kernel frequently as the memory is alloca=
ted
> >> and freed for every signal call to compress2()
> >>
> >> The remaining patches clean the code up dramatically
> >>
> >> Performance numbers:
> >> We have tested it on my desktop, i7-4790 + 16G, by locally live migr=
ate
> >> the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limite=
d to
> >> 350. During the migration, a workload which has 8 threads repeatedly
> >> written total 6G memory in the VM.
> >>
> >> Before this patchset, its bandwidth is ~25 mbps, after applying, the
> >> bandwidth is ~50 mbp.
> >>
> >> We also collected the perf data for patch 2 and 3 on our production,
> >> before the patchset:
> >> +=C2=A0 57.88%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [k] queued_spin_lock_slowpath
> >> +=C2=A0 10.55%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [k] __lock_acquire
> >> +=C2=A0=C2=A0 4.83%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] flush_tlb_func_common
> >>
> >> -=C2=A0=C2=A0 1.16%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k]
> >> lock_acquire=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =E2=96=92
> >> =C2=A0=C2=A0=C2=A0 -
> >> lock_acquire=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 15.68%
> >> _raw_spin_lock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 29.42%
> >> __schedule=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 29.14%
> >> perf_event_context_sched_out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 23.60%
> >> tdp_page_fault=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 10.54%
> >> do_anonymous_page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 2.07%
> >> kvm_mmu_notifier_invalidate_range_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 1.83%
> >> zap_pte_range=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 1.44% kvm_m=
mu_notifier_invalidate_range_end
> >>
> >>
> >> apply our work:
> >> +=C2=A0 51.92%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [k] queued_spin_lock_slowpath
> >> +=C2=A0 14.82%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [k] __lock_acquire
> >> +=C2=A0=C2=A0 1.47%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] mark_lock.clone.0
> >> +=C2=A0=C2=A0 1.46%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] native_sched_clock
> >> +=C2=A0=C2=A0 1.31%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] lock_acquire
> >> +=C2=A0=C2=A0 1.24%=C2=A0 kqemu=C2=A0 libc-2.12.so=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] __memset_sse2
> >>
> >> -=C2=A0 14.82%=C2=A0 kqemu=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [k]
> >> __lock_acquire=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =E2=96=92
> >> =C2=A0=C2=A0=C2=A0 -
> >> __lock_acquire=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 99.75%
> >> lock_acquire=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 18.38%
> >> _raw_spin_lock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 + 39.62%
> >> tdp_page_fault=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 + 31.32%
> >> __schedule=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 + 27.53%
> >> perf_event_context_sched_out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> >> =E2=96=92
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 + 0.58% hrtimer_interrupt
> >>
> >>
> >> We can see the TLB flush and mmu-lock contention have gone.
> >>
> >> Xiao Guangrong (10):
> >> =C2=A0=C2=A0 migration: stop compressing page in migration thread
> >> =C2=A0=C2=A0 migration: stop compression to allocate and free memory=
 frequently
> >> =C2=A0=C2=A0 migration: stop decompression to allocate and free memo=
ry frequently
> >> =C2=A0=C2=A0 migration: detect compression and decompression errors
> >> =C2=A0=C2=A0 migration: introduce control_save_page()
> >> =C2=A0=C2=A0 migration: move some code to ram_save_host_page
> >> =C2=A0=C2=A0 migration: move calling control_save_page to the common=
 place
> >> =C2=A0=C2=A0 migration: move calling save_zero_page to the common pl=
ace
> >> =C2=A0=C2=A0 migration: introduce save_normal_page()
> >> =C2=A0=C2=A0 migration: remove ram_save_compressed_page()
> >>
> >> =C2=A0 migration/qemu-file.c |=C2=A0 43 ++++-
> >> =C2=A0 migration/qemu-file.h |=C2=A0=C2=A0 6 +-
> >> =C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 482
> >> ++++++++++++++++++++++++++++++--------------------
> >> =C2=A0 3 files changed, 324 insertions(+), 207 deletions(-)
> >>
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
