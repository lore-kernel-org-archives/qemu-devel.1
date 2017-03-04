Received: from eggs.gnu.org ([2001:4830:134:3::10]:38593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ckFeF-0000S5-JN
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ckFeE-0007on-Df
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:47:23 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1ckFeE-0007n9-9M
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:47:22 -0500
Received: by mail-oi0-x241.google.com with SMTP id x195so5766670oia.2
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 11:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5303cac4-a8d8-bf89-b525-3b0fb1b19127@redhat.com>
References: <20170303185427.32681-1-jsnow@redhat.com>
	<CAMr-obuiwE_ef6OPSJbBtmZYsaqo_mzU9E6q8zhbrviZ6_=krQ@mail.gmail.com>
	<5303cac4-a8d8-bf89-b525-3b0fb1b19127@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Sat, 4 Mar 2017 21:47:19 +0200
Message-ID: <CAMr-obsrUqvqbLabYgKgv1J+ztn5XCwto6LowoN=S0ZWuFLZMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Fri, Mar 3, 2017 at 9:29 PM, John Snow <jsnow@redhat.com> wrote:
>
>
> On 03/03/2017 02:26 PM, Nir Soffer wrote:
>> On Fri, Mar 3, 2017 at 8:54 PM, John Snow <jsnow@redhat.com> wrote:
>>> Use the existing readline history function we are utilizing
>>> to provide persistent command history across instances of qmp-shell.
>>>
>>> This assists entering debug commands across sessions that may be
>>> interrupted by QEMU sessions terminating, where the qmp-shell has
>>> to be relaunched.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>
>>> v2: Adjusted the errors to whine about non-ENOENT errors, but still
>>>     intercept all errors as non-fatal.
>>>     Save history atexit() to match bash standard behavior
>>>
>>>  scripts/qmp/qmp-shell | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
>>> index 0373b24..55a8285 100755
>>> --- a/scripts/qmp/qmp-shell
>>> +++ b/scripts/qmp/qmp-shell
>>> @@ -70,6 +70,9 @@ import json
>>>  import ast
>>>  import readline
>>>  import sys
>>> +import os
>>> +import errno
>>> +import atexit
>>>
>>>  class QMPCompleter(list):
>>>      def complete(self, text, state):
>>> @@ -109,6 +112,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>          self._pretty = pretty
>>>          self._transmode = False
>>>          self._actions = list()
>>> +        self._histfile = os.path.join(os.path.expanduser('~'), '.qmp_history')
>>>
>>>      def __get_address(self, arg):
>>>          """
>>> @@ -137,6 +141,21 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>>>          # XXX: default delimiters conflict with some command names (eg. query-),
>>>          # clearing everything as it doesn't seem to matter
>>>          readline.set_completer_delims('')
>>> +        try:
>>> +            readline.read_history_file(self._histfile)
>>> +        except Exception as e:
>>> +            if isinstance(e, IOError) and e.errno == errno.ENOENT:
>>> +                # File not found. No problem.
>>> +                pass
>>> +            else:
>>> +                print "Failed to read history '%s'; %s" % (self._histfile, e)
>>
>> I would handle only IOError, since any other error means a bug in this code
>> or in the underlying readline library, and the best way to handle this is to
>> let it fail loudly.
>>
>
> Disagree. No reason to stop the shell from working because a QOL feature
> didn't initialize correctly.
>
> The warning will be enough to solicit reports and fixes if necessary.

I agree, the current solution is good tradeoff.

One thing missing, is a call to readline.set_history_length, without
it the history
will grow without limit, see:
https://docs.python.org/2/library/readline.html#readline.set_history_length

>
>>> +        atexit.register(self.__save_history)
>>> +
>>> +    def __save_history(self):
>>> +        try:
>>> +            readline.write_history_file(self._histfile)
>>> +        except Exception as e:
>>> +            print "Failed to save history file '%s'; %s" % (self._histfile, e)
>>>
>>>      def __parse_value(self, val):
>>>          try:
>>
>> But I think this is good enough and useful as is.
>>
>> Reviewed-by: Nir Soffer <nirsof@gmail.com>
>>
