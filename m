Received: from eggs.gnu.org ([2001:4830:134:3::10]:35483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhi57-0006ej-EO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhi53-0004xR-E0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:04:52 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhi53-0004ww-9H
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:04:49 -0400
Received: by mail-qt0-x244.google.com with SMTP id c15so1713489qta.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 13:04:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6da168f-2d33-55e9-1b52-3ede15a7f5c1@amsat.org>
Date: Tue, 15 Aug 2017 17:04:35 -0300
MIME-Version: 1.0
In-Reply-To: <2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 08/15/2017 12:47 PM, Richard Henderson wrote:
> On 08/14/2017 08:33 AM, Cornelia Huck wrote:
>> On Mon, 14 Aug 2017 17:34:15 +0300
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> Speed up tests on host systems with kvm support.
>>> In particular, this fixes tests with --disable-tcg.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Cc: Laurent Vivier <lvivier@redhat.com>
>>> Suggested-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>
>>> Tested on x86 only.
>>>
>>>   tests/boot-serial-test.c | 2 +-
>>>   tests/pnv-xscom-test.c   | 4 ++--
>>>   tests/prom-env-test.c    | 2 +-
>>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>>> index 11f48b0..c3b2e4e 100644
>>> --- a/tests/boot-serial-test.c
>>> +++ b/tests/boot-serial-test.c
>>> @@ -78,7 +78,7 @@ static void test_machine(const void *data)
>>>       fd = mkstemp(tmpname);
>>>       g_assert(fd != -1);
>>>   
>>> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>>> +    args = g_strdup_printf("-M %s,accel=kvm:tcg -chardev file,id=serial0,path=%s"
>>>                              " -no-shutdown -serial chardev:serial0 %s",
>>>                              test->machine, tmpname, test->extra);
>>
>> This has already been changed upstream.
> 
> Ouch.  This is the only real smoke test we have for the tcg backend for the
> host.  While it is still going to test tcg for whatever machines do not run
> natively on the host, I can't help think we've lost testing.
> 
> Can we use accel=tcg:kvm instead?

can we use the following in this test main()?

/* This test is fast fast enough to use to test the host TCG backend,
  * so use "tcg" as default accel if available. */
#ifdef CONFIG_TCG
static const char *accel = "tcg";
#else
static const char *accel = "kvm";
#endif

> 
> 
> r~
> 
