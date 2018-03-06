Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etATb-0005O7-Tj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etATX-0005rm-SR
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:47 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etATX-0005rb-JJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id w77so20502234wrc.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:09:43 -0800 (PST)
References: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4db613bc-2e22-176b-ecf7-ef628ccc8c7b@redhat.com>
Date: Tue, 6 Mar 2018 12:09:36 +0100
MIME-Version: 1.0
In-Reply-To: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] scripts/checkpatch.pl: add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, thuth@redhat.com, eblake@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

On 06/03/2018 08:04, Su Hang wrote:
> Adding check for `while` and `for` statements, which condition has more than
> one line.
> 
> The former checkpatch.pl can check `if` statement, which condition has more
> than one line, whether block misses brace round, like this:
> '''
> if (cond1 ||
>     cond2)
>     statement;
> '''
> But it doesn't do the same check for `for` and `while` statements.
> 
> Using `(?:...)` instead of `(...)` in regex pattern catch.
> Because `(?:...)` is faster and avoids unwanted side-effect.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b4b812e28fa..b1a8407d7406 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2352,8 +2352,9 @@ sub process {
>  			}
>  		}
>  
> -# check for missing bracing round if etc
> -		if ($line =~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
> +# check for missing bracing around if etc
> +		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
> +			$line !~ /\#\s*(?:if|while|for)/) {

The second line checks for preprocessor statements and does not need to
be extended with (?:if|while|for).

I changed this and applied the patch.  Thanks,

Paolo


>  			my ($level, $endln, @chunks) =
>  				ctx_statement_full($linenr, $realcnt, 1);
>                          if ($dbg_adv_apw) {
> 

Q
