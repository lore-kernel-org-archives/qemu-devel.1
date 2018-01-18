Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8B4-0004eE-3Q
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8Az-0007BG-3p
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:16:14 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8Ay-0007AP-U3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:16:09 -0500
Received: by mail-qt0-x244.google.com with SMTP id z10so1106947qti.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:16:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <151627206353.4505.4602428849861610759.stgit@bahia.lan>
	<36cc0b97-2214-fc42-085c-78d3e4fe6da4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58c7a1f0-21e3-9f4e-6c32-74721f6ac1ea@amsat.org>
Date: Thu, 18 Jan 2018 08:16:04 -0300
MIME-Version: 1.0
In-Reply-To: <36cc0b97-2214-fc42-085c-78d3e4fe6da4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] readline: don't free completions in
 readline_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/18/2018 07:45 AM, Paolo Bonzini wrote:
> On 18/01/2018 11:41, Greg Kurz wrote:
>> Since commit e5dc1a6c6c43, QEMU aborts on exit if completion was used
>> in the monitor:
>>
>> *** Error in `obj/ppc64-softmmu/qemu-system-ppc64': double free or
>>  corruption (fasttop): 0x00000100331069d0 ***
>>
>> #0  0x00007ffff267eff0 in raise () from /lib64/libc.so.6
>> #1  0x00007ffff268136c in abort () from /lib64/libc.so.6
>> #2  0x00007ffff26c6b48 in __libc_message () from /lib64/libc.so.6
>> #3  0x00007ffff26d69fc in free () from /lib64/libc.so.6
>> #4  0x00007ffff28cb794 in g_free () from /lib64/libglib-2.0.so.0
>> #5  0x00000000106230e4 in readline_free (rs=0x11223e60) at
>>  /home/greg/Work/qemu/qemu-spapr/util/readline.c:514
>> #6  0x0000000010074cc4 in monitor_data_destroy (mon=0x1121c9f0) at
>>  /home/greg/Work/qemu/qemu-spapr/monitor.c:586
>> #7  0x000000001007bcc8 in monitor_cleanup () at
>>  /home/greg/Work/qemu/qemu-spapr/monitor.c:4125
>> #8  0x0000000010291274 in main (argc=<optimized out>,
>>  argv=<optimized out>, envp=<optimized out>) at
>>  /home/greg/Work/qemu/qemu-spapr/vl.c:4795
>>
>> Completion strings are not persistent accross completions (why would
>> they?). They are allocated under readline_completion(), which already
>> takes care of freeing them before returning.

Oops I missed that.

>>
>> Maybe all completion related bits should be moved out of ReadLineState
>> to a dedicated structure ?
>>
>> In the meantime, let's drop the offending lines from readline_free()
>> to fix the crash.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  util/readline.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/util/readline.c b/util/readline.c
>> index 24ec839854cf..ec91ee0fea6f 100644
>> --- a/util/readline.c
>> +++ b/util/readline.c
>> @@ -510,9 +510,6 @@ void readline_free(ReadLineState *rs)
>>      for (i = 0; i < READLINE_MAX_CMDS; i++) {
>>          g_free(rs->history[i]);
>>      }
>> -    for (i = 0; i < READLINE_MAX_COMPLETIONS; i++) {
>> -        g_free(rs->completions[i]);
>> -    }
>>      g_free(rs);
>>  }
>>  
>>
> 
> Queued, thanks.
> 
> Paolo
> 
