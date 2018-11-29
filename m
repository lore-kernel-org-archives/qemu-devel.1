Received: from eggs.gnu.org ([2001:4830:134:3::10]:48294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSNCA-0004Jd-Fs
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSN0j-00005L-UN
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:09:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSN0j-0008Ts-IT
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:09:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so2033009wrs.8
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:09:40 -0800 (PST)
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eed95c3-4598-6b4c-674c-4eef2dc598bc@redhat.com>
Date: Thu, 29 Nov 2018 15:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181129090120.28828-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/4] checkpatch: colorize output to
 terminal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 29/11/18 10:01, Paolo Bonzini wrote:
> Add optional colors to make seeing message types a bit easier.
> The default is to show them on a tty.  The chosen colors should resemble
> gcc's.
> 
> Inspired by Linux commit 57230297116faf5b0a995916d5dd5fedab54cba3
> ("checkpatch: colorize output to terminal").
> ---
>  scripts/checkpatch.pl | 51 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f5284d910c..14be11719c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7,6 +7,7 @@
>  
>  use strict;
>  use warnings;
> +use Term::ANSIColor qw(:constants);
>  
>  my $P = $0;
>  $P =~ s@.*/@@g;
> @@ -26,6 +27,7 @@ my $tst_only;
>  my $emacs = 0;
>  my $terse = 0;
>  my $file = undef;
> +my $color = "auto";
>  my $no_warnings = 0;
>  my $summary = 1;
>  my $mailback = 0;
> @@ -64,6 +66,8 @@ Options:
>                               is all off)
>    --test-only=WORD           report only warnings/errors containing WORD
>                               literally
> +  --color[=WHEN]             Use colors 'always', 'never', or only when output
> +                             is a terminal ('auto'). Default is 'auto'.
>    -h, --help, --version      display this help and exit
>  
>  When FILE is - read standard input.
> @@ -72,6 +76,14 @@ EOM
>  	exit($exitcode);
>  }
>  
> +# Perl's Getopt::Long allows options to take optional arguments after a space.
> +# Prevent --color by itself from consuming other arguments
> +foreach (@ARGV) {
> +	if ($_ eq "--color" || $_ eq "-color") {
> +		$_ = "--color=$color";
> +	}
> +}
> +
>  GetOptions(
>  	'q|quiet+'	=> \$quiet,
>  	'tree!'		=> \$tree,
> @@ -89,6 +101,8 @@ GetOptions(
>  
>  	'debug=s'	=> \%debug,
>  	'test-only=s'	=> \$tst_only,
> +	'color=s'       => \$color,
> +	'no-color'      => sub { $color = 'never'; },
>  	'h|help'	=> \$help,
>  	'version'	=> \$help
>  ) or help(1);
> @@ -144,6 +158,18 @@ if (!$chk_patch && !$chk_branch && !$file) {
>  	die "One of --file, --branch, --patch is required\n";
>  }
>  
> +if ($color =~ /^[01]$/) {
> +	$color = !$color;

Without this if:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +} elsif ($color =~ /^always$/i) {
> +	$color = 1;
> +} elsif ($color =~ /^never$/i) {
> +	$color = 0;
> +} elsif ($color =~ /^auto$/i) {
> +	$color = (-t STDOUT);
> +} else {
> +	die "Invalid color mode: $color\n";
> +}
> +
>  my $dbg_values = 0;
>  my $dbg_possible = 0;
>  my $dbg_type = 0;
> @@ -372,7 +398,9 @@ if ($chk_branch) {
>  		close($FILE);
>  		$vname = substr($hash, 0, 12) . ' (' . $git_commits{$hash} . ')';
>  		if ($num_patches > 1 && $quiet == 0) {
> -			print "$i/$num_patches Checking commit $vname\n";
> +			my $prefix = "$i/$num_patches";
> +			$prefix = BLUE . BOLD . $prefix . RESET if $color;
> +			print "$prefix Checking commit $vname\n";
>  			$vname = "Patch $i/$num_patches";
>  		} else {
>  			$vname = "Commit " . $vname;
> @@ -1182,14 +1210,23 @@ sub possible {
>  my $prefix = '';
>  
>  sub report {
> -	if (defined $tst_only && $_[0] !~ /\Q$tst_only\E/) {
> +	my ($level, $msg) = @_;
> +	if (defined $tst_only && $msg !~ /\Q$tst_only\E/) {
>  		return 0;
>  	}
> -	my $line = $prefix . $_[0];
>  
> -	$line = (split('\n', $line))[0] . "\n" if ($terse);
> +	my $output = '';
> +	$output .= BOLD if $color;
> +	$output .= $prefix;
> +	$output .= RED if $color && $level eq 'ERROR';
> +	$output .= MAGENTA if $color && $level eq 'WARNING';
> +	$output .= $level . ':';
> +	$output .= RESET if $color;
> +	$output .= ' ' . $msg . "\n";
> +
> +	$output = (split('\n', $output))[0] . "\n" if ($terse);
>  
> -	push(our @report, $line);
> +	push(our @report, $output);
>  
>  	return 1;
>  }
> @@ -1197,13 +1234,13 @@ sub report_dump {
>  	our @report;
>  }
>  sub ERROR {
> -	if (report("ERROR: $_[0]\n")) {
> +	if (report("ERROR", $_[0])) {
>  		our $clean = 0;
>  		our $cnt_error++;
>  	}
>  }
>  sub WARN {
> -	if (report("WARNING: $_[0]\n")) {
> +	if (report("WARNING", $_[0])) {
>  		our $clean = 0;
>  		our $cnt_warn++;
>  	}
> 
