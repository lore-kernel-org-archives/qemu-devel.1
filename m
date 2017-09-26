Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwt1N-00032t-3f
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwt1M-0005tS-9F
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:47:45 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwt1M-0005su-2E
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:47:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id m127so9653267wmm.0
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:47:43 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170926090521.GE16834@stefanha-x1.localdomain>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<20170926090521.GE16834@stefanha-x1.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 26 Sep 2017 09:47:12 -0700
Message-ID: <CAKmqyKNpNKDoy_grMKqExYiK9BaZJFTj=V1AY8RvwPHMRHtSyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/8] Remove some of the fprintf(stderr,
 "*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Sep 26, 2017 at 2:05 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Sep 25, 2017 at 05:08:34PM -0700, Alistair Francis wrote:
>>
>> Continue on improving QEMUs logging/error messages by removing more
>> fprintf()'s.
>>
>> Unfortunatley my Coccinelle skills aren't that great so it's all done in
>> some nasty regex and a little bit of manual work.
>>
>>
>>
>> Alistair Francis (8):
>>   Replace all occurances of __FUNCTION__ with __func__
>>   tests: Replace fprintf(stderr, "*\n" with error_report()
>>   hw: Replace fprintf(stderr, "*\n" with error_report()
>>   block: Replace fprintf(stderr, "*\n" with error_report()
>>   util: Replace fprintf(stderr, "*\n" with error_report()
>>   ui: Replace fprintf(stderr, "*\n" with error_report()
>>   tcg: Replace fprintf(stderr, "*\n" with error_report()
>>   target: Replace fprintf(stderr, "*\n" with error_report()
>>
>>  audio/audio_int.h                      |   2 +-
>>  block/file-posix.c                     |   6 +-
>>  block/file-win32.c                     |   3 +-
>>  block/linux-aio.c                      |   5 +-
>>  block/parallels.c                      |   7 ++-
>>  block/qcow2-cluster.c                  |   2 +-
>>  block/qcow2-refcount.c                 |  95 +++++++++++++++----------------
>>  block/qcow2.c                          |   8 +--
>>  block/quorum.c                         |   5 +-
>>  block/ssh.c                            |   4 +-
>>  block/vdi.c                            |  14 +++--
>>  block/vpc.c                            |   5 +-
>>  block/vvfat.c                          |  99 ++++++++++++++++++---------------
>
> Please don't convert fprintfs to error_report in the block layer yet.
> error_report() uses the cur_mon global variable in a way that is not
> thread-safe:
>
>   void error_vprintf(const char *fmt, va_list ap)
>   {
>       if (cur_mon && !monitor_cur_is_qmp()) {
>           monitor_vprintf(cur_mon, fmt, ap);
>
> This is a time-of-check-to-time-of-use race condition.
> monitor_cur_is_qmp() itself also suffers from a race condition.
>
> I guess we haven't seen issues because error_report() is rarely called.

Thanks, I didn't know that. I'll drop the block patches then.

Thanks,
Alistair

>
> Stefan
