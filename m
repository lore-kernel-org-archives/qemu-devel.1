Received: from eggs.gnu.org ([2001:4830:134:3::10]:37806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d4DGb-0004w4-R6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d4DGY-000263-Li
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:17:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1d4DGY-000254-CJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DED380042
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 21:17:24 +0000 (UTC)
Date: Fri, 28 Apr 2017 23:13:04 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170428211304.syetkl42juooegjl@eukaryote>
References: <20170427223628.20893-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427223628.20893-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qmp-shell: add persistent command
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

On Thu, Apr 27, 2017 at 06:36:28PM -0400, John Snow wrote:
> Use the existing readline history function we are utilizing
> to provide persistent command history across instances of qmp-shell.
> 
> This assists entering debug commands across sessions that may be
> interrupted by QEMU sessions terminating, where the qmp-shell has
> to be relaunched.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> 
> v3: Hardcoded limit of 1024 lines of history for now,
>     as setting limits in ~/.inputrc does not appear to work (Nir)

Yeah, as-is, this is strict improvement, so it's alright for now.

> v2: Adjusted the errors to whine about non-ENOENT errors, but still
>     intercept all errors as non-fatal.
>     Save history atexit() to match bash standard behavior
>
> 
>  scripts/qmp/qmp-shell | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
 
Can confim the, expected, 'atexit' behavior -- only upon termination
does the history file get saved:

    $ cat ~/.qmp-shell_history 
    query-block
    query-named-block-nodes
    query-kvm
    quit

Tested with:

  $ git describe
  v3.9.0-304-gca7305b

Most of my test procedure is noted in my response to the earlier
revisions:

https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg00356.html

> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index eccb88a..6ece6e7 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -70,6 +70,9 @@ import json
>  import ast
>  import readline
>  import sys
> +import os
> +import errno
> +import atexit
>  
>  class QMPCompleter(list):
>      def complete(self, text, state):
> @@ -109,6 +112,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>          self._pretty = pretty
>          self._transmode = False
>          self._actions = list()
> +        self._histfile = os.path.join(os.path.expanduser('~'),
> +                                      '.qmp-shell_history')

Thanks for changing the name :-)  Now the raw QMP history file
(~/.qmp_history) and 'qmp-shell' history file (~/qmp-shell_history)
won't collide.

>      def __get_address(self, arg):
>          """
> @@ -132,11 +137,27 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>      def __completer_setup(self):
>          self._completer = QMPCompleter()
>          self._fill_completion()
> +        readline.set_history_length(1024)
>          readline.set_completer(self._completer.complete)
>          readline.parse_and_bind("tab: complete")
>          # XXX: default delimiters conflict with some command names (eg. query-),
>          # clearing everything as it doesn't seem to matter
>          readline.set_completer_delims('')
> +        try:
> +            readline.read_history_file(self._histfile)
> +        except Exception as e:
> +            if isinstance(e, IOError) and e.errno == errno.ENOENT:
> +                # File not found. No problem.
> +                pass
> +            else:
> +                print "Failed to read history '%s'; %s" % (self._histfile, e)
> +        atexit.register(self.__save_history)
> +
> +    def __save_history(self):
> +        try:
> +            readline.write_history_file(self._histfile)
> +        except Exception as e:
> +            print "Failed to save history file '%s'; %s" % (self._histfile, e)
>  
>      def __parse_value(self, val):
>          try:
> -- 
> 2.9.3
> 

-- 
/kashyap
