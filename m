Received: from eggs.gnu.org ([2001:4830:134:3::10]:40980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOjNw-0005lM-7u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOjNi-0007UL-Bw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:42:23 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOjNh-0007TP-Cv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:42:09 -0400
Received: by mail-qt0-x241.google.com with SMTP id i18-v6so21277446qtp.12
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:42:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-2-richard.henderson@linaro.org>
	<b5e492dc-da36-dbb4-5cc4-32d2d78050cd@amsat.org>
	<b072270a-28c1-6fb5-0b91-87a35ddfc952@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b4dad39-27b7-e13e-6a64-90b725a99296@amsat.org>
Date: Fri, 1 Jun 2018 09:42:04 -0300
MIME-Version: 1.0
In-Reply-To: <b072270a-28c1-6fb5-0b91-87a35ddfc952@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] gdbstub: Return the fd from
 gdbserver_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

On 05/31/2018 09:16 PM, Richard Henderson wrote:
> On 05/31/2018 04:15 PM, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 05/31/2018 07:49 PM, Richard Henderson wrote:
>>> This will allow us to protect gdbserver_fd from the guest.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  gdbstub.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index 6081e719c5..057d0d65c5 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -1890,15 +1890,16 @@ static int gdbserver_open(int port)
>>>  int gdbserver_start(int port)
>>>  {
>>>      gdbserver_fd = gdbserver_open(port);
>>> -    if (gdbserver_fd < 0)
>>> +    if (gdbserver_fd < 0) {
>>>          return -1;
>>> +    }
>>>      /* accept connections */
>>>      if (!gdb_accept()) {
>>>          close(gdbserver_fd);
>>>          gdbserver_fd = -1;
>>>          return -1;
>>>      }
>>> -    return 0;
>>> +    return gdbserver_fd;
>>
>> I agree with your change, but what about !CONFIG_USER_ONLY?
> 
> It's still a non-negative number, so the success value is still the same.

Good point.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
