Received: from eggs.gnu.org ([2001:4830:134:3::10]:36850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dy1Hx-0000xf-4R
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dy1Hw-0007Ah-6U
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:49:33 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dy1Hv-0007AF-VE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:49:32 -0400
Received: by mail-wm0-x230.google.com with SMTP id m127so1377577wmm.1
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 12:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
References: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
	<46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Sep 2017 12:49:08 -0700
Message-ID: <CAFEAcA_wfyAweXnaz1eNZ6r0GvhFUoeRqk8vUUaV_wTEBNWu0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: zhuoweizhang@yahoo.com, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>
List-ID: <qemu-devel.nongnu.org>

On 29 September 2017 at 12:14, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 29/09/2017 =C3=A0 18:50, zhuoweizhang@yahoo.com a =C3=A9crit :
>> From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
>>
>> Linux returns success for the special case of calling write with a zero-=
length
>> NULL buffer: compiling and running
>>
>> ```
>>
>> int main() {
>>    ssize_t ret =3D write(STDOUT_FILENO, NULL, 0);
>>    fprintf(stderr, "write returned %ld\n", ret);
>>    return 0;
>> }
>> ```
>> gives "write returned 0" when run directly, but "write returned -1" in Q=
EMU.
>>
>> This commit checks for this situation and returns success if found.
>>
>> Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
>> ---
>>  linux-user/syscall.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 9b6364a..ecadf49 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7783,6 +7783,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>>          }
>>          break;
>>      case TARGET_NR_write:
>> +        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
>> +            /* special case: write(fd, NULL, 0) returns success. */
>> +            ret =3D 0;
>> +            break;
>> +        }
>>          if (!(p =3D lock_user(VERIFY_READ, arg2, arg3, 1)))
>>              goto efault;
>>          if (fd_trans_target_to_host_data(arg1)) {
>>
>
> I think we should keep the call to the kernel write() as the behavior
> depends on the driver behind the syscall. Moreover, calling write() with
> (NULL, 0) can triggers "something" at kernel level.

I tend to agree. On the other hand our handling of NR_read
with a zero count just returns 0 without calling the syscall;
perhaps we should change that for consistency?

Do we also have the same issue with pread64/pwrite64 ?

thanks
-- PMM
