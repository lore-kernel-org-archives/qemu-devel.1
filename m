Received: from eggs.gnu.org ([2001:4830:134:3::10]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkPZW-00057T-93
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkPZS-0000Z7-BO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:55:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkPZR-0000YM-W8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:55:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7N6rsBs116774
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 02:55:20 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ch43ptpyg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 02:55:20 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 23 Aug 2017 07:55:18 +0100
References: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 23 Aug 2017 08:55:14 +0200
MIME-Version: 1.0
In-Reply-To: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7758389d-91cd-6408-485d-19af6153dc65@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Dan Horak <dhorak@redhat.com>



On 08/23/2017 08:53 AM, Christian Borntraeger wrote:
> KVM guests on s390 need a different page table layout than normal
> processes (2kb page table + 2kb page status extensions vs 2kb page table
> only). As of today this has to be enabled via the vm.allocate_pgste
> sysctl.
> 
> Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
> and enable the pgste page table extensions in that case. This makes the
> vm.allocate_pgste sysctl unnecessary. We enable this program header for
> the s390 system emulation (qemu-system-s390x) if we build on s390
> - for s390 system emulation
> - the linker supports --s390-pgste (binutils >= 2.29)
> - KVM is enabled
> 
> This will allow distributions to disable the global vm.allocate_pgste
> sysctl, which will improve the page table allocation for non KVM
> processes as only 2kb chunks are necessary.
> 
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Dan Horak <dhorak@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
> V1->V2:
> 	- provide ld_has function
> 	- use ld_has to replace some open coded variants
> 	- check target arch and arch for s390
> 	- check for s390x before calling the linker
> 
>  configure | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index dd73cce..0b68b37 100755
> --- a/configure
> +++ b/configure
> @@ -240,6 +240,11 @@ supported_target() {
>      return 1
>  }
> 
> +
> +ld_has() {
> +    $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
> +}
> +
>  # default parameters
>  source_path=$(dirname "$0")
>  cpu=""
> @@ -5043,7 +5048,7 @@ fi
>  # Use ASLR, no-SEH and DEP if available
>  if test "$mingw32" = "yes" ; then
>      for flag in --dynamicbase --no-seh --nxcompat; do
> -        if $ld --help 2>/dev/null | grep ".$flag" >/dev/null 2>/dev/null ; then
> +        if ld_had $flag ; then

	typo, will fix with v3 :-/


>              LDFLAGS="-Wl,$flag $LDFLAGS"
>          fi
>      done
> @@ -6522,6 +6527,20 @@ if test "$target_linux_user" = "yes" -o "$target_bsd_user" = "yes" ; then
>    ldflags="$ldflags $textseg_ldflags"
>  fi
> 
> +# Newer kernels on s390 check for an S390_PGSTE program header and
> +# enable the pgste page table extensions in that case. This makes
> +# the vm.allocate_pgste sysctl unnecessary. We enable this program
> +# header if
> +#  - we build on s390x
> +#  - we build the system emulation for s390x (qemu-system-s390x)
> +#  - KVM is enabled
> +#  - the linker support --s390-pgste
> +if test "$TARGET_ARCH" = "s390x" -a "$target_softmmu" = "yes"  -a "$ARCH" = "s390x" -a "$kvm" = "yes"; then
> +    if ld_has --s390-pgste ; then
> +        ldflags="-Wl,--s390-pgste $ldflags"
> +    fi
> +fi
> +
>  echo "LDFLAGS+=$ldflags" >> $config_target_mak
>  echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
> 
