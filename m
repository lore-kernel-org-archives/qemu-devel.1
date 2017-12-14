Received: from eggs.gnu.org ([2001:4830:134:3::10]:53692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTPc-0004rO-5t
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTPY-0000Sg-VM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:18:56 -0500
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTPY-0000RL-OH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:18:52 -0500
Received: by mail-qk0-x232.google.com with SMTP id 63so6146152qke.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 05:18:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
	<20171214090658.GA3731@dhcp-200-186.str.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b32e086-806f-1fc3-3415-358dd787543e@amsat.org>
Date: Thu, 14 Dec 2017 10:18:44 -0300
MIME-Version: 1.0
In-Reply-To: <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Kevin,

On 12/14/2017 06:06 AM, Kevin Wolf wrote:
> Am 14.12.2017 um 00:20 hat Philippe Mathieu-Daudé geschrieben:
>> Use Base64 to serialize the binary blobs in JSON.
>> So far at most 512 bytes will be transfered, which result
>> in a 684 bytes payload.
>> Since this command is intented for qtesting, this is acceptable.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Doing this kind of thing over QMP doesn't look right to me. qtests
> should access hardware the same way as real guests access the hardware
> (i.e. MMIO and I/O ports).

Yes, I agree with you, however this command does not implement a guest
access behavior (MMIO and I/O ports) but a _bus_ access.

Guests access buses via MMIO/IOP hardware frontend (bus master), bus
slave devices might be considered as backend, like the BlockBackend.

As the current iotests are meant for backend testing, this command is
meant for SDBus backend testing.

Actually with SDHCI I started to qtest the hardware frontend then
realized the backend was incorrect, so I had to go this way to fix it.
Later series do test the HCI using C qtests.

This approach should works for any buses, and start to be quite
interesting with:
- hot-plug buses to unplug/plug slaves
- multi-master buses like I2C to inject noise on the bus and see if the
host can recover/continue
- testing slave failures like a bricked SPI slave keeping some bus lines
held and checking if the HCI expose this failure to the guest (or the
guest checking the HCI for failures)

> But if for some reason the QMP maintainers were to think that this is
> acceptable in QMP, I'd argue it should at least get an x-debug- prefix
> to avoid making it a stable API that management tools may rely on.

I'd rather have the qtests using this command always run (if they take
too long they might be tagged as 'slow' tests), so I'd keep this stable.

Maybe we can prefix the qtests related QMP commands as "x-qtest-"? Else
your suggestion is fine.

Regards,

Phil.
