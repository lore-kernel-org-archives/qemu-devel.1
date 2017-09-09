Received: from eggs.gnu.org ([2001:4830:134:3::10]:55171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqUWk-0002sp-N9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqUWh-0006e8-QR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:42 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:38877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqUWh-0006dp-L5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:39 -0400
Received: by mail-qt0-x234.google.com with SMTP id q8so10157241qtb.5
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 18:25:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-5-famz@redhat.com> <87tw0dgqpv.fsf@linaro.org>
	<20170908232950.GD18677@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e624d60-c8ed-54f5-a2ca-9caf9d9c489f@amsat.org>
Date: Fri, 8 Sep 2017 22:25:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170908232950.GD18677@lemon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com

Hi Fam, Alex,

>>
>> If this fails it's fairly cryptic:
>>
>> /home/alex/lsrc/qemu/qemu.git/tests/vm/openbsd  --debug   --image "tests/vm/openbsd.img" --build-qemu /home/alex/lsrc/qemu/qemu.git
>> DEBUG:root:Creating archive ./vm-test-fxejnB.tmp/data-2de24.tar for src_dir dir: /home/alex/lsrc/qemu/qemu.git
>> DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev user,id=vnet,hostfwd=:0.0.0.0:0-:22 -device virtio-net-pci,netdev=vnet -vnc :0,to=20 -serial file:./vm-test-fxejnB.tmp/serial.out -smp 4 -enable-kvm -device VGA -drive file=tests/vm/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -drive file=./vm-test-fxejnB.tmp/data-2de24.tar,if=none,id=data-2de24,cache=writeback,format=raw -device virtio-blk,drive=data-2de24,serial=data-2de24,bootindex=1
>> Failed to prepare guest environment
>> Traceback (most recent call last):
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 260, in main
>>      vm.boot(args.image + ",snapshot=on")
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 184, in boot
>>      guest.launch()
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", line 151, in launch
>>      self._post_launch()
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", line 135, in _post_launch
>>      self._qmp.accept()
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py", line 147, in accept
>>      return self.__negotiate_capabilities()
>>    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py", line 60, in __negotiate_capabilities
>>      raise QMPConnectError
>> QMPConnectError
>>
>> I assume QEMU failed to boot and might have given us a message that
>> would be useful.
> 
> It's a separate issue of qemu.py, I didn't try to fix it here because currently
> there are many patches touching that file on the list, there is a high chance of
> conflict.
> 
> In your case which qemu version are you using? If not master it probably is
> failing because of the hostfwd syntax.

very likely.

one simple way to handle this could be having this script catching 
QMPConnectError and restart with older command line format,

but I prefer starting QEMU binding a QMP socket, then initialize the 
options via QMP packets, this should be more portable, this is cleaner.

also I think we don't want to run those images with bleeding edge 
qemu-system, we want a stable QEMU to be able to compile the bleeding 
edge codebase inside a working VM.

another note: currently when a VM fails, it closes and what I've left is 
only the last stderr.
I'd rather see 2 modes:
- run from some CI when only the final return value is useful, the 
stderr being extra value.
- in user-dev mode if the build fails I'd like to have access to the 
terminal, eventually some msg like "this build failed, you can connect 
to this VM copy/pasting the following ssh command: ... or hit ^C to 
gracefully shutdown the VM"
But in this mode I'd rather mount my current workdir via a read-writable 
netshare rather than a one-time temporary read-only tarball, so I could 
modify my repo and just run 'make' inside the VM.

Regards,

Phil.
