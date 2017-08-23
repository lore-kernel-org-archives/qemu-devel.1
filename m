Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkUeb-0005FA-A5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkUeY-0000om-1i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkUeX-0000oU-PL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:20:57 -0400
Date: Wed, 23 Aug 2017 14:20:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170823142047.366068f7.cohuck@redhat.com>
In-Reply-To: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Wed, 23 Aug 2017 10:35:43 +0200
Thomas Huth <thuth@redhat.com> wrote:

> True. And I just learned that you can also already set the SPEED
> variable to either "quick" or "slow" and that we're already using
> g_test_quick() and g_test_slow() in a couple of places to check this. So
> the framework for running quick vs. thorough tests is already there ...
> we just might want to add this to some more tests, I guess...
> 
> Question for the maintainers and the test automation folks: Is anybody
> already running "make check SPEED=slow" or is this just rather an
> unheard-of way of running the tests?

So I tried this on master just for fun, and 'make V=1 SPEED=slow
check-qtest-x86_64' promptly failed for some ivshmem test.

On x86_86:
TEST: tests/ivshmem-test... (pid=3672)
  /x86_64/ivshmem/single:                                              OK
  /x86_64/ivshmem/hotplug:                                             OK
  /x86_64/ivshmem/memdev:                                              OK
  /x86_64/ivshmem/pair:                                                OK
  /x86_64/ivshmem/server-msi:                                          **
ERROR:/home/cohuck/git/qemu/tests/ivshmem-test.c:367:test_ivshmem_server: assertion failed (ret == 0): (1 == 0)
FAIL
GTester: last random seed: R02Scde8fd6835fdf17450c73e2f74f25007
(pid=3697)
 /x86_64/ivshmem/server-irq:                                          OK
FAIL: tests/ivshmem-test

On s390x:
TEST: tests/ivshmem-test... (pid=63617)
  /x86_64/ivshmem/single:                                              OK
  /x86_64/ivshmem/hotplug:                                             OK
  /x86_64/ivshmem/memdev:                                              OK
  /x86_64/ivshmem/pair:                                                OK
  /x86_64/ivshmem/server-msi:                                          qemu-system-x86_64: -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
Broken pipe
FAIL
GTester: last random seed: R02Sda000f7be5ce27b3dfbb03d12f297b69
(pid=63640)
  /x86_64/ivshmem/server-irq:                                          qemu-system-x86_64: -device ivshmem,size=1M,msi=off,chardev=chr0,vectors=2: server sent invalid ID message
Broken pipe
FAIL
GTester: last random seed: R02S5a236dbcac35545cc34c0131fbc06162
(pid=63648)
FAIL: tests/ivshmem-test

Both machines are on Fedora 26.

(On the bright side, the rest of the test seemed fine.)
