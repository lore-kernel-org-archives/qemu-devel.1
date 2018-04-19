Received: from eggs.gnu.org ([2001:4830:134:3::10]:56468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96RB-00043v-Ee
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96R1-000711-T2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:05:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f96R1-000704-Pe
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:04:59 -0400
References: <20180419091105.3943-1-stefanha@redhat.com>
	<20180419091105.3943-2-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <59bf5edb-3156-04a6-4b51-6459aaace806@redhat.com>
Date: Thu, 19 Apr 2018 12:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180419091105.3943-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] checkpatch: add a --strict check for
 utf-8 in commit logs
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
> From: Joe Perches <joe@perches.com>
> 
> Some find using utf-8 in commit logs inappropriate.
> 
> Some patch commit logs contain unintended utf-8 characters when doing
> things like copy/pasting compilation output.
> 
> Look for the start of any commit log by skipping initial lines that look
> like email headers and "From: " lines.
> 
> Stop looking for utf-8 at the first signature line.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Whitcroft <apw@shadowen.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit 15662b3e8644905032c2e26808401a487d4e90c1)
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/checkpatch.pl | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d52207a3cc..2d28db03a0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
[...]
> @@ -1397,6 +1405,21 @@ sub process {
>  			ERROR("Invalid UTF-8, patch and commit message should be encoded in UTF-8\n" . $hereptr);
>  		}
>  
> +# Check if it's the start of a commit log
> +# (not a header line and we haven't seen the patch filename)
> +		if ($in_header_lines && $realfile =~ /^$/ &&
> +		    $rawline !~ /^(commit\b|from\b|\w+:).+$/i) {
> +			$in_header_lines = 0;
> +			$in_commit_log = 1;
> +		}
> +
> +# Still not yet in a patch, check for any UTF-8
> +		if ($in_commit_log && $realfile =~ /^$/ &&
> +		    $rawline =~ /$NON_ASCII_UTF8/) {
> +			CHK("UTF8_BEFORE_PATCH",
> +			    "8-bit UTF-8 used in possible commit log\n" . $herecurr);
> +		}

As far as I can see, we don't have that CHK() function in our version of
checkpatch.pl yet, so you'd either have to turn that into a WARN or port
the CHK() function, too?

 Thomas
