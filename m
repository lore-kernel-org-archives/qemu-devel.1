Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g84rT-0007ub-7f
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g84rP-00041J-Hj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:44:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g84rP-0003oA-3g
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:44:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so10212251wra.11
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 07:44:10 -0700 (PDT)
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org> <87tvm1rhh5.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1631c2a-7694-c49f-6086-1d8caf8e5026@redhat.com>
Date: Thu, 4 Oct 2018 16:44:06 +0200
MIME-Version: 1.0
In-Reply-To: <87tvm1rhh5.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/3] acceptance tests: Test firmware
 checking debug console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Alex,

On 04/10/2018 15:04, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> Hi,
>>>
>>> This RFC series add simple acceptance tests which boot SeaBIOS and EDK2 on
>>> the pc and virt/aarch64 default machines
>>>
>>> Still PoC but can be useful for the Avocado team to test the
>>> multi-arch targets.
>>
>> I couldn't get this to work on qemu-test (aarch64):

Thanks for giving it a try!

Sorry, I only tested this on x86_64 :/

>>
>>   12:52:56 [alex@qemu-test:~/l/qemu.git] review/acceptance-rfc-v2 + avocado run tests/acceptance
>>   JOB ID     : b6377b8d4196903846c7d57e2b234c523d6c6ba1
>>   JOB LOG    : /home/alex/avocado/job-results/job-2018-10-04T12.53-b6377b8/job.log
>>    (1/9) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: ERROR: timed out (15.14 s)
>>    (2/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc: ERROR: timed out (15.14 s)
>>    (3/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt: FAIL: OVMF failed to boot (17.97 s)
>>    (4/9) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: ERROR: timed out (17.36 s)
>>    (5/9) tests/acceptance/version.py:Version.test_qmp_human_info_version: ERROR: timed out (15.14 s)
>>    (6/9) tests/acceptance/vnc.py:Vnc.test_no_vnc: ERROR: timed out (15.14 s)
>>    (7/9) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: ERROR: timed out (15.14 s)
>>    (8/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password: ERROR: timed out (15.14 s)
>>    (9/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: ERROR: timed out (15.14 s)
>>   RESULTS    : PASS 0 | ERROR 8 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>   JOB TIME   : 142.37 s
>>
>> The error log: https://transfer.sh/lK71v/avocado-errors.log
> 
> It looks like it's trying to launch a pc (rather than virt) machine:
> 
>   2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output: 'qemu-system-aarch64: -machine pc: unsupported machine type\nUse -machine help to list supported machines\n'

Due to some limitation (Cleber is aware of it) you have to use the -p
option as in patch #3 of this series:

$ avocado run --filter-by-tags=arch:x86_64 -p
qemu_bin=x86_64-softmmu/qemu-system-x86_64 tests/acceptance/boot_firmware.py
JOB ID     : 5f9078796ef749e0606bbdf9409e91443ab2bad1
JOB LOG    :
/home/phil/avocado/job-results/job-2018-10-04T14.30-5f90787/job.log
 (1/2) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: PASS
(0.90 s)
 (2/2) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc:
FAIL: 'SEC: Normal boot\r\n' not found in [] (9.48 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 10.72 s

The error "FAIL: 'SEC: Normal boot\r\n' not found" means the serial test
worked, but not the debugconsole.

You can use verbose Avocado:

$ avocado --show=app,debugcon,serial run --filter-by-tags=arch:x86_64 -p
qemu_bin=x86_64-softmmu/qemu-system-x86_64 tests/acceptance/boot_firmware.py
 (2/2) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc: \
serial: UEFI Interactive Shell v2.2


serial: EDK II


FAIL: 'SEC: Normal boot\r\n' not found in [] (9.58 s)



I'll look at it.

$ avocado run --filter-by-tags=arch:aarch64 -p
qemu_bin=aarch64-softmmu/qemu-system-aarch64
tests/acceptance/boot_firmware.py
JOB ID     : 678d83c0b10d6daadb5fa177318b774281c346b7
JOB LOG    :
/home/phil/avocado/job-results/job-2018-10-04T14.29-678d83c/job.log
 (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt:
FAIL: OVMF failed to boot (16.59 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 16.83 s

$ avocado --show=app,serial run --filter-by-tags=arch:aarch64 -p
qemu_bin=aarch64-softmmu/qemu-system-aarch64
tests/acceptance/boot_firmware.py
JOB LOG    :
/home/phil/avocado/job-results/job-2018-10-04T14.40-dab2e26/job.log
 (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt:
serial: a
serial: dd-symbol-
serial: file /home/
serial: buildslave/
serial: workspace/l
serial: eg-virt-tia
serial: nocore-edk2
serial: -upstream/e
serial: dk2/Build/A
serial: rmVirtQemu-
serial: AARCH64/DEB
serial: UG_GCC5/AA
serial: RCH64/ArmPl
serial: atformPkg/P
serial: rePeiCore/P
serial: rePeiCoreUn
serial: iCore/DEBUG
serial: /ArmPlatfor
serial: mPrePeiCore
serial: .dll 0x1800
...
serial: Boot00
serial: 04: EFI In
serial: ternal S
serial: h
serial: ell              0x00
serial: 01
serial:
serial: PlatformRe
serial: covery Opti
serial: ons:
FAIL: OVMF failed to boot (16.44 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 16.68 s

So this image boots, this is my ugly way of handling virt console with
avocado which failed :)

QEMU console arg:

   '-chardev', 'file,path=%s,id=console' % serial_path,
   '-serial', 'chardev:console')

then I'd like to use the FDDrainer class Cleber suggested instead of the
current read_console_for_string().

Thanks,

Phil.
