Received: from eggs.gnu.org ([209.51.188.92]:54854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4dn-0000yV-PU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4dm-0001kv-L7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:59:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go4dm-0001jz-EW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:59:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so10128945wmh.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 02:59:46 -0800 (PST)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com> <874l9tnmev.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9be59725-0c22-9928-ae04-8e3f38260e95@redhat.com>
Date: Mon, 28 Jan 2019 11:59:43 +0100
MIME-Version: 1.0
In-Reply-To: <874l9tnmev.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1/28/19 10:47 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Previous to OpenBSD 6.3 [1], fcntl(F_SETFL) is not permitted on memory
>> devices. Do not assert fcntl failures on OpenBSD.
>> This fixes:
>>
>>   $ lm32-softmmu/qemu-system-lm32
>>   assertion "f != -1" failed: file "util/oslib-posix.c", line 247, function "qemu_set_nonblock"
>>   Abort trap (core dumped)
>>
>> [1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
>>   "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
>>   the memory devices (/dev/null, /dev/zero, etc) need to permit them."
> 
> I assume set_nonblock is called on more than just these special devices?
> Is there anyway to check this on OpenBSD or is it just an anonymous fd
> at this point?

I'll let an OpenBSD expert to answer that.

I forgot to comment, the assert() was added one month ago (da93b82079d),
Michael said we can also revert this change.

>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  util/oslib-posix.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 4ce1ba9ca4..064c3ae2f7 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -244,7 +244,9 @@ void qemu_set_nonblock(int fd)
>>      f = fcntl(fd, F_GETFL);
>>      assert(f != -1);
>>      f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
>> +#ifndef __OpenBSD__
>>      assert(f != -1);
>> +#endif
>>  }
>>
>>  int socket_set_fast_reuse(int fd)
> 
> 
> --
> Alex Bennée
> 
