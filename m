Received: from eggs.gnu.org ([2001:4830:134:3::10]:53714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cjRgJ-0000Mp-64
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cjRgG-0002vb-0q
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:26:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cjRgF-0002uF-OC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:26:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 054CC811A7
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 14:26:07 +0000 (UTC)
Date: Thu, 2 Mar 2017 15:22:16 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170302142216.rrvf4yczal7gi6bq@eukaryote>
References: <20170301194433.23379-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301194433.23379-1-jsnow@redhat.com>
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

On Wed, Mar 01, 2017 at 02:44:33PM -0500, John Snow wrote:
> Use the existing readline history function we are utilizing
> to provide persistent command history across instances of qmp-shell.

Thanks for adding it to 'qmp-shell' this is useful.  I normally use the
READLINE functionality using 'qmp_history' file in conjunction with
`socat` (thanks: Markus Armbruster).

    $ socat UNIX:./qmp-sock READLINE,history=$HOME/.qmp_history,prompt='QMP> '

As I often shuffle between 'qmp-shell' and `socat`, so having the
history file conveniently track history is very handy.

> This assists entering debug commands across sessions that may be
> interrupted by QEMU sessions terminating, where the qmp-shell has
> to be relaunched.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

I just tested this patch.  And the bare-bones functionality works fine
for me: if the 'qmp_history' file already exists, it'll just append the
history to it; otherwise, it'll create one.

And I have the same question as you, to Nir (especially, I do care
about the history if the 'qmp-shell' process is killed).

For now, I'm abivalent about handling ENOSPC. 

So, with or without the error handling changes that you're discussing,
I'm fine with this initial version of the change, as it is additive.

Just for posterity, my test 'evidence'

- Apply the patch to current Git, and compile:

  $ git log --oneline | head -1
  b8c1c7b qmp-shell: add persistent command history
  
  $ ./qemu-system-x86_64 -version
  QEMU emulator version 2.8.50 (v2.8.0-1813-gb8c1c7b-dirty)

- Run a minimal QEMU instance with '-qmp unix:./qmp-sock,server,nowait']

- Run a few commands from the QMP shell:

    $ ./qmp-shell -v -p /export/qmp-sock 

- Observe the history file:

    $ tail ~/.qmp_history 
    }
    {  
      "execute":"nbd-server-stop"
    }
    { "execute": "query-block" }
    query-block
    query-name
    query-named-block-nodes
    query-kvm
    quit

You see both the raw QMP JSON and 'qmp-shell' history there (as I
mentioned I shuffle between both).

So, FWIW:

  Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

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
> +
> +    def __save_history(self):
> +        try:
> +            readline.write_history_file(self._histfile)
> +        except:
> +            pass
>  
>      def __parse_value(self, val):
>          try:
> @@ -244,6 +257,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>              print 'command format: <command-name> ',
>              print '[arg-name1=arg1] ... [arg-nameN=argN]'
>              return True
> +        self.__save_history()
>          # For transaction mode, we may have just cached the action:
>          if qmpcmd is None:
>              return True
> -- 
> 2.9.3
> 

-- 
/kashyap
