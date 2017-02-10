Received: from eggs.gnu.org ([2001:4830:134:3::10]:43216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin@c-home.cz>) id 1cbyuC-00051s-BL
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin@c-home.cz>) id 1cbyu7-0005ez-Vf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:17:40 -0500
Received: from gw.c-home.cz ([89.24.150.100]:51229 helo=dmz.c-home.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <martin@c-home.cz>) id 1cbyu7-0005dM-Ci
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:17:35 -0500
Date: Fri, 10 Feb 2017 01:17:17 +0100 (CET)
From: Martin Cerveny <martin@c-home.cz>
Reply-To: Martin Cerveny <M.Cerveny@computer.org>
In-Reply-To: <alpine.GSO.2.00.1702031147000.5901@dmz.c-home.cz>
Message-ID: <alpine.GSO.2.00.1702100115320.15492@dmz.c-home.cz>
References: <1486104705-13761-1-git-send-email-kraxel@redhat.com>
	<alpine.GSO.2.00.1702031147000.5901@dmz.c-home.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] xhci: fix event queue IRQ handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hello.

Ok. Not more bugs. The problem was in qemu-xen-4.8 missing "usb-redir: allocate buffers before waking up the host adapter"

Martin

On Fri, 3 Feb 2017, Martin Cerveny wrote:

> Hello.
>
> Thanks for patch. I tested it.
>
> Good news, does not assert() :-)
> Bad news, not all works as expected (trace + pcap for usbredir attached), 
> maybe loosing some "interrupts".
>
> ------------------------------------------- EVENT description
> @1486115814.426976
> - guest (win7+renesas v2.1.39) boots ok (monitoring over RDP)
>
> @1486115984.087097
> - usbredir attach keyboard
> - guest start recognize device - "usb compound" and 3x "usb hid" but NOT HID 
> keyboard
>
> @14955@1486115985.022026
> - recognitions stops/hungs *** 1 ***
>
> - I try to "press" key but no activity on network "usbredir" channel or 
> "xhci" (10 minutes)
>
> @1486116641.063441
> - disconnect USB keyboard
>
> @1486116654.757221
> - reconnect USB keyboard
> - guest start recognize device - "usb compound" and 4x "usb hid" and HID 
> keyboard !
>
> @1486116786.752275 (frame 143-145 of pcap)
> - press + release key "enter"
> - BUT there is no corresponding activity in xhci driver (no trace) *** 2 ***
>
> @1486116990.347841
> - shutdown guest
> -------------------------------------------
>
> I see two problems/questions:
> *** 1 *** - Why recognition stopped ? Need some "hw" reset ? (no problem with 
> UHCI/EHCI emulation)
>            Sometimes (1:5) it attaches ok.
> *** 2 *** - Recognized successfully but does not work. Problem with INTR 
> transfers ?
>
> Mouse works with the same problems.
>
> I try attach USB-flash disk, all seems to work ok (read files, write files) 
> and 2x faster then UHCI/EHCI emulation (and probably reached limit of 
> RaspberryPI).
>
> Any hint to debug (maybe qemu/usbredir - usbredir/libusb bindings) ?
>
> Thanks, Martin Cerveny
>
> On Fri, 3 Feb 2017, Gerd Hoffmann wrote:
>
>> The qemu xhci emulation doesn't handle the ERDP_EHB flag correctly.
>> 
>> When the host adapter queues a new event the ERDP_EHB flag is set.  The
>> flag is cleared (via w1c) by the guest when it updates the ERDP (event
>> ring dequeue pointer) register to notify the host adapter which events
>> it has fetched.
>> 
>> An IRQ must raised in case the ERDP_EHB flag flips from clear to set.
>> If the flag is set already (which implies there are events queued up
>> which are not yet processed by the guest) xhci must *not* raise a IRQ.
>> 
>> Qemu got that wrong and raised an IRQ on every event, thereby generating
>> suspious interrupts in case we've queued events faster than the guest
>> processed them.  This patch fixes that.
>> 
>> With that change in place we also have to check ERDP updates, to see
>> whenever the guest has fetched all queued events.  In case there are
>> still pending events set ERDP_EHB and raise an IRQ again, to make sure
>> the events don't linger unseen forever.
>> 
>> The linux kernel driver and the microsoft windows driver (shipped with
>> win8+) can deal with the suspious interrupts without problems.  The
>> renesas windows driver (v2.1.39) which can be used on older windows
>> versions is quite upset though.  It does suspious ERDP updates now and
>> then (not every time, seems we must hit a race window for this to
>> happen), which in turn makes the qemu xhci emulation think the event
>> ring is full.  Things go south from here ...
>> 
>> tl;dr: This is the "fix xhci on win7" patch.
>> 
>> Cc: M.Cerveny@computer.org
>> Cc: 1373228@bugs.launchpad.net
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> hw/usb/hcd-xhci.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>> 
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index df75907..4f05747 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -789,11 +789,15 @@ static void xhci_msix_update(XHCIState *xhci, int v)
>> static void xhci_intr_raise(XHCIState *xhci, int v)
>> {
>>     PCIDevice *pci_dev = PCI_DEVICE(xhci);
>> +    bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
>>
>>     xhci->intr[v].erdp_low |= ERDP_EHB;
>>     xhci->intr[v].iman |= IMAN_IP;
>>     xhci->usbsts |= USBSTS_EINT;
>> 
>> +    if (pending) {
>> +        return;
>> +    }
>>     if (!(xhci->intr[v].iman & IMAN_IE)) {
>>         return;
>>     }
>> @@ -3352,6 +3356,15 @@ static void xhci_runtime_write(void *ptr, hwaddr 
>> reg,
>>             intr->erdp_low &= ~ERDP_EHB;
>>         }
>>         intr->erdp_low = (val & ~ERDP_EHB) | (intr->erdp_low & ERDP_EHB);
>> +        if (val & ERDP_EHB) {
>> +            dma_addr_t erdp = xhci_addr64(intr->erdp_low, 
>> intr->erdp_high);
>> +            unsigned int dp_idx = (erdp - intr->er_start) / TRB_SIZE;
>> +            if (erdp >= intr->er_start &&
>> +                erdp < (intr->er_start + TRB_SIZE * intr->er_size) &&
>> +                dp_idx != intr->er_ep_idx) {
>> +                xhci_intr_raise(xhci, v);
>> +            }
>> +        }
>>         break;
>>     case 0x1c: /* ERDP high */
>>         intr->erdp_high = val;
>> -- 
>> 1.8.3.1
>
