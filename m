Received: from eggs.gnu.org ([2001:4830:134:3::10]:36863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNIlG-0006DH-I9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNIlD-0006Nk-C5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:36:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNIlD-0006F7-2h
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:36:47 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-3-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40ed700b-d0b1-2a03-eba9-4afa595de556@redhat.com>
Date: Thu, 15 Nov 2018 08:36:19 -0600
MIME-Version: 1.0
In-Reply-To: <20181115140501.7872-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/9] cutils: use qemu_strtod_finite() in
 do_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 8:04 AM, David Hildenbrand wrote:
> Let's use the new function. In order to do so, we have to convert all
> users of qemu_strtosz*() to pass a "const char **end" ptr.
> 
> We will now also reject "inf" properly.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/qemu/cutils.h |  6 +++---
>   monitor.c             |  2 +-
>   tests/test-cutils.c   | 14 +++++++-------
>   util/cutils.c         | 14 ++++++--------
>   4 files changed, 17 insertions(+), 19 deletions(-)
> 

> +++ b/tests/test-cutils.c
> @@ -1950,7 +1950,7 @@ static void test_qemu_strtou64_full_max(void)
>   static void test_qemu_strtosz_simple(void)
>   {
>       const char *str;
> -    char *endptr = NULL;
> +    const char *endptr = NULL;
...
> diff --git a/util/cutils.c b/util/cutils.c

Conversion of call sites is good (in fact, you could drop the ' = NULL' 
initialization, since do_strtosz() guarantees it is set to something 
sane even on error).  But where's the added test coverage of rejecting 
"inf" as a size?

> index 7868a683e8..dd61fb4558 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -206,19 +206,17 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>    * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
>    * other error.
>    */
> -static int do_strtosz(const char *nptr, char **end,
> +static int do_strtosz(const char *nptr, const char **end,
>                         const char default_suffix, int64_t unit,
>                         uint64_t *result)
>   {
>       int retval;
> -    char *endptr;
> +    const char *endptr;
>       unsigned char c;
>       int mul_required = 0;
>       double val, mul, integral, fraction;
>   
> -    errno = 0;
> -    val = strtod(nptr, &endptr);
> -    if (isnan(val) || endptr == nptr || errno != 0) {
> +    if (qemu_strtod_finite(nptr, &endptr, &val)) {
>           retval = -EINVAL;

This slams -ERANGE failure into -EINVAL.  Do we care?  Or would it have 
been better to just do:

retval = qemu_strtod_finite(...);
if (retval) {
     goto out;

>           goto out;
>       }
> @@ -259,17 +257,17 @@ out:

More context:

out:
     if (end) {
         *end = endptr;
     } else if (*endptr) {
         retval = -EINVAL;
     }

>       return retval;
>   }

Everything else looks okay.

Hmm - while touching this, is it worth making mul_required be a bool, to 
match its use?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
