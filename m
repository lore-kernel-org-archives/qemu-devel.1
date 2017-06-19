Received: from eggs.gnu.org ([2001:4830:134:3::10]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMvyd-0005so-Nc
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMvyY-0006Yr-Qo
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:40:19 -0400
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
	<20170616155312.623f859e@nial.brq.redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <7285021b-79e7-0820-a006-24062b85a2b8@redhat.com>
Date: Mon, 19 Jun 2017 15:40:05 +0300
MIME-Version: 1.0
In-Reply-To: <20170616155312.623f859e@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 16/06/2017 16:53, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 19:27:12 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
>> Quoting Igor Mammedov (2017-06-14 04:00:01)
>>> On Tue, 13 Jun 2017 16:42:45 -0500
>>> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>>>    
>>>> Quoting Igor Mammedov (2017-06-09 03:27:33)

[...]

>> But that raises a 2nd point. Our dilemma isn't that we can't
>> rely on dev->hotplugged being synchronized (though if it
>> was we could build something around that), our dilemma is
>> that we make the following assumption in our code:
>>
>> "Devices present at start-time will be handled the same way,
>> on source or dest, regardless of whether they were added via
>> cmdline or via device_add prior to machine start / migration
>> stream processing."
>>
>> And I think that's a sensible expectation, since in theory
>> even the source could build up a machine via device_add
>> prior to starting it, and the reasonable default there is
>> dev->hotplugged = false rather than the opposite. That
>> suggests a need to fix things outside of migration.
> Agreed to a degree, i.e.
> 
>    -device/device_add before machine has been started
> without migration should follow coldplug path
> 
> it shouldn't cause problems for CPU/mem hotplug on x86
> and maybe will work for PCI (it may change behavior of
> ACPI based hotplug and bridges),
> CCing Marcel to confirm.
> 

As long as machine_done is not triggered and the dev->hotplugged
is not set I suppose it will work for PCI.

But why allow device_add before the machine is running?
I don't see the benefits for it. I did see in the mail thread
that libvirt may build the machine using device_add, but
again, what is the gain? What you can do before the machine is running
do it at command line.

I would also not allow hot-plugging once migration is started
and delay migration until we finish all hot-plugging operations (not 
directly related to this thread).


Thanks,
Marcel


> 


[...]
