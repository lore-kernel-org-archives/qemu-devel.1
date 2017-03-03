Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cjpar-0000tl-UB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cjpar-0006nP-9E
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:10 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1cjpar-0006mC-3u
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:09 -0500
Received: by mail-it0-x22a.google.com with SMTP id h10so15294983ith.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:58:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_V8azXLLptxqNWBwkY7wJZzK+YkZHd6RfHEVS-NoXXBg@mail.gmail.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<CAFEAcA_V8azXLLptxqNWBwkY7wJZzK+YkZHd6RfHEVS-NoXXBg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Mar 2017 16:57:46 +0100
Message-ID: <CAG48ez2eaXFk50puw_bc27tNdfOHDsL08A9jY8=7DnA-mtEXWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>

On Fri, Mar 3, 2017 at 4:55 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 March 2017 at 11:25, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Limit the number of arguments passed to execve(2) call from
>> a user program, as large number of them could lead to a bad
>> guest address error.
>>
>> Reported-by: Jann Horn <jannh@google.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  linux-user/syscall.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 9be8e95..c545c12 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7766,6 +7766,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>  #endif
>>      case TARGET_NR_execve:
>>          {
>> +#define ARG_MAX 65535
>>              char **argp, **envp;
>>              int argc, envc;
>>              abi_ulong gp;
>> @@ -7794,6 +7795,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>                  envc++;
>>              }
>>
>> +            if (argc > ARG_MAX || envc > ARG_MAX) {
>> +                fprintf(stderr,
>> +                        "argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
>> +                ret = -TARGET_EFAULT;
>> +                break;
>> +            }
>>              argp = alloca((argc + 1) * sizeof(void *));
>>              envp = alloca((envc + 1) * sizeof(void *));
>
> This code is already supposed to handle "argument string too big",
> see commit a6f79cc9a5e.
>
> What's the actual bug case we're trying to handle here?

commit a6f79cc9a5e doesn't help here, it only bails out after the two
alloca() calls
