Received: from eggs.gnu.org ([2001:4830:134:3::10]:35514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9zL-000477-TV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9zH-0004kp-Rp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:13:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9zH-0004kZ-NW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:13:39 -0400
Received: by mail-qt0-x241.google.com with SMTP id o21so437129qtb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:13:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170607175419.13558-1-berrange@redhat.com>
	<CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
	<20170614105023.GG4370@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15e25d8e-4a2d-6d2a-95b3-9b045abf7af6@amsat.org>
Date: Wed, 14 Jun 2017 12:13:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170614105023.GG4370@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Daniel,

On 06/14/2017 07:50 AM, Daniel P. Berrange wrote:
> On Mon, Jun 12, 2017 at 02:14:19PM +0100, Peter Maydell wrote:
>> On 7 June 2017 at 18:54, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376af:
>>>
>>>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-07 11:56:00 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/berrange/qemu tags/pull-sockets-2017-06-07-1
>>>
>>> for you to fetch changes up to 8dd2c27927b93aa352c43e8f0b9437f85d2f5f55:
>>>
>>>   tests: add functional test validating ipv4/ipv6 address flag handling (2017-06-07 17:15:08 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Merge sockets 2017/06/07 v1
>>>
>>> ----------------------------------------------------------------
>>
>> Hi; I'm afraid this ran into 'make check' problems:
>>
>> On OSX and FreeBSD:
>>   GTESTER check-qtest-i386
>> ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
>> test_listen(const void *): assertion failed: (data->ipv6 != 0)
>> GTester: last random seed: R02Sc21fa7784ab13d0fd3274d86c5a52367
>> **
>> ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
>> test_listen(const void *): assertion failed: (data->ipv6 != 0)
>> GTester: last random seed: R02Sdf653a63e8d9a5d03bfadb49122f3e9a
>
> Ok, it appears that getaddrinfo() returns different results for "localhost"
> on FreeBSD/OSX, compared to Linux. Linux returns IPv4 first, then IPv6,
> while FreeBSD/OSX return IPv6 first then IPv4. The sockets code is working
> correctly, but the unit test is not seeing the expected results, since its
> data tables are expecting the Linux behaviour. Not sure how I'll fix this
> yet, perhaps I'll just #ifdef __linux__ as a temporary hack.

On Linux it depends of your /etc/gai.conf(5), on FreeBSD it depends on 
ip6addrctl(8) policy.

I'm not sure about this hack, temporary tends to last...

>
>
>> On the clang runtime undefined-behavior sanitizer:
>>   GTESTER check-qtest-i386
>> /home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
>> runtime error: load of value 254, which is not a valid value for type
>> 'bool'
>>
>> (ditto for check-qtest-ppc64, x86_64
>>   GTESTER check-qtest-ppc64
>> /home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
>> runtime error: load of value 254, which is not a valid value for type
>> 'bool'
>
> [snip]
>
>> This usually means "forgot to initialize a bool". May or may not
>> be the same bug in both cases...
>
> Yes, this was a unit test bug using  g_new instead of g_new0
>
> Regards,
> Daniel
>
