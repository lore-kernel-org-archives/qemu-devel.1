Received: from eggs.gnu.org ([2001:4830:134:3::10]:39542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjCbP-0006na-3e
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjCbK-0008VZ-J7
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:20:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cjCbK-0008Uq-A3
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:20:02 -0500
References: <20170301194433.23379-1-jsnow@redhat.com>
	<CAMr-obvmL+fHRvEGq+U7S30FSFDZ2USiw2DKOKbJN0dZ=AUZPA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5bd5d17d-aae6-dc8b-0643-fae0bd562bb7@redhat.com>
Date: Wed, 1 Mar 2017 17:19:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAMr-obvmL+fHRvEGq+U7S30FSFDZ2USiw2DKOKbJN0dZ=AUZPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: add persistent command history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com



On 03/01/2017 05:01 PM, Nir Soffer wrote:
> On Wed, Mar 1, 2017 at 9:44 PM, John Snow <jsnow@redhat.com> wrote:
>>
>> Use the existing readline history function we are utilizing
>> to provide persistent command history across instances of qmp-shell.
>>
>> This assists entering debug commands across sessions that may be
>> interrupted by QEMU sessions terminating, where the qmp-shell has
>> to be relaunched.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  scripts/qmp/qmp-shell | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
>> index 0373b24..b19f44b 100755
>> --- a/scripts/qmp/qmp-shell
>> +++ b/scripts/qmp/qmp-shell
>> @@ -70,6 +70,7 @@ import json
>>  import ast
>>  import readline
>>  import sys
>> +import os
>>
>>  class QMPCompleter(list):
>>      def complete(self, text, state):
>> @@ -109,6 +110,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>          self._pretty = pretty
>>          self._transmode = False
>>          self._actions = list()
>> +        self._histfile = os.path.join(os.path.expanduser('~'),
>> +                                      '.qmp_history')
> 
> This can be little bit more readable in one line
> 

I thought I was over 80, but maybe not.

>>
>>      def __get_address(self, arg):
>>          """
>> @@ -137,6 +140,16 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>          # XXX: default delimiters conflict with some command names (eg. query-),
>>          # clearing everything as it doesn't seem to matter
>>          readline.set_completer_delims('')
>> +        try:
>> +            readline.read_history_file(self._histfile)
>> +        except:
>> +            pass
> 
> This hides all errors, including KeyboardInterrupt and SystemExit, and will
> make debugging impossible.
> 

Indeed, I want to ignore errors related to a missing history file. It
wasn't documented, and this isn't an important feature (for a shell
script only used for debugging), so I went with the dumb thing.

> It looks like you want to ignore missing history file, but this way we also
> ignore permission error or even typo in the code. For example this will
> fail silently:
> 
>     try:
>         readdline.read_history_file(self._histfile)
>     except:
>         pass
> 
> The docs do not specify the possible errors, but the code is raising IOError:
> https://github.com/python/cpython/blob/2.7/Modules/readline.c#L126
> 
> So it would be best to handle only IOError, and ignore ENOENT. Any other
> error should fail in a visible way.
> 

Maybe not "fail," but perhaps "warn." This feature is not so important
that it should inhibit normal operation.

>> +
>> +    def __save_history(self):
>> +        try:
>> +            readline.write_history_file(self._histfile)
>> +        except:
>> +            pass
> 
> Same, but I'm not sure what errors should be ignored. Do we want to silently
> ignore a read only file system? no space?
> 

Pretty much my thought, yes. I could "warn" on the first failure and
then stifle subsequent ones. I don't want this to be an irritant.

> I think a safe way would be to print a warning if the history file
> cannot be saved
> with the text from the IOError.
> 
>>
>>      def __parse_value(self, val):
>>          try:
>> @@ -244,6 +257,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>              print 'command format: <command-name> ',
>>              print '[arg-name1=arg1] ... [arg-nameN=argN]'
>>              return True
>> +        self.__save_history()
> 
> This will save the history after every command, making error handling
> more complicated, and also unneeded, since we don't care about history
> if you kill the qmp-shell process, right?
> 

I suppose so. My thought was more along the lines of: "If the program
explodes, I'd like to have the intervening history saved." I didn't
think this would complicate performance of a debugging tool.

Why do you feel this would make error handling more complicated?

Why do you think we wouldn't care about the history if we kill the
qmp-shell process?

> We can invoke readline.write_history_file() using atexit. This is also
> what the docs suggest, see:
> https://docs.python.org/2/library/readline.html#example
> 
> Nir
> 
>>          # For transaction mode, we may have just cached the action:
>>          if qmpcmd is None:
>>              return True
>> --
>> 2.9.3
>>
>>
