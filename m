Received: from eggs.gnu.org ([2001:4830:134:3::10]:35611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaui-0003w8-0G
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaue-0002Bw-QE
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:41:00 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaue-0002BI-Kk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:40:56 -0400
Received: by mail-qt0-x244.google.com with SMTP id q12-v6so1556589qtp.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:40:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-5-f4bug@amsat.org> <87in62vq15.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <543f19ab-385c-4e77-b243-d6740b456360@amsat.org>
Date: Thu, 28 Jun 2018 14:40:49 -0300
MIME-Version: 1.0
In-Reply-To: <87in62vq15.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 06/28/2018 01:23 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Similar to the BootLinuxConsoleX86_64 test:
>> boot a Linux kernel on a Malta board and verify the serial is working.
>>
>> This test can be run using:
>>
>>     $ avocado run -t endian:big tests/acceptance
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/acceptance/boot_linux_console.py | 38 ++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 17dc8d58c1..72cf5e943c 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -46,3 +46,41 @@ class BootLinuxConsoleX86_64(Test):
>>                  break
>>              if 'Kernel panic - not syncing' in msg:
>>                  self.fail("Kernel panic reached")
>> +
>> +
>> +class BootLinuxConsoleMips(Test):
>> +    """
>> +    Boots a mips Linux kernel and checks that the console is operational
>> +    and the kernel command line is properly passed from QEMU to the kernel
>> +
>> +    :avocado: enable
>> +    :avocado: tags=endian:big
>> +    :avocado: tags=arch:mips
>> +    :avocado: tags=board:malta
>> +    """
>> +
>> +    arch = "mips"
>> +    timeout = 60
>> +
>> +    def test(self):
>> +        kernel_url = ('http://people.debian.org/~aurel32/qemu/mips/'
>> +                      'vmlinux-3.2.0-4-4kc-malta')
>> +        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
>> +        kernel_path = self.fetch_asset(kernel_url,
>> asset_hash=kernel_hash)
> 
> I'm uncomfortable using "random" binaries of websites as the source of
> our test kernels. I can see the justification for distro kernels as they
> at least have the infrastructure to rebuild from source if you really
> want to, but even then the distros don't cover a lot of the
> architectures.

And now I notice I made an mistake here :) I guess remember the Avocado
team started using the SHA-1 hash as default and I suggested them to be
able to use other hashes for this particular case, since Aurelien
provided the MD5 hashes signed by his GPG key, which is signed/trusted
by Peter and used to merge mips32 pulls.

That would verify the QEMU community circle of trust right?

I don't think Avocado should parse the FTP/HTTP signed indexes, but a
manual verification when merging this series should suffice.

> 
> I had experimented with using docker based builds for building test
> fixtures (see tests/docker/dockerbuilds):
> 
>    https://github.com/stsquad/qemu/tree/docker/linux-user-and-ltp-builds-v2
> 
> As these tests are fairly simple boot tests that just need kernels maybe
> we could look at tooling up the generation of these images in a
> repeatable way - similar to the way vmtest builds VMs.

Yes, I have another acceptance branch where I cross-build an old mipssim
kernel to test the board, using the following:
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html

But preparing a Docker cross image, fetching the Linux kernel source,
building it, takes a lot of time/storage I'd rather avoid; at least with
Aurelien kernels, since they are known to work since years.

>> +
>> +        self.vm.set_machine('malta')
>> +        self.vm.set_console()
>> +        kernel_command_line = 'console=ttyS0 printk.time=0'
>> +        self.vm.add_args('-m', "64",
>> +                         '-kernel', kernel_path,
>> +                         '-append', kernel_command_line)
>> +        self.vm.launch()
>> +        console = self.vm.console_socket.makefile()
>> +        console_logger = logging.getLogger('console')
>> +        while True:
>> +            msg = console.readline()
>> +            console_logger.debug(msg.strip())
>> +            if 'Kernel command line: %s' % kernel_command_line in msg:
>> +                break
>> +            if 'Kernel panic - not syncing' in msg:
>> +                self.fail("Kernel panic reached")
> 
> Of course for bonus points a simple rootfs with hackbench or some such
> in it would be nice. But I appreciate this makes the building job a lot
> more complex than just a kernel.

My idea is to use the rootfs for larger tests, and tag the "Kernel
panic" tests as "quick", so we can have a "make acceptance-speed" or
similar.

We can already test than many devices were initialized correctly quickly
looking at this console output.

Regards,

Phil.
