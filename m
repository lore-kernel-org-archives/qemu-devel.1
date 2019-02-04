Received: from eggs.gnu.org ([209.51.188.92]:53740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqngB-0001Zi-4x
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqng7-0008Mw-AS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:29:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqng2-0008G9-9G
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:29:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so1766430wmi.4
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 15:29:17 -0800 (PST)
References: <20190204225542.5597-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
Date: Tue, 5 Feb 2019 00:29:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190204225542.5597-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

On 2/4/19 11:55 PM, Eric Blake wrote:
> Flag commit attribution tags that are unusual (often because they
> were a typo), but only as a warning (because sometimes a humorous
> or otherwise useful tag is intentionally supplied).
> 
> This picks the 6-most popular tags, each with 700 or more uses (well,
> S-o-b was already checked for case-sensitivity and typos, leaving
> only 5 new tags being checked), as determined by:
> $ git log | sed -n 's/^ *\([A-Za-z-]*-by:\).*/\1/p' | \
>   sort | uniq -c | sort -k1,1n | tail
> 
> Most of the rejected lines were obvious typos (among others, we've
> had 4 cases of someone being burnt, based on Singed-off-by; and 2
> cases of list-reading via an e-reader, based on eviewed-by; there
> are also lines forgetting a space after the ':') or otherwise
> tongue-in-check (3 Approximately-suggested-by). A few lines not
> whitelisted here may be legitimate, but as they are orders of
> magnitude rarer, it is therefore not worth worrying about
> (7 Requested-by, 3 Co-authored-by, 1 Inspired-by, etc.).

'Inspired-by' is kinda Zen :) And is from Peter!

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v2: fix regex
> 
>  scripts/checkpatch.pl | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 88682cb0a9f..4962f74eec1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1456,7 +1456,7 @@ sub process {
>  		    ERROR("Author email address is mangled by the mailing list\n" . $herecurr);
>  		}
> 
> -#check the patch for a signoff:
> +#check the patch for a signoff, and that other attribution lines are typical:
>  		if ($line =~ /^\s*signed-off-by:/i) {
>  			# This is a signoff, if ugly, so do not double report.
>  			$signoff++;
> @@ -1470,6 +1470,10 @@ sub process {
>  				ERROR("space required after Signed-off-by:\n" .
>  					$herecurr);
>  			}
> +		} elsif($line =~ /^\s*([A-Za-z-]*)-by:/ &&

I guess we don't mind about angry typewriters who Ack-BY ;)

> +			($1 !~ /(Suggest|Report|Test|Ack|Review)ed/ ||
> +			 $line !~ /^\s*[a-z-]*-by:\s/i)) {

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +		    WARN("suspicious attribution tag:\n" . $herecurr);
>  		}
> 
>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
> 
