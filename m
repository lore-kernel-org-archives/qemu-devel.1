Received: from eggs.gnu.org ([2001:4830:134:3::10]:46307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEH7D-00033h-H9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEH7C-0001XO-Cx
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:25:23 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dEH7C-0001X9-6F
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:25:22 -0400
Received: by mail-oi0-x22e.google.com with SMTP id l18so16691329oig.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:25:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170526143843.GL24484@redhat.com>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<CAPcyv4gp1CBFA+MMXSjxw1b3nSeHCYkMN1daMP2+r4DpfPmMug@mail.gmail.com>
	<20170526143843.GL24484@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 May 2017 08:25:20 -0700
Message-ID: <CAPcyv4g-=VytzHCw8QzSq5yNW-PLPz0MNzT=vDqxTmEuF_DWHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH 1/2] nvdimm: warn if the backend is
 not a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, May 26, 2017 at 7:38 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, May 25, 2017 at 08:34:23PM -0700, Dan Williams wrote:
>> On Thu, May 25, 2017 at 7:32 PM, Haozhong Zhang
>> <haozhong.zhang@intel.com> wrote:
>> > Applications in Linux guest that use device-dax never trigger flush
>> > that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
>> > device-dax, QEMU cannot guarantee the persistence of guest writes.
>> > Before solving this flushing problem, QEMU should warn users if the
>> > host backend is not device-dax.
>>
>> I think this needs to be stronger than a "warn" it needs to be
>> explicitly forbidden when it is known to be unsafe.
>
> I think users should have the choice in what they want to do -
> QEMU should not artifically block it.  There are plenty of things
> in QEMU that are potentially unsafe in some usage scenarios, but
> we just document how to use them in a safe manner & any caveats
> that apply. Higher level applications above QEMU can then consider
> how they want to apply a usage policy to meet the needs of their
> usage scenario.
>
> Having an emulated DAX device that doesn't guarantee persistence
> is no different to having an emulated disk device that never flushes
> to underlying host storage.
>

It is different in the sense that the contract of when the guest
should assume persistence is specified by when the write completes to
the virtual disk. In the case of the virtual NFIT we are currently
lying to the guest about that platform persistence guarantee even if
the hypervisor is emulating pmem with volatile memory.

In other words, I agree that it should be possible to tell the guest
to assume it is pmem when it is not, but we need more granularity in
the configuration to communicate the capabilities correctly to the
guest. It seems the NFIT memory device state flag
ACPI_NFIT_MEM_NOT_ARMED is a good way to communicate pmem safety to
the guest. Can we add a new knob to control the polarity of that flag
and make ACPI_NFIT_MEM_NOT_ARMED being set the default case when using
regular file mmap and clear the flag by default in the device-dax
case?
