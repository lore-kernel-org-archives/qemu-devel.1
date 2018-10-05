Received: from eggs.gnu.org ([2001:4830:134:3::10]:54943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QUc-0005pB-QA
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QUX-00033j-0M
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:50:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QUW-000339-P7
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:50:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id a2-v6so6570006wrc.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:50:04 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
	<35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
	<CAFEAcA9vHi=qrV-Aj5ptgBQntafLGwL6VezxnmOuuR=6=Pr8cA@mail.gmail.com>
	<33c3ea72-652a-53b2-4865-830f3d7f2c3a@greensocs.com>
	<3d459f14-b701-02b6-d231-fc48c509640f@redhat.com>
	<20181004195225.GV5738@habkost.net>
	<CAFEAcA9tT5iFAo5DG=3dyBYNjBVN9u2qEK6Bo9Rf2MAPMBC6bg@mail.gmail.com>
	<20181004215352.GW5738@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4724ba3-4dbc-7b79-b520-96b69be1a73c@redhat.com>
Date: Fri, 5 Oct 2018 15:50:01 +0200
MIME-Version: 1.0
In-Reply-To: <20181004215352.GW5738@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and
 RPUs in separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Luc Michel <luc.michel@greensocs.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On 04/10/2018 23:53, Eduardo Habkost wrote:
> On Thu, Oct 04, 2018 at 09:01:09PM +0100, Peter Maydell wrote:
>> On 4 October 2018 at 20:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> Changing the object hierarchy based on GDB groups doesn't seem
>>> right, but I don't think it would be a big deal if we have the
>>> board code explicitly telling the GDB code how to group the CPUs.
>>>
>>> If you really want to do it implicitly, would it work if you
>>> simply group the CPUs based on object_get_canonical_path()?
>>>
>>> If a more explicit GDB grouping API is acceptable, what about
>>> just adding a INTERFACE_GDB_GROUP interface name to (existing)
>>> container objects that we expect to become GDB groups?
>>>
>>> I'm not sure which way is better. I'm a bit worried that making
>>> things too implicit could easily break (e.g. if somebody changes
>>> the CPU QOM hierarchy in the future for unrelated reasons).
>>
>> I don't want things implicit. I just don't want the explicitness
>> to be "this is all about GDB", because it isn't. I want us
>> to explicitly say "these 4 CPUs are in one cluster" (or
>> whatever term we use), because that affects more than merely GDB.
> 
> We already have a way to say "these 4 CPUs are in one cluster",
> don't we?  That's the QOM hierarchy.
> 
> My question is if "the CPUs are in one cluster" should implicitly
> mean "the CPUs are in one GDB group".
> 

What about having the container implement INTERFACE_CPU_CLUSTER?

Or even cleaner, add a TYPE_CPU_CLUSTER which is just a container for
TYPE_CPU[*]?
