Received: from eggs.gnu.org ([2001:4830:134:3::10]:51411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fPkSO-0002wI-0z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fPkSJ-00023k-RG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fPkSJ-00023N-IX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:03:07 -0400
Date: Mon, 4 Jun 2018 04:03:06 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <120916025.39666078.1528099386072.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180601115429.GL8687@stefanha-x1.localdomain>
References: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
	<20180601115429.GL8687@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, NVDIMM-ML <linux-nvdimm@lists.01.org>, dan j williams <dan.j.williams@intel.com>

Hi,
 
> 
> > I'm investigating status of vNVDIMM on qemu/KVM,
> > and I have some questions about it. I'm glad if anyone answer them.
> > 
> > In my understanding, qemu/KVM has a feature to show NFIT for guest,
> > and it will be still updated about platform capability with this patch set.
> > https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04756.html
> > 
> > And libvirt also supports this feature with <memory model='nvdimm'>
> > https://libvirt.org/formatdomain.html#elementsMemory
> > 
> > 
> > However, virtio-pmem is developing now, and it is better
> > for archtectures to detect regions of NVDIMM without ACPI (like s390x)
> > In addition, It is also necessary to flush guest contents on vNVDIMM
> > who has a backend-file.
> > 
> > 
> > Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem?
        No.

> >     How do each roles become it if both NFIT and virtio-pmem will be
> >     available?

        There are two main use cases:

        1] DAX memory region pass-through to guest:
        -------------------------------------------
        As this region is present in actual physical NVDIMM device and exposed to guest,
        ACPI/NFIT way is used. If all the persistent memory is used by only this way we 
        don't need 'virtio-pmem'.

        2] Emulated DAX memory region in host passed to guest:
        --------------------------------------------------------
        If this type of region is exposed to guest, it will be preferable to use
        'virtio-pmem'. 

        This is regular host memory which is mmaped in guest address space for emulating 
        persistent memory. Guest writes are present in host page cache and not assured to be 
        written on backing disk without an explicit flush/sync call.
 
        'virtio-pmem' will solve the problem of flushing guest writes present in host page cache.
        With filesystems at host which use journal-ling like (ext4, xfs), they automatically call 
        'fsync' at regular intervals. but still there is not 100% assurance of all write persistence until
        an explicit flush is done from guest. So, we need an additional fsync to flush guest writes to 
        backing disk. We are using this approach to avoid using guest page cache and keep page cache management 
        of all the guests at host side.
        
        If both ACPI NFIT and virtio-pmem are present, both will have their corresponding memory regions and 
        defined by memory type "Persistent shared Memory" in case of virtio-pmem and "Persistent Memory" for 
        ACPI NVDIMM. This is to differentiate both the memory types.

> >     If my understanding is correct, both NFIT and virtio-pmem is used to
> >     detect vNVDIMM regions, but only one seems to be necessary....
> > 
> >     Otherwize, is the NFIT bus just for keeping compatibility,
> >     and virtio-pmem is promising way?
> > 
> >     
> > Q2) What bus is(will be?) created for virtio-pmem?
> >     I could confirm the bus of NFIT is created with <memory
> >     model='nvdimm'>,

        For virtio-pmem also its nvdimm bus.

> >     and I heard other bus will be created for virtio-pmem, but I could not
> >     find what bus is created concretely.
> >     ---
> >       # ndctl list -B
> >       {
> >          "provider":"ACPI.NFIT",
> >          "dev":"ndbus0"
> >       }
> >     ---
> >    
> >     I think it affects what operations user will be able to, and what
> >     notification is necessary for vNVDIMM.
> >     ACPI defines some operations like namespace controll, and notification
> >     for NVDIMM health status or others.
> >     (I suppose that other status notification might be necessary for
> >     vNVDIMM,
> >      but I'm not sure yet...)

         For virtio-pmem, we are not providing advance features like namespace and various
         other features which ACPI/NVDIMM hardware provides. This is just to keep paravirt
         device simple.

         Moreover I have not yet looked at ndctl side of things. I am not 100% sure how
         ndctl will handle 'virtio-pmem'.

        Adding 'Dan' in loop, he can add his thoughts.

Thanks,
Pankaj

> > 
> > If my understanding is wrong, please correct me.
> > 
> > Thanks,
> > ---
> > Yasunori Goto
> > 
> > 
> > 
> 
