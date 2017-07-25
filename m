Received: from eggs.gnu.org ([2001:4830:134:3::10]:40033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZuEQ-0005l2-BL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZuEP-00067q-BF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:26:14 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-28-f4bug@amsat.org>
	<CAFEAcA86cuTukJ4HXVKDjewpxy2myPU1Gdbn671zqxJq6d09Wg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <069e3f18-317e-49d7-263f-206d5c21a755@vivier.eu>
Date: Tue, 25 Jul 2017 09:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86cuTukJ4HXVKDjewpxy2myPU1Gdbn671zqxJq6d09Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 27/35] syscall: fix dereference of
 undefined pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 24/07/2017 à 23:26, Peter Maydell a écrit :
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Clang's scan-build-5.0 reports:
>>
>> linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer value
>>     if (*host_rt_dev_ptr != 0) {
>>         ^~~~~~~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Suggested-by: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/syscall.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index fcd20fa276..e79b5baec4 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -5524,7 +5524,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>>      int target_size;
>>      void *argptr;
>>      abi_ulong *target_rt_dev_ptr;
>> -    unsigned long *host_rt_dev_ptr;
>> +    unsigned long *host_rt_dev_ptr = NULL;
>>      abi_long ret;
>>      int i;
>>
>> @@ -5570,6 +5570,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>>      unlock_user(argptr, arg, 0);
>>
>>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
>> +    assert(host_rt_dev_ptr);
> 
> There's not much point in this assert because it doesn't
> tell us anything we're not about to find out immediately
> by dereferencing the pointer...

It's just to shut off the warning.

What I said in the comment of the previous version of this patch:

I think we should "assert(host_rt_dev_ptr)" here. It's a bug if
host_rt_dev_ptr is not set.

The "for" loop scans the structure to find the rt_dev field, and we
should always enter in the first "if", so "host_rt_dev_ptr" is always set.

Thanks,
Laurent
