Received: from eggs.gnu.org ([209.51.188.92]:55069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gjqVz-00069C-9M
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gjqVx-0001Jz-Ct
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:06:15 -0500
Received: from smtp52.i.mail.ru ([94.100.177.112]:59004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gjqVu-00016h-Nr
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:06:11 -0500
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
Date: Wed, 16 Jan 2019 22:05:58 +0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>

On 16.01.2019 0:51, Alistair Francis wrote:
> On Tue, Jan 15, 2019 at 7:04 AM Julia Suvorova via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
>>
>> If the memory is set using a file, and PC is specified on the command
>> line, it will be overwritten with the value 'entry'. This is not only
>> illogical, but also incorrect, because the load_ * functions do not take
>> into account the specifics of the ARM-M PC.
> 
> How does this come up?
> I see that the value of entry will force overwrite the PC addr, but
> doesn't force_raw fix that? Is there a common use case of loading an
> ELF/uimage but having to manually specify a start address?

generic_loader_reset() is called after arm_cpu_reset() and damages PC
(it is wrong to call arm_cpu_set_pc() with entry to set ARM PC reset
value). Therefore, I tried to configure PC manually and ran into this
problem.

By the way, I do not know the right way to fix the original issue. Try
to replace generic_loader_reset() with the device reset function or
change the reset order or transfer PC reset value setting to a separate
function and associate it with cpu. What do you think about it?

Best regards, Julia Suvorova.
