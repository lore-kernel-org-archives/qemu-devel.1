Received: from eggs.gnu.org ([2001:4830:134:3::10]:48377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f8Cyq-0001uZ-Ez
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f8Cyn-0002iN-Cf
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:52:12 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:34152
	helo=godking.net) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f8Cyn-0002dg-3T
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:52:09 -0400
References: <1523698174-22832-1-git-send-email-agk@godking.net>
	<20180416082944.fkgqs5htp2rr3yi5@sirius.home.kraxel.org>
From: Alexander Kappner <agk@godking.net>
Message-ID: <b751dfad-7548-63f1-4f79-7b068a5952aa@godking.net>
Date: Mon, 16 Apr 2018 15:52:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180416082944.fkgqs5htp2rr3yi5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qapi: [PATCH v2] Implement query-usbhost QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org

Hi Gerd,

thanks for reviewing. I'll follow up with a v3 of the patch addressing your proposed changes.

>> This allows a QMP client to query which USB devices may be available
>> for redirection.

> At least libvirt sandboxes qemu, for security reasons, and you wouldn't
> get any useful results because qemu hasn't the permissions needed to
> scan the usb bus.
Then at least this tells you that you can't make anything available via redirection either, which is also useful information.

> I'm wondering what the use case is?
I'm working on a smartphone client that talks to a QEMU instance via QMP, and that allows the user to switch USB devices between host and QEMU guest. This removes the need for a separate set of input devices permanently assigned to the host (since if I pass through a keyboard/mouse to the VM, I can't use that same keyboard/mouse to run a command that re-attaches those devices to the host, so I need some external channel). Basically using the phone as a KVM switch.

Best
Alexander

On 04/16/2018 01:29 AM, Gerd Hoffmann wrote:
> On Sat, Apr 14, 2018 at 02:29:34AM -0700, Alexander Kappner wrote:
>> Implement a QMP command similar to the HMP's "info usbhost" command.
> 
> The hmp version of the command should be switched over to call the
> qmp_query_usbhost() and pretty-print the qapi struct then, to make
> sure hmp and qmp versions of the command deliver consistent results.
> 
>> This allows a QMP client to query which USB devices may be available
>> for redirection.
> 
> I'm wondering what the use case is?
> 
> At least libvirt sandboxes qemu, for security reasons, and you wouldn't
> get any useful results because qemu hasn't the permissions needed to
> scan the usb bus.
> 
>>  ##
>> +# @query-usbhost:
>> +#
>> +# Returns information about USB devices available on the host
>> +#
>> +# Returns: a [UsbDeviceInfo]. Returns an error if compiled without
>> +# CONFIG_USB_LIBUSB
>> +#
>> +# Since: TODO (maintainer insert version number if mainlined)
> 
> Will not make it into 2.12, so 2.13.
> 
>> +# @UsbDeviceInfo:
>> +#
>> +# @speed: the speed
> 
> Use an enum for this?
> 
>> +# @id_vendor: idVendor field from device descriptor
>> +#
>> +# @id_product: idProduct field from device descriptor
>> +#
>> +# @str_product: string descriptor referenced by iProduct index, if any
>> +#
>> +# @str_manufacturer: string descriptor referenced by iManufacturer index, if any
>> +#
>> +# @dev_addr: address on bus that device is connected to
>> +#
>> +# @bus_num: bus number device is connected to
> 
> No port?
> 
> cheers,
>   Gerd
> 
