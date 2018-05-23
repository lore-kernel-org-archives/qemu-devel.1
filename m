Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fLYfH-0000Mn-1H
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fLYfF-0004nf-QY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:39:11 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fLYfF-0004nE-Iw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:39:09 -0400
Received: by mail-oi0-x243.google.com with SMTP id p62-v6so20427478oie.10
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:39:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
References: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 May 2018 11:39:06 -0700
Message-ID: <CAPcyv4g3pMV54bYwOOeMiFbi2swi5v9RTrBh8-_mtGpoOiw5XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions about vNVDIMM on qemu/KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, NVDIMM-ML <linux-nvdimm@lists.01.org>, Pankaj Gupta <pagupta@redhat.com>

On Tue, May 22, 2018 at 10:08 PM, Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> Hello,
>
> I'm investigating status of vNVDIMM on qemu/KVM,
> and I have some questions about it. I'm glad if anyone answer them.
>
> In my understanding, qemu/KVM has a feature to show NFIT for guest,
> and it will be still updated about platform capability with this patch set.
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04756.html
>
> And libvirt also supports this feature with <memory model='nvdimm'>
> https://libvirt.org/formatdomain.html#elementsMemory
>
>
> However, virtio-pmem is developing now, and it is better
> for archtectures to detect regions of NVDIMM without ACPI (like s390x)

I think you are confusing virtio-pmem (patches from Pankaj) and
virtio-mem (patches from David)? ...or I'm confused.

> In addition, It is also necessary to flush guest contents on vNVDIMM
> who has a backend-file.

virtio-pmem is a mechanism to use host page cache as pmem in a guest.
It does not support high performance memory applications because it
requires fsync/msync. I.e. it is not DAX it is the traditional mmap
I/O model, but moving page cache management to the host rather than
duplicating it in guests.

> Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem?
>     How do each roles become it if both NFIT and virtio-pmem will be available?
>     If my understanding is correct, both NFIT and virtio-pmem is used to
>     detect vNVDIMM regions, but only one seems to be necessary....

We need both because they are different. Guest DAX should not be using
virtio-pmem.

>     Otherwize, is the NFIT bus just for keeping compatibility,
>     and virtio-pmem is promising way?
>
>
> Q2) What bus is(will be?) created for virtio-pmem?
>     I could confirm the bus of NFIT is created with <memory model='nvdimm'>,
>     and I heard other bus will be created for virtio-pmem, but I could not
>     find what bus is created concretely.
>     ---
>       # ndctl list -B
>       {
>          "provider":"ACPI.NFIT",
>          "dev":"ndbus0"
>       }
>     ---
>
>     I think it affects what operations user will be able to, and what
>     notification is necessary for vNVDIMM.
>     ACPI defines some operations like namespace controll, and notification
>     for NVDIMM health status or others.
>     (I suppose that other status notification might be necessary for vNVDIMM,
>      but I'm not sure yet...)
>
> If my understanding is wrong, please correct me.

The current plan, per my understanding, is a virtio-pmem SPA UUID
added to the virtual NFIT so that the guest driver can load the pmem
driver but also hook up the virtio command ring for forwarding
WRITE_{FUA,FLUSH} commands as host fsync operations.
