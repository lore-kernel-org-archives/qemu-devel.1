Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dnj-0002rL-5c
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dng-0006Av-2I
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:29:51 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3dnf-0006Aj-TI
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:29:47 -0400
Received: by mail-qk0-x232.google.com with SMTP id d206so21653445qkb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:29:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-12-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6de747e1-4504-12ff-0bf1-a4ca57720de7@amsat.org>
Date: Wed, 4 Apr 2018 05:29:42 -0300
MIME-Version: 1.0
In-Reply-To: <20180329213857.15499-12-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 11/18] qemu.py: Log crashes inside
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
> This will allow us to log QEMU crashes even if the test code uses
> .wait() instead of .shutdown().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 226d2c4d48..e19e4b34d0 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -225,6 +225,15 @@ class QEMUMachine(object):
>              shutil.rmtree(self._temp_dir)
>              self._temp_dir = None
>  
> +        exitcode = self.exitcode()
> +        if exitcode is not None and exitcode < 0:
> +            msg = 'qemu received signal %i: %s'
> +            if self._qemu_full_args:
> +                command = ' '.join(self._qemu_full_args)
> +            else:
> +                command = ''
> +            LOG.warn(msg, exitcode, command)
> +
>          self._launched = False
>  
>      def launch(self):
> @@ -279,15 +288,6 @@ class QEMUMachine(object):
>  
>          self.wait()
>  
> -        exitcode = self.exitcode()
> -        if exitcode is not None and exitcode < 0:
> -            msg = 'qemu received signal %i: %s'
> -            if self._qemu_full_args:
> -                command = ' '.join(self._qemu_full_args)
> -            else:
> -                command = ''
> -            LOG.warn(msg, exitcode, command)
> -
>      def qmp(self, cmd, conv_keys=True, **args):
>          '''Invoke a QMP command and return the response dict'''
>          qmp_args = dict()
> 
