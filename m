Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dMwl6-0005H0-0d
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dMwl1-0004vm-KO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:30:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dMwl1-0004v4-BM
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:30:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5JDTAAU080832
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 09:30:17 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b6cks1r5x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 09:30:17 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 19 Jun 2017 10:30:14 -0300
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
	<20170616155312.623f859e@nial.brq.redhat.com>
	<7285021b-79e7-0820-a006-24062b85a2b8@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 10:30:05 -0300
MIME-Version: 1.0
In-Reply-To: <7285021b-79e7-0820-a006-24062b85a2b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7a83004a-5592-9865-7a09-4b5c941ac59d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: manage hotplugged
 devices while the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 06/19/2017 09:40 AM, Marcel Apfelbaum wrote:
> On 16/06/2017 16:53, Igor Mammedov wrote:
>> On Wed, 14 Jun 2017 19:27:12 -0500
>> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>>
>>> Quoting Igor Mammedov (2017-06-14 04:00:01)
>>>> On Tue, 13 Jun 2017 16:42:45 -0500
>>>> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>>>>> Quoting Igor Mammedov (2017-06-09 03:27:33)
>
> [...]
>
>>> But that raises a 2nd point. Our dilemma isn't that we can't
>>> rely on dev->hotplugged being synchronized (though if it
>>> was we could build something around that), our dilemma is
>>> that we make the following assumption in our code:
>>>
>>> "Devices present at start-time will be handled the same way,
>>> on source or dest, regardless of whether they were added via
>>> cmdline or via device_add prior to machine start / migration
>>> stream processing."
>>>
>>> And I think that's a sensible expectation, since in theory
>>> even the source could build up a machine via device_add
>>> prior to starting it, and the reasonable default there is
>>> dev->hotplugged = false rather than the opposite. That
>>> suggests a need to fix things outside of migration.
>> Agreed to a degree, i.e.
>>
>>    -device/device_add before machine has been started
>> without migration should follow coldplug path
>>
>> it shouldn't cause problems for CPU/mem hotplug on x86
>> and maybe will work for PCI (it may change behavior of
>> ACPI based hotplug and bridges),
>> CCing Marcel to confirm.
>>
>
> As long as machine_done is not triggered and the dev->hotplugged
> is not set I suppose it will work for PCI.
>
> But why allow device_add before the machine is running?
> I don't see the benefits for it. I did see in the mail thread
> that libvirt may build the machine using device_add, but
> again, what is the gain? What you can do before the machine is running
> do it at command line.

This takes us back to an older discussion about this subject. If I 
recall correctly
the only reason we're allowing this is because Libvirt does it. At that 
time there
where no mentions of any other use case or benefits from allowing it in PPC.

I haven't had the time to check it but if Libvirt can get away with 
device_add
before the machine is running in x86 (or any other arch for instance) 
then supporting
this scenario in PPC makes management happier, avoiding more arch specific
code from their side to handle migration and hotplugs.

A discussion that might be worth having is why support device_add/del 
operations
before the machine is started in any architecture at all, not just 
pseries. Not sure
if this is the right moment/thread for that though.


Thanks,

Daniel


>
> I would also not allow hot-plugging once migration is started
> and delay migration until we finish all hot-plugging operations (not 
> directly related to this thread).
>
>
> Thanks,
> Marcel
>
>
>>
>
>
> [...]
>
