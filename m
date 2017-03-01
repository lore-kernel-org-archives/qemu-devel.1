Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cjCJt-0003U0-NX
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cjCJs-0000dx-Mo
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:01 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1cjCJs-0000dr-IH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:00 -0500
Received: by mail-ot0-x243.google.com with SMTP id k4so5621024otc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 14:01:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301194433.23379-1-jsnow@redhat.com>
References: <20170301194433.23379-1-jsnow@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 2 Mar 2017 00:01:57 +0200
Message-ID: <CAMr-obvmL+fHRvEGq+U7S30FSFDZ2USiw2DKOKbJN0dZ=AUZPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: add persistent command history
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

On Wed, Mar 1, 2017 at 9:44 PM, John Snow <jsnow@redhat.com> wrote:
>
> Use the existing readline history function we are utilizing
> to provide persistent command history across instances of qmp-shell.
>
> This assists entering debug commands across sessions that may be
> interrupted by QEMU sessions terminating, where the qmp-shell has
> to be relaunched.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 0373b24..b19f44b 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -70,6 +70,7 @@ import json
>  import ast
>  import readline
>  import sys
> +import os
>
>  class QMPCompleter(list):
>      def complete(self, text, state):
> @@ -109,6 +110,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>          self._pretty = pretty
>          self._transmode = False
>          self._actions = list()
> +        self._histfile = os.path.join(os.path.expanduser('~'),
> +                                      '.qmp_history')

This can be little bit more readable in one line

>
>      def __get_address(self, arg):
>          """
> @@ -137,6 +140,16 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>          # XXX: default delimiters conflict with some command names (eg. query-),
>          # clearing everything as it doesn't seem to matter
>          readline.set_completer_delims('')
> +        try:
> +            readline.read_history_file(self._histfile)
> +        except:
> +            pass

This hides all errors, including KeyboardInterrupt and SystemExit, and will
make debugging impossible.

It looks like you want to ignore missing history file, but this way we also
ignore permission error or even typo in the code. For example this will
fail silently:

    try:
        readdline.read_history_file(self._histfile)
    except:
        pass

The docs do not specify the possible errors, but the code is raising IOError:
https://github.com/python/cpython/blob/2.7/Modules/readline.c#L126

So it would be best to handle only IOError, and ignore ENOENT. Any other
error should fail in a visible way.

> +
> +    def __save_history(self):
> +        try:
> +            readline.write_history_file(self._histfile)
> +        except:
> +            pass

Same, but I'm not sure what errors should be ignored. Do we want to silently
ignore a read only file system? no space?

I think a safe way would be to print a warning if the history file
cannot be saved
with the text from the IOError.

>
>      def __parse_value(self, val):
>          try:
> @@ -244,6 +257,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>              print 'command format: <command-name> ',
>              print '[arg-name1=arg1] ... [arg-nameN=argN]'
>              return True
> +        self.__save_history()

This will save the history after every command, making error handling
more complicated, and also unneeded, since we don't care about history
if you kill the qmp-shell process, right?

We can invoke readline.write_history_file() using atexit. This is also
what the docs suggest, see:
https://docs.python.org/2/library/readline.html#example

Nir

>          # For transaction mode, we may have just cached the action:
>          if qmpcmd is None:
>              return True
> --
> 2.9.3
>
>
