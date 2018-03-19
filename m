Received: from eggs.gnu.org ([2001:4830:134:3::10]:58904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwfA-0004IJ-1P
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwf6-0002lx-Kw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:25:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exwf6-0002lf-Cr
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:25:24 -0400
References: <1521467768-3162-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <938b752e-770a-b8d2-d51f-55ef412973ae@redhat.com>
Date: Mon, 19 Mar 2018 10:25:20 -0500
MIME-Version: 1.0
In-Reply-To: <1521467768-3162-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, vsementsov@virtuozzo.com
Cc: qemu-devel@nongnu.org

On 03/19/2018 08:56 AM, Su Hang wrote:
> Bug fix: checkpatch.pl stops complaining about following pattern:
> """
> do {
>      //do somethins;

s/somethins/something/

> } while (conditions);

Having the commit message point to the commit id that introduced the bug 
is useful.  The grammar is awkward (it sounds like the bug is that 
checkpatch.pl stopped complaining about the pattern, so the fix is to 
reinstate the complaint); better might be:

Commit XYZ introduced a regression: checkpatch.pl started complaining 
about the following valid pattern:
do {
     /* something */
} while (condition);

Fix the script to once again permit this pattern.

> """
> 
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---

Is this an updated revision to a patch posted earlier?  If so, including 
'v2' in the subject line (easy if you use 'git format-patch -v2' or 'git 
send-email -v2'), and then using this space after the --- separator to 
describe what changed since v1, makes life easier for reviewers.

>   scripts/checkpatch.pl | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d1fe79bcc47c..2ca833f22e5a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2355,6 +2355,18 @@ sub process {
>   # check for missing bracing around if etc
>   		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
>   			$line !~ /\#\s*if/) {
> +			my $allowed = 0;
> +
> +			# Check the pre-context.
> +			if ($line =~ /(\}.*?)$/) {
> +				my $pre = $1;
> +
> +				if ($line !~ /else/) {
> +					print "APW: ALLOWED: pre<$pre> line<$line>\n"
> +						if $dbg_adv_apw;
> +					$allowed = 1;
> +				}
> +			}
>   			my ($level, $endln, @chunks) =
>   				ctx_statement_full($linenr, $realcnt, 1);
>                           if ($dbg_adv_apw) {
> @@ -2363,7 +2375,6 @@ sub process {
>                                   if $#chunks >= 1;
>                           }
>   			if ($#chunks >= 0 && $level == 0) {
> -				my $allowed = 0;
>   				my $seen = 0;
>   				my $herectx = $here . "\n";
>   				my $ln = $linenr - 1;
> @@ -2407,7 +2418,7 @@ sub process {
>                                               $allowed = 1;
>   					}
>   				}
> -				if ($seen != ($#chunks + 1)) {
> +				if ($seen != ($#chunks + 1) && !$allowed) {
>   					ERROR("braces {} are necessary for all arms of this statement\n" . $herectx);
>   				}
>   			}
> --
> 2.7.4
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
