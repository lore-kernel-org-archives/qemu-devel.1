Received: from eggs.gnu.org ([2001:4830:134:3::10]:51986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dlo-0000tj-SW
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dll-00058T-OJ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:52 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dll-00058H-Iq
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:49 -0400
Received: by mail-qk0-x22e.google.com with SMTP id p67so13107496qke.13
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:27:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-7-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c0b6107-2870-7ddc-5c01-8ee9b8c21c6e@amsat.org>
Date: Wed, 4 Apr 2018 05:27:43 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-7-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 06/18] qemu.py: Move _load_io_log() call to
 _post_shutdown()
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
> All callers of _post_shutdown() call _load_io_log(), so it's
> easier to simply call it inside _post_shutdown().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index d9f85bb153..84bb3da613 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -199,6 +199,7 @@ class QEMUMachine(object):
>          self._qmp.accept()
>  
>      def _post_shutdown(self):
> +        self._load_io_log()
>          if self._qemu_log_file is not None:
>              self._qemu_log_file.close()
>              self._qemu_log_file = None
> @@ -250,7 +251,6 @@ class QEMUMachine(object):
>          '''Wait for the VM to power off'''
>          self._popen.wait()
>          self._qmp.close()
> -        self._load_io_log()
>          self._post_shutdown()
>  
>      def shutdown(self):
> @@ -263,7 +263,6 @@ class QEMUMachine(object):
>                  self._popen.kill()
>              self._popen.wait()
>  
> -        self._load_io_log()
>          self._post_shutdown()
>  
>          exitcode = self.exitcode()
> 
