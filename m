Received: from eggs.gnu.org ([209.51.188.92]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvtcr-0000wu-Ve
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvtcq-00062d-Qz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:51:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:57377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gvtcq-00061X-I3
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:51:08 -0500
Date: Tue, 19 Feb 2019 08:50:42 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190219005042.GA14362@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190218011333.13976-1-richardw.yang@linux.intel.com>
	<20190218105034.167293f4@Igors-MacBook-Pro.local>
	<20190218121324.utxt2zojfjia4pjl@master>
	<20190218135602.11a98964@Igors-MacBook-Pro.local>
	<20190218132129.pcb4jl63om3f37ew@master>
	<20190218145336.2fa8b5d0@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218145336.2fa8b5d0@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH v2] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com

On Mon, Feb 18, 2019 at 02:53:36PM +0100, Igor Mammedov wrote:
>On Mon, 18 Feb 2019 13:21:29 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Mon, Feb 18, 2019 at 01:56:02PM +0100, Igor Mammedov wrote:
>> >On Mon, 18 Feb 2019 12:13:24 +0000
>> >Wei Yang <richard.weiyang@gmail.com> wrote:
>> >
>> >> On Mon, Feb 18, 2019 at 10:50:34AM +0100, Igor Mammedov wrote:
>> >> >On Mon, 18 Feb 2019 09:13:33 +0800
>> >> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >> >
>> >> >> Currently we do device realization like below:
>> >> >> 
>> >> >>    hotplug_handler_pre_plug()
>> >> >>    dc->realize()
>> >> >>    hotplug_handler_plug()
>> >> >> 
>> >> >> Before we do device realization and plug, we should allocate necessary
>> >> >> resources and check if memory-hotplug-support property is enabled.
>> >> >> 
>> >> >> At the piix4 and ich9, the acpi_memory_hotplug property is checked in
>> >> >                             ^^^^^^^ is field name and not a property so
>> >> >s/acpi_memory_hotplug/memory-hotplug-support/
>> >> >s/in/at/
>> >> >
>> >> >> plug stage. This means that device has been realized and mapped into
>> >> >> guest address space 'pc_dimm_plug()' by the time acpi plug handler is
>> >> >> called, where it might fail and crash QEMU due to reaching
>> >> >> g_assert_not_reached() (piix4) or error_abort (ich9).
>> >> >
>> >> >
>> >> >> This patch abstract the check on acpi_memory_hotplug capacity in
>> >> >> pre_plug stage.
>> >> >maybe better would be:
>> >> >"Fix it by checking if memory hotplug is enabled at pre_plug stage
>> >> >where we can gracefully abort hotplug request."
>> >> >
>> >> >> [changelog rephrase from imammedo@redhat.com]
>> >> >this provides zero information for a commit reader,
>> >> >it should go under --- to chagelog
>> >> > 
>> >> 
>> >> Ok, maybe different community has different convention.
>> >> 
>> >> Linux kernel mm subsystem maintainer suggest me to add above line.
>> >> 
>> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> >> CC: Igor Mammedov <imammedo@redhat.com>
>> >> >> CC: Eric Blake <eblake@redhat.com>
>> >> >> 
>> >> >> ---
>> >> >> v2:
>> >> >>    * rephrase change log
>> >> >one usually adds commenter's name here
>> >> >   * like this (someone@foo.bar)
>> >> >or
>> >> >   * (someone@foo.bar)
>> >> >     - entry 1
>> >> >     - entry 2
>> >> >   * (someone-else@foo.bar)
>> >> >     - ...
>> >> >
>> >> 
>> >> Well, I would change to this style.
>> >> 
>> >> >>    * apply this change to ich9
>> >> >>    * use hotplug_handler_pre_plug() instead of open-coding check
>> >> >> ---
>> >> >>  hw/acpi/ich9.c         | 14 ++++++++++++--
>> >> >>  hw/acpi/piix4.c        | 14 ++++++++++++--
>> >> >>  hw/i386/pc.c           |  5 +++++
>> >> >>  hw/isa/lpc_ich9.c      |  1 +
>> >> >>  include/hw/acpi/ich9.h |  2 ++
>> >> >>  5 files changed, 32 insertions(+), 4 deletions(-)
>> >> >> 
>> >> >> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>> >> >> index c5d8646abc..906a10f09a 100644
>> >> >> --- a/hw/acpi/ich9.c
>> >> >> +++ b/hw/acpi/ich9.c
>> >> >> @@ -483,13 +483,23 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>> >> >>                               NULL);
>> >> >>  }
>> >> >>  
>> >> >> +void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>> >> >> +                            Error **errp)
>> >> >broken alignment?
>> >> >
>> >> >run /scripts/checkpatch.pl on patches before submitting them
>> >> 
>> >> I copied this from ich9_pm_device_plug_cb(), so thought this is the
>> >> correct style.
>> >> 
>> >> Will adjust this according to checkpatch.pl.
>> >
>> >see CODING_STYLE
>> >
>> 
>> Went throught this file, but not find the description of function
>> definition's second line.
>A patch fixing CODING_STYLE that is welcome
>

Hmm... writing document seems more difficult than writing code to me :-)

Let me have a try to see if my English is not that bad.

-- 
Wei Yang
Help you, Help me
