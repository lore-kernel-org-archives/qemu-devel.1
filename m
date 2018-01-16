Received: from eggs.gnu.org ([2001:4830:134:3::10]:51663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebErT-00040E-TZ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebErQ-0004mI-Nr
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:12:19 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebErQ-0004m8-JD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:12:16 -0500
Received: by mail-qk0-x244.google.com with SMTP id b76so18950437qkc.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:12:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<425e38f28bba536cfb1ae389ffa963984990f306.1515960078.git.pisa@cmp.felk.cvut.cz>
	<65ff7759-2e09-fba6-e60e-41e8d89d0e7c@amsat.org>
	<201801152229.53520.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
Date: Mon, 15 Jan 2018 21:12:09 -0300
MIME-Version: 1.0
In-Reply-To: <201801152229.53520.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 2/7] CAN bus support to connect bust to
 Linux host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 01/15/2018 06:29 PM, Pavel Pisa wrote:
> Hello Philippe,
> 
> thanks for review.
> 
> I have updated patch series in can-pci branch in
> 
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus
> 
> I would wait some day if there is some remark
> from other developers and socket ones especially.

I'll have a look.

> 
> On Monday 15 of January 2018 03:55:00 Philippe Mathieu-Daudé wrote:
>> Hi Pavel,
>>
>> I'm CC'ing the QEMU Sockets maintainer to ask them a quick review of the
>> socket part.
>>
>> On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
>>> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
>> Please move those checks out of the function, to call them once at build
>> time and not at runtime.
>>
>> /* Check that QEMU and Linux kernel flags encoding matches */
>> QEMU_BUILD_BUG_ON(QEMU_CAN_EFF_FLAG == CAN_EFF_FLAG);
>> QEMU_BUILD_BUG_ON(QEMU_CAN_RTR_FLAG == CAN_RTR_FLAG);
>> QEMU_BUILD_BUG_ON(QEMU_CAN_ERR_FLAG == CAN_ERR_FLAG);
>> QEMU_BUILD_BUG_ON(QEMU_CAN_INV_FILTER == CAN_INV_FILTER);
>> QEMU_BUILD_BUG_ON(offsetof(qemu_can_frame, data)
>>                   == offsetof(struct can_frame, data));
> 
> moved
> 
>>> +
>>> +    qemu_log_lock();
>>> +    qemu_log("[cansocketcan]: %03X [%01d] %s %s",
>>> +             msg->can_id & QEMU_CAN_EFF_MASK,
>>> +             msg->can_dlc,
>>> +             msg->can_id & QEMU_CAN_EFF_FLAG ? "EFF" : "SFF",
>>> +             msg->can_id & QEMU_CAN_RTR_FLAG ? "RTR" : "DAT");
>>> +
>>> +    for (i = 0; i < msg->can_dlc; i++) {
>>> +        qemu_log(" %02X", msg->data[i]);
>>> +    }
>>> +    qemu_log("\n");
>>
>> I'd rather use tracepoints, but since this is restricted by DEBUG_CAN
>> this doesn't bother the user console, so ok.
>>
>>> +    qemu_log_flush();
>>> +    qemu_log_unlock();
>>> +}
> 
> Trace events seems as nice feature. But simple text printf
> like output has been enough till now for CAN testing.
> There is no debugging output in production build.
> So I would add tracing infrastructure later if needed.

They are as useful as console printf, but less invasive and more
powerful: you can use a much precise timing, select which set of events
to display without having to recompile.
The default backend behaves as console printf.

You should try them :)

>>> +    /* open socket */
>>> +    s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>>
>> I never used it, but I think QEMU uses his socket API: "qemu/sockets.h"
> 
> The SocketCAN host connection code is Linux specific,
> but I can switch to qemu_socket() if it is preferred.
> But address family has to be from Linux header file anyway.

qemu_socket() sockets are heavily tested and already solve many things,
like async I/O and error handling.

Regards,

Phil.
