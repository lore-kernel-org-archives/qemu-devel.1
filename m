Received: from eggs.gnu.org ([2001:4830:134:3::10]:49989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7eXZ-0008GK-QQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7eXZ-0001Jt-0s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:01:13 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7eXY-0001Jd-Qb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:01:12 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 142so57156003wma.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 02:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEfK_44TpSJVi7JULXMRLftM5BFUJs=vHSxKG3h=YOUjQz1t+g@mail.gmail.com>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
	<20170502142207.GJ22502@stefanha-x1.localdomain>
	<CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
	<20170505144506.GA14316@stefanha-x1.localdomain>
	<CAEfK_44TpSJVi7JULXMRLftM5BFUJs=vHSxKG3h=YOUjQz1t+g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 8 May 2017 10:01:10 +0100
Message-ID: <CAJSP0QV++8rKxPrAXv1GWrwtiK4CNZCv+QoSzYkG-1LYF2SEgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] gdbstub: implement remote debugging
 protocol escapes for command receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sun, May 7, 2017 at 4:26 PM, Doug Gale <doug16k@gmail.com> wrote:
> On Fri, May 5, 2017 at 10:45 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Tue, May 02, 2017 at 10:32:40AM -0400, Doug Gale wrote:
>>> +            } else {
>>> +                /* decode repeat length */
>>> +                int repeat = (unsigned char)ch - ' ' + 3;
>>> +                if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
>>> +                    /* that many repeats would overrun the command buffer */
>>> +#ifdef DEBUG_GDB
>>> +                    printf("gdbstub command buffer overrun,"
>>> +                           " dropping command\n");
>>> +#endif
>>> +                    s->state = RS_IDLE;
>>> +                } else if (s->line_buf_index <= 2) {
>>
>> Why s->line_buf_index <= 2?  I expected s->line_buf_index < 1 since we
>> just need 1 character to clone for run-length decoding.
>
> Yes, on second thought, <= 2 is off by one. [0] would be the '$', [1]
> would be the repeated character, and [2] would be the '*'.

'$' and '*' are not placed into line_buf[] and do not increment
line_buf_index.  They don't count.

I think the correct condition is line_buf_index < 1 so that the
following input from the GDB documentation parses: "$0* " -> "0000".

https://sourceware.org/gdb/onlinedocs/gdb/Overview.html
