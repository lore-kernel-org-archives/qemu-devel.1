Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqmy-0007Gz-PJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqmv-0002u0-F4
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:23:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIqmv-0002tq-A8
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:23:53 -0400
References: <20180515172729.24564-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44d0b35b-ed0d-bae0-5208-36aa1fcce881@redhat.com>
Date: Wed, 16 May 2018 09:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180515172729.24564-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memfd: Avoid Coverity warning about
 integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 15/05/2018 19:27, Peter Maydell wrote:
> Coverity complains about qemu_memfd_create() (CID 1385858) because
> we calculate a bit position htsize which could be up to 63, but
> then use it in "1 << htsize" which is a 32-bit integer calculation
> and could push the 1 off the top of the value.
> 
> Silence the complaint bu using "1ULL"; this isn't a bug in
> practice since a hugetlbsize of 4GB is not very plausible.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  util/memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index b3ecbac19e..d248a53c3c 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -66,7 +66,7 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>  {
>      int htsize = hugetlbsize ? ctz64(hugetlbsize) : 0;
>  
> -    if (htsize && 1 << htsize != hugetlbsize) {
> +    if (htsize && 1ULL << htsize != hugetlbsize) {
>          error_setg(errp, "Hugepage size must be a power of 2");
>          return -1;
>      }
> 

Queued, thanks.

Paolo
