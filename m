Received: from eggs.gnu.org ([2001:4830:134:3::10]:51169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACEn-0001fA-6y
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACEg-0008Rh-7e
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:01:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gACEg-0008RI-0D
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:01:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so5220022wrw.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 04:01:01 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
Date: Wed, 10 Oct 2018 13:00:59 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined
 machine type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/10/2018 01:26, Cleber Rosa wrote:
> Some targets require a machine type to be set, as there's no default
> (aarch64 is one example).  To give a consistent interface to users of
> this API, this changes set_machine() so that a predefined default can
> be used, if one is not given.  The approach used is exactly the same
> with the console device type.
> 
> Also, even when there's a default machine type, for some purposes,
> testing included, it's better if outside code is explicit about the
> machine type, instead of relying on whatever is set internally.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index d9e24a0c1a..fca9b76990 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES = {
>      r'^s390-ccw-virtio.*': 'sclpconsole',
>      }
>  
> +#: Maps archictures to the preferred machine type
> +MACHINE_TYPES = {
> +    r'^aarch64$': 'virt',
> +    r'^ppc$': 'g3beige',
> +    r'^ppc64$': 'pseries',
> +    r'^s390x$': 's390-ccw-virtio',
> +    r'^x86_64$': 'q35',

Why choose Q35 rather than PC (the default)?

I was wondering about how to generate variants/machines.json but this is
definitively something we want to do via a QMP query.

Eduardo what do you think?

> +    }
> +
>  
>  class QEMUMachineError(Exception):
>      """
> @@ -413,13 +422,24 @@ class QEMUMachine(object):
>          """
>          self._arch = arch
>  
> -    def set_machine(self, machine_type):
> +    def set_machine(self, machine_type=None):
>          '''
>          Sets the machine type
>  
>          If set, the machine type will be added to the base arguments
>          of the resulting QEMU command line.
>          '''
> +        if machine_type is None:
> +            if self._arch is None:
> +                raise QEMUMachineError("Can not set a default machine type: "
> +                                       "QEMU instance without a defined arch")
> +            for regex, machine in MACHINE_TYPES.items():
> +                if re.match(regex, self._arch):
> +                    machine_type = machine
> +                    break
> +            if machine_type is None:
> +                raise QEMUMachineError("Can not set a machine type: no "
> +                                       "matching machine type definition")
>          self._machine = machine_type
>  
>      def set_console(self, device_type=None):
> 
