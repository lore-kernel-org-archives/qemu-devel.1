Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Sl9-0006BZ-HJ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Sl6-0004pu-A4
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:38:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506004106.3291-1-f4bug@amsat.org>
	<7f51d88d-0dea-5d64-7c6d-530365e29923@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7193a8d-0086-d61c-b214-76c7f204d062@amsat.org>
Date: Wed, 10 May 2017 11:38:28 -0300
MIME-Version: 1.0
In-Reply-To: <7f51d88d-0dea-5d64-7c6d-530365e29923@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] syscall: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 05/10/2017 09:32 AM, Laurent Vivier wrote:
> On 06/05/2017 02:41, Philippe Mathieu-Daudé wrote:
>> static code analyzer complain:
>>
>> linux-user/syscall.c:5575:9: warning: Dereference of undefined pointer value
>>     if (*host_rt_dev_ptr != 0) {
>>         ^~~~~~~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/syscall.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index cec8428589..c541e22693 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -5526,7 +5526,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>>      int target_size;
>>      void *argptr;
>>      abi_ulong *target_rt_dev_ptr;
>> -    unsigned long *host_rt_dev_ptr;
>> +    unsigned long *host_rt_dev_ptr = NULL;
>>      abi_long ret;
>>      int i;
>>
>> @@ -5572,7 +5572,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>>      unlock_user(argptr, arg, 0);
>>
>>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
>
> I think we should "assert(host_rt_dev_ptr)" here. It's a bug if
> host_rt_dev_ptr is not set.
>
> The "for" loop scans the structure to find the rt_dev field, and we
> should always enter in the first "if", so "host_rt_dev_ptr" is always set.

It's better indeed, I'll use g_assert_nonnull() and resend.

Thanks!

>
>> -    if (*host_rt_dev_ptr != 0) {
>> +    if (host_rt_dev_ptr != NULL && *host_rt_dev_ptr != 0) {
>>          unlock_user((void *)*host_rt_dev_ptr,
>>                      *target_rt_dev_ptr, 0);
>>      }
>>
>
> Laurent
>
