Received: from eggs.gnu.org ([209.51.188.92]:38701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpHPa-0001oD-J3
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpHPZ-0007pP-OB
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:50:06 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-12-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <dca0df17-749f-a94a-c036-4b60b4814a46@redhat.com>
Date: Thu, 31 Jan 2019 16:49:55 -0200
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-12-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 11/18] scripts/qemu.py: support adding a
 console with the default serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi Cleber,

me again. :)

On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> The set_console() utility function traditionally adds a device either
> based on the explicitly given device type, or based on the machine type,
> a known good type of device.
>
> But, for a number of machine types, it may be impossible or
> inconvenient to add the devices my means of "-device" command line
> options, and then it may better to just use the "-serial" option and
> let QEMU itself, based on the machine type, set the device
> accordingly.
>
> To achieve that, the behavior of set_console() now flags the intention
> to add a console device on launch(), and if no explicit device type is
> given, and there's no definition on CONSOLE_DEV_TYPES, the "-serial"
> is going to be added to the QEMU command line, instead of raising
> exceptions.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   scripts/qemu.py | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index ec3567d4e2..88e1608b42 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -121,6 +121,7 @@ class QEMUMachine(object):
>           self._temp_dir = None
>           self._launched = False
>           self._machine = None
> +        self._console_set = False
>           self._console_device_type = None
>           self._console_address = None
>           self._console_socket = None
> @@ -240,13 +241,17 @@ class QEMUMachine(object):
>                   '-display', 'none', '-vga', 'none']
>           if self._machine is not None:
>               args.extend(['-machine', self._machine])
> -        if self._console_device_type is not None:
> +        if self._console_set:
>               self._console_address = os.path.join(self._temp_dir,
>                                                    self._name + "-console.sock")
>               chardev = ('socket,id=console,path=%s,server,nowait' %
>                          self._console_address)
> -            device = '%s,chardev=console' % self._console_device_type
> -            args.extend(['-chardev', chardev, '-device', device])
> +            args.extend(['-chardev', chardev])
> +            if self._console_device_type is None:
> +                args.extend(['-serial', 'chardev:console'])
> +            else:
> +                device = '%s,chardev=console' % self._console_device_type
> +                args.extend(['-device', device])
>           return args
>   
>       def _pre_launch(self):
> @@ -479,23 +484,20 @@ class QEMUMachine(object):
>           machine launch time, as it depends on the temporary directory
>           to be created.
>   
> -        @param device_type: the device type, such as "isa-serial"
> +        @param device_type: the device type, such as "isa-serial".  If
> +                            None is given (the default value) a "-serial
> +                            chardev:console" command line argument will
> +                            be used instead, resorting to the machine's
> +                            default device type.

Shouldn't you mention it will look for device type on CONSOLE_DEV_TYPES 
if device_type is None and machine is not None?

The description on set_console()'s docstring is out-of-sync with current 
implementation too.

- Wainer

>           @raises: QEMUMachineAddDeviceError if the device type is not given
>                    and can not be determined.
>           """
> -        if device_type is None:
> -            if self._machine is None:
> -                raise QEMUMachineAddDeviceError("Can not add a console device:"
> -                                                " QEMU instance without a "
> -                                                "defined machine type")
> +        self._console_set = True
> +        if device_type is None and self._machine is not None:
>               for regex, device in CONSOLE_DEV_TYPES.items():
>                   if re.match(regex, self._machine):
>                       device_type = device
>                       break
> -            if device_type is None:
> -                raise QEMUMachineAddDeviceError("Can not add a console device:"
> -                                                " no matching console device "
> -                                                "type definition")
>           self._console_device_type = device_type
>   
>       @property
