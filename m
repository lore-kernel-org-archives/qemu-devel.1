Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHcJ-0003M0-Tr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHcG-0000oo-NM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:47:15 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHcG-0000nH-GH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:47:12 -0500
Received: by mail-wr0-x22f.google.com with SMTP id o8so10503561wra.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:47:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306154650.24075-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f774b431-ac8b-347b-806d-157a7ee5a121@amsat.org>
Date: Tue, 6 Mar 2018 15:47:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180306154650.24075-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trace: include filename when printing
 parser error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 03/06/2018 12:46 PM, Daniel P. Berrangé wrote:
> Improves error messages from:
> 
>   ValueError: Error on line 72: need more than 1 value to unpack
> 
> To
> 
>   ValueError: Error at /home/berrange/src/virt/qemu/trace-events:72:
>     need more than 1 value to unpack
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/simpletrace.py        | 4 ++--
>  scripts/tracetool.py          | 2 +-
>  scripts/tracetool/__init__.py | 6 ++++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index a3a6315055..fefc0806b8 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -168,7 +168,7 @@ class Analyzer(object):
>  def process(events, log, analyzer, read_header=True):
>      """Invoke an analyzer on each event in a log."""
>      if isinstance(events, str):
> -        events = read_events(open(events, 'r'))
> +        events = read_events(open(events, 'r'), events)
>      if isinstance(log, str):
>          log = open(log, 'rb')
>  
> @@ -233,7 +233,7 @@ def run(analyzer):
>                           '<trace-file>\n' % sys.argv[0])
>          sys.exit(1)
>  
> -    events = read_events(open(sys.argv[1], 'r'))
> +    events = read_events(open(sys.argv[1], 'r'), sys.argv[1])
>      process(events, sys.argv[2], analyzer, read_header=read_header)
>  
>  if __name__ == '__main__':
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> index c55a21518b..fe2b0771f2 100755
> --- a/scripts/tracetool.py
> +++ b/scripts/tracetool.py
> @@ -142,7 +142,7 @@ def main(args):
>      events = []
>      for arg in args:
>          with open(arg, "r") as fh:
> -            events.extend(tracetool.read_events(fh))
> +            events.extend(tracetool.read_events(fh, arg))
>  
>      try:
>          tracetool.generate(events, arg_group, arg_format, arg_backends,
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 52cc687ae3..b645be30d1 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -336,13 +336,15 @@ class Event(object):
>                       self)
>  
>  
> -def read_events(fobj):
> +def read_events(fobj, fname):
>      """Generate the output for the given (format, backends) pair.
>  
>      Parameters
>      ----------
>      fobj : file
>          Event description file.
> +    fname : str
> +        Name of event file
>  
>      Returns a list of Event objects
>      """
> @@ -357,7 +359,7 @@ def read_events(fobj):
>          try:
>              event = Event.build(line)
>          except ValueError as e:
> -            arg0 = 'Error on line %d: %s' % (lineno, e.args[0])
> +            arg0 = 'Error at %s:%d: %s' % (fname, lineno, e.args[0])
>              e.args = (arg0,) + e.args[1:]
>              raise
>  
> 
