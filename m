Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drnUL-0007Hz-4e
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drnUH-0006Hk-4W
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drnUG-0006GE-RW
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB7A48553C
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 15:52:31 +0000 (UTC)
References: <20170912104626.8386-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <810971dc-0a17-cf41-c11a-db991a17317a@redhat.com>
Date: Tue, 12 Sep 2017 17:52:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170912104626.8386-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 12/09/2017 12:46, Daniel P. Berrange wrote:
> Currently before submitting a series, devs should run checkpatch.pl
> across each patch to be submitted. This can be automated using a
> command such as:
> 
>   git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'
> 
> This is rather long winded to type, so this patch introduces a new
> flag '--branch' to checkpatch.pl which instructs it to check every
> patch on the current GIT branch.

Great idea, though I'm not sure about having a default.  And to keep it
easy to invoke, having a sole argument that ends with ".." might DWIM
and enable --branch too...

Paolo

> For example:
> 
>     $ ./scripts/checkpatch.pl --branch
>     total: 0 errors, 0 warnings, 297 lines checked
> 
>     b886d352a2bf58f0996471fb3991a138373a2957 has no obvious style problems and is ready for submission.
>     total: 0 errors, 0 warnings, 182 lines checked
> 
>     2a731f9a9ce145e0e0df6d42dd2a3ce4dfc543fa has no obvious style problems and is ready for submission.
>     total: 0 errors, 0 warnings, 102 lines checked
> 
>     11844169bcc0c8ed4449eb3744a69877ed329dd7 has no obvious style problems and is ready for submission.
> 
> By default it checks every patch identified by 'master..', however,
> an alternative origin can be given if desired, if the current branch
> is rebased to another non-master branch:
> 
>     $ ./scripts/checkpatch.pl --branch somebranch..
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 97 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 71 insertions(+), 26 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fa478074b8..f8d080441f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -19,6 +19,8 @@ my $quiet = 0;
>  my $tree = 1;
>  my $chk_signoff = 1;
>  my $chk_patch = 1;
> +my $chk_branch = 0;
> +my $revlist = "master..";
>  my $tst_only;
>  my $emacs = 0;
>  my $terse = 0;
> @@ -43,6 +45,7 @@ Options:
>    --no-tree                  run without a kernel tree
>    --no-signoff               do not check for 'Signed-off-by' line
>    --patch                    treat FILE as patchfile (default)
> +  --branch                   check all patches on branch since master
>    --emacs                    emacs compile window format
>    --terse                    one line per report
>    -f, --file                 treat FILE as regular source file
> @@ -69,6 +72,7 @@ GetOptions(
>  	'tree!'		=> \$tree,
>  	'signoff!'	=> \$chk_signoff,
>  	'patch!'	=> \$chk_patch,
> +	'branch'	=> \$chk_branch,
>  	'emacs!'	=> \$emacs,
>  	'terse!'	=> \$terse,
>  	'f|file!'	=> \$file,
> @@ -88,9 +92,19 @@ help(0) if ($help);
>  
>  my $exit = 0;
>  
> -if ($#ARGV < 0) {
> -	print "$P: no input files\n";
> -	exit(1);
> +if ($chk_branch) {
> +	if ($#ARGV > 0) {
> +		print "$P: expected zero or one origni revisions\n";
> +		exit(1);
> +	}
> +	if ($#ARGV == 0) {
> +		$revlist = shift @ARGV;
> +	}
> +} else {
> +	if ($#ARGV < 0) {
> +		print "$P: no input files\n";
> +		exit(1);
> +	}
>  }
>  
>  my $dbg_values = 0;
> @@ -251,32 +265,63 @@ $chk_signoff = 0 if ($file);
>  my @rawlines = ();
>  my @lines = ();
>  my $vname;
> -for my $filename (@ARGV) {
> -	my $FILE;
> -	if ($file) {
> -		open($FILE, '-|', "diff -u /dev/null $filename") ||
> -			die "$P: $filename: diff failed - $!\n";
> -	} elsif ($filename eq '-') {
> -		open($FILE, '<&STDIN');
> -	} else {
> -		open($FILE, '<', "$filename") ||
> -			die "$P: $filename: open failed - $!\n";
> -	}
> -	if ($filename eq '-') {
> -		$vname = 'Your patch';
> -	} else {
> -		$vname = $filename;
> -	}
> -	while (<$FILE>) {
> +if ($chk_branch) {
> +	my @patches;
> +	my $HASH;
> +	open($HASH, "-|", "git", "log", "--format=%H", $revlist) ||
> +		die "$P: git log --format=%H $revlist failed - $!\n";
> +
> +	while (<$HASH>) {
>  		chomp;
> -		push(@rawlines, $_);
> +		push @patches, $_;
>  	}
> -	close($FILE);
> -	if (!process($filename)) {
> -		$exit = 1;
> +
> +	close $HASH;
> +
> +	for my $hash (@patches) {
> +		my $FILE;
> +		open($FILE, '-|', "git", "show", $hash) ||
> +			die "$P: git show $hash - $!\n";
> +		$vname = $hash;
> +		while (<$FILE>) {
> +			chomp;
> +			push(@rawlines, $_);
> +		}
> +		close($FILE);
> +		if (!process($hash)) {
> +			$exit = 1;
> +		}
> +		@rawlines = ();
> +		@lines = ();
> +	}
> +} else {
> +	for my $filename (@ARGV) {
> +		my $FILE;
> +		if ($file) {
> +			open($FILE, '-|', "diff -u /dev/null $filename") ||
> +				die "$P: $filename: diff failed - $!\n";
> +		} elsif ($filename eq '-') {
> +			open($FILE, '<&STDIN');
> +		} else {
> +			open($FILE, '<', "$filename") ||
> +				die "$P: $filename: open failed - $!\n";
> +		}
> +		if ($filename eq '-') {
> +			$vname = 'Your patch';
> +		} else {
> +			$vname = $filename;
> +		}
> +		while (<$FILE>) {
> +			chomp;
> +			push(@rawlines, $_);
> +		}
> +		close($FILE);
> +		if (!process($filename)) {
> +			$exit = 1;
> +		}
> +		@rawlines = ();
> +		@lines = ();
>  	}
> -	@rawlines = ();
> -	@lines = ();
>  }
>  
>  exit($exit);
> 
