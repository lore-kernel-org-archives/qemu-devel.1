Received: from eggs.gnu.org ([209.51.188.92]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hBn6w-00080N-BL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hBn6r-0008UH-VZ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:07:53 -0400
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <cd1b1889-7e03-6268-8d1e-f1ccfb388588@gmail.com>
Date: Wed, 3 Apr 2019 18:07:24 -0300
MIME-Version: 1.0
In-Reply-To: <20190402122807.1a141e37@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>, david@gibson.dropbear.id.au



On 4/2/19 7:28 AM, Greg Kurz wrote:
> On Mon, 1 Apr 2019 12:01:48 -0300
> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
>
>> Hi Greg,
>>
>> Thanks for your review. I added some comments below...
>>
>> On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
>>> On Thu, 28 Mar 2019 15:39:45 -0300
>>> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
>>>    
>>>> Hi,
>>>>
>>>> On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote:
>>>>> On Wed, 27 Mar 2019 17:41:00 -0300
>>>>> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
>>>>>      
>>>>>> Here are two patches to add a handler for ibm,get-vpd RTAS calls.
>>>>>> This RTAS exposes host information in case of set QEMU options
>>>>>> 'host-serial' and 'host-model' as 'passthrough'.
>>>>>>
>>>>>> The patch 1 creates helper functions to get valid 'host-serial'
>>>>>> and 'host-model' parameters, guided by QEMU command line. These
>>>>>> parameters are useful to build the guest device tree and to return
>>>>>> get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
>>>>>>
>>>>>> Update v7:
>>>>>> * rtas_get_vpd_fields as a static array in spapr machine state
>>>>>>
>>>>>> Maxiwell S. Garcia (2):
>>>>>>    spapr: helper functions to get valid host fields
>>>>>>    spapr-rtas: add ibm,get-vpd RTAS interface
>>>>>>
>>>>>>   hw/ppc/spapr.c         | 48 +++++++++++----------
>>>>>>   hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>   include/hw/ppc/spapr.h | 14 +++++-
>>>>>>   3 files changed, 135 insertions(+), 23 deletions(-)
>>>>>>      
>>>>> Hi Maxiwell,
>>>>>
>>>>> David sent a patch to rework how the host data is exposed to the guest.
>>>>> Especially, the special casing of the "none" and "passthrough" strings
>>>>> is no more... I'm afraid you'll have to rework your patches accordingly:
>>>>> code+changelog in patch 1 and at least changelog in patch 2.
>>>>>
>>>>> Cheers,
>>>> IIUC, the 'ibm,get-vpd' RTAS should return information about the
>>>> platform/cabinet. Thus, it's not necessary to add new nodes in the guest
>>>> device tree to export information like that.
>>> I agree that these "host-model" and "host-serial" props, which aren't
>>> described anywhere and not used by either the linux kernel or the
>>> powerpc-utils, look like a QEMU-specific poor man's version of VPD.
>>>
>>> Not quite sure why they were even created since this is the purpose
>>> of "system-id" and "model" as explained in PAPR, and supposedly
>>> exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
>>> page:
>>>
>>>         serial_number
>>>         The serial number of the physical system in which the partition resides
>>>
>>>         system_type
>>>         The  machine,type-model  of  the physical system in which the partition
>>>         resides
>>>
>>> This is indeed what we get in a PowerVM LPAR running on a tuleta system:
>>>
>>> [root@furax1 ~]# head -3 /proc/ppc64/lparcfg
>>> lparcfg 1.9
>>> serial_number=IBM,032116A9A
>>> system_type=IBM,8247-22L
>>>
>>> [root@furax1 ~]# echo $(cat /proc/device-tree/system-id)
>>> IBM,032116A9A
>>> [root@furax1 ~]# echo $(cat /proc/device-tree/model)
>>> IBM,8247-22L
>>>
>>> But QEMU generates a hard coded "IBM pSeries (emulated by qemu)" model,
>>> which is clearly not PAPR compliant according to this requirement:
>>>
>>> 	R1–12.2–13. There must be a property, “model”, under the root node
>>> 	in the format, “<vendor>,xxxx-yyy”, where <vendor> is replaced by
>>> 	one to five letters representing the stock symbol of the company
>>> 	(for example, for IBM: “IBM,xxxx-yyy”), and where xxxx-yyy is
>>> 	derived from the VPD TM field (see Table 160‚ “LoPAPR VPD Fields‚”
>>> 	on page 343) of the first or ‘marked’ processor enclosure.
>>>
>>> And worse, it mixes "vm,uuid" which is QEMU specific concept to uniquely
>>> identify guests, with "system-id" which is about the host :-\
>>>
>>> All of this is very confusing and need to be sorted out before building
>>> anything on top of it. Especially since "model" and "system-id" are
>>> supposed to derive from VPD IIUC.
>>>
>>> I guess that we should first decide what we really want to expose
>>> in "system-id" and "model": what we have now ? the same as in
>>> "host-serial" and "host-model", ie. user configurable ? Must we
>>> stay compatible with existing setups ? In any case, I'm afraid that
>>> we have to diverge from PAPR somehow, since it obviously doesn't
>>> care about the security concerns that motivated recent changes
>>> for "host-serial" and "host-model"...
>>>    
>> Many important changes should be done to solve these inconsistencies.
>> So, I saw in the 'get-vpd' RTAS a manner to return host information
>> and that works with live-migration.
>>
> Yes it does indeed allow that, among other things. My concern is more that
> PAPR clearly indicates that the "system-id" and "model" in the root node
> are derived from the VPD, and this series is about to tie the VPD TM and
> VPD SE keywords to something else that isn't documented in PAPR...
>
> The more I look at the "host-serial" and "host-model" properties, the more
> I have the impression that they serve the same purpose as "system-id" and
> "model" in PAPR (at least when peeking into the device tree of a PowerVM
> LPAR as shown somewhere ^^)... what about unifying these ? It would likely
> impact some guest software that use this to guess the platform type, like
> powerpc-utils for example:
>
> 		} else if (strstr(line, "IBM pSeries (emulated by qemu)")) {
> 			rc = PLATFORM_POWERKVM_GUEST;
> 			break;
> 		} else if (strstr(line, "pSeries")) {
>
> but this is fragile and should be improved anyway...
>
>>>    
>>>> Since it's a POWER specific
>>>> functionality, may 'ibm,get-vpd' export host information if the
>>>> guest instance allows it? Or is it better return only the 'host-serial'
>>>> and 'host-model' content, like in the patch "spapr: Simplify handling
>>>> of host-serial and host-model values"?
>>>>    
>>> I've spent some time reading PAPR on this topic and I'm not sure that
>>> "ibm,get-vpd" is the way to go for what you were trying to achieve
>>> initially (ie, obtain up-to-date host model and serial after migration).
>>>
>>> Have you looked at RTAS "ibm,update-properties" ?
>>> 	7.4.8 ibm,update-properties RTAS Call
>>>
>>> 	This RTAS call is used to report updates to the properties changed
>>> 	due to a massive platform reconfiguration such as when the partition
>>> 	is migrated between machines.
>>>
>>> This explicitly covers updates to "system-id" and "model". Maybe it is
>>> time to do as Ben was suggesting a long time ago when "host-serial"
>>> and "host-model" were introduced [1]:
>>>
>>> 	On Tue, 2014-07-08 at 12:49 +0200, Alexander Graf wrote:
>>> 	> Please be aware that all of the above is bogus when you start
>>> 	> thinking
>>> 	> about live migration.
>>>
>>> 	What's probably where we need to start thinking about implementing
>>> 	migration according to PAPR :-)
>>>
>>> 	IE. With pre and post-migration notifications to the guest including
>>> 	device-tree updates.
>>>
>>> 	Cheers,
>>> 	Ben.
>>>
>>> [1] https://patchwork.ozlabs.org/patch/367792/#813547
>>>
>>> Cheers,
>>>    
>> The 'ibm,update-properties' and 'ibm,update-nodes' RTAS report which DT
>> nodes was modified. So, to implement this approach, the QEMU should change
>> the DT nodes when the live-migration finish and some service in the guest
>> need to call these RTAS to discovery what nodes was changed. Is it the
>> right way?
>>
> If QEMU on the target is started with different "host-serial" and
> "host-model", the DT in QEMU already has the new value. No need to
> change anything. Appart from that, yes, QEMU should generate a PRRN
> event at post load to notify the guest, which in turns do the RTAS
> calls to get the updates.
>
>> Assuming that in new pseries machine won't be possible choose
>> 'passthrough' options to 'host-serial' and 'host-model' (last patch of
>> dgibson about this), it's necessary get the host information and set it
>> as string in these options. So, if we use the same qemu options in a
>> live-migration scenario for src and dst (libvirt do that), these
>> properties will remain the same. Is this behavior expected?
>>
> The recent fixes around "host-serial" and "host-model" simply moved
> the decision to expose host data to the upper layer, ie. libvirt
> which should be involved in this discussion.
>
> Cc'ing Andrea for expertise. Problem exposed below.
>
> The pseries machine used to expose the content of the host's
> /proc/device-tree/system-id and /proc/device-tree/model in the guest
> DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> types. Instead, two new properties where added to the pseries machine:
>
> pseries-4.0.host-serial=string (Host serial number to advertise in guest device tree)
> pseries-4.0.host-model=string (Host model to advertise in guest device tree)
>
> It is up to the caller to pass something... which may be anything,
> including something like $(cat /proc/device-tree/system-id) or
> randomly generated.
>
> Is there a chance libvirt can be taught to pass a different string
> to the target QEMU in case of migration ?


Isn't that just pushing up the same problem (in this case, CVE-2019-8934)
to Libvirt? By the CVE description [1], the problem is exactly the exposure
of /proc/device-tree/system-id and /proc/device-tree/model system attributes
in the guest. The only difference is that instead of QEMU doing it, Libvirt
wll end up doing it if anything meaninful (i.e. anything that can identify
the host) is passed in host-serial in the destination during a migration.

I am no security expert (and please correct me if I'm wrong), but in the 
end,
what this CVE is telling is "the guest shouldn't know any host details 
or anything
that can uniquely identify the host". This means that we can't populate 
these
attributes with meaninful host data (serial number, hostname, etc).

This kind of obliterates the point of Max patch - the idea is that the 
user wants
to be able do pinpoint, after migrating, which host is running the VM, by
checking host_serial. Perhaps we should just discourage this usage 
altogether
and show this CVE as proof. The user will need to go to the VM management
layer to discover where the guest is (which is the proper way of doing it,
anyway).


Thanks,


DHB


[1] https://access.redhat.com/security/cve/cve-2019-8934



>
>>> --
>>> Greg
>>>
>>>    
>>>>> --
>>>>> Greg
>>>>>      
>>>>    
>>>    
>>
>
