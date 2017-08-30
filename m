Received: from eggs.gnu.org ([2001:4830:134:3::10]:47191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmz46-0003rU-1c
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmz40-0005s8-V5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:13:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dmz40-0005rl-L9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:13:32 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<20170823142047.366068f7.cohuck@redhat.com>
	<897a578e-2375-b892-10af-879b8cc6136b@redhat.com>
	<20170830105901.6c1632ef.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1020ea13-1f4d-4679-61d4-98c21dca0bb5@redhat.com>
Date: Wed, 30 Aug 2017 11:13:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170830105901.6c1632ef.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cam Macdonell <cam@cs.ualberta.ca>

On 30.08.2017 10:59, Cornelia Huck wrote:
[...]
>>> On s390x:
>>> TEST: tests/ivshmem-test... (pid=63617)
>>>   /x86_64/ivshmem/single:                                              OK
>>>   /x86_64/ivshmem/hotplug:                                             OK
>>>   /x86_64/ivshmem/memdev:                                              OK
>>>   /x86_64/ivshmem/pair:                                                OK
>>>   /x86_64/ivshmem/server-msi:                                          qemu-system-x86_64: -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
>>> Broken pipe
>>> FAIL
>>> GTester: last random seed: R02Sda000f7be5ce27b3dfbb03d12f297b69
>>> (pid=63640)
>>>   /x86_64/ivshmem/server-irq:                                          qemu-system-x86_64: -device ivshmem,size=1M,msi=off,chardev=chr0,vectors=2: server sent invalid ID message
>>> Broken pipe
>>> FAIL
>>> GTester: last random seed: R02S5a236dbcac35545cc34c0131fbc06162
>>> (pid=63648)
>>> FAIL: tests/ivshmem-test
> 
> ...but this is a different problem (i.e., it can't be tracked down to
> commit b4ba67d9a7). I'm not sure whether that one ever worked. Might be
> an endianness problem (a quick test on another BE platform could
> confirm.)

This also fails on a big endian ppc64 host machine:

$ uname -m
ppc64
$ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
/x86_64/ivshmem/single: OK
/x86_64/ivshmem/hotplug: OK
/x86_64/ivshmem/memdev: OK
/x86_64/ivshmem/pair: OK
/x86_64/ivshmem/server-msi: qemu-system-x86_64: -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
Broken pipe

 Thomas
