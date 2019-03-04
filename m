Received: from eggs.gnu.org ([209.51.188.92]:43418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h0oCe-0003c7-Pf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h0oCa-0004qB-Fa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:04:22 -0500
Received: from greensocs.com ([193.104.36.180]:39433)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h0oCY-0004dz-Er
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:04:20 -0500
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <39fbf4a3-d6eb-9623-ed11-ceb21e8305c7@greensocs.com>
Date: Mon, 4 Mar 2019 15:04:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>



On 3/1/19 5:52 PM, Peter Maydell wrote:
> On Fri, 1 Mar 2019 at 15:34, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> On 3/1/19 12:43 PM, Peter Maydell wrote:
>>> On Mon, 25 Feb 2019 at 10:49, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>>> I had more thought about the reset problem and what we want to achieve
>>>> (add power gating and clock support).
>>>> Feel free to comment. I'll start to implement this and send a first
>>>> version with a reroll of everything when it's ready.
>>>
>>> I generally like this; I have some comments below.
>>>
>>>> # PROPOSAL OVERVIEW
>>>>
>>>> I propose to add a Resetable interface and a ResetDomain object.
>>>>
>>>> Having an interface simplify things since there is several reset entry
>>>> points (at least Buses and Devices).
>>>> Device and Bus objects will implement this interface.
>>>>
>>>> The ResetDomain will hold several Resetable objects and implement the
>>>> interface too. The ResetDomain is needed to have at least a global/main
>>>> ResetDomain to place buses and devices to replace the current
>>>> qemu_register_reset system which only allow to register a function.
>>>
>>> How does the ResetDomain fit in for a typical case where
>>> we have an SoC container object with a handful of devices
>>> (which are children of the container object)? Does the
>>> SoC container object just directly implement the Resettable
>>> interface and handle the propagation as ResetDomain would?
>>> Does the SoC container create one or more ResetDomains and
>>> add its child devices to them (if so, with what API)?
>>
>> By SoC container, I suppose you mean a Machine object.
> 
> No, I mean something like the TYPE_NRF51_SOC device.
> This isn't a machine, it's a device that represents an SoC,
> and which is pretty much just a container that wires up
> all the devices that an SoC has. The Machine represents
> an entire board, and usually will create an SoC, some memory
> and perhaps a few other devices.
> 
>> Right now, I only have 2 functions reset_domain_[un]register_object to
>> add/remove an object in a reset domain (which is just a list of Resettable).
> 
> OK, so whether devices are in a reset domain object
> is distinct from what object they are QOM children of ?

Yes, it is a totally independent pool of objects.

Regarding device composition, such as in the soc container you mention,
we can choose to handle it in the base class (TYPE_DEVICE or
TYPE_SYSBUS_DEVICE) by walking the children and look for Resettable
objects. But this would change the current reset way of doing things
which requires composed device to explicitly reset sub-devices.

I choose to implicitly use device/bus hierarchy to propagate reset but
it is maybe a bad idea. We can instead use qom parent/child relationship
and make some explicit bus-level reset domains (right now it is explicit
through the qdev/bus_reset_all). What do you think is best ?

Thanks,
Damien
