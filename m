Received: from eggs.gnu.org ([2001:4830:134:3::10]:43648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFse7-0003dh-UU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFse1-00055U-Rg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:41:56 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFse1-000552-My
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:41:53 -0400
Received: by mail-io0-x244.google.com with SMTP id f102so706529ioi.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:41:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
	<20170517145259.28979-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <59c69534-df61-ddee-57a7-6ba803b1f579@amsat.org>
Date: Tue, 30 May 2017 22:41:49 -0300
MIME-Version: 1.0
In-Reply-To: <20170517145259.28979-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] scripts/qemu-gdb/tcg: new helper to
 dump tcg state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com
Cc: cota@braap.org, qemu-devel@nongnu.org

On 05/17/2017 11:52 AM, Alex Bennée wrote:
> This adds a simple helper to dump lock state within TCG.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu-gdb.py    |  3 ++-
>  scripts/qemugdb/tcg.py | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/qemugdb/tcg.py
>
> diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
> index 3e7adb87dc..91e928f6af 100644
> --- a/scripts/qemu-gdb.py
> +++ b/scripts/qemu-gdb.py
> @@ -26,7 +26,7 @@ import os, sys
>
>  sys.path.append(os.path.dirname(__file__))
>
> -from qemugdb import aio, mtree, coroutine, timers
> +from qemugdb import aio, mtree, coroutine, timers, tcg
>
>  class QemuCommand(gdb.Command):
>      '''Prefix for QEMU debug support commands'''
> @@ -39,6 +39,7 @@ coroutine.CoroutineCommand()
>  mtree.MtreeCommand()
>  aio.HandlersCommand()
>  timers.TimersCommand()
> +tcg.TCGLockStatusCommand()
>
>  coroutine.CoroutineSPFunction()
>  coroutine.CoroutinePCFunction()
> diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
> new file mode 100644
> index 0000000000..8c7f1d7454
> --- /dev/null
> +++ b/scripts/qemugdb/tcg.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/python
> +# -*- coding: utf-8 -*-
> +#
> +# GDB debugging support, TCG status
> +#
> +# Copyright 2016 Linaro Ltd
> +#
> +# Authors:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +# Contributions after 2012-01-13 are licensed under the terms of the
> +# GNU GPL, version 2 or (at your option) any later version.
> +
> +# 'qemu tcg-lock-status' -- display the TCG lock status across threads
> +
> +import gdb
> +
> +class TCGLockStatusCommand(gdb.Command):
> +    '''Display TCG Execution Status'''
> +    def __init__(self):
> +        gdb.Command.__init__(self, 'qemu tcg-lock-status', gdb.COMMAND_DATA,
> +                             gdb.COMPLETE_NONE)
> +
> +    def invoke(self, arg, from_tty):
> +        gdb.write("Thread, BQL (iothread_mutex), Replay, Blocked?\n")
> +        for thread in gdb.inferiors()[0].threads():
> +            thread.switch()
> +
> +            iothread = gdb.parse_and_eval("iothread_locked")
> +            replay = gdb.parse_and_eval("replay_locked")
> +
> +            frame = gdb.selected_frame()
> +            if frame.name() == "__lll_lock_wait":
> +                frame.older().select()
> +                mutex = gdb.parse_and_eval("mutex")
> +                owner = gdb.parse_and_eval("mutex->__data.__owner")
> +                blocked = ("__lll_lock_wait waiting on %s from %d" %
> +                           (mutex, owner))
> +            else:
> +                blocked = "not blocked"
> +
> +            gdb.write("%d/%d, %s, %s, %s\n" % (thread.num, thread.ptid[1],
> +                                               iothread, replay, blocked))
>
