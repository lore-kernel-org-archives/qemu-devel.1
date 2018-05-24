Received: from eggs.gnu.org ([2001:4830:134:3::10]:53110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fLkY2-0006x7-ER
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fLkXy-0002EM-Bf
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:20:30 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <y-goto@jp.fujitsu.com>)
	id 1fLkXx-00024D-KX
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:20:26 -0400
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id F33F8AC0191
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 16:20:17 +0900 (JST)
Date: Thu, 24 May 2018 16:19:27 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
In-Reply-To: <CAPcyv4g3pMV54bYwOOeMiFbi2swi5v9RTrBh8-_mtGpoOiw5XQ@mail.gmail.com>
References: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
	<CAPcyv4g3pMV54bYwOOeMiFbi2swi5v9RTrBh8-_mtGpoOiw5XQ@mail.gmail.com>
Message-Id: <20180524161922.EC59.E1E9C6FF@jp.fujitsu.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, NVDIMM-ML <linux-nvdimm@lists.01.org>

> On Tue, May 22, 2018 at 10:08 PM, Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> > Hello,
> >
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
> 
> I think you are confusing virtio-pmem (patches from Pankaj) and
> virtio-mem (patches from David)? ...or I'm confused.

Probably, "I" am confusing.
So, your clarification is very helpful for me.


> 
> > In addition, It is also necessary to flush guest contents on vNVDIMM
> > who has a backend-file.
> 
> virtio-pmem is a mechanism to use host page cache as pmem in a guest.
> It does not support high performance memory applications because it
> requires fsync/msync. I.e. it is not DAX it is the traditional mmap
> I/O model, but moving page cache management to the host rather than
> duplicating it in guests.

Ah, ok.


> 
> > Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem?
> >     How do each roles become it if both NFIT and virtio-pmem will be available?
> >     If my understanding is correct, both NFIT and virtio-pmem is used to
> >     detect vNVDIMM regions, but only one seems to be necessary....
> 
> We need both because they are different. Guest DAX should not be using
> virtio-pmem.

Hmm. Ok.

But ,I would like understand one more thing.
In the following mail, it seems that e820 bus will be used for fake DAX.

https://lists.01.org/pipermail/linux-nvdimm/2018-January/013926.html

Could you tell me what is relationship between "fake DAX" in this mail
and Guest DAX? 
Why e820 is necessary for this case?

(Probably, it may be one of the reason why I'm confusing....)


> 
> >     Otherwize, is the NFIT bus just for keeping compatibility,
> >     and virtio-pmem is promising way?
> >
> >
> > Q2) What bus is(will be?) created for virtio-pmem?
> >     I could confirm the bus of NFIT is created with <memory model='nvdimm'>,
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
> >     (I suppose that other status notification might be necessary for vNVDIMM,
> >      but I'm not sure yet...)
> >
> > If my understanding is wrong, please correct me.
> 
> The current plan, per my understanding, is a virtio-pmem SPA UUID
> added to the virtual NFIT so that the guest driver can load the pmem
> driver but also hook up the virtio command ring for forwarding
> WRITE_{FUA,FLUSH} commands as host fsync operations.

Ok.

Thank you very much for your answer!

---
Yasunori Goto
