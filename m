Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1d7O5k-0006pQ-1Q
	for qemu-devel@nongnu.org; Sun, 07 May 2017 11:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1d7O5j-00069C-8i
	for qemu-devel@nongnu.org; Sun, 07 May 2017 11:27:24 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1d7O5j-00067R-3G
	for qemu-devel@nongnu.org; Sun, 07 May 2017 11:27:23 -0400
Received: by mail-it0-x236.google.com with SMTP id c15so53967604ith.0
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 08:27:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170505144506.GA14316@stefanha-x1.localdomain>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
	<20170502142207.GJ22502@stefanha-x1.localdomain>
	<CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
	<20170505144506.GA14316@stefanha-x1.localdomain>
From: Doug Gale <doug16k@gmail.com>
Date: Sun, 7 May 2017 11:27:20 -0400
Message-ID: <CAEfK_47+yGMVSEPui3GfyEfqPy9dQfJGB2c1smhV=TjSCoD8=g@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

[Oops, forgot to reply all, resending...]

Yes, on second thought, <= 2 is off by one. [0] would be the '$', [1]
would be the repeated character, and [2] would be the '*'.

And yes, there is a missing s->state = RS_IDLE there. Good catch. I'll
post updated patch shortly...

On Fri, May 5, 2017 at 10:45 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, May 02, 2017 at 10:32:40AM -0400, Doug Gale wrote:
>> +            } else {
>> +                /* decode repeat length */
>> +                int repeat = (unsigned char)ch - ' ' + 3;
>> +                if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
>> +                    /* that many repeats would overrun the command buffer */
>> +#ifdef DEBUG_GDB
>> +                    printf("gdbstub command buffer overrun,"
>> +                           " dropping command\n");
>> +#endif
>> +                    s->state = RS_IDLE;
>> +                } else if (s->line_buf_index <= 2) {
>
> Why s->line_buf_index <= 2?  I expected s->line_buf_index < 1 since we
> just need 1 character to clone for run-length decoding.
>
>> +                    /* got a repeat but we have nothing to repeat */
>> +#ifdef DEBUG_GDB
>> +                    printf("gdbstub got invalid RLE sequence\n");
>> +#endif
>> +                } else {
>
> Missing s->state = RS_IDLE?
