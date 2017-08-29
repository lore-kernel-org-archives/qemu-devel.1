Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmo9q-0004Pq-8y
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmo9n-000235-2g
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:34:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dmo9m-00022d-Rz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:34:46 -0400
Date: Tue, 29 Aug 2017 15:34:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170829153442.1175f76d@w520.home>
In-Reply-To: <20170801131618.27332-8-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
	<20170801131618.27332-8-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 7/9] checkpatch: check trace-events code
 style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Tue,  1 Aug 2017 14:16:16 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> According to CODING_STYLE, check that in trace-events:
> 1. hex numbers are prefixed with '0x'
> 2. '#' flag of printf is not used
> 3. The exclusion from 1. are period-separated groups of numbers
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20170731160135.12101-4-vsementsov@virtuozzo.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4e91122813..fa478074b8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1337,6 +1337,25 @@ sub process {
>  			$rpt_cleaners = 1;
>  		}
>  
> +# checks for trace-events files
> +		if ($realfile =~ /trace-events$/ && $line =~ /^\+/) {
> +			if ($rawline =~ /%[-+ 0]*#/) {
> +				ERROR("Don't use '#' flag of printf format ('%#') in " .
> +				      "trace-events, use '0x' prefix instead\n" . $herecurr);
> +			} else {
> +				my $hex =
> +					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
> +
> +				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
> +				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
> +
> +				if ($tmpline =~ /(?<!0x)$hex/) {
> +					ERROR("Hex numbers must be prefixed with '0x'\n" .
> +					      $herecurr);
> +				}
> +			}
> +		}
> +
>  # check we are in a valid source file if not then ignore this hunk
>  		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
>  

This broke checkpatch.pl for me:

Bareword found where operator expected at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
syntax error at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
Execution of ./scripts/checkpatch.pl aborted due to compilation errors.

$ perl -v

This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi
