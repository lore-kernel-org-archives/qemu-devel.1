Received: from eggs.gnu.org ([2001:4830:134:3::10]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzg3a-0004XB-4J
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzg3W-0008Qs-W9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:33:34 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:30907 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dzg3W-0008QD-Jm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:33:30 -0400
References: <20171003220038.16762.20147.stgit@gimli.home>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7ff138b7-9ceb-9e0d-f470-2f216683591c@virtuozzo.com>
Date: Wed, 4 Oct 2017 12:33:25 +0300
MIME-Version: 1.0
In-Reply-To: <20171003220038.16762.20147.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Revert: checkpatch: check trace-events
 code style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com

04.10.2017 01:00, Alex Williamson wrote:
> Commit c3e5875afc0f ("checkpatch: check trace-events code style")
> introduces a regression as reported:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05820.html
>
> Bareword found where operator expected at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
> syntax error at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
> Execution of ./scripts/checkpatch.pl aborted due to compilation errors.
>
> $ perl -v
>
> This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi
>
> As no fix or discussion has resulted, revert the original patch.

However, this revert will be a regression too - checkpatch will not 
check that thing more.

>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Fixes: c3e5875afc0f ("checkpatch: check trace-events code style")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   scripts/checkpatch.pl |   19 -------------------
>   1 file changed, 19 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3c0a28e644aa..f7e785d12a49 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1422,25 +1422,6 @@ sub process {
>   			$rpt_cleaners = 1;
>   		}
>   
> -# checks for trace-events files
> -		if ($realfile =~ /trace-events$/ && $line =~ /^\+/) {
> -			if ($rawline =~ /%[-+ 0]*#/) {
> -				ERROR("Don't use '#' flag of printf format ('%#') in " .
> -				      "trace-events, use '0x' prefix instead\n" . $herecurr);
> -			} else {
> -				my $hex =
> -					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
> -
> -				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
> -				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
> -
> -				if ($tmpline =~ /(?<!0x)$hex/) {
> -					ERROR("Hex numbers must be prefixed with '0x'\n" .
> -					      $herecurr);
> -				}
> -			}
> -		}
> -
>   # check we are in a valid source file if not then ignore this hunk
>   		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
>   
>


-- 
Best regards,
Vladimir
