Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezp4a-0003jo-31
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezp0a-0006RW-Km
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:43:28 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:35812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezp0a-0006Qf-EK
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:39:20 -0400
Received: by mail-pf0-x236.google.com with SMTP id u86so218855pfd.2
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:39:20 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
	<20180219040342.12686-3-mdavidsaver@gmail.com>
	<bd080194-a170-52a0-59fd-31678e838d34@redhat.com>
	<6b259b00-e185-5ca9-f101-e69a5c8dcbb6@gmail.com>
Message-ID: <364d195d-b948-52f4-8c65-2ea535061fe9@gmail.com>
Date: Sat, 24 Mar 2018 12:39:16 -0700
MIME-Version: 1.0
In-Reply-To: <6b259b00-e185-5ca9-f101-e69a5c8dcbb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tests: more thorough test of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

> On 02/20/2018 09:44 AM, Michael Davidsaver wrote:
>> On 02/18/2018 11:39 PM, Thomas Huth wrote:
...
>> That magic (together with patch 1/5) is IMHO a little bit ugly. I've hit
>> the same problem with the m48t59 test recently, and I solved it by
>> moving the qtest_start() and qtest_end() calls from the main() function
>> into the single tests instead, so that each test starts with a clean state:
>>
>> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=9c29830c90d82f27f
>>
>> Could you maybe try whether that approach works for your test cases
>> here, too? Then you could do this without the "0xff" hack here...
> 
> Your right, this looks clearer.  I'll try this approach.

I ultimately decided not to go with this approach as test failures
didn't call qtest_quit(), and the process under test is left running
after gtester exits.

Instead I split the current time test off into a second executable.
This avoids all of the magic.


FYI.  I also looked at using g_test_add(), keeping the QTestState* in a
Fixture struct, and using setup and teardown functions to call
qtest_start()/qtest_quit().  This works, but seemed to me like too much
effort in this case.
