Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eMxP7-0003t3-Bf
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eMxP4-0006bt-66
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:44:01 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eMxP3-0006a9-Vg
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:43:58 -0500
Received: by mail-pf0-x244.google.com with SMTP id c204so4814355pfc.13
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 06:43:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171205044844.3597-1-richard.henderson@linaro.org>
	<CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
Date: Thu, 7 Dec 2017 06:43:52 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/07/2017 05:05 AM, Peter Maydell wrote:
> On 5 December 2017 at 04:48, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> From: Richard Henderson <rth@twiddle.net>
>>
>> If the interp_prefix is a complete chroot, it may have a *lot* of files.
>> Setting up the cache for this is quite expensive.  Instead, use the *at
>> versions of various syscalls to attempt the operation in the prefix.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>
>> Changes since v1 (Nov 2016):
>>   * Require interp_dirfd set before trying the *at path.
>>
>>
>> r~
>> ---
>>  linux-user/qemu.h    |   1 +
>>  linux-user/elfload.c |  12 ++-
>>  linux-user/main.c    |   3 +-
>>  linux-user/syscall.c | 236 ++++++++++++++++++++++++++++++++++++++++++---------
>>  4 files changed, 208 insertions(+), 44 deletions(-)
>>
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index 4edd7d0c08..d04924fd2e 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -437,6 +437,7 @@ void mmap_fork_start(void);
>>  void mmap_fork_end(int child);
>>
>>  /* main.c */
>> +extern int interp_dirfd;
>>  extern unsigned long guest_stack_size;
>>
>>  /* user access */
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 20f3d8c2c3..5d3f7aa11d 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2203,7 +2203,17 @@ static void load_elf_interp(const char *filename, struct image_info *info,
>>  {
>>      int fd, retval;
>>
>> -    fd = open(path(filename), O_RDONLY);
>> +    switch (interp_dirfd > 0 && filename[0] == '/') {
>> +    case true:
> 
> gcc doesn't like this pattern:
> 
> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c: In
> function ‘do_name_to_handle_at’:
> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c:7231:13:
> error: switch condition has boolean value [-Werror=switch-bool]
>      switch (interp_dirfd > 0 && name[0] == '/') {
>              ^
> 
> It seems like an odd way to write an if().

Huh.  My gcc likes it just fine.  What version are you using?

It's an IF with a /* fallthru */, so there are very few
less ugly ways to write it...


r~
