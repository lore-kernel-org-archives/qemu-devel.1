Received: from eggs.gnu.org ([2001:4830:134:3::10]:54376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFReC-0001YU-CU
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFReB-0005dq-HN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:52:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc558af7-c381-d74c-9806-569a6cd5ad33@amsat.org>
Date: Mon, 29 May 2017 17:52:06 -0300
MIME-Version: 1.0
In-Reply-To: <1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] simpletrace: Improve the error message if
 event is not declared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 05/29/2017 01:30 PM, Jose Ricardo Ziviani wrote:
> Today, if we use a trace-event file which does not declare an event
> existing in the log file we'll get the following error:
>
> $ scripts/simpletrace.py trace-events trace-68508
> Traceback (most recent call last):
>   File "scripts/simpletrace.py", line 242, in <module>
>     run(Formatter())
>   File "scripts/simpletrace.py", line 217, in run
>     process(events, sys.argv[2], analyzer, read_header=read_header)
>   File "scripts/simpletrace.py", line 192, in process
>     for rec in read_trace_records(edict, log):
>   File "scripts/simpletrace.py", line 107, in read_trace_records
>     rec = read_record(edict, idtoname, fobj)
>   File "scripts/simpletrace.py", line 71, in read_record
>     return get_record(edict, idtoname, rechdr, fobj)
>   File "scripts/simpletrace.py", line 45, in get_record
>     event = edict[name]
> KeyError: 'qemu_mutex_locked'
>
> This patch improves this error by adding a hint instead of just that
> KeyError log:
>
> $ scripts/simpletrace.py trace-events trace-68508
> 'qemu_mutex_locked' event is logged but is not declared in the trace
> events file, try using trace-events-all instead.
>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/simpletrace.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index d60b3a0..f1be6e4 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -42,7 +42,15 @@ def get_record(edict, idtoname, rechdr, fobj):
>          event_id = rechdr[0]
>          name = idtoname[event_id]
>          rec = (name, rechdr[1], rechdr[3])
> -        event = edict[name]
> +        try:
> +            event = edict[name]
> +        except KeyError, e:
> +            import sys
> +            sys.stderr.write('%s event is logged but is not declared ' \
> +                             'in the trace events file, try using ' \
> +                             'trace-events-all instead.\n' % str(e))
> +            sys.exit(1)
> +
>          for type, name in event.args:
>              if is_string(type):
>                  l = fobj.read(4)
>
