Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo0oo-0003Wk-KR
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo0ol-0006JN-BR
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:22:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo0ol-0006J2-6I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:22:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 08:22:32 +0200
In-Reply-To: <20180809160011.17225-1-peter.maydell@linaro.org> (Peter
	Maydell's message of "Thu, 9 Aug 2018 17:00:11 +0100")
Message-ID: <87zhxuu4ev.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> We now require Linux-kernel-style multiline comments:
>     /*
>      * line one
>      * line two
>      */
>
> Enforce this in checkpatch.pl, by backporting the relevant
> parts of the Linux kernel's checkpatch.pl. (The only changes
> needed are that Linux's checkpatch.pl WARN() function takes
> an extra argument that ours does not.)

Really?  [*]

>
> The kernel's checkpatch does not enforce "leading /* on
> a line of its own, so that part is unique to QEMU's checkpatch.
>
> Sample warning output:
>
> WARNING: Block comments use a leading /* on a separate line
> #34: FILE: hw/intc/arm_gicv3_common.c:39:
> +    /* Older versions of QEMU had a bug in the handling of state save/restore
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm still not used to the leeading-/*-on-it's-own style,
> so having checkpatch catch my lapses is handy...

Yes, please!

> I used WARN level severity mostly because Linux does.
> ---
>  scripts/checkpatch.pl | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 42e1c50dd80..18bc3c59c85 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1566,6 +1566,54 @@ sub process {
>  # check we are in a valid C source file if not then ignore this hunk
>  		next if ($realfile !~ /\.(h|c|cpp)$/);
>  
> +# Block comment styles
> +
> +		# Block comments use /* on a line of its own
> +		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
> +		    $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
> +			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
> +		}
> +

[*] The kernel's has

   # Networking with an initial /*
                   if ($realfile =~ m@^(drivers/net/|net/)@ &&
                       $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
                       $rawline =~ /^\+[ \t]*\*/ &&
                       $realline > 2) {
                           WARN("NETWORKING_BLOCK_COMMENT_STYLE",
                                "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
                   }

which makes no sense for us.  Your code looks good to me, but your
commit message claims it doesn't exist :)

The remainder matches the kernel's version.

> +# Block comments use * on subsequent lines
> +		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
> +		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
> +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
> +		    $rawline =~ /^\+/ &&			#line is new
> +		    $rawline !~ /^\+[ \t]*\*/) {		#no leading *
> +			WARN("Block comments use * on subsequent lines\n" . $hereprev);
> +		}
> +
> +# Block comments use */ on trailing lines
> +		if ($rawline !~ m@^\+[ \t]*\*/[ \t]*$@ &&	#trailing */
> +		    $rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
> +		    $rawline !~ m@^\+.*\*{2,}/[ \t]*$@ &&	#trailing **/
> +		    $rawline =~ m@^\+[ \t]*.+\*\/[ \t]*$@) {	#non blank */
> +			WARN("Block comments use a trailing */ on a separate line\n" . $herecurr);
> +		}
> +
> +# Block comment * alignment
> +		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
> +		    $line =~ /^\+[ \t]*$;/ &&			#leading comment
> +		    $rawline =~ /^\+[ \t]*\*/ &&		#leading *
> +		    (($prevrawline =~ /^\+.*?\/\*/ &&		#leading /*
> +		      $prevrawline !~ /\*\/[ \t]*$/) ||		#no trailing */
> +		     $prevrawline =~ /^\+[ \t]*\*/)) {		#leading *
> +			my $oldindent;
> +			$prevrawline =~ m@^\+([ \t]*/?)\*@;
> +			if (defined($1)) {
> +				$oldindent = expand_tabs($1);
> +			} else {
> +				$prevrawline =~ m@^\+(.*/?)\*@;
> +				$oldindent = expand_tabs($1);
> +			}
> +			$rawline =~ m@^\+([ \t]*)\*@;
> +			my $newindent = $1;
> +			$newindent = expand_tabs($newindent);
> +			if (length($oldindent) ne length($newindent)) {
> +				WARN("Block comments should align the * on each line\n" . $hereprev);
> +			}
> +		}
> +
>  # Check for potential 'bare' types
>  		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
>  		    $realline_next);

With a corrected commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
