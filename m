Received: from eggs.gnu.org ([2001:4830:134:3::10]:36861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDYq8-0005HA-O2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDYq4-0005FN-L9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:45:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDYq3-00056L-CN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:45:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so4392400wmg.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 10:45:14 -0700 (PDT)
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-3-f4bug@amsat.org>
	<6dd4b200-03d1-728d-45b2-a89c5461d5cc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6122fc49-c67e-d6ef-0225-691426581eb7@redhat.com>
Date: Fri, 19 Oct 2018 19:45:07 +0200
MIME-Version: 1.0
In-Reply-To: <6dd4b200-03d1-728d-45b2-a89c5461d5cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 2/6] tests/acceptance: Add a kludge
 to not use the default console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 19/10/2018 19:37, Cleber Rosa wrote:
> On 10/13/18 11:15 AM, Philippe Mathieu-Daudé wrote:
>> The board already instantiate the proper devices, we don't want to
>> add extra devices but connect the chardev to one of the serial already
>> available.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  scripts/qemu.py | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index fca9b76990..7e779954e6 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -221,8 +221,10 @@ class QEMUMachine(object):
>>                                                   self._name + "-console.sock")
>>              chardev = ('socket,id=console,path=%s,server,nowait' %
>>                         self._console_address)
>> -            device = '%s,chardev=console' % self._console_device_type
>> -            args.extend(['-chardev', chardev, '-device', device])
>> +            args.extend(['-chardev', chardev])
>> +            if len(self._console_device_type):
> 
> Considering `self._console_device_type` will come from `set_console()`,
> either explicitly as the "device_type" parameter, or from the list on
> CONSOLE_DEV_TYPES, wouldn't it make more sense to just drop the
> definitions for the machine types that don't need an explicit device?
> 
> That way, self.set_console() could be called with no arguments (instead
> of the empty string).  And this check would become:
> 
>   if self._console_device_type is not None:

Clever Cleber!

> 
>> +                device = '%s,chardev=console' % self._console_device_type
>> +                args.extend(['-device', device])
>>          return args
>>  
>>      def _pre_launch(self):
>>
> 
> 
