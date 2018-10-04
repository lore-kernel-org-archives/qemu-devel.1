Received: from eggs.gnu.org ([2001:4830:134:3::10]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85ML-0007UF-Vt
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85MF-00087o-42
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:16:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g85MD-0007vt-B0
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:16:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so9433347wma.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:16:02 -0700 (PDT)
References: <20181003183036.6716-1-philmd@redhat.com>
	<20181003183036.6716-4-philmd@redhat.com>
	<2803f12b-9e59-58f4-9ca9-65819ef5492c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a201087-10ca-5f09-4164-d6f019bee60f@redhat.com>
Date: Thu, 4 Oct 2018 17:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <2803f12b-9e59-58f4-9ca9-65819ef5492c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/3] acceptance tests: Add EDK2
 ArmVirtQemu boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 04/10/2018 17:07, Laszlo Ersek wrote:
> On 10/03/18 20:30, Philippe Mathieu-Daudé wrote:
>> This test boots EDK2 ArmVirtQemu and check the debug console (PL011) reports enough
>> information on the initialized devices.
>>
>> $ avocado run -p qemu_bin=aarch64-softmmu/qemu-system-aarch64 tests/acceptance/boot_firmware.py
>> JOB ID     : cb1c5bd9e0312483eabeffbb37885a5273ef23bf
>> JOB LOG    : /home/phil/avocado/job-results/job-2018-10-03T19.39-cb1c5bd/job.log
>>  (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt: PASS (5.02 s)
>> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>> JOB TIME   : 5.30 s
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> The '-p' option requires Avocado >= 65.0
>> ---
>>  tests/acceptance/boot_firmware.py | 36 +++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_firmware.py
>> index 2053b1a4b6..42f0672963 100644
>> --- a/tests/acceptance/boot_firmware.py
>> +++ b/tests/acceptance/boot_firmware.py
>> @@ -121,3 +121,39 @@ class BootFirmware(Test):
>>                  debugcon_logger.debug(line.strip())
>>              for exp in expected:
>>                  self.assertIn(exp + '\r\n', content)
>> +
>> +    def test_ovmf_virt(self):
>> +        """
>> +        Boots OVMF on the default virt machine, checks the debug console
>> +
>> +        :avocado: tags=arch:aarch64
>> +        :avocado: tags=maxtime:20s
>> +        """
>> +        image_url = ('http://snapshots.linaro.org/components/kernel/'
>> +                    'leg-virt-tianocore-edk2-upstream/latest/'
>> +                    'QEMU-AARCH64/DEBUG_GCC5/QEMU_EFI.img.gz')
>> +        image_path_gz = self.fetch_asset(image_url)
>> +        image_path = os.path.join(self.workdir, 'flash.img')
>> +
>> +        # kludge until Avocado support gzip files
>> +        import gzip, shutil
>> +        with gzip.open(image_path_gz) as gz, open(image_path, 'wb') as img:
>> +            shutil.copyfileobj(gz, img)
>> +
>> +        serial_path = os.path.join(self.workdir, 'serial.log')
>> +        self.vm.set_machine('virt')
>> +        self.vm.add_args('-nographic',
>> +                         '-cpu', 'cortex-a57',
>> +                         '-m', '1G', # 1GB min to boot fw?
>> +                         '-drive', 'file=%s,format=raw,if=pflash' % image_path,
>> +                         '-chardev', 'file,path=%s,id=console' % serial_path,
>> +                         '-serial', 'chardev:console')
>> +        self.vm.launch()
>> +        serial_logger = logging.getLogger('serial')
>> +
>> +        # serial console checks
>> +        if not wait_for(read_console_for_string, timeout=15, step=0,
>> +                        args=(open(serial_path),
>> +                              'Start PXE over IPv4',
>> +                              serial_logger)):
>> +            self.fail("OVMF failed to boot")
>>
> 
> I suggest replacing "OVMF" with "ArmVirtQemu" in comments and strings as
> well.

Oops OK.

> 
> I'd also suggest renaming the method test_ovmf_virt() to
> test_armvirtqemu_virt().
> 
> If that seems baroque, then I suggest "test_uefi_<machtype>" in both
> patches #2 and #3.

What about this?

- test_bios_seabios_x86_64_pc()
- test_uefi_ovmf_x86_64_pc()
- test_uefi_armvirtqemu_aarch64_virt()

> 
> (Sorry about my obsession with these names; just trying to capture the
> existing "vernacular".)
> 
> Thanks
> Laszlo
> 
