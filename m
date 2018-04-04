Received: from eggs.gnu.org ([2001:4830:134:3::10]:52111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dmT-0001VE-9t
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dmQ-0005bQ-5f
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:28:33 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:40246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dmQ-0005aw-17
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:28:30 -0400
Received: by mail-qk0-x230.google.com with SMTP id o64so21614777qkl.7
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:28:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-9-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb83c679-c1cd-dcae-9469-4cf7cc608d13@amsat.org>
Date: Wed, 4 Apr 2018 05:28:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-9-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 08/18] qemu.py: Close _qmp inside
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
> This way all shutdown-related cleanup is kept in a single place.
> 
> While at it, set _qmp to None after closing the socket, to avoid
> trying to reuse it by mistake later.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 4a71542c6b..1241e7f10b 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -199,6 +199,10 @@ class QEMUMachine(object):
>          self._qmp.accept()
>  
>      def _post_shutdown(self):
> +        if self._qmp is not None:
> +            self._qmp.close()
> +            self._qmp = None
> +
>          self._load_io_log()
>          if self._qemu_log_file is not None:
>              self._qemu_log_file.close()
> @@ -250,7 +254,6 @@ class QEMUMachine(object):
>      def wait(self):
>          '''Wait for the VM to power off'''
>          self._popen.wait()
> -        self._qmp.close()
>          self._post_shutdown()
>  
>      def shutdown(self):
> 
