Received: from eggs.gnu.org ([2001:4830:134:3::10]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ewuM4-0001iB-Pj
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ewuLz-0000Bs-P6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:45:28 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38643
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1ewuLz-0000BF-AF
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:45:23 -0400
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-x8PryWiOdh3CR-0o5UvL=0day0LMUyPRKzy2dE0XL=A@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <af1ce941-2b9a-bc84-4419-52727c7bd236@adacore.com>
Date: Fri, 16 Mar 2018 19:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-x8PryWiOdh3CR-0o5UvL=0day0LMUyPRKzy2dE0XL=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 03/16/2018 05:34 PM, Peter Maydell wrote:
> On 16 March 2018 at 16:23, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> Since the commit:
>> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Wed Mar 7 14:42:05 2018 +0000
>>
>>      vl: introduce vm_shutdown()
>>
>> GDB crash when qemu exits (at least on sparc-softmmu):
>> Remote communication error.  Target disconnected.: Connection reset by peer.
>> Quitting: putpkt: write failed: Broken pipe.
>>
>> So send a packet to kill GDB before we exit QEMU:
>> [Inferior 1 (Thread 0) exited normally]
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   gdbstub.c              | 7 +++++++
>>   include/exec/gdbstub.h | 2 ++
>>   vl.c                   | 2 ++
>>   3 files changed, 11 insertions(+)
> 
> We didn't send an exiting packet before commit 4486e89c219c0,
> so do you know why this worked before then? (Telling gdb we're
> exiting seems like the right thing, though.)
> 

Hmmm good question, I didn't had time to investigate in detail

Before 4486e89c219c0:

(gdb) tar rem :1234
Remote debugging using :1234
0x40000000 in trap_table ()
(gdb) c
Continuing.
Remote connection closed

After 4486e89c219c0:

(gdb) tar rem :1234
Remote debugging using :1234
0x40000000 in trap_table ()
(gdb) c
Continuing.
putpkt: write failed: Connection reset by peer.

With the patch:

(gdb) tar rem :1234
Remote debugging using :1234
0x40000000 in trap_table ()
(gdb) c
Continuing.
[Inferior 1 (Thread 0) exited normally]

We use to have this patch in our repository to avoid the remote
connection closed above.

Thanks,
Fred

> thanks
> -- PMM
> 
