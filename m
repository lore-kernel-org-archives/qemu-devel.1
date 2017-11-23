Received: from eggs.gnu.org ([2001:4830:134:3::10]:36616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHuMM-0003oK-Cs
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHuMI-00046n-SH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHuMI-00044I-Lh
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:28:14 -0500
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
	<CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
	<1501112787.4073.49.camel@redhat.com>
	<CAPcyv4gbC6Hx_4YsCfOd2t=fn=wPGp5h__1QH=-p40TPFNbFzA@mail.gmail.com>
	<0a26793f-86f7-29e7-f61b-dc4c1ef08c8e@gmail.com>
	<CAPcyv4iw2cCpDmr+4kxsFvdy+iGZiz=ok-kLhsDKpqDy+szf-Q@mail.gmail.com>
	<378b10f3-b32f-84f5-2bbc-50c2ec5bcdd4@gmail.com>
	<CAPcyv4jR_LdbsX-rAsHC7++C6d-WYC084uWXzr+08PSYwoXFMw@mail.gmail.com>
	<ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
	<CAPcyv4gKzvd39WbnKjbs3Bn9+o1tt=vz90CYMFu0DF5PsfHUig@mail.gmail.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
Date: Thu, 23 Nov 2017 17:28:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On 23/11/2017 17:14, Dan Williams wrote:
> On Wed, Nov 22, 2017 at 8:05 PM, Xiao Guangrong
> <xiaoguangrong.eric@gmail.com> wrote:
>>
>>
>> On 11/22/2017 02:19 AM, Rik van Riel wrote:
>>
>>> We can go with the "best" interface for what
>>> could be a relatively slow flush (fsync on a
>>> file on ssd/disk on the host), which requires
>>> that the flushing task wait on completion
>>> asynchronously.
>>
>>
>> I'd like to clarify the interface of "wait on completion
>> asynchronously" and KVM async page fault a bit more.
>>
>> Current design of async-page-fault only works on RAM rather
>> than MMIO, i.e, if the page fault caused by accessing the
>> device memory of a emulated device, it needs to go to
>> userspace (QEMU) which emulates the operation in vCPU's
>> thread.
>>
>> As i mentioned before the memory region used for vNVDIMM
>> flush interface should be MMIO and consider its support
>> on other hypervisors, so we do better push this async
>> mechanism into the flush interface design itself rather
>> than depends on kvm async-page-fault.
> 
> I would expect this interface to be virtio-ring based to queue flush
> requests asynchronously to the host.

Could we reuse the virtio-blk device, only with a different device id?

Thanks,

Paolo
