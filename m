Received: from eggs.gnu.org ([2001:4830:134:3::10]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evNmc-0007xU-KT
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evNma-0007MG-IV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evNma-0007LV-DN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:32 -0400
References: <20180312131806.23209-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
Date: Mon, 12 Mar 2018 14:46:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180312131806.23209-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 12.03.2018 14:18, Stefan Hajnoczi wrote:
> Warn if files are added/renamed/deleted without MAINTAINERS file
> changes.  This has helped me in Linux and we could benefit from this
> check in QEMU.
> 
> This patch is a manual cherry-pick of Linux commit
> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
> file add/move/delete") by Joe Perches <joe@perches.com>.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Note the 80-char lines are from upstream code.  Keep them as-is.
> 
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d1fe79bcc4..d0d8f63d48 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1177,6 +1177,7 @@ sub process {
>  	our $clean = 1;
>  	my $signoff = 0;
>  	my $is_patch = 0;
> +	my $reported_maintainer_file = 0;
>  
>  	our @report = ();
>  	our $cnt_lines = 0;
> @@ -1379,6 +1380,24 @@ sub process {
>  			}
>  		}
>  
> +# Check if MAINTAINERS is being updated.  If so, there's probably no need to
> +# emit the "does MAINTAINERS need updating?" message on file add/move/delete
> +		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
> +			$reported_maintainer_file = 1;
> +		}
> +
> +# Check for added, moved or deleted files
> +		if (!$reported_maintainer_file &&
> +		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> +		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> +		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> +		      (defined($1) || defined($2))))) {
> +			$is_patch = 1;
> +			$reported_maintainer_file = 1;
> +			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" .
> +				$herecurr);

Could you please turn this into a notification instead of a warning? For
rationale, please see the discussion of this patch last year:

http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html

 Thanks,
  Thomas
