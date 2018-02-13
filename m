Received: from eggs.gnu.org ([2001:4830:134:3::10]:45409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elcMv-000854-02
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elcMt-0006Kh-NA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:19:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elcMt-0006K6-IJ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:19:39 -0500
References: <20180213140029.8308-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40306631-7740-3b72-f561-16a786cf8c7a@redhat.com>
Date: Tue, 13 Feb 2018 09:19:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180213140029.8308-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 02/13/2018 08:00 AM, Peter Maydell wrote:
> A persistent build problem we see is where a source file
> accidentally omits the #include of log.h. This slips through
> local developer testing because if you configure with the
> default (log) trace backend trace.h will pull in log.h for you.
> Compilation fails only if some other backend is selected.
> 
> To make this error cause a compile failure regardless of
> the configured trace backend, split out the parts of log.h
> that trace.h requires into a new log-for-trace.h header.
> Since almost all manual uses of the log.h functions will
> use constants or functions which aren't in log-for-trace.h,
> this will let us catch missing #include "qemu/log.h" more
> consistently.

You've been threatening this for a while.  Thanks!

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++++++++++
>   include/qemu/log.h               | 18 ++++--------------
>   scripts/tracetool/backend/log.py | 13 ++++++-------
>   3 files changed, 45 insertions(+), 21 deletions(-)
>   create mode 100644 include/qemu/log-for-trace.h
> 
> +++ b/include/qemu/log-for-trace.h
> @@ -0,0 +1,35 @@
> +/* log-for-trace.h: logging basics required by the trace.h generated
> + * by the log trace backend.
> + *
> + * This should not be included directly by any .c file: if you
> + * need to use the logging functions include "qemu/log.h".

This can be enforced with preprocessor magic, you know...

> + *
> + * The purpose of splitting these parts out into their own header
> + * is to catch the easy mistake where a .c file includes trace.h
> + * but forgets to include qemu/log.h. Without this split, that
> + * would result in the .c file compiling fine when the default
> + * trace backend is in use but failing to compile with any other
> + * backend.
> + *
> + * This code is licensed under the GNU General Public License,
> + * version 2 or (at your option) any later version.
> + */
> +
> +#ifndef QEMU_LOG_FOR_TRACE_H
> +#define QEMU_LOG_FOR_TRACE_H

To enforce proper inclusion, you can have:

#ifndef SOME_WITNESS
#error "Don't include this file directly"
#endif

then have log.h and trace.h predefine the witness prior to including 
this header.  The witness check should be outside of the idempotent 
portion guarded by QEMU_LOG_FOR_TRACE_H.

> +++ b/scripts/tracetool/backend/log.py
> @@ -20,7 +20,7 @@ PUBLIC = True
>   
>   
>   def generate_h_begin(events, group):
> -    out('#include "qemu/log.h"',
> +    out('#include "qemu/log-for-trace.h"',
>           '')
>   
>   
> @@ -35,14 +35,13 @@ def generate_h(event, group):
>       else:
>           cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>   
> -    out('    if (%(cond)s) {',
> +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>           '        struct timeval _now;',
>           '        gettimeofday(&_now, NULL);',
> -        '        qemu_log_mask(LOG_TRACE,',

Oh, nice side effect - the old code was unconditionally calling 
gettimeofday() even when qemu_loglevel_mask(LOG_TRACE) fails; the new 
code limits the call when the logging is actually going to happen.

> -        '                      "%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
> -        '                      getpid(),',
> -        '                      (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> -        '                      %(argnames)s);',
> +        '        qemu_log("%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
> +        '                 getpid(),',
> +        '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> +        '                 %(argnames)s);',
>           '    }',
>           cond=cond,
>           name=event.name,
> 

If you don't think the extra preprocessor magic to prevent accidental 
inclusion of the internal header is necessary, then
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
