Received: from eggs.gnu.org ([2001:4830:134:3::10]:51484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCBKF-0000I3-FJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCBKE-0001rQ-BX
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:26:59 -0400
Date: Mon, 15 Oct 2018 19:26:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015222638.GH31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-10-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-10-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Unify log outputs between
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

On Mon, Oct 15, 2018 at 04:14:53PM +0200, Max Reitz wrote:
> When dumping an object into the log, there are differences between
> Python 2 and 3.  First, unicode strings are prefixed by 'u' in Python 2
> (they are no longer in 3, because unicode strings are the default
> there).  [...]

This could be addressed using JSON.  See below[1].

> [...] Second, the order of keys in dicts may differ.  [...]

Can be addressed using json.dumps(..., sort_keys=True).

> [...] Third,
> especially long numbers are longs in Python 2 and thus get an 'L'
> suffix, which does not happen in Python 3.

print() doesn't add a L suffix on Python 2.7 on my system:

Python 2.7.15 (default, May 15 2018, 15:37:31)
[GCC 7.3.1 20180303 (Red Hat 7.3.1-5)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> print(99999999999999999999999999999999999999999999999999999999999999999999999999999999999L)
99999999999999999999999999999999999999999999999999999999999999999999999999999999999

So I assume this happens only for QMP commands.  It would be
addressed if using JSON, too.


> 
> To get around these differences, this patch introduces functions to
> convert an object to a string that looks the same regardless of the
> Python version: In Python 2, they decode unicode strings to byte strings
> (normal str); in Python 3, they encode byte strings to unicode strings
> (normal str).  They also manually convert lists and dicts to strings,
> which allows sorting the dicts by key, so we are no longer at the mercy
> of the internal implementation when it comes to how the keys appear in
> the output.
> 
> This changes the output of all tests that use these logging functions.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/194.out    |  22 +-
>  tests/qemu-iotests/202.out    |  12 +-
>  tests/qemu-iotests/203.out    |  14 +-
>  tests/qemu-iotests/206.out    | 144 +++++-----
>  tests/qemu-iotests/207.out    |  52 ++--
>  tests/qemu-iotests/208.out    |   8 +-
>  tests/qemu-iotests/210.out    |  72 ++---
>  tests/qemu-iotests/211.out    |  66 ++---
>  tests/qemu-iotests/212.out    | 102 +++----
>  tests/qemu-iotests/213.out    | 124 ++++----
>  tests/qemu-iotests/216.out    |   4 +-
>  tests/qemu-iotests/218.out    |  20 +-
>  tests/qemu-iotests/219.out    | 526 +++++++++++++++++-----------------
>  tests/qemu-iotests/222.out    |  24 +-
>  tests/qemu-iotests/iotests.py |  42 ++-
>  15 files changed, 634 insertions(+), 598 deletions(-)
[...]
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index a64ea90fb4..f8dbc8cc71 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -250,10 +250,45 @@ def filter_img_info(output, filename):
>          lines.append(line)
>      return '\n'.join(lines)
>  
> +def log_to_string_repr(obj):
> +    # Normal Python 3 strings are the unicode strings from Python 2;
> +    # and normal Python 2 strings are byte strings in Python 3.  Thus,
> +    # we convert bytes -> str in py3 and unicode -> str in py2.
> +    if sys.version_info.major >= 3:
> +        if type(obj) is bytes:
> +            return repr(obj.decode('utf-8'))
> +    else:
> +        if type(obj) is unicode:
> +            return repr(obj.encode('utf-8'))
> +        elif type(obj) is long:
> +            return str(obj) # repr() would include an 'L' suffix
> +
> +    if type(obj) is list:
> +        return '[' + ', '.join(map(log_to_string_repr, obj)) + ']'
> +    elif type(obj) is dict:
> +        return '{' + ', '.join(map(lambda k: log_to_string_repr(k) + ': ' +
> +                                             log_to_string_repr(obj[k]),
> +                                   sorted(obj.keys()))) + '}'
> +    else:
> +        return repr(obj)

I assume this function exists only because of QMP logging,
correct?

I would just use json.dumps() at qmp_log(), see below[1].


> +
> +def log_to_string(obj):
> +    if type(obj) is str:
> +        return obj
> +
> +    if sys.version_info.major >= 3:
> +        if type(obj) is bytes:
> +            return obj.decode('utf-8')

Do you know how many of existing log() calls actually pass a byte
string as argument?

> +    else:
> +        if type(obj) is unicode:
> +            return obj.encode('utf-8')

Is this really necessary?  The existing code just calls
print(msg) and it works, doesn't it?



> +
> +    return log_to_string_repr(obj)
> +
>  def log(msg, filters=[]):
>      for flt in filters:
>          msg = flt(msg)
> -    print(msg)
> +    print(log_to_string(msg))
>  
>  class Timeout:
>      def __init__(self, seconds, errmsg = "Timeout"):
> @@ -441,10 +476,11 @@ class VM(qtest.QEMUQtestMachine):
>          return result
>  
>      def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
> -        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
> +        logmsg = "{'execute': '%s', 'arguments': %s}" % \
> +            (cmd, log_to_string(kwargs))
>          log(logmsg, filters)
>          result = self.qmp(cmd, **kwargs)
> -        log(str(result), filters)
> +        log(log_to_string(result), filters)

[1]

If we're being forced to regenerate all the QMP output in the
.out files, what about always using JSON instead of the hack at
log_to_string_repr()?  i.e.:

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a64ea90fb4..0b28dc2a65 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -441,10 +441,12 @@ class VM(qtest.QEMUQtestMachine):
         return result
 
     def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
-        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
+        logmsg = '{"execute": %s, "arguments": %s}' % \
+                 (json.dumps(cmd, sort_keys=True),
+                  json.dumps(kwargs, sort_keys=True))
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
-        log(str(result), filters)
+        log(json.dumps(result, sort_keys=True), filters)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):

>          return result
>  
>      def run_job(self, job, auto_finalize=True, auto_dismiss=False):
> -- 
> 2.17.1
> 
> 

-- 
Eduardo
