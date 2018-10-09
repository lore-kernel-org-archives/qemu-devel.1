Received: from eggs.gnu.org ([2001:4830:134:3::10]:38320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9wf7-0003C6-1B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9wf0-0006Dm-Ep
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9wf0-0006DR-7w
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:23:10 -0400
References: <20181009181612.10633-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7f3a1b3-7c06-b82b-3201-4db1175ee8f0@redhat.com>
Date: Tue, 9 Oct 2018 13:23:07 -0500
MIME-Version: 1.0
In-Reply-To: <20181009181612.10633-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] coccinelle: new inplace-byteswaps.cocci to
 remove inplace-byteswapping calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

On 10/9/18 1:16 PM, Peter Maydell wrote:
> Add a new Coccinelle script which replaces uses of the inplace
> byteswapping functions *_to_cpus() and cpu_to_*s() with their
> not-in-place equivalents. This is useful for where the swapping
> is done on members of a packed struct -- taking the address
> of the member to pass it to an inplace function is undefined
> behaviour in C.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Richard asked for a coccinelle script in the scripts/coccinelle
> directory, so here's a patch to add it.
> 
>   scripts/coccinelle/inplace-byteswaps.cocci | 65 ++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100644 scripts/coccinelle/inplace-byteswaps.cocci
> 
> diff --git a/scripts/coccinelle/inplace-byteswaps.cocci b/scripts/coccinelle/inplace-byteswaps.cocci
> new file mode 100644
> index 00000000000..a869a90cbfd
> --- /dev/null
> +++ b/scripts/coccinelle/inplace-byteswaps.cocci
> @@ -0,0 +1,65 @@
> +// Replace uses of in-place byteswapping functions with calls to the
> +// equivalent not-in-place functions.  This is necessary to avoid
> +// undefined behaviour if the expression being swapped is a field in a
> +// packed struct.
> +
> +@@
> +expression E;
> +@@
> +-be16_to_cpus(&E);
> ++E = be16_to_cpu(E);
> +@@
> +expression E;
> +@@
> +-be32_to_cpus(&E);
> ++E = be32_to_cpu(E);

It's probably possible to shorten this as:

@@
expression E;
@@
(
-be16_to_cpus(&E);
+E = be16_to_cpu(E);
|
-be32_to_cpus(&E);
+E = be32_to_cpu(E);
...
)

But I'm also okay if the long form gets checked in.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
