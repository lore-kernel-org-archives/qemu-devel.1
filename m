Received: from eggs.gnu.org ([2001:4830:134:3::10]:54235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLY8G-0007dA-DJ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLY85-0000yD-AU
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:05:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLY85-0000xn-0m
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:04:53 -0400
References: <20180523031805.27101-1-peterx@redhat.com>
	<20180523031805.27101-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32769328-e52a-db6b-d963-973f174f4462@redhat.com>
Date: Wed, 23 May 2018 13:04:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180523031805.27101-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 05/22/2018 10:18 PM, Peter Xu wrote:
> I stole the printk_once() macro.
> 
> I always wanted to be able to print some error directly if there is a
> buffer to dump, however we can't use error_report() where the code path
> can be triggered by DDOS attack.  To avoid that, we can introduce a
> print-once-like function for it.  Meanwhile, we also introduce the
> corresponding helper for warn_report().
> 
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qemu/error-report.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1a52..3e6e84801f 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -44,6 +44,32 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   
> +/* Similar to error_report(), but it only prints the message once. */
> +#define error_report_once(fmt, ...)             \
> +    ({                                          \
> +        static bool __print_once;               \
> +        bool __ret_print_once = !__print_once;  \

In v1 you were asked to avoid leading double underscore 
(https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03442.html; 
use things like 'print_once_' instead) and to document the return value 
of these macros 
(https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03503.html; 
having the return value makes it possible to write conditional code that 
caches further information about a first, but not repeat, failures). 
Why hasn't that happened?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
