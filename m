Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xf-00062z-RN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xb-0001yn-8y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:11 -0400
Received: from [59.151.112.132] (port=24777 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xa-0001vr-7X
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:07 -0400
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161238.366ce6a7@t450s.home> <58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home> <58E4B0C9.50109@cn.fujitsu.com>
	<20170405133822.76cda620@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58E60115.3000707@cn.fujitsu.com>
Date: Thu, 6 Apr 2017 16:49:25 +0800
MIME-Version: 1.0
In-Reply-To: <20170405133822.76cda620@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com



On 04/06/2017 03:38 AM, Alex Williamson wrote:
> On Wed, 5 Apr 2017 16:54:33 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> Sorry for late. Distracted by other problem for a while.
>>
>> On 03/31/2017 02:16 AM, Alex Williamson wrote:
>>> On Thu, 30 Mar 2017 21:00:35 +0300  
>>
>>>>>>>>       
>>>>>>>>>
>>>>>>>>> I also asked in my previous comments to provide examples of errors that
>>>>>>>>> might trigger correctable errors to the user, this comment seems to
>>>>>>>>> have been missed.  In my experience, AERs generated during device
>>>>>>>>> assignment are generally hardware faults or induced by bad guest
>>>>>>>>> drivers.  These are cases where a single fatal error is an appropriate
>>>>>>>>> and sufficient response.  We've scaled back this support to the point
>>>>>>>>> where we're only improving the situation of correctable errors and I'm
>>>>>>>>> not convinced this is worthwhile and we're not simply checking a box on
>>>>>>>>> an ill-conceived marketing requirements document.        
>>>>>>>>
>>>>>>>> Sorry. I noticed that question: "what actual errors do we expect
>>>>>>>> userspace to see as non-fatal errors?", but I am confused about it.
>>>>>>>> Correctable, non-fatal, fatal errors are clearly defined in PCIe spec,
>>>>>>>> and Uncorrectable Error Severity Register will tell which is fatal, and
>>>>>>>> which is non-fatal, this register is configurable, they are device
>>>>>>>> specific as I guess. AER core driver distinguish them by
>>>>>>>> pci_channel_io_normal/pci_channel_io_frozen,  So I don't understand your
>>>>>>>> question. Or
>>>>>>>>
>>>>>>>> Or, Do you mean we could list the default non-fatal error of
>>>>>>>> Uncorrectable Error Severity Register which is provided by PCIe spec?      
>>>>>>>
>>>>>>> I'm trying to ask why is this patch series useful.  It's clearly
>>>>>>> possible for us to signal non-fatal errors for a device to a guest, but
>>>>>>> why is it necessarily a good idea to do so?  What additional RAS
>>>>>>> feature is gained by this?  Can we give a single example of a real
>>>>>>> world scenario where a guest has been shutdown due to a non-fatal error
>>>>>>> that the guest driver would have handled?      
>>>>>>
>>>>>> We've been discussing AER for months if not years.
>>>>>> Isn't it a bit too late to ask whether AER recovery
>>>>>> by guests it useful at all?    
>>>>>
>>>>>
>>>>> Years, but I think that is more indicative of the persistence of the
>>>>> developers rather than growing acceptance on my part.  For the majority
>>>>> of that we were headed down the path of full AER support with the guest
>>>>> able to invoke bus resets.  It was a complicated solution, but it was
>>>>> more clear that it had some value.   Of course that's been derailed
>>>>> due to various issues and we're now on this partial implementation that
>>>>> only covers non-fatal errors that we assume the guest can recover from
>>>>> without providing it mechanisms to do bus resets.  Is there actual
>>>>> value to this or are we just trying to fill an AER checkbox on
>>>>> someone's marketing sheet?  I don't think it's too much to ask for a
>>>>> commit log to include evidence or discussion about how a feature is
>>>>> actually a benefit to implement.    
>>>>
>>>> Seems rather self evident but ok.  So something like
>>>>
>>>> With this patch, guest is able to recover from non-fatal correctable
>>>> errors - as opposed to stopping the guest with no ability to
>>>> recover which was the only option previously.
>>>>
>>>> Would this address your question?  
>>>
>>>
>>> No, that's just restating the theoretical usefulness of this.  Have you
>>> ever seen a non-fatal error?  Does it ever trigger?  If we can't
>>> provide a real world case of this being useful, can we at least discuss
>>> the types of things that might trigger a non-fatal error for which the
>>> guest could recover?  In patch 3/3 Cao Jin claimed we have a 50% chance
>>> of reducing VM stop conditions, but I suspect this is just a misuse of
>>> statistics, just because there are two choices, fatal vs non-fatal,
>>> does not make them equally likely.  Do we have any idea of the
>>> incidence rate of non-fatal errors?  Is it non-zero?  Thanks,
>>>   
>>
>> Apparently, I don't have experience to induce non-fatal error, device
>> error is more of a chance related with the environment(temperature,
>> humidity, etc) as I understand.
>>
>> After reading the discussion, can I construe that the old design with
>> full AER support is preferred than this new one?  The core issue of the
>> old design is that the second host link reset make the subsequent
>> guest's register reading fail, and I think this can be solved by test
>> the device's accessibility(read device' register, all F's means
>> unaccessible. IIRC, EEH of Power also use this way to test device's
>> accessiblity) and delay guest's reading if device is temporarily
>> unaccessible.
> 
> What is the actual AER handling requirement you're trying to solve?  Is
> it simply to check a box on a marketing spec sheet for anything related
> to AER with device assignment or is it to properly handle a specific
> class of errors which a user might actually see and thus provide some
> tangible RAS benefit?

The motion we implement this feature is neither from a marketing spec,
nor we have seen AER error occurs when using VM with pass-throughed PCIe
device.  It is a potential deficiency we find and think we could improve it.

-- 
Sincerely,
Cao jin

> Without even anecdotal incidence rates of
> non-fatal errors and no plan for later incorporating fatal error
> handling, this feels like we're just trying to implement anything to do
> with AER with no long term vision.
> 
> The previous intention of trying to handle all sorts of AER faults
> clearly had more value, though even there the implementation and
> configuration requirements restricted the practicality.  For instance
> is AER support actually useful to a customer if it requires all ports
> of a multifunction device assigned to the VM?  This seems more like a
> feature targeting whole system partitioning rather than general VM
> device assignment use cases.  Maybe that's ok, but it should be a clear
> design decision.
> 
> I think perhaps the specific issue of the device being in reset while
> the guest tries to access it is only a symptom of deeper problems.  Who
> owns resetting the bus on error?  My position was that we can't make
> the user solely responsible for that since we should never trust the
> user.  If the host handles the reset, then does that imply we have both
> host and guest triggered resets and how do we handle the device during
> the host reset.  It's not clear how we can necessarily correlate a
> guest reset to a specific host reset.  Would it make more sense to
> allow the host AER handling to release some control to the user with
> vfio doing cleanup at the end.  These are hard problems that need to be
> thought through.  I don't want to continue on a path of "can I just fix
> this one next thing and it will be ok?".  The entire previous design is
> suspect.  If you want to move this area forward, take ownership of it
> and propose a complete, end-to-end solution.  Thanks,
> 
> Alex
> 
> 
> .
> 
