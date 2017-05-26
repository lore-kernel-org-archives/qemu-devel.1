Received: from eggs.gnu.org ([2001:4830:134:3::10]:59572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEGE6-0000hp-Uj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEGE6-0005K2-0z
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:28:26 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:35299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dEGE5-0005Hi-RV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:28:25 -0400
Received: by mail-oi0-x22f.google.com with SMTP id l18so14611189oig.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:28:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170526043024.zk4msmkcuihb4f4t@hz-desktop>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<CAPcyv4gp1CBFA+MMXSjxw1b3nSeHCYkMN1daMP2+r4DpfPmMug@mail.gmail.com>
	<20170526043024.zk4msmkcuihb4f4t@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 May 2017 07:28:24 -0700
Message-ID: <CAPcyv4i9yz+CyYeegRN5_zavG15qE2Wf0a--FF2z9hVg5CqWLA@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, May 25, 2017 at 9:30 PM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> On 05/25/17 20:34 -0700, Dan Williams wrote:
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
>>
>
> I understand your worry and am not object to your suggestion, but
> forbidden will change the existing behavior that allows such unsafe
> usage. Let's wait for other maintainers' comments.

Changing existing behavior is the point. Even if a qemu maintainer
thought it was acceptable to allow the dangerous behavior with a
warning I would continue to assert that we need to block it by
default. I'm not opposed to adding a new configuration option like
"allow dangerous pmem" to override the new default behavior, but I
think this patch is incorrect to just emit a message.
