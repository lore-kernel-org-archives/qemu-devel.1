Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJ5y-0004z4-UF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJ5t-0004Nz-9o
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJ5t-0004Mx-23
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:04:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170303185427.32681-1-jsnow@redhat.com>
	<CAMr-obuiwE_ef6OPSJbBtmZYsaqo_mzU9E6q8zhbrviZ6_=krQ@mail.gmail.com>
	<5303cac4-a8d8-bf89-b525-3b0fb1b19127@redhat.com>
	<CAMr-obsrUqvqbLabYgKgv1J+ztn5XCwto6LowoN=S0ZWuFLZMA@mail.gmail.com>
	<871sua4y3u.fsf@dusky.pond.sub.org>
	<3fbdfabf-82b4-d774-d5f4-2c50a6d740dc@redhat.com>
	<87efy9ijrf.fsf@dusky.pond.sub.org>
	<c9905f84-846a-4656-14cd-a8bd7628ea08@redhat.com>
	<878tog1dtc.fsf@dusky.pond.sub.org>
	<CAMr-obtywhYemkHd8=mjXFHT=NZM4uAFC-H8ftJbPjTtciU__g@mail.gmail.com>
Date: Mon, 13 Mar 2017 07:04:29 +0100
In-Reply-To: <CAMr-obtywhYemkHd8=mjXFHT=NZM4uAFC-H8ftJbPjTtciU__g@mail.gmail.com>
	(Nir Soffer's message of "Wed, 8 Mar 2017 18:13:27 +0200")
Message-ID: <87fuihn24y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Nir Soffer <nirsof@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

Nir Soffer <nirsof@gmail.com> writes:

> On Wed, Mar 8, 2017 at 8:29 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 03/07/2017 03:16 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> On 03/06/2017 03:18 AM, Markus Armbruster wrote:
>>>>>> Nir Soffer <nirsof@gmail.com> writes:
>>>>>>
>>>>>>> On Fri, Mar 3, 2017 at 9:29 PM, John Snow <jsnow@redhat.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 03/03/2017 02:26 PM, Nir Soffer wrote:
>>>>>>>>> On Fri, Mar 3, 2017 at 8:54 PM, John Snow <jsnow@redhat.com> wrote:
>>>>>>>>>> Use the existing readline history function we are utilizing
>>>>>>>>>> to provide persistent command history across instances of qmp-shell.
>>>>>>>>>>
>>>>>>>>>> This assists entering debug commands across sessions that may be
>>>>>>>>>> interrupted by QEMU sessions terminating, where the qmp-shell has
>>>>>>>>>> to be relaunched.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> v2: Adjusted the errors to whine about non-ENOENT errors, but still
>>>>>>>>>>     intercept all errors as non-fatal.
>>>>>>>>>>     Save history atexit() to match bash standard behavior
>>>>>>>>>>
>>>>>>>>>>  scripts/qmp/qmp-shell | 19 +++++++++++++++++++
>>>>>>>>>>  1 file changed, 19 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
>>>>>>>>>> index 0373b24..55a8285 100755
>>>>>>>>>> --- a/scripts/qmp/qmp-shell
>>>>>>>>>> +++ b/scripts/qmp/qmp-shell
>>>>>>>>>> @@ -70,6 +70,9 @@ import json
>>>>>>>>>>  import ast
>>>>>>>>>>  import readline
>>>>>>>>>>  import sys
>>>>>>>>>> +import os
>>>>>>>>>> +import errno
>>>>>>>>>> +import atexit
>>>>>>>>>>
>>>>>>>>>>  class QMPCompleter(list):
>>>>>>>>>>      def complete(self, text, state):
>>>>>>>>>> @@ -109,6 +112,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>>>>>>>>          self._pretty = pretty
>>>>>>>>>>          self._transmode = False
>>>>>>>>>>          self._actions = list()
>>>>>>>>>> +        self._histfile = os.path.join(os.path.expanduser('~'), '.qmp_history')
>>>>>>
>>>>>> I selfishly object to this filename, because I'm using it with
>>>>>>
>>>>>>     $ socat UNIX:/work/armbru/images/test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>>>>>>
>>>>>> Just kidding.  But seriously, shouldn't this be named after the
>>>>>> *application* (qmp-shell) rather than the protocol (qmp)?
>>>>>>
>>>>>
>>>>> Seeing as the history itself is the qmp-shell syntax, you are correct.
>>>>>
>>>>> (Hey, it would be interesting to store the generated QMP into the
>>>>> qmp_history, though...!)
>>>>
>>>> Hah!  Saving it would be easy enough, but reloading it...  okay, call it
>>>> a "backup" and declare victory when saving works.
>>>>
>>>>>>>>>>
>>>>>>>>>>      def __get_address(self, arg):
>>>>>>>>>>          """
>>>>>>>>>> @@ -137,6 +141,21 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>>>>>>>>          # XXX: default delimiters conflict with some command names (eg. query-),
>>>>>>>>>>          # clearing everything as it doesn't seem to matter
>>>>>>>>>>          readline.set_completer_delims('')
>>>>>>>>>> +        try:
>>>>>>>>>> +            readline.read_history_file(self._histfile)
>>>>>>>>>> +        except Exception as e:
>>>>>>>>>> +            if isinstance(e, IOError) and e.errno == errno.ENOENT:
>>>>>>>>>> +                # File not found. No problem.
>>>>>>>>>> +                pass
>>>>>>>>>> +            else:
>>>>>>>>>> +                print "Failed to read history '%s'; %s" % (self._histfile, e)
>>>>>>>>>
>>>>>>>>> I would handle only IOError, since any other error means a bug in this code
>>>>>>>>> or in the underlying readline library, and the best way to handle this is to
>>>>>>>>> let it fail loudly.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Disagree. No reason to stop the shell from working because a QOL feature
>>>>>>>> didn't initialize correctly.
>>>>>>>>
>>>>>>>> The warning will be enough to solicit reports and fixes if necessary.
>>>>>>>
>>>>>>> I agree, the current solution is good tradeoff.
>>>>>>
>>>>>> For what it's worth, bash seems to silently ignore a history file it
>>>>>> can't read.  Tested by running "HISTFILE=xxx bash", then chmod 0 xxx, da
>>>>>> capo.
>>>>>>
>>>>>
>>>>> Right, done by example.
>>>>>
>>>>>>> One thing missing, is a call to readline.set_history_length, without
>>>>>>> it the history
>>>>>>> will grow without limit, see:
>>>>>>> https://docs.python.org/2/library/readline.html#readline.set_history_length
>>>>>>
>>>>>> Should this be addressed for 2.9?
>>>>>>
>>>>>
>>>>> You can add a limit if you want to; I don't have suggestions for which
>>>>> completely arbitrary limit makes sense, so I left it blank intentionally.
>>>>
>>>> For what it's worth, bash defaults HISTSIZE to 500.
>>>>
>>>> GNU Readline lets users configure it in ~/.inputrc.  Conditional
>>>> configuration is possible, i.e. something like
>>>>
>>>>     $if Qmp-shell
>>>>     set history-size 5000
>>>>     $endif
>>>>
>>>> should work, provided qmp-shell sets rl_readline_name as it should.
>>>>
>>>
>>> Spoke too soon. I don't see a way to control this in python's readline
>>> library... I'm not very familiar with readline, is there some
>>> environment variable or something perhaps?
>>> (It looks like python's code just hard-sets it to "python" ...)
>>
>> How sad.  If https://bugs.python.org/ didn't require a login, I would've
>> filed a bug already.
>>
>> I'm afraid all I can offer meanwhile is INPUTRC:
>>
>>     Any user can customize programs that use Readline by putting
>>     commands in an "inputrc" file, conventionally in his home directory.
>>     The name of this file is taken from the value of the environment
>>     variable `INPUTRC'.  If that variable is unset, the default is
>>     `~/.inputrc'.  If that file does not exist or cannot be read, the
>>     ultimate default is `/etc/inputrc'.
>>
>
> Having a way to limit history globally looks good enough.

Certainly good enough for merging qmp-shell patches.

> Note that python readline does not report the readline
> limit correctly (get_history_length() returns -1), but saving
> history uses the limit defined  in .inputrc.
>
> Playing with this, I found a nice bug - if you set history
> size to N, and your history file contains 2 * N items or more,
> python segfaults when entering the first input line.
>
> I'll file a python bug later.

Please do.

If you could throw in a (separate) request for letting us set
rl_readline_name, that would be great.

[...]
