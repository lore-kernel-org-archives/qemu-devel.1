Received: from eggs.gnu.org ([2001:4830:134:3::10]:51388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ckwsM-00079b-HH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ckwsJ-0006YR-Ar
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ckwsJ-0006Y5-1u
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:56:47 -0500
References: <20170303185427.32681-1-jsnow@redhat.com>
	<CAMr-obuiwE_ef6OPSJbBtmZYsaqo_mzU9E6q8zhbrviZ6_=krQ@mail.gmail.com>
	<5303cac4-a8d8-bf89-b525-3b0fb1b19127@redhat.com>
	<CAMr-obsrUqvqbLabYgKgv1J+ztn5XCwto6LowoN=S0ZWuFLZMA@mail.gmail.com>
	<871sua4y3u.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <3fbdfabf-82b4-d774-d5f4-2c50a6d740dc@redhat.com>
Date: Mon, 6 Mar 2017 12:56:45 -0500
MIME-Version: 1.0
In-Reply-To: <871sua4y3u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qmp-shell: add persistent command
 history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org



On 03/06/2017 03:18 AM, Markus Armbruster wrote:
> Nir Soffer <nirsof@gmail.com> writes:
> 
>> On Fri, Mar 3, 2017 at 9:29 PM, John Snow <jsnow@redhat.com> wrote:
>>>
>>>
>>> On 03/03/2017 02:26 PM, Nir Soffer wrote:
>>>> On Fri, Mar 3, 2017 at 8:54 PM, John Snow <jsnow@redhat.com> wrote:
>>>>> Use the existing readline history function we are utilizing
>>>>> to provide persistent command history across instances of qmp-shell.
>>>>>
>>>>> This assists entering debug commands across sessions that may be
>>>>> interrupted by QEMU sessions terminating, where the qmp-shell has
>>>>> to be relaunched.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> ---
>>>>>
>>>>> v2: Adjusted the errors to whine about non-ENOENT errors, but still
>>>>>     intercept all errors as non-fatal.
>>>>>     Save history atexit() to match bash standard behavior
>>>>>
>>>>>  scripts/qmp/qmp-shell | 19 +++++++++++++++++++
>>>>>  1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
>>>>> index 0373b24..55a8285 100755
>>>>> --- a/scripts/qmp/qmp-shell
>>>>> +++ b/scripts/qmp/qmp-shell
>>>>> @@ -70,6 +70,9 @@ import json
>>>>>  import ast
>>>>>  import readline
>>>>>  import sys
>>>>> +import os
>>>>> +import errno
>>>>> +import atexit
>>>>>
>>>>>  class QMPCompleter(list):
>>>>>      def complete(self, text, state):
>>>>> @@ -109,6 +112,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>>>          self._pretty = pretty
>>>>>          self._transmode = False
>>>>>          self._actions = list()
>>>>> +        self._histfile = os.path.join(os.path.expanduser('~'), '.qmp_history')
> 
> I selfishly object to this filename, because I'm using it with
> 
>     $ socat UNIX:/work/armbru/images/test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
> 
> Just kidding.  But seriously, shouldn't this be named after the
> *application* (qmp-shell) rather than the protocol (qmp)?
> 

Seeing as the history itself is the qmp-shell syntax, you are correct.

(Hey, it would be interesting to store the generated QMP into the
qmp_history, though...!)

>>>>>
>>>>>      def __get_address(self, arg):
>>>>>          """
>>>>> @@ -137,6 +141,21 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>>>          # XXX: default delimiters conflict with some command names (eg. query-),
>>>>>          # clearing everything as it doesn't seem to matter
>>>>>          readline.set_completer_delims('')
>>>>> +        try:
>>>>> +            readline.read_history_file(self._histfile)
>>>>> +        except Exception as e:
>>>>> +            if isinstance(e, IOError) and e.errno == errno.ENOENT:
>>>>> +                # File not found. No problem.
>>>>> +                pass
>>>>> +            else:
>>>>> +                print "Failed to read history '%s'; %s" % (self._histfile, e)
>>>>
>>>> I would handle only IOError, since any other error means a bug in this code
>>>> or in the underlying readline library, and the best way to handle this is to
>>>> let it fail loudly.
>>>>
>>>
>>> Disagree. No reason to stop the shell from working because a QOL feature
>>> didn't initialize correctly.
>>>
>>> The warning will be enough to solicit reports and fixes if necessary.
>>
>> I agree, the current solution is good tradeoff.
> 
> For what it's worth, bash seems to silently ignore a history file it
> can't read.  Tested by running "HISTFILE=xxx bash", then chmod 0 xxx, da
> capo.
> 

Right, done by example.

>> One thing missing, is a call to readline.set_history_length, without
>> it the history
>> will grow without limit, see:
>> https://docs.python.org/2/library/readline.html#readline.set_history_length
> 
> Should this be addressed for 2.9?
> 

You can add a limit if you want to; I don't have suggestions for which
completely arbitrary limit makes sense, so I left it blank intentionally.

>>>>> +        atexit.register(self.__save_history)
>>>>> +
>>>>> +    def __save_history(self):
>>>>> +        try:
>>>>> +            readline.write_history_file(self._histfile)
>>>>> +        except Exception as e:
>>>>> +            print "Failed to save history file '%s'; %s" % (self._histfile, e)
>>>>>
>>>>>      def __parse_value(self, val):
>>>>>          try:
>>>>
>>>> But I think this is good enough and useful as is.
>>>>
>>>> Reviewed-by: Nir Soffer <nirsof@gmail.com>
>>>>
