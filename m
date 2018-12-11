Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1gWZ3r-0000NF-Uv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1gWYxR-0001LX-2t
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:43:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1gWYxQ-0001LI-Re
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:43:41 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so12699407otr.10
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 19:43:40 -0800 (PST)
MIME-Version: 1.0
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
	<1280755991.8446336.1495007019282.JavaMail.zimbra@redhat.com>
	<CANRm+CwbTaoxq35zyfNF1BP3d5GqRmtq0sY+aRKRaOsFwGB1Mw@mail.gmail.com>
	<591EA84D.1030800@huawei.com>
In-Reply-To: <591EA84D.1030800@huawei.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 11 Dec 2018 11:43:24 +0800
Message-ID: <CANRm+CzvwhV1CqYfc_=tO167A=3Lmqf7HCeYhY4kGCW=p-V3cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, Juan Quintela <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Gonglei <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, kvm <kvm@vger.kernel.org>

On Fri, 19 May 2017 at 16:10, Jay Zhou <jianjay.zhou@huawei.com> wrote:
>
> Hi Paolo and Wanpeng,
>
> On 2017/5/17 16:38, Wanpeng Li wrote:
> > 2017-05-17 15:43 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> >>> Recently, I have tested the performance before migration and after migration failure
> >>> using spec cpu2006 https://www.spec.org/cpu2006/, which is a standard performance
> >>> evaluation tool.
> >>>
> >>> These are the steps:
> >>> ======
> >>>   (1) the version of kmod is 4.4.11(with slightly modified) and the version of
> >>>   qemu is 2.6.0
> >>>      (with slightly modified), the kmod is applied with the following patch
> >>>
> >>> diff --git a/source/x86/x86.c b/source/x86/x86.c
> >>> index 054a7d3..75a4bb3 100644
> >>> --- a/source/x86/x86.c
> >>> +++ b/source/x86/x86.c
> >>> @@ -8550,8 +8550,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >>>           */
> >>>          if ((change != KVM_MR_DELETE) &&
> >>>                  (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
> >>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
> >>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
> >>> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
> >>> +               printk(KERN_ERR "zj make KVM_REQ_MMU_RELOAD request\n");
> >>> +               kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
> >>> +       }
> >>>
> >>>          /*
> >>>           * Set up write protection and/or dirty logging for the new slot.
> >>
> >> Try these modifications to the setup:
> >>
> >> 1) set up 1G hugetlbfs hugepages and use those for the guest's memory
> >>
> >> 2) test both without and with the above patch.
> >>
>
> In order to avoid random memory allocation issues, I reran the test cases:
> (1) setup: start a 4U10G VM with memory preoccupied, each vcpu is pinned to a
> pcpu respectively, these resources(memory and pcpu) allocated to VM are all
> from NUMA node 0
> (2) sequence: firstly, I run the 429.mcf of spec cpu2006 before migration, and
> get a result. And then, migration failure is constructed. At last, I run the
> test case again, and get an another result.
> (3) results:
> Host hugepages           THP on(2M)  THP on(2M)   THP on(2M)   THP on(2M)
> Patch                    patch1      patch2       patch3       -
> Before migration         No          No           No           Yes
> After migration failed   Yes         Yes          Yes          No
> Largepages               67->1862    62->1890     95->1865     1926
> score of 429.mcf         189         188          188          189
>
> Host hugepages           1G hugepages  1G hugepages  1G hugepages  1G hugepages
> Patch                    patch1        patch2        patch3        -
> Before migration         No            No            No            Yes
> After migration failed   Yes           Yes           Yes           No
> Largepages               21            21            26            39
> score of 429.mcf         188           188           186           188
>
> Notes:
> patch1  means with "lazy collapse small sptes into large sptes" codes
> patch2  means comment out "lazy collapse small sptes into large sptes" codes
> patch3  means using kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD)
>          instead of kvm_mmu_zap_collapsible_sptes(kvm, new)
>
> "Largepages" means the value of /sys/kernel/debug/kvm/largepages
>
> > In addition, we can compare /sys/kernel/debug/kvm/largepages w/ and
> > w/o the patch. IIRC, /sys/kernel/debug/kvm/largepages will drop during
> > live migration, it will keep a small value if live migration fails and
> > w/o "lazy collapse small sptes into large sptes" codes, however, it
> > will increase gradually if w/ the "lazy collapse small sptes into
> > large sptes" codes.
> >
>
> No, without the "lazy collapse small sptes into large sptes" codes,
> /sys/kernel/debug/kvm/largepages does drop during live migration,
> but it still will increase gradually if live migration fails, see the result
> above. I printed out the back trace when it increases after migration failure,
>
> [139574.369098]  [<ffffffff81644a7f>] dump_stack+0x19/0x1b
> [139574.369111]  [<ffffffffa02c3af6>] mmu_set_spte+0x2f6/0x310 [kvm]
> [139574.369122]  [<ffffffffa02c4f7e>] __direct_map.isra.109+0x1de/0x250 [kvm]
> [139574.369133]  [<ffffffffa02c8a76>] tdp_page_fault+0x246/0x280 [kvm]
> [139574.369144]  [<ffffffffa02bf4e4>] kvm_mmu_page_fault+0x24/0x130 [kvm]
> [139574.369148]  [<ffffffffa07c8116>] handle_ept_violation+0x96/0x170 [kvm_intel]
> [139574.369153]  [<ffffffffa07cf949>] vmx_handle_exit+0x299/0xbf0 [kvm_intel]
> [139574.369157]  [<ffffffff816559f0>] ? uv_bau_message_intr1+0x80/0x80
> [139574.369161]  [<ffffffffa07cd5e0>] ? vmx_inject_irq+0xf0/0xf0 [kvm_intel]
> [139574.369172]  [<ffffffffa02b35cd>] vcpu_enter_guest+0x76d/0x1160 [kvm]
> [139574.369184]  [<ffffffffa02d9285>] ? kvm_apic_local_deliver+0x65/0x70 [kvm]
> [139574.369196]  [<ffffffffa02bb125>] kvm_arch_vcpu_ioctl_run+0xd5/0x440 [kvm]
> [139574.369205]  [<ffffffffa02a2b11>] kvm_vcpu_ioctl+0x2b1/0x640 [kvm]
> [139574.369209]  [<ffffffff810e7852>] ? do_futex+0x122/0x5b0
> [139574.369212]  [<ffffffff811fd9d5>] do_vfs_ioctl+0x2e5/0x4c0
> [139574.369223]  [<ffffffffa02b0cf5>] ? kvm_on_user_return+0x75/0xb0 [kvm]
> [139574.369225]  [<ffffffff811fdc51>] SyS_ioctl+0xa1/0xc0
> [139574.369229]  [<ffffffff81654e09>] system_call_fastpath+0x16/0x1b
>
> Any suggestion will be appreciated, Thanks!

I found some time to figure it out, there is a simple program to
reproduce in the guest:

#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#define BUFSIZE (1024 * 1024)

int useconds = 0;
int mbytes = 0;

void *memory_write(void *arg)
{
    int i = arg;
    int j = 0;
    char *p_buf = NULL;
    p_buf = (char *)malloc(mbytes * BUFSIZE);
    //use the memory
    memset(p_buf, 0, mbytes * BUFSIZE);
    printf("thread: %d\n", i);
    while (1) {
        for (j = 0; j < mbytes; j++) {
            memset(&p_buf[j * BUFSIZE], 0, 100);
        }
    usleep(useconds);
    }
}

int main(int argc, const char *argv[])
{
    int i = 0;
    int ret = 0;
    int threads = 0;
    pthread_t tid = 0;
    mbytes = atoi(argv[1]);
    threads = atoi(argv[2]);
    useconds = atoi(argv[3]);
    if (mbytes == 0 || threads == 0 || useconds == 0) {
        printf("get mbytes or threads or useconds error\n");
        return 1;
    }

    printf("mbytes:%dm, thread:%d, useconds:%d\n", mbytes, threads, useconds);

    for (i=0; i< threads; i++) {
        ret = pthread_create(&tid, NULL, (void *)memory_write, (void *)i);
        if(ret)
        {
            printf("Create pthread error!\n");
            return 1;
        }
   }

    sleep(1000000);
    return 0;
}

I try ./a.out 100 50 2 which means it will spawn 50 threads, each
allocate 100MB, and sleep 2us after each round of writing. In
addition, it just dirties 100 byte(which just occupies 4KB page) of
each 1MB memory.  The large sptes are dropped in the ept violation
path since the large sptes are write-protect during live migration,
small sptes are populated in this process, however, in the above
setup, just 2 small sptes for each 2MB memory range are populated,
there is no further ept violation and no further small sptes are
replaced by large sptes after migration fails since the 2 small sptes
are still populated. If I stop the a.out and run it the second time,
the memory of a.out is reallocated, it probably allocate other gfns,
the small sptes are replaced by large sptes during this process since
the sptes(the remaining sptes in the 2MB memory except the 2 before)
of the new gfns are empty and ept violation path figure out it is huge
page backed. I do another testing, replace the 100 bytes by BUFSIZE
which means that it will dirty the whole 1MB memory, this result in
all the small sptes are populated, it will not be replaced by large
sptes any more after migration fails.

For the the 429.mcf of spec cpu2006 testcase, the RES is 10GB, I guess
the whole memory of each 2MB is not accessing simultaneously, during
EPT violation, most large sptes are dropped, part of each 2MB memory
is accessed and small sptes are populated. The small sptes will be
dropped and replaced by large sptes in the ept violation path if other
part of each 2MB memory is accessed after migration fails.

Regards,
Wanpeng Li
