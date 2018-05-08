Received: from eggs.gnu.org ([2001:4830:134:3::10]:39194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG65x-0006Hf-9B
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG65w-00044Q-4A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:09 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:33829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fG65v-00044E-VV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:08 -0400
Received: by mail-yw0-x241.google.com with SMTP id x27-v6so7289078ywj.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:08:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508163639.7138-1-laurent@vivier.eu>
References: <20180508163639.7138-1-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 8 May 2018 10:08:06 -0700
Message-ID: <CAMo8BfJg3P=xxdZpkyj6yayHh5ce7z2VKFru=o8DkcVQOBc-Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix convertion of
 flock/flock64 l_type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Tue, May 8, 2018 at 9:36 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
> are not bitmasks, we can't use target_to_host_bitmask() and
> host_to_target_bitmask() to convert them.
>
> Introduce target_to_host_flock() and host_to_target_flock()
> to convert values between host and target.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 48 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e4825747f9..fdf6766eca 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6546,15 +6546,33 @@ static int target_to_host_fcntl_cmd(int cmd)
>      return -TARGET_EINVAL;
>  }
>
> -#define TRANSTBL_CONVERT(a) { -1, TARGET_##a, -1, a }
> -static const bitmask_transtbl flock_tbl[] = {
> -    TRANSTBL_CONVERT(F_RDLCK),
> -    TRANSTBL_CONVERT(F_WRLCK),
> -    TRANSTBL_CONVERT(F_UNLCK),
> -    TRANSTBL_CONVERT(F_EXLCK),
> -    TRANSTBL_CONVERT(F_SHLCK),
> -    { 0, 0, 0, 0 }
> -};
> +static unsigned int target_to_host_flock(unsigned int type)
> +{
> +    switch (type) {
> +#define TRANSTBL_CONVERT(a) case TARGET_##a: return a;
> +    TRANSTBL_CONVERT(F_RDLCK)
> +    TRANSTBL_CONVERT(F_WRLCK)
> +    TRANSTBL_CONVERT(F_UNLCK)
> +    TRANSTBL_CONVERT(F_EXLCK)
> +    TRANSTBL_CONVERT(F_SHLCK)
> +#undef  TRANSTBL_CONVERT
> +    }
> +    return type;

Shouldn't it return something special, like -1 in case of conversion failure?

> +}
> +
> +static unsigned int host_to_target_flock(unsigned int type)
> +{
> +    switch (type) {
> +#define TRANSTBL_CONVERT(a) case a: return TARGET_##a;
> +    TRANSTBL_CONVERT(F_RDLCK)
> +    TRANSTBL_CONVERT(F_WRLCK)
> +    TRANSTBL_CONVERT(F_UNLCK)
> +    TRANSTBL_CONVERT(F_EXLCK)
> +    TRANSTBL_CONVERT(F_SHLCK)
> +#undef  TRANSTBL_CONVERT
> +    }
> +    return type;
> +}
>

There's a duplication. Wouldn't it be better if it was done like the following:

#define FLOCK_TRANSTBL \
    switch (type) {
    TRANSTBL_CONVERT(F_RDLCK) \
    TRANSTBL_CONVERT(F_WRLCK) \
    TRANSTBL_CONVERT(F_UNLCK) \
    TRANSTBL_CONVERT(F_EXLCK) \
    TRANSTBL_CONVERT(F_SHLCK) \
    }

static unsigned int target_to_host_flock(unsigned int type)
{
#define TRANSTBL_CONVERT(a) case TARGET_##a: return a;
    FLOCK_TRANSTBL
#undef  TRANSTBL_CONVERT
    return -1;
}

static unsigned int host_to_target_flock(unsigned int type)
{
#define TRANSTBL_CONVERT(a) case a: return TARGET_##a;
    FLOCK_TRANSTBL
#undef  TRANSTBL_CONVERT
    return -1;
}

#undef FLOCK_TRANSTBL

-- 
Thanks.
-- Max
