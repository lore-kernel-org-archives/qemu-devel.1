Received: from eggs.gnu.org ([2001:4830:134:3::10]:33708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSKDE-0000hu-FF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSKDA-0006Jx-KS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSKDA-0006Ik-Ek
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47A7F3B721
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 09:33:35 +0000 (UTC)
Date: Tue, 4 Jul 2017 10:33:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704093331.GE3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170704092704.8754-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704092704.8754-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: should not use signal except
 for SIG_DFL or SIG_IGN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jul 04, 2017 at 11:27:04AM +0200, Paolo Bonzini wrote:
> Using signal to establish a signal handler is not portable; on
> SysV systems, the signal handler would be reset to SIG_DFL after
> delivery, while BSD preserves the signal handler.  Daniel Berrange
> reported that (to complicate matters further) the signal system call
> has SysV behavior, but glibc signal() actually calls the sigaction
> system call to provide BSD behavior.
> 
> However, using signal() to set a signal's disposition to SIG_DFL
> or SIG_IGN is portable and is a relatively common occurrence in
> QEMU source code, so allow that.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

We currently only have 1 violation of this rule, and that
is in the TCG test suite, so pretty harmless.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 45027b9281..73efc927a9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2473,6 +2473,10 @@ sub process {
>  		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
>  			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
>  		}
> +# recommend sigaction over signal for portability, when establishing a handler
> +		if ($line =~ /\bsignal\s*\(/ && !($line =~ /SIG_(?:IGN|DFL)/)) {
> +			ERROR("use sigaction to establish signal handlers; signal is not portable\n" . $herecurr);
> +		}
>  # check for module_init(), use category-specific init macros explicitly please
>  		if ($line =~ /^module_init\s*\(/) {
>  			ERROR("please use block_init(), type_init() etc. instead of module_init()\n" . $herecurr);
> -- 
> 2.13.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
