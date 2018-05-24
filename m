Received: from eggs.gnu.org ([2001:4830:134:3::10]:58434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fLquh-0008KL-Oy
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fLqub-0002Mg-Ft
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:08:19 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fLqub-0002Ly-8G
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:08:13 -0400
Received: by mail-ot0-x242.google.com with SMTP id 77-v6so2074668otd.4
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:08:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524161922.EC59.E1E9C6FF@jp.fujitsu.com>
References: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
	<CAPcyv4g3pMV54bYwOOeMiFbi2swi5v9RTrBh8-_mtGpoOiw5XQ@mail.gmail.com>
	<20180524161922.EC59.E1E9C6FF@jp.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 24 May 2018 07:08:10 -0700
Message-ID: <CAPcyv4h3RHymfKXxebBf+4DJs7vyJyhOVOuhDUJtchBnGOFrDw@mail.gmail.com>
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, NVDIMM-ML <linux-nvdimm@lists.01.org>

On Thu, May 24, 2018 at 12:19 AM, Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>> On Tue, May 22, 2018 at 10:08 PM, Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>> > Hello,
>> >
>> > I'm investigating status of vNVDIMM on qemu/KVM,
>> > and I have some questions about it. I'm glad if anyone answer them.
>> >
>> > In my understanding, qemu/KVM has a feature to show NFIT for guest,
>> > and it will be still updated about platform capability with this patch set.
>> > https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04756.html
>> >
>> > And libvirt also supports this feature with <memory model='nvdimm'>
>> > https://libvirt.org/formatdomain.html#elementsMemory
>> >
>> >
>> > However, virtio-pmem is developing now, and it is better
>> > for archtectures to detect regions of NVDIMM without ACPI (like s390x)
>>
>> I think you are confusing virtio-pmem (patches from Pankaj) and
>> virtio-mem (patches from David)? ...or I'm confused.
>
> Probably, "I" am confusing.
> So, your clarification is very helpful for me.
>
>
>>
>> > In addition, It is also necessary to flush guest contents on vNVDIMM
>> > who has a backend-file.
>>
>> virtio-pmem is a mechanism to use host page cache as pmem in a guest.
>> It does not support high performance memory applications because it
>> requires fsync/msync. I.e. it is not DAX it is the traditional mmap
>> I/O model, but moving page cache management to the host rather than
>> duplicating it in guests.
>
> Ah, ok.
>
>
>>
>> > Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem?
>> >     How do each roles become it if both NFIT and virtio-pmem will be available?
>> >     If my understanding is correct, both NFIT and virtio-pmem is used to
>> >     detect vNVDIMM regions, but only one seems to be necessary....
>>
>> We need both because they are different. Guest DAX should not be using
>> virtio-pmem.
>
> Hmm. Ok.
>
> But ,I would like understand one more thing.
> In the following mail, it seems that e820 bus will be used for fake DAX.
>
> https://lists.01.org/pipermail/linux-nvdimm/2018-January/013926.html
>
> Could you tell me what is relationship between "fake DAX" in this mail
> and Guest DAX?
> Why e820 is necessary for this case?
>

It was proposed as a starting template for writing a new nvdimm bus
driver. All we need is a way to communicate both the address range and
the flush interface. This could be done with a new SPA Range GUID with
the NFIT, or a custom virtio-pci device that registers a special
nvdimm region with this property. My preference is whichever approach
minimizes the code duplication, because the pmem driver should be
re-used as much as possible.
