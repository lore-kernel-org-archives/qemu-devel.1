Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkW-0008Lh-1X
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkV-0004Im-4u
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:32 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:41337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkV-0004IR-0X
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:31 -0400
Received: by mail-qk0-x22a.google.com with SMTP id s78so21604843qkl.8
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:26:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-4-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4e675a5-b555-e6d1-d516-01926a4abf5e@amsat.org>
Date: Wed, 4 Apr 2018 05:26:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 03/18] qmp.py: Cleanly handle unexpectedly
 closed socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

On 03/29/2018 06:38 PM, Eduardo Habkost wrote:
> QEMUMonitorProtocol.cmd() returns None if the socket was closed,
> so callers must handle this case explicltly.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qmp/qmp.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index e9cb6b2683..91b537ea04 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -73,6 +73,8 @@ class QEMUMonitorProtocol(object):
>              raise QMPConnectError
>          # Greeting seems ok, negotiate capabilities
>          resp = self.cmd('qmp_capabilities')
> +        if resp is None:
> +            raise QMPConnectError("QMP connection unexpectedly closed")
>          if "return" in resp:
>              return greeting
>          raise QMPCapabilitiesError
> @@ -182,6 +184,8 @@ class QEMUMonitorProtocol(object):
>          @param name: command name (string)
>          @param args: command arguments (dict)
>          @param cmd_id: command id (dict, list, string or int)
> +        @return QMP response as a Python dict or None if the connection has
> +                been closed
>          """
>          qmp_cmd = {'execute': name}
>          if args:
> @@ -195,6 +199,8 @@ class QEMUMonitorProtocol(object):
>          Build and send a QMP command to the monitor, report errors if any
>          """
>          ret = self.cmd(cmd, kwds)
> +        if ret is None:
> +            raise QMPConnectError("QMP connection unexpectedly closed")
>          if "error" in ret:
>              raise Exception(ret['error']['desc'])
>          return ret['return']
> 
