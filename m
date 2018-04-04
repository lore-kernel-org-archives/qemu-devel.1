Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkQ-0008Hc-E8
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkN-00044B-Av
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:26 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:45735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dkN-00042p-3S
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:26:23 -0400
Received: by mail-qt0-x22b.google.com with SMTP id f8so22222771qtg.12
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:26:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <188e5aff-d5eb-9f04-8970-50917ee42492@amsat.org>
Date: Wed, 4 Apr 2018 05:26:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 02/18] qmp.py: Fix error handling for Python 3
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
> socket.error doesn't behave like a tuple in Python 3, but we can
> use error.args on both Python 2.7 and 3.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qmp/qmp.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 078ce65f3b..e9cb6b2683 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -108,7 +108,7 @@ class QEMUMonitorProtocol(object):
>          try:
>              self.__json_read()
>          except socket.error as err:
> -            if err[0] == errno.EAGAIN:
> +            if err.args[0] == errno.EAGAIN:
>                  # No data available
>                  pass
>          self.__sock.setblocking(1)
> @@ -168,9 +168,9 @@ class QEMUMonitorProtocol(object):
>          try:
>              self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>          except socket.error as err:
> -            if err[0] == errno.EPIPE:
> +            if err.args[0] == errno.EPIPE:
>                  return
> -            raise socket.error(err)
> +            raise
>          resp = self.__json_read()
>          self.logger.debug("<<< %s", resp)
>          return resp
> 
