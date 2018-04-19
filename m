Received: from eggs.gnu.org ([2001:4830:134:3::10]:59743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96YF-0006h3-Mx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96YB-0005Oc-Oq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f96YB-0005Nu-JZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:12:23 -0400
References: <20180419091105.3943-1-stefanha@redhat.com>
	<20180419091105.3943-3-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <369f09c1-bfa5-ff7e-d4f7-906b1c7f7098@redhat.com>
Date: Thu, 19 Apr 2018 12:12:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180419091105.3943-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] checkpatch: check utf-8 content from a
 commit log when it's missing from charset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>

On 19.04.2018 11:11, Stefan Hajnoczi wrote:
> From: Pasi Savanainen <pasi.savanainen@nixu.com>
> 
> Check that a commit log doesn't contain UTF-8 when a mail header
> explicitly defines a different charset, like
> 
> 'Content-Type: text/plain; charset="us-ascii"'
> 
> Signed-off-by: Pasi Savanainen <pasi.savanainen@nixu.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Andy Whitcroft <apw@canonical.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit fa64205df9dfd7b7662cc64a7e82115c00e428e5)
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/checkpatch.pl | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2d28db03a0..b2b088bab7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1185,6 +1185,8 @@ sub process {
>  	my $in_header_lines = 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  
> +	my $non_utf8_charset = 0;
> +
>  	our @report = ();
>  	our $cnt_lines = 0;
>  	our $cnt_error = 0;
> @@ -1413,10 +1415,17 @@ sub process {
>  			$in_commit_log = 1;
>  		}
>  
> -# Still not yet in a patch, check for any UTF-8
> -		if ($in_commit_log && $realfile =~ /^$/ &&
> +# Check if there is UTF-8 in a commit log when a mail header has explicitly
> +# declined it, i.e defined some charset where it is missing.
> +		if ($in_header_lines &&
> +		    $rawline =~ /^Content-Type:.+charset="(.+)".*$/ &&

In my version of the patch, I removed the quotes:

https://patchwork.kernel.org/patch/9539231/

... but I guess I should likely follow up on that change with the kernel
folks first ...


> +		    $1 !~ /utf-8/i) {
> +			$non_utf8_charset = 1;
> +		}
> +
> +		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>  		    $rawline =~ /$NON_ASCII_UTF8/) {
> -			CHK("UTF8_BEFORE_PATCH",
> +			WARN("UTF8_BEFORE_PATCH",
>  			    "8-bit UTF-8 used in possible commit log\n" . $herecurr);

Ah, here's the WARN instead of CHK ... in case you respin, you should do
that in the first patch already, I think.

In either case:

Reviewed-by: Thomas Huth <thuth@redhat.com>
