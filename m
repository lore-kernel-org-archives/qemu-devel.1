Received: from eggs.gnu.org ([2001:4830:134:3::10]:36693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evlaW-0001N0-EV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evlaQ-0000q7-IE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evlaQ-0000pw-Cv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:34 -0400
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-13-git-send-email-ian.jackson@eu.citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b200dee9-bbdb-8c4b-7604-d9b6d566ea5d@redhat.com>
Date: Tue, 13 Mar 2018 16:11:31 +0100
MIME-Version: 1.0
In-Reply-To: <1520535787-6223-13-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/12] scripts/get_maintainer.pl: Print
 proper error message for missing $file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Thomas Huth <thuth@redhat.com>

On 08/03/2018 20:03, Ian Jackson wrote:
> If you pass scripts/get_maintainer.pl the name of a FIFO or other
> exciting object (/dev/stdin, for example), it would falsely print
> "file not found".  Instead: stat the object rather than using -f so
> that we do not mind if the object is not a file; and print the errno
> value in the error message.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony PERARD <anthony.perard@citrix.com>
> ---
> v6: New patch in this version of the series
> ---
>  scripts/get_maintainer.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 07369aa..43fb5f5 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -381,8 +381,8 @@ foreach my $file (@ARGV) {
>  	##if $file is a directory and it lacks a trailing slash, add one
>  	if ((-d $file)) {
>  	    $file =~ s@([^/])$@$1/@;
> -	} elsif (!(-f $file)) {
> -	    die "$P: file '${file}' not found\n";
> +	} elsif (!(stat $file)) {
> +	    die "$P: file '${file}' not found: $!\n";
>  	}
>      }
>      if ($from_filename) {
> 

Queued, thanks.

Paolo
