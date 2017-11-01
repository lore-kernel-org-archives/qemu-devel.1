Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yYk-0008VM-3B
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yYe-0003UB-SW
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:20:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yYe-0003Td-Ix
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:20:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1JIQKQ097586
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:20:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dyh3h2nn6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:20:07 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:20:06 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
References: <20171101191030.16136-1-danielhb@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 17:20:00 -0200
MIME-Version: 1.0
In-Reply-To: <20171101191030.16136-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <e018cff0-933d-d9ef-83a1-ea2a81c459a2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: adding ppc64le to supported
 host CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com

Ops, sorry about that. Resending ....

On 11/01/2017 05:10 PM, Daniel Henrique Barboza wrote:
> When executing 'configure' in a fresh QEMU clone, in a fresh
> OS install running in a ppc64le host, this is the error
> shown:
>
> -----
>
> ../configure --enable-trace-backend=simple --enable-debug
>      --target-list=ppc64-softmmu
>
> ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter
>
> -----
>
> This isn't true, ppc64le host CPU is supported. This happens because,
> in a fresh install, we don't have a C compiler to autodetect
> the $cpu variable to "ppc64".
>
> Since we need a C compiler to properly get the value of $cpu
> in this and other cases, this patch changes the location of the C
> compiler check right after setting the preferred CC.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>   configure | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/configure b/configure
> index 285d123dbf..5a4e0f0468 100755
> --- a/configure
> +++ b/configure
> @@ -467,6 +467,17 @@ else
>     cc="${CC-${cross_prefix}gcc}"
>   fi
>
> +# check that the C compiler works.
> +write_c_skeleton;
> +if compile_object ; then
> +  : C compiler works ok
> +else
> +    error_exit "\"$cc\" either does not exist or does not work"
> +fi
> +if ! compile_prog ; then
> +    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
> +fi
> +
>   if test -z "${CXX}${cross_prefix}"; then
>     cxx="c++"
>   else
> @@ -1593,17 +1604,6 @@ if test -z "$werror" ; then
>       fi
>   fi
>
> -# check that the C compiler works.
> -write_c_skeleton;
> -if compile_object ; then
> -  : C compiler works ok
> -else
> -    error_exit "\"$cc\" either does not exist or does not work"
> -fi
> -if ! compile_prog ; then
> -    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
> -fi
> -
>   if test "$bogus_os" = "yes"; then
>       # Now that we know that we're not printing the help and that
>       # the compiler works (so the results of the check_defines we used
