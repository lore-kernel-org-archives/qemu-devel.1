Received: from eggs.gnu.org ([2001:4830:134:3::10]:47495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8mt1-00020t-PE
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8msz-0007po-3O
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:08:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8msy-0007kw-Ck
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:08:01 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Thu, 11 May 2017 12:07:28 +0000
Message-ID: <B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
In-Reply-To: <20170424164244.GJ2362@work-vm>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>

Hi all,

After applying the patch below, the time which
memory_global_dirty_log_stop() function takes is down to milliseconds
of a 4T memory guest, but I'm not sure whether this patch will trigger
other problems. Does this patch make sense?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 464da93..fe26ee5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8313,6 +8313,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
                                enum kvm_mr_change change)
 {
        int nr_mmu_pages =3D 0;
+       int i;
+       struct kvm_vcpu *vcpu;
=20
        if (!kvm->arch.n_requested_mmu_pages)
                nr_mmu_pages =3D kvm_mmu_calculate_mmu_pages(kvm);
@@ -8328,14 +8330,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
         * in the source machine (for example if live migration fails), sma=
ll
         * sptes will remain around and cause bad performance.
         *
-        * Scan sptes if dirty logging has been stopped, dropping those
-        * which can be collapsed into a single large-page spte.  Later
-        * page faults will create the large-page sptes.
+        * Reset each vcpu's mmu, then page faults will create the large-pa=
ge
+        * sptes later.
         */
        if ((change !=3D KVM_MR_DELETE) &&
                (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
-               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-               kvm_mmu_zap_collapsible_sptes(kvm, new);
+               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
+               kvm_for_each_vcpu(i, vcpu, kvm)
+                       kvm_mmu_reset_context(vcpu);
+       }
=20
        /*
         * Set up write protection and/or dirty logging for the new slot.

> * Yang Hongyang (yanghongyang@huawei.com) wrote:
> >
> >
> > On 2017/4/24 20:06, Juan Quintela wrote:
> > > Yang Hongyang <yanghongyang@huawei.com> wrote:
> > >> Hi all,
> > >>
> > >> We found dirty log switch costs more then 13 seconds while
> > >> migrating a 4T memory guest, and dirty log switch is currently
> > >> protected by QEMU BQL. This causes guest freeze for a long time
> > >> when switching dirty log on, and the migration downtime is
> unacceptable.
> > >> Are there any chance to optimize the time cost for dirty log switch
> operation?
> > >> Or move the time consuming operation out of the QEMU BQL?
> > >
> > > Hi
> > >
> > > Could you specify what do you mean by dirty log switch?
> > > The one inside kvm?
> > > The merge between kvm one and migration bitmap?
> >
> > The call of the following functions:
> > memory_global_dirty_log_start/stop();
>=20
> I suppose there's a few questions;
>   a) Do we actually need the BQL - and if so why
>   b) What actually takes 13s?  It's probably worth figuring out where it
> goes,  the whole bitmap is only 1GB isn't it even on a 4TB machine, and
> even the simplest way to fill that takes way less than 13s.
>=20
> Dave
>=20
> >
> > >
> > > Thanks, Juan.
> > >
> >
> > --
> > Thanks,
> > Yang
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Jay Zhou
