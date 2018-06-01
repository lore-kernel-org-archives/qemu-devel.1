Received: from eggs.gnu.org ([2001:4830:134:3::10]:53362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOXk4-0002Zu-SC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 20:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOXk1-0007Xp-NT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 20:16:28 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOXk1-0007W3-8K
	for qemu-devel@nongnu.org; Thu, 31 May 2018 20:16:25 -0400
Received: by mail-pl0-x244.google.com with SMTP id 31-v6so4277999plc.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:25 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-2-richard.henderson@linaro.org>
	<b5e492dc-da36-dbb4-5cc4-32d2d78050cd@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b072270a-28c1-6fb5-0b91-87a35ddfc952@linaro.org>
Date: Thu, 31 May 2018 17:16:21 -0700
MIME-Version: 1.0
In-Reply-To: <b5e492dc-da36-dbb4-5cc4-32d2d78050cd@amsat.org>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

On 05/31/2018 04:15 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 05/31/2018 07:49 PM, Richard Henderson wrote:
>> This will allow us to protect gdbserver_fd from the guest.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  gdbstub.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 6081e719c5..057d0d65c5 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1890,15 +1890,16 @@ static int gdbserver_open(int port)
>>  int gdbserver_start(int port)
>>  {
>>      gdbserver_fd = gdbserver_open(port);
>> -    if (gdbserver_fd < 0)
>> +    if (gdbserver_fd < 0) {
>>          return -1;
>> +    }
>>      /* accept connections */
>>      if (!gdb_accept()) {
>>          close(gdbserver_fd);
>>          gdbserver_fd = -1;
>>          return -1;
>>      }
>> -    return 0;
>> +    return gdbserver_fd;
> 
> I agree with your change, but what about !CONFIG_USER_ONLY?

It's still a non-negative number, so the success value is still the same.


r~
