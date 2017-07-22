Received: from eggs.gnu.org ([2001:4830:134:3::10]:43016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjFj-00076S-Lr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjFe-0001u3-FL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:30:43 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:33241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjFe-0001tk-84
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:30:38 -0400
Received: by mail-qt0-x22d.google.com with SMTP id n42so48861074qtn.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:30:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-7-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
Date: Fri, 21 Jul 2017 22:30:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170720162815.19802-7-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

Hi Lukáš,

Since comment/indent fixes and code changes are not related I'd rather 
see this split in at least 2 patches.

On 07/20/2017 01:28 PM, Lukáš Doktor wrote:
> No actual code changes, just a few pylint/style fixes and docstring
> clarifications.
> 
> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>
> ---
>   scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 62d3651..bb4d614 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -13,19 +13,30 @@ import errno
>   import socket
>   import sys
>   
> +
>   class QMPError(Exception):
>       pass
>   
> +
>   class QMPConnectError(QMPError):
>       pass
>   
> +
>   class QMPCapabilitiesError(QMPError):
>       pass
>   
> +
>   class QMPTimeoutError(QMPError):
>       pass
>   
> +
>   class QEMUMonitorProtocol:
> +
> +    #: Socket's error class
> +    error = socket.error
> +    #: Socket's timeout
> +    timeout = socket.timeout
> +

ok

>       def __init__(self, address, server=False, debug=False):
>           """
>           Create a QEMUMonitorProtocol class.
> @@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
>           self.__address = address
>           self._debug = debug
>           self.__sock = self.__get_sock()
> +        self.__sockfile = None
>           if server:
>               self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
>               self.__sock.bind(self.__address)
> @@ -56,7 +68,7 @@ class QEMUMonitorProtocol:
>   
>       def __negotiate_capabilities(self):
>           greeting = self.__json_read()
> -        if greeting is None or not greeting.has_key('QMP'):
> +        if greeting is None or "QMP" not in greeting:

ok

>               raise QMPConnectError
>           # Greeting seems ok, negotiate capabilities
>           resp = self.cmd('qmp_capabilities')
> @@ -78,8 +90,6 @@ class QEMUMonitorProtocol:
>                       continue
>               return resp
>   
> -    error = socket.error
> -
>       def __get_events(self, wait=False):
>           """
>           Check for new events in the stream and cache them in __events.
> @@ -89,8 +99,8 @@ class QEMUMonitorProtocol:
>   
>           @raise QMPTimeoutError: If a timeout float is provided and the timeout
>                                   period elapses.
> -        @raise QMPConnectError: If wait is True but no events could be retrieved
> -                                or if some other error occurred.
> +        @raise QMPConnectError: If wait is True but no events could be
> +                                retrieved or if some other error occurred.
>           """
>   
>           # Check for new events regardless and pull them into the cache:
> @@ -175,7 +185,7 @@ class QEMUMonitorProtocol:
>           @param args: command arguments (dict)
>           @param id: command id (dict, list, string or int)
>           """
> -        qmp_cmd = { 'execute': name }
> +        qmp_cmd = {'execute': name}
>           if args:
>               qmp_cmd['arguments'] = args
>           if id:
> @@ -183,6 +193,9 @@ class QEMUMonitorProtocol:
>           return self.cmd_obj(qmp_cmd)
>   
>       def command(self, cmd, **kwds):
> +        """
> +        Build and send a QMP command to the monitor, report errors when any

I'm not native english speaker but I think "if any" sounds better.

> +        """
>           ret = self.cmd(cmd, kwds)
>           if ret.has_key('error'):
>               raise Exception(ret['error']['desc'])
> @@ -190,15 +203,15 @@ class QEMUMonitorProtocol:
>   
>       def pull_event(self, wait=False):
>           """
> -        Get and delete the first available QMP event.
> +        Get and pop the first available QMP event.

Both sentences seems unclear to me, regarding the function name... I 
wonder if removing this comment makes this function clearer.

>   
>           @param wait (bool): block until an event is available.
>           @param wait (float): If wait is a float, treat it as a timeout value.
>   
>           @raise QMPTimeoutError: If a timeout float is provided and the timeout
>                                   period elapses.
> -        @raise QMPConnectError: If wait is True but no events could be retrieved
> -                                or if some other error occurred.
> +        @raise QMPConnectError: If wait is True but no events could be
> +                                retrieved or if some other error occurred.
>   
>           @return The first available QMP event, or None.
>           """
> @@ -217,8 +230,8 @@ class QEMUMonitorProtocol:
>   
>           @raise QMPTimeoutError: If a timeout float is provided and the timeout
>                                   period elapses.
> -        @raise QMPConnectError: If wait is True but no events could be retrieved
> -                                or if some other error occurred.
> +        @raise QMPConnectError: If wait is True but no events could be
> +                                retrieved or if some other error occurred.
>   
>           @return The list of available QMP events.
>           """
> @@ -235,8 +248,6 @@ class QEMUMonitorProtocol:
>           self.__sock.close()
>           self.__sockfile.close()
>   
> -    timeout = socket.timeout
> -
>       def settimeout(self, timeout):
>           self.__sock.settimeout(timeout)
>   
> 

Regards,

Phil.
