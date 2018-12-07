Received: from eggs.gnu.org ([2001:4830:134:3::10]:52899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD8A-0006vx-V2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD87-0002b7-MD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:13:10 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVD85-0002E2-Ic
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:13:07 -0500
Received: by mail-wm1-f51.google.com with SMTP id c126so3928688wmh.0
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:13:00 -0800 (PST)
References: <20181206151856.77503-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9022c85e-9bbd-3500-edcd-c4ff014c5604@redhat.com>
Date: Fri, 7 Dec 2018 11:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181206151856.77503-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cutils: Assert in-range base for
 string-to-integer conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com

On 12/6/18 4:18 PM, Eric Blake wrote:
> POSIX states that the value of endptr is unspecified if strtol()
> fails with EINVAL due to an invalid base argument.  Since none of
> the callers to check_strtox_error() initialized endptr, we could
> end up propagating uninitialized data back to a caller on error.
> However, passing an out-of-range base is already a sign of poor
> programming, so let's just assert that base is in range, at which
> point check_strtox_error() can be tightened to assert that it is
> receiving an initialized ep that points somewhere within the
> caller's original string, regardless of whether strto*() succeeded
> or failed with ERANGE.
> 
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Also tested that this does not negatively impact David's pending
> additions of qemu_strtod{,_finite}().  Thus:
> Based-on: <20181121164421.20780-1-david@redhat.com>
> 
>  util/cutils.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index 91930d1bbeb..e098debdc0c 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -278,6 +278,7 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
>  static int check_strtox_error(const char *nptr, char *ep,
>                                const char **endptr, int libc_errno)
>  {
> +    assert(ep >= nptr);
>      if (endptr) {
>          *endptr = ep;
>      }
> @@ -325,6 +326,7 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,
>      char *ep;
>      long long lresult;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -377,6 +379,7 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,
>      char *ep;
>      long long lresult;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -433,6 +436,7 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
>  {
>      char *ep;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -475,6 +479,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
>  {
>      char *ep;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -502,6 +507,7 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
>  {
>      char *ep;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -525,6 +531,7 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
>  {
>      char *ep;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!nptr) {
>          if (endptr) {
>              *endptr = nptr;
> @@ -657,6 +664,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
>      char *endp = (char *)s;
>      unsigned long long val = 0;
> 
> +    assert((unsigned) base <= 36 && base != 1);
>      if (!s) {
>          r = -EINVAL;
>          goto out;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
