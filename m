Received: from eggs.gnu.org ([2001:4830:134:3::10]:44958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cGO9I-0006kP-OQ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cGO9F-0000JL-8Q
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:48:00 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cGO9F-0000DT-2e
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:47:57 -0500
Received: by mail-oi0-f46.google.com with SMTP id v84so83203289oie.3
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 02:47:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161208195955.GG2054@work-vm>
References: <CAC2QTZa8paD4kaY+fWqwWiAu9NKsCTZr9-=Ldn78HPHAUE1ZSA@mail.gmail.com>
	<20161208195955.GG2054@work-vm>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 12 Dec 2016 16:16:34 +0530
Message-ID: <CAC2QTZZptvs8Fk+jnL4FvPuD3p-5SXO0V2BWEozpQKhpVSVZwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] migration: Introduce a new "--only-migratable"
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Dec 9, 2016 at 1:29 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>> Hi Dave,
>>
>> I have added the compatibility of this option for both command line
>> and hotplug via qmp and hmp. Although, please confirm that making use
>> of "device_add" is the only way of hotplugging devices into a QEMU
>> instance.
>
> Hmm; there's obsolete commands like usb_add and netdev_add as well.

Great news is I was finally able to retrieve the DeviceClass of the
device by following the steps just like you advised. So "-usbdevice"
option is now successfully handled and "usb_add" in turn goes through
the same path as well.

Regarding netdev_add, I checked that it only supports those devices
which are all migratable and as you mentioned it has been obsolete now
which means no more devices will be added in the future for this one.
So I believe there might not be a requirement to add compatibility
here.

>
>> With this sorted out, there is one special case left where the device
>> dynamically declares itself 'unmigratable' via migrate_add_blocker. I
>> have a query regarding that which is, what is the preferred action in
>> this scenario? Should I unmount the device or restrict the device from
>> becoming unmigratable in the first place.
>> For example, restrict 9pfs from mounting the filesystem (which you
>> explained previously).
>>
>> Or is there a completely different solution in your mind?
>
> My preferred solution is to stop the device getting into the unmigratable
> state; so whatever function tries to set it should fail (nicely) and
> give an error - e.g the 9pfs should refuse to mount.  I'm not sure
> how hard that is.
>

Alright. I think with the new work posted by John on the list, this
should now be really easy.
I think I can just check if the "--only-migratable" option was used
inside the newly designed "migrate_add_blocker" function by John and
return an error if this is the case. Also your concern about all of it
failing "nicely" will already be handled by John's new work. Although,
I think the error message might change in this case?

Ashijeet

> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
