Received: from eggs.gnu.org ([2001:4830:134:3::10]:51430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dk75z-0004YW-N8
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dk75w-0007h4-C7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:11:43 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dk75w-0007fJ-7n
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:11:40 -0400
Received: by mail-it0-f54.google.com with SMTP id 77so42720631itj.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:11:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822102456.GC3210@lemon>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-3-apahim@redhat.com>
	<20170822102456.GC3210@lemon>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 22 Aug 2017 13:11:37 +0200
Message-ID: <CALAZnb2sgT+er96jA79nG7+bK3H2kN4MMjrPT+6wm9HF_ZT7pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 02/11] qemu.py: avoid writing to
 stdout/stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Tue, Aug 22, 2017 at 12:24 PM, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 08/18 19:05, Amador Pahim wrote:
>> This module should not write directly to stdout/stderr. Instead, it
>> should either raise exceptions or just log the messages and let the
>> callers handle them and decide what to do. For example, scripts could
>> choose to send the log messages stderr or/and write them to a file if
>> verbose or debugging mode is enabled.
>>
>> This patch replaces the writes to stderr by an exception in the
>> send_fd_scm() when _socket_scm_helper is not set or not present. In the
>> same method, the subprocess Popen will now redirect the stdout/stderr to
>> logging.debug instead of writing to system stderr. As consequence, since
>> the Popen.communicate() is now used (in order to get the stdout), the
>> further call to wait() became redundant and was replaced by
>> Popen.returncode.
>>
>> The shutdown() message on negative exit code will now be logged
>> to logging.debug instead of written to system stderr.
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py | 29 +++++++++++++++++++++--------
>>  1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 0ae5d39414..ef531bb23b 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -13,6 +13,7 @@
>>  #
>>
>>  import errno
>> +import logging
>>  import string
>>  import os
>>  import sys
>> @@ -20,6 +21,15 @@ import subprocess
>>  import qmp.qmp
>>
>>
>> +LOG = logging.getLogger(__name__)
>
> Previously the messages written to sys.stderr always get printed, now it depends
> on the log level and IIUC debug messages are not printed by default. Should
> LOG.warn be used to replace sys.stderr instead of LOG.debug?

I don't think that the 'keep the behavior' principle should overcome
what the messages actually are. The question is: are they warning
messages? The way I see, the messages I changed in this commit to use
the logging system are both debug messages.

Btw, notice that scripts have to take an action to see these messages
anyway, even if it's just calling logging.basicConfig() (which adds by
default the logging.StreamHandler, if no handler is specified).
Meaning that the same behavior will not happen out-of-the-box, even if
we use logging.warn(). So, what your question really asks is if users
should use (at least) logging.basicConfig() or
logging.basicConfig(level=logging.DEBUG) to see those messages.

>
>> +
>> +
>> +class QEMUMachineError(Exception):
>> +    """
>> +    Exception called when an error in QEMUMachine happens.
>> +    """
>> +
>> +
>>  class QEMUMachine(object):
>>      '''A QEMU VM'''
>>
>> @@ -62,18 +72,20 @@ class QEMUMachine(object):
>>          # In iotest.py, the qmp should always use unix socket.
>>          assert self._qmp.is_scm_available()
>>          if self._socket_scm_helper is None:
>> -            print >>sys.stderr, "No path to socket_scm_helper set"
>> -            return -1
>> +            raise QEMUMachineError("No path to socket_scm_helper set")
>>          if os.path.exists(self._socket_scm_helper) == False:
>> -            print >>sys.stderr, "%s does not exist" % self._socket_scm_helper
>> -            return -1
>> +            raise QEMUMachineError("%s does not exist" % self._socket_scm_helper)
>>          fd_param = ["%s" % self._socket_scm_helper,
>>                      "%d" % self._qmp.get_sock_fd(),
>>                      "%s" % fd_file_path]
>>          devnull = open('/dev/null', 'rb')
>> -        p = subprocess.Popen(fd_param, stdin=devnull, stdout=sys.stdout,
>> -                             stderr=sys.stderr)
>> -        return p.wait()
>> +        p = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
>> +                             stderr=subprocess.STDOUT)
>> +        output = p.communicate()[0]
>> +        if output:
>> +            LOG.debug(output)
>> +
>> +        return p.returncode
>>
>>      @staticmethod
>>      def _remove_if_exists(path):
>> @@ -154,7 +166,8 @@ class QEMUMachine(object):
>>
>>              exitcode = self._popen.wait()
>>              if exitcode < 0:
>> -                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
>> +                LOG.debug('qemu received signal %i: %s', -exitcode,
>> +                          ' '.join(self._args))
>>              self._load_io_log()
>>              self._post_shutdown()
>>
>> --
>> 2.13.5
>>
>
> Fam
