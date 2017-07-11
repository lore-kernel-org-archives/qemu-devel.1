Received: from eggs.gnu.org ([2001:4830:134:3::10]:33593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUuTE-00049B-6F
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUuTA-0004be-8O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUuT9-0004bR-VD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:40:48 -0400
References: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
	<d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
	<20170711091506.GC7116@redhat.com>
	<4268aa00-6700-0554-10a2-451acb0baad6@redhat.com>
	<20170711123710.GP7116@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5e141e9-c1ba-f11a-f662-5a5725faa907@redhat.com>
Date: Tue, 11 Jul 2017 14:40:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170711123710.GP7116@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, wang.yechao255@zte.com.cn

On 11/07/2017 14:37, Daniel P. Berrange wrote:
> On Tue, Jul 11, 2017 at 02:21:08PM +0200, Paolo Bonzini wrote:
>> On 11/07/2017 11:15, Daniel P. Berrange wrote:
>>> On Tue, Jul 11, 2017 at 10:30:14AM +0200, Paolo Bonzini wrote:
>>>> On 11/07/2017 13:47, Peng Hao wrote:
>>>>> Parallel device don't register be->chr_can_read function, but remote
>>>>> disconnect event is handled in chr_read.So connected parallel device
>>>>> can not detect remote disconnect event. The chardevs with chr_can_read=NULL
>>>>> has the same problem.
>>>>>
>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>>> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
>>>>> ---
>>>>>  chardev/char-socket.c  | 11 +++++++++++
>>>>>  chardev/char.c         | 10 ++++++++++
>>>>>  include/chardev/char.h |  9 +++++++++
>>>>>  3 files changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>>>>> index ccc499c..aa44f8f 100644
>>>>> --- a/chardev/char-socket.c
>>>>> +++ b/chardev/char-socket.c
>>>>> @@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
>>>>>          return 0;
>>>>>      }
>>>>>      s->max_size = qemu_chr_be_can_write(chr);
>>>>> +    if (qemu_chr_null_be_can_read(chr)) {
>>>>> +        return 1;
>>>>> +    }
>>>>>      return s->max_size;
>>>>>  }
>>>>>  
>>>>> @@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>>>>>      uint8_t buf[CHR_READ_BUF_LEN];
>>>>>      int len, size;
>>>>>  
>>>>> +    if (qemu_chr_null_be_can_read(chr)) {
>>>>> +        size = tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
>>>>
>>>> It would be better not to destroy data in the channel, because the
>>>> device could set handlers later.
>>>>
>>>> Daniel, maybe QIOChannel could have a function to check for hung-up
>>>> channels and return a bool?  For file descriptors it would poll the file
>>>> descriptor and check for POLLHUP, while other channels would have a more
>>>> or less obvious implementation.
>>>
>>> IMHO the chardev code all needs to switch over to using even driven I/O
>>> using the  qio_channel_add_watch() function.
>>
>> This is a slightly different case; qio_channel_add_watch() is for the
>> write side, while in this case we're concerned with the read side.
>>
>> The read-side watch is managed automatically by common chardev code.
>> I'll see if we can change that code to set up a G_IO_HUP watch in
>> addition to G_IO_IN.
> 
> NB You don't ever need to use G_IO_HUP as an explicit input flag - poll()
> will always report G_IO_HUP if you asked it to monitor for G_IO_IN.

Right, but in this case we don't want to monitor G_IO_IN, because there
is no listener.  The parallel port is a special case but actually the
same would happen for any other device whose can_read callback can
return zero.

Some Unix variants require you to specify G_IO_HUP in the events
(FreeBSD), others don't (Linux).

Paolo
