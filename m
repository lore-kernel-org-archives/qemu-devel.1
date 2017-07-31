Received: from eggs.gnu.org ([2001:4830:134:3::10]:42856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dcCGU-0002Ra-RI
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dcCGP-0004Kx-HV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:05:50 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dcCGP-0004I6-9k
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:05:45 -0400
Received: by mail-it0-f47.google.com with SMTP id h199so126773503ith.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 08:05:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170731145014.GA20793@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
	<20170731145014.GA20793@localhost.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 17:05:41 +0200
Message-ID: <CALAZnb1cFQ-uooG3mLj9G+7wHhOWX39mDAkFnsA+Bfhk=MAR9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Mon, Jul 31, 2017 at 4:50 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Jul 31, 2017 at 10:51:06AM +0200, Amador Pahim wrote:
>> Let's provide extra control and flexibility by using python logging
>> system instead of print and/or sys.std*.write().
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 77565eb092..e3ea534ec4 100644
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
>> @@ -20,11 +21,19 @@ import subprocess
>>  import qmp.qmp
>>
>>
>> +logging.basicConfig()
>
> Please don't call logging.basicConfig() from a module, as this
> will break scripts that already use logging.basicConfig().

Sure, this is a leftover from my tests.

>
> This breaks the following:
>
>   $ ./scripts/device-crash-test --debug /usr/bin/qemu-system-x86_64
>
>
>> +LOG = logging.getLogger(__name__)
>> +
>> +
>>  class QEMUMachine(object):
>>      '''A QEMU VM'''
>>
>>      def __init__(self, binary, args=[], wrapper=[], name=None, test_dir="/var/tmp",
>>                   monitor_address=None, socket_scm_helper=None, debug=False):
>> +        if debug:
>> +            LOG.setLevel(logging.DEBUG)
>> +        else:
>> +            LOG.setLevel(logging.INFO)
>
> This makes the debug argument for one QEMUMachine object affect
> other QEMUMachine objects.
>
> What about:
>     self.logger = LOG.getChild(name)
>     self.logger.setLevel(...)
>
> But do we really need to support per-QEMUMachine verbosity
> levels?  We could simply eliminate the 'debug' argument and let
> scripts configure logging.

Ok, agreed.

>
>>          if name is None:
>>              name = "qemu-%d" % os.getpid()
>>          if monitor_address is None:
>> @@ -62,10 +71,10 @@ class QEMUMachine(object):
>>          # In iotest.py, the qmp should always use unix socket.
>>          assert self._qmp.is_scm_available()
>>          if self._socket_scm_helper is None:
>> -            print >>sys.stderr, "No path to socket_scm_helper set"
>> +            LOG.error("No path to socket_scm_helper set")
>>              return -1
>>          if os.path.exists(self._socket_scm_helper) == False:
>> -            print >>sys.stderr, "%s does not exist" % self._socket_scm_helper
>> +            LOG.error("%s does not exist", self._socket_scm_helper)
>>              return -1
>>          fd_param = ["%s" % self._socket_scm_helper,
>>                      "%d" % self._qmp.get_sock_fd(),
>> @@ -154,7 +163,8 @@ class QEMUMachine(object):
>>
>>              exitcode = self._popen.wait()
>>              if exitcode < 0:
>> -                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
>> +                LOG.error('qemu received signal %i: %s', -exitcode,
>> +                          ' '.join(self._args))
>>              self._load_io_log()
>>              self._post_shutdown()
>>
>> --
>> 2.13.3
>>
>
> --
> Eduardo
