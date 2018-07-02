Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1fZzFn-000847-Ok
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1fZzFm-0005CF-E5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:52:31 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:41467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bergwolf@gmail.com>) id 1fZzFm-0005Bk-44
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:52:30 -0400
Received: by mail-wr0-x241.google.com with SMTP id h10-v6so15637544wrq.8
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:52:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702131054.GE2155@stefanha-x1.localdomain>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
From: Peng Tao <bergwolf@gmail.com>
Date: Mon, 2 Jul 2018 21:52:08 +0800
Message-ID: <CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, Jul 2, 2018 at 9:10 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, Mar 31, 2018 at 04:45:00PM +0800, Lai Jiangshan wrote:
>> a) feature: qemu-local-migration, qemu-live-update
>> Set the mem-path on the tmpfs and set share=3Don for it when
>> start the vm. example:
>> -object \
>> memory-backend-file,id=3Dmem,size=3D128M,mem-path=3D/dev/shm/memory,shar=
e=3Don \
>> -numa node,nodeid=3D0,cpus=3D0-7,memdev=3Dmem
>>
>> when you want to migrate the vm locally (after fixed a security bug
>> of the qemu-binary, or other reason), you can start a new qemu with
>> the same command line and -incoming, then you can migrate the
>> vm from the old qemu to the new qemu with the migration capability
>> 'bypass-shared-memory' set. The migration will migrate the device-state
>> *ONLY*, the memory is the origin memory backed by tmpfs file.
>
> Marcelo, Andrea, Paolo: There was a more complex local migration
> approach in 2013 with fd passing and vmsplice.  They specifically
> avoided the approach proposed in this patch, but I don't remember why.
>
> The closest to an explanation I've found is this message from Marcelo:
>
>   Another possibility is to use memory that is not anonymous for guest
>   RAM, such as hugetlbfs or tmpfs.
>
>   IIRC ksm and thp have limitations wrt tmpfs.
>
> https://www.spinics.net/lists/linux-mm/msg67437.html
>
> Have the limitations been been solved since then?
>
>> c)  feature: vm-template, vm-fast-live-clone
>> the template vm is started as 1), and paused when the guest reaches
>> the template point(example: the guest app is ready), then the template
>> vm is saved. (the qemu process of the template can be killed now, becaus=
e
>> we need only the memory and the device state files (in tmpfs)).
>>
>> Then we can launch one or multiple VMs base on the template vm states,
>> the new VMs are started without the =E2=80=9Cshare=3Don=E2=80=9D, all th=
e new VMs share
>> the initial memory from the memory file, they save a lot of memory.
>> all the new VMs start from the template point, the guest app can go to
>> work quickly.
>>
>> The new VM booted from template vm can=E2=80=99t become template again,
>> if you need this unusual chained-template feature, you can write
>> a cloneable-tmpfs kernel module for it.
>>
>> The libvirt toolkit can=E2=80=99t manage vm-template currently, in the
>> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
>> =E2=80=9Clibvrit managed template=E2=80=9D feature to libvirt.
>
> This feature has been discussed multiple times in the past and probably
> the reason why it's not in libvirt yet is that no one wants it badly
> enough that they have solved the security issues.
>
> RAM and disk contain secrets like address-space layout randomization,
> random number generator state, cryptographic keys, etc.  Both the kernel
> and userspace handle secrets, making it hard to isolate all secrets and
> wipe them when cloning.
>
Hi Stefan,

> Risks:
> 1. If one cloned VM is exploited then all other VMs are more likely to
>    be exploitable (e.g. kernel address space layout randomization).
w.r.t. KASLR, any memory duplication technology would expose it. I
remember there are CVEs (e.g., CVE-2015-2877) specific to this kind
attack against KSM and it was stated that "Basically if you care about
this attack vector, disable deduplication.". Share-until-written
approaches for memory conservation among mutually untrusting tenants
are inherently detectable for information disclosure, and can be
classified as potentially misunderstood behaviors rather than
vulnerabilities. [1]

I think the same applies to vm templating as well. Actually VM
templating is more useful (than KSM) in this regard since we can
create a template for each trusted tenant where as with KSM all VMs on
a host are treated equally.

[1] https://access.redhat.com/security/cve/cve-2015-2877

> 2. If you give VMs cloned from the same template to untrusted users,
>    they may be able to determine the secrets other users' VMs.
In kata and runv, vm templating is used carefully so that we do not
use or save any secret keys before creating the template VM. IOW, the
feature is not supposed to be used generally to create any template
VMs at any stage.

>
> How are you wiping secrets and re-randomizing cloned VMs?
I think we can write some host generated random seeds to guest's
urandom device, when cloning VMs from the same template before handing
it to users. Is it enough or do you think there are more to do w/
re-randomizing?

>  Security is a
> major factor for using Kata, so it's important not to leak secrets
> between cloned VMs.
>
Yes, indeed! And it is all about trade-offs, VM templating or KSM. If
we want security above anything, we should just disable all the
sharing. But there is actually no ceiling (think about physical
isolation!). So it's more about trade-offs. With Kata, VM templating
and KSM give users options to achieve better performance and lower
memory footprint with little sacrifice. The security advantage of
running VM-based containers is still there.

Cheers,
Tao
