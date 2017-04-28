Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d45sK-0004wL-TC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d45sG-0003ES-VJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d45sG-0003DA-La
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:23:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6919561B8E
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 13:23:51 +0000 (UTC)
Date: Fri, 28 Apr 2017 09:23:51 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1612393779.1670657.1493385831149.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170427165526.19836-1-dgilbert@redhat.com>
References: <20170427165526.19836-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com



----- Original Message -----
> From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
> To: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com
> Sent: Thursday, April 27, 2017 6:55:26 PM
> Subject: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main code
> 
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Glib commit a6a875068779 (from 2013) made many of the glib assert
> macros non-fatal if a flag is set.
> This causes two problems:
>   a) Compilers moan that your code is unsafe even though you've
>      put an assert in before the point of use.
>   b) Someone evil could, in a library, call
>      g_test_set_nonfatal_assertions() and cause our assertions in
>      important places not to fail and potentially allow memory overruns.
> 
> Ban most of the glib assertion functions (basically everything except
> g_assert and g_assert_not_reached) except in tests/
> 
> This makes checkpatch gives an error such as:
> 
>   ERROR: Use g_assert or g_assert_not_reached
>   #77: FILE: vl.c:4725:
>   +    g_assert_cmpstr("Chocolate", >, "Cheese");
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  scripts/checkpatch.pl | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f084542934..73cee81b79 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2571,6 +2571,27 @@ sub process {
>  		if ($line =~ /\bbzero\(/) {
>  			ERROR("use memset() instead of bzero()\n" . $herecurr);
>  		}
> +		my $non_exit_glib_asserts = qr{g_assert_cmpstr|
> +						g_assert_cmpint|
> +						g_assert_cmpuint|
> +						g_assert_cmphex|
> +						g_assert_cmpfloat|
> +						g_assert_true|
> +						g_assert_false|
> +						g_assert_nonnull|
> +						g_assert_null|
> +						g_assert_no_error|
> +						g_assert_error|
> +						g_test_assert_expected_messages|
> +						g_test_trap_assert_passed|
> +						g_test_trap_assert_stdout|
> +						g_test_trap_assert_stdout_unmatched|
> +						g_test_trap_assert_stderr|
> +						g_test_trap_assert_stderr_unmatched}x;
> +		if ($realfile !~ /^tests\// &&
> +			$line =~ /\b(?:$non_exit_glib_asserts)\(/) {
> +			ERROR("Use g_assert or g_assert_not_reached\n". $herecurr);
> +		}
>  	}
>  
>  	# If we have no input at all, then there is nothing to report on
> --
> 2.12.2
> 
> 
> 

Queued, thanks.

Paolo
