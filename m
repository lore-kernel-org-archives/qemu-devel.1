Received: from eggs.gnu.org ([2001:4830:134:3::10]:54516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fQNW0-0003gy-OK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 21:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fQNVx-0007Mq-M1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 21:45:32 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:28374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <y-goto@jp.fujitsu.com>)
	id 1fQNVx-0007GE-3T
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 21:45:29 -0400
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
	[10.134.21.209])
	by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id B4574AC0206
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 10:45:13 +0900 (JST)
Date: Wed, 06 Jun 2018 10:44:45 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
In-Reply-To: <120916025.39666078.1528099386072.JavaMail.zimbra@redhat.com>
References: <20180601115429.GL8687@stefanha-x1.localdomain>
	<120916025.39666078.1528099386072.JavaMail.zimbra@redhat.com>
Message-Id: <20180606104437.40CE.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions about vNVDIMM on qemu/KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, NVDIMM-ML <linux-nvdimm@lists.01.org>, dan j williams <dan.j.williams@intel.com>

> Hi,
>  
> > 
> > > I'm investigating status of vNVDIMM on qemu/KVM,
> > > and I have some questions about it. I'm glad if anyone answer them.
> > > 
> > > In my understanding, qemu/KVM has a feature to show NFIT for guest,
> > > and it will be still updated about platform capability with this patch set.
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04756.html
> > > 
> > > And libvirt also supports this feature with <memory model='nvdimm'>
> > > https://libvirt.org/formatdomain.html#elementsMemory
> > > 
> > > 
> > > However, virtio-pmem is developing now, and it is better
> > > for archtectures to detect regions of NVDIMM without ACPI (like s390x)
> > > In addition, It is also necessary to flush guest contents on vNVDIMM
> > > who has a backend-file.
> > > 
> > > 
> > > Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem?
>         No.
> 
> > >     How do each roles become it if both NFIT and virtio-pmem will be
> > >     available?
> 
>         There are two main use cases:
> 
>         1] DAX memory region pass-through to guest:
>         -------------------------------------------
>         As this region is present in actual physical NVDIMM device and exposed to guest,
>         ACPI/NFIT way is used. If all the persistent memory is used by only this way we 
>         don't need 'virtio-pmem'.
> 
>         2] Emulated DAX memory region in host passed to guest:
>         --------------------------------------------------------
>         If this type of region is exposed to guest, it will be preferable to use
>         'virtio-pmem'. 
> 
>         This is regular host memory which is mmaped in guest address space for emulating 
>         persistent memory. Guest writes are present in host page cache and not assured to be 
>         written on backing disk without an explicit flush/sync call.
>  
>         'virtio-pmem' will solve the problem of flushing guest writes present in host page cache.
>         With filesystems at host which use journal-ling like (ext4, xfs), they automatically call 
>         'fsync' at regular intervals. but still there is not 100% assurance of all write persistence until
>         an explicit flush is done from guest. So, we need an additional fsync to flush guest writes to 
>         backing disk. We are using this approach to avoid using guest page cache and keep page cache management 
>         of all the guests at host side.
>         
>         If both ACPI NFIT and virtio-pmem are present, both will have their corresponding memory regions and 
>         defined by memory type "Persistent shared Memory" in case of virtio-pmem and "Persistent Memory" for 
>         ACPI NVDIMM. This is to differentiate both the memory types.

Ok.

> 
> > >     If my understanding is correct, both NFIT and virtio-pmem is used to
> > >     detect vNVDIMM regions, but only one seems to be necessary....
> > > 
> > >     Otherwize, is the NFIT bus just for keeping compatibility,
> > >     and virtio-pmem is promising way?
> > > 
> > >     
> > > Q2) What bus is(will be?) created for virtio-pmem?
> > >     I could confirm the bus of NFIT is created with <memory
> > >     model='nvdimm'>,
> 
>         For virtio-pmem also its nvdimm bus.
> 
> > >     and I heard other bus will be created for virtio-pmem, but I could not
> > >     find what bus is created concretely.
> > >     ---
> > >       # ndctl list -B
> > >       {
> > >          "provider":"ACPI.NFIT",
> > >          "dev":"ndbus0"
> > >       }
> > >     ---
> > >    
> > >     I think it affects what operations user will be able to, and what
> > >     notification is necessary for vNVDIMM.
> > >     ACPI defines some operations like namespace controll, and notification
> > >     for NVDIMM health status or others.
> > >     (I suppose that other status notification might be necessary for
> > >     vNVDIMM,
> > >      but I'm not sure yet...)
> 
>          For virtio-pmem, we are not providing advance features like namespace and various
>          other features which ACPI/NVDIMM hardware provides. This is just to keep paravirt
>          device simple.

Hmm, I see.
Thank you for your explanation.

Bye.
---
Yasunori Goto


> 
>          Moreover I have not yet looked at ndctl side of things. I am not 100% sure how
>          ndctl will handle 'virtio-pmem'.
> 
>         Adding 'Dan' in loop, he can add his thoughts.
> 
> Thanks,
> Pankaj
> 
