Received: from eggs.gnu.org ([2001:4830:134:3::10]:55639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrQ-00006d-99
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrN-0007N6-0W
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:32 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrM-0007Mt-RN
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:28 -0500
Received: by mail-qk0-x244.google.com with SMTP id p22so11577709qka.3
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:12:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-6-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <860c3af1-5a8b-b8f5-2bc1-de3807adb096@amsat.org>
Date: Sun, 19 Feb 2017 01:12:24 -0300
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/24] util/cutils: Rewrite documentation
 of qemu_strtol() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 02/14/2017 07:25 AM, Markus Armbruster wrote:
> Fixes the following documentation bugs:
>
> * Fails to document that null @nptr is safe.
>
> * Fails to document that we return -EINVAL when no conversion could be
>   performed (commit 47d4be1).
>
> * Confuses long long with int64_t, and unsigned long long with
>   uint64_t.
>
> * Claims the unsigned conversions can underflow.  They can't.
>
> While there, mark problematic assumptions that int64_t is long long,
> and uint64_t is unsigned long long with FIXME comments.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/cutils.c | 80 +++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index 4fefcf3..1ae2a08 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -265,9 +265,6 @@ int64_t qemu_strtosz(const char *nptr, char **end)
>  static int check_strtox_error(const char *p, char *endptr, const char **next,
>                                int err)
>  {
> -    /* If no conversion was performed, prefer BSD behavior over glibc
> -     * behavior.
> -     */
>      if (err == 0 && endptr == p) {
>          err = EINVAL;
>      }
> @@ -281,30 +278,28 @@ static int check_strtox_error(const char *p, char *endptr, const char **next,
>  }
>
>  /**
> - * QEMU wrappers for strtol(), strtoll(), strtoul(), strotull() C functions.
> + * Convert string @nptr to a long integer, and store it in @result.
>   *
> - * Convert ASCII string @nptr to a long integer value
> - * from the given @base. Parameters @nptr, @endptr, @base
> - * follows same semantics as strtol() C function.
> + * This is a wrapper around strtol() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtol() with differences
> + * noted below.
>   *
> - * Unlike from strtol() function, if @endptr is not NULL, this
> - * function will return -EINVAL whenever it cannot fully convert
> - * the string in @nptr with given @base to a long. This function returns
> - * the result of the conversion only through the @result parameter.
> + * @nptr may be null, and no conversion is performed then.
>   *
> - * If NULL is passed in @endptr, then the whole string in @ntpr
> - * is a number otherwise it returns -EINVAL.
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
>   *
> - * RETURN VALUE
> - * Unlike from strtol() function, this wrapper returns either
> - * -EINVAL or the errno set by strtol() function (e.g -ERANGE).
> - * If the conversion overflows, -ERANGE is returned, and @result
> - * is set to the max value of the desired type
> - * (e.g. LONG_MAX, LLONG_MAX, ULONG_MAX, ULLONG_MAX). If the case
> - * of underflow, -ERANGE is returned, and @result is set to the min
> - * value of the desired type. For strtol(), strtoll(), @result is set to
> - * LONG_MIN, LLONG_MIN, respectively, and for strtoul(), strtoull() it
> - * is set to 0.
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store LONG_MAX in @result,
> + * and return -ERANGE.
> + *
> + * If the conversion underflows @result, store LONG_MIN in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
>   */
>  int qemu_strtol(const char *nptr, const char **endptr, int base,
>                  long *result)
> @@ -325,17 +320,29 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
>  }
>
>  /**
> - * Converts ASCII string to an unsigned long integer.
> + * Convert string @nptr to an unsigned long, and store it in @result.
>   *
> - * If string contains a negative number, value will be converted to
> - * the unsigned representation of the signed value, unless the original
> - * (nonnegated) value would overflow, in this case, it will set @result
> - * to ULONG_MAX, and return ERANGE.
> + * This is a wrapper around strtoul() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtoul() with differences
> + * noted below.
>   *
> - * The same behavior holds, for qemu_strtoull() but sets @result to
> - * ULLONG_MAX instead of ULONG_MAX.
> + * @nptr may be null, and no conversion is performed then.
>   *
> - * See qemu_strtol() documentation for more info.
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store ULONG_MAX in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + *
> + * Note that a number with a leading minus sign gets converted without
> + * the minus sign, checked for overflow (see above), then negated (in
> + * @result's type).  This is exactly how strtoul() works.
>   */
>  int qemu_strtoul(const char *nptr, const char **endptr, int base,
>                   unsigned long *result)
> @@ -360,9 +367,10 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
>  }
>
>  /**
> - * Converts ASCII string to a long long integer.
> + * Convert string @nptr to an int64_t.
>   *
> - * See qemu_strtol() documentation for more info.
> + * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
> + * and INT_MIN on underflow.
>   */
>  int qemu_strtoll(const char *nptr, const char **endptr, int base,
>                   int64_t *result)
> @@ -376,6 +384,7 @@ int qemu_strtoll(const char *nptr, const char **endptr, int base,
>          err = -EINVAL;
>      } else {
>          errno = 0;
> +        /* FIXME This assumes int64_t is long long */
>          *result = strtoll(nptr, &p, base);
>          err = check_strtox_error(nptr, p, endptr, errno);
>      }
> @@ -383,9 +392,9 @@ int qemu_strtoll(const char *nptr, const char **endptr, int base,
>  }
>
>  /**
> - * Converts ASCII string to an unsigned long long integer.
> + * Convert string @nptr to an uint64_t.
>   *
> - * See qemu_strtol() documentation for more info.
> + * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
>   */
>  int qemu_strtoull(const char *nptr, const char **endptr, int base,
>                    uint64_t *result)
> @@ -399,6 +408,7 @@ int qemu_strtoull(const char *nptr, const char **endptr, int base,
>          err = -EINVAL;
>      } else {
>          errno = 0;
> +        /* FIXME This assumes uint64_t is unsigned long long */
>          *result = strtoull(nptr, &p, base);
>          /* Windows returns 1 for negative out-of-range values.  */
>          if (errno == ERANGE) {
>
