Received: from eggs.gnu.org ([2001:4830:134:3::10]:60821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crRX6-0004Pa-JI
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crRX3-0003i5-HN
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:53:44 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1crRX3-0003hr-AM
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:53:41 -0400
Received: by mail-wm0-x22d.google.com with SMTP id n11so16441380wma.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:53:41 -0700 (PDT)
References: <1490361570-288658-1-git-send-email-borntraeger@de.ibm.com>
	<CAFEAcA_7NggYw6gATm_B7rKRJX-C9dU-dCv_NF_e_5WOP_rmdQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_7NggYw6gATm_B7rKRJX-C9dU-dCv_NF_e_5WOP_rmdQ@mail.gmail.com>
Date: Fri, 24 Mar 2017 15:53:38 +0000
Message-ID: <8737e2y8l9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] boot-serial-test: use -no-shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 March 2017 at 13:19, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>> a qemu with an empty s390 guest will exit very quickly. This races
>> against the testsuite reading from the console pipe leading to
>> intermittent test suite failures. Using -no-shutdown will keep
>> the guest running.
>>
>> Fixes: 864111f422ba (vl: exit qemu on guest panic if -no-shutdown is not set)
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  tests/boot-serial-test.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 57edf6a..11f48b0 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>>      g_assert(fd != -1);
>>
>>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>> -                           " -serial chardev:serial0 %s", test->machine,
>> -                           tmpname, test->extra);
>> +                           " -no-shutdown -serial chardev:serial0 %s",
>> +                           test->machine, tmpname, test->extra);
>>
>>      qtest_start(args);
>>      unlink(tmpname);
>
> Applied to master, thanks. Let's see if this fixes the travis flapping...

A bit late as it is merged but I did test it on the reproduction case
and ran 50 check-qtest-s390x while loading the system with a kernel
compile. It previously failed after about 20 iterations. So:

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
