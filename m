Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmk4g-0004d5-KZ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmk4d-0004xI-FJ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dmk4d-0004x2-6F
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:13:11 -0400
From: Thomas Huth <thuth@redhat.com>
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
	<c4c9776a-4284-796d-2439-42ad89015098@redhat.com>
Message-ID: <41064d41-33d0-8db9-7d44-31935ebf6eea@redhat.com>
Date: Tue, 29 Aug 2017 19:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <c4c9776a-4284-796d-2439-42ad89015098@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 29.08.2017 18:34, Thomas Huth wrote:
> On 23.08.2017 14:20, Cornelia Huck wrote:
>> On Wed, 23 Aug 2017 10:35:43 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> True. And I just learned that you can also already set the SPEED
>>> variable to either "quick" or "slow" and that we're already using
>>> g_test_quick() and g_test_slow() in a couple of places to check this. So
>>> the framework for running quick vs. thorough tests is already there ...
>>> we just might want to add this to some more tests, I guess...
>>>
>>> Question for the maintainers and the test automation folks: Is anybody
>>> already running "make check SPEED=slow" or is this just rather an
>>> unheard-of way of running the tests?
>>
>> So I tried this on master just for fun, and 'make V=1 SPEED=slow
>> check-qtest-x86_64' promptly failed for some ivshmem test.
>>
>> On x86_86:
>> TEST: tests/ivshmem-test... (pid=3672)
>>   /x86_64/ivshmem/single:                                              OK
>>   /x86_64/ivshmem/hotplug:                                             OK
>>   /x86_64/ivshmem/memdev:                                              OK
>>   /x86_64/ivshmem/pair:                                                OK
>>   /x86_64/ivshmem/server-msi:                                          **
>> ERROR:/home/cohuck/git/qemu/tests/ivshmem-test.c:367:test_ivshmem_server: assertion failed (ret == 0): (1 == 0)
>> FAIL
>> GTester: last random seed: R02Scde8fd6835fdf17450c73e2f74f25007
>> (pid=3697)
>>  /x86_64/ivshmem/server-irq:                                          OK
>> FAIL: tests/ivshmem-test
> 
> Bisecting this problem automatically ("git bisect run" rules!) revealed
> that this test broke with this commit:
> 
> 	commit b4ba67d9a702507793c2724e56f98e9b0f7be02b
> 	Author: David Gibson <david@gibson.dropbear.id.au>
> 	Title: libqos: Change PCI accessors to take opaque BAR handle
> 
> David, any ideas what's going wrong here?

Never mind, I've found the problem: dev->msix_pba_bar is not properly
initialized anymore if bir_pba == bir_table. I'm working on a patch...

 Thomas
