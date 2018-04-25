Received: from eggs.gnu.org ([2001:4830:134:3::10]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBAjb-0004A6-5M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBAjX-0004Si-VP
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:04:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBAjX-0004SV-R3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:04:39 -0400
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-17-git-send-email-ian.jackson@eu.citrix.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <779c1429-b78d-076e-3376-34a9d4efdd13@redhat.com>
Date: Wed, 25 Apr 2018 05:04:28 +0200
MIME-Version: 1.0
In-Reply-To: <1524592709-6553-17-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 24.04.2018 19:58, Ian Jackson wrote:
> This makes it much easier to find a particular thing in config.log.
> 
> We have to use the ${BASH_LINENO[*]} syntax which is a syntax error in
> other shells, so test what shell we are running and use eval.
> 
> The extra output is only printed if configure is run with bash.  On
> systems where /bin/sh is not bash, it is necessary to say bash
> ./configure to get the extra debug info in the log.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Kent R. Spillner <kspillner@acm.org>
> CC: Janosch Frank <frankja@linux.vnet.ibm.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v8: Fix so that it actually works as intended with bash.
> v6: Fix commit message wording.
> v4: No longer tag this patch RFC.
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configure b/configure
> index aa35aef..f9ba9ea 100755
> --- a/configure
> +++ b/configure
> @@ -60,6 +60,11 @@ do_compiler() {
>      # is compiler binary to execute.
>      local compiler="$1"
>      shift
> +    if test -n "$BASH_VERSION"; then eval '
> +        echo >>config.log "
> +funcs: ${FUNCNAME[*]}
> +lines: ${BASH_LINENO[*]}"
> +    '; fi
>      echo $compiler "$@" >> config.log
>      $compiler "$@" >> config.log 2>&1 || return $?
>      # Test passed. If this is an --enable-werror build, rerun

I just applied the patch and had a look at config.log, and this looks
useful indeed.

Tested-by: Thomas Huth <thuth@redhat.com>
