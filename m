Received: from eggs.gnu.org ([2001:4830:134:3::10]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dlN-0000Tj-TS
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dlM-0004lu-SJ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:25 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dlM-0004l5-NL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:27:24 -0400
Received: by mail-qt0-x22f.google.com with SMTP id f8so22224953qtg.12
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:27:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-6-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd014c44-7c62-ebdd-f40a-1ac10e1d9495@amsat.org>
Date: Wed, 4 Apr 2018 05:27:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-6-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 05/18] qemu.py: Split _base_args()
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
> Split it into _monitor_args() and _display_args(), so we can make
> monitor args optional later.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index c051c4525a..d9f85bb153 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -173,15 +173,20 @@ class QEMUMachine(object):
>          else:
>              return os.path.join(self._temp_dir, self._name + "-monitor.sock")
>  
> -    def _base_args(self):
> +    def _monitor_args(self):
>          addr = self._vm_monitor()
>          if isinstance(addr, tuple):
>              moncdev = "socket,id=mon,host=%s,port=%s" % (addr[0], addr[1])
>          else:
>              moncdev = 'socket,id=mon,path=%s' % (addr)
>          return ['-chardev', moncdev,
> -                '-mon', 'chardev=mon,mode=control',
> -                '-display', 'none', '-vga', 'none']
> +                '-mon', 'chardev=mon,mode=control']
> +
> +    def _display_args(self):
> +        return ['-display', 'none', '-vga', 'none']
> +
> +    def _base_args(self):
> +        return self._monitor_args() + self._display_args()
>  
>      def _pre_launch(self):
>          self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> 
