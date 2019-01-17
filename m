Received: from eggs.gnu.org ([209.51.188.92]:55751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gjwLS-0002c0-42
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 20:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gjwLQ-0001iK-3V
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 20:19:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:31158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gjwLP-0008S0-R6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 20:19:44 -0500
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
	<1547468699-17633-3-git-send-email-like.xu@linux.intel.com>
	<20190114205134.GB16013@habkost.net>
	<20190116182606.GH20275@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <b2ec9b01-2b16-5822-9e6f-9d1c4dd1cd64@linux.intel.com>
Date: Thu, 17 Jan 2019 09:18:29 +0800
MIME-Version: 1.0
In-Reply-To: <20190116182606.GH20275@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] vl.c: add -smp,
 dies=* command line support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: drjones@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2019/1/17 2:26, Daniel P. Berrangé wrote:
> On Mon, Jan 14, 2019 at 06:51:34PM -0200, Eduardo Habkost wrote:
>> On Mon, Jan 14, 2019 at 08:24:56PM +0800, Like Xu wrote:
>>> This patch updates the check rules on legeacy -smp parse from user command
>>> and it's designed to obey the same restrictions as socket/core/thread model.
>>>
>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>
>> This would require the documentation for -smp to be updated.
>> qemu-options.hx still says that "cores=" is the number of cores
>> per socket.
>>
>> Also, I'm not completely sure we should change the meaning of
>> "cores=" and smp_cores to be per-die instead of per-socket.  Most
>> machines won't have any code for tracking dies, so we probably
>> shouldn't make the extra complexity affect all machines.[1]
> 
> Could we not simply have a 'max-dies' property against the machine
> base class which defaults to 1. Then no existing machine types
> need any changes unless they want to opt-in to supporting
> "dies > 1".
It's nice to have max-dies for machine base class.
> 
>> What would be the disadvantages of a simple -machine
>> "dies-per-socket" option, specific for PC?
> 
> Libvirt currently has
> 
>    <cpu>
>       <topology sockets='1' cores='2' threads='1'/>
>    </cpu>
> 
> To me the natural way to expand that is to use
> 
>    <cpu>
>       <topology sockets='1' dies='2' cores='2' threads='1'/>
>    </cpu>
> 
> but this rather implies dies-per-socket + cores-per-die
> not cores-per-socket.  Libvirt could of course convert
> its value from  cores-per-die into cores-per-socket
> before giving it to QEMU, albeit with the potential
> for confusion from people comparing the libvirt and QEMU
> level configs
It is a recommended update on cpu topo configuration of libvirt
as well as other upper layer apps.
> 
>> Keeping core-id and smp_cores per-socket instead of per-die also
>> seems necessary to keep backwards compatibility on the interface
>> for identifying CPU hotplug slots.  Igor, what do you think?
> 
> Is there really a backwards compatibility problem, given that
> no existing mgmt app will have created a VM with "dies != 1".
> IOW, if an application adds logic to support configuring a
> VM with "dies > 1" it seems fine that they should need to
> understand how this impacts the way you identify CPUs for
> hotplug.
The impacts from MCP model will be documented continuously.
Any concerns for hot-plugging CPUs in MCP socket is welcomed.
> 
>> [1] I would even argue that the rest of the -smp options belong
>>      to the machine object, and topology rules should be
>>      machine-specific, but cleaning this up will require
>>      additional work.
> 
> If we ever expect to support non-homogenous CPUs then our
> modelling of topology is fatally flawed, as it doesm't allow
> us to specify  creating a VM with  1 socket containing 2
> cores and a second socket containing 4 cores. Fixing that
> might require modelling each socket, die, and core as a
> distinct set of nested QOM objects which gets real fun.
Do we really need to go out of this non-homogeneous step？
Currently there is no support on physical host AFAIK.
Is there enough benefit?
> 
> 
> Regards,
> Daniel
> 
