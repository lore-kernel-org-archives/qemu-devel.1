Received: from eggs.gnu.org ([2001:4830:134:3::10]:50798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkAh1-0007t6-B3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkAgv-0007Zx-Jw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dkAgv-0007Zl-BZ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:02:05 -0400
References: <1503413250-18432-1-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c3e49a8a-8dec-51a4-f160-65a89abf9b8e@redhat.com>
Date: Tue, 22 Aug 2017 17:02:01 +0200
MIME-Version: 1.0
In-Reply-To: <1503413250-18432-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Dan Horak <dhorak@redhat.com>

On 22.08.2017 16:47, Christian Borntraeger wrote:
> KVM guests on s390 need a different page table layout than normal
> processes (2kb page table + 2kb page status extensions vs 2kb page table
> only). As of today this has to be enabled via the vm.allocate_pgste
> sysctl.
> 
> Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
> and enable the pgste page table extensions in that case. This makes the
> vm.allocate_pgste sysctl unnecessary. We enable this program header for
> the s390 system emulation (qemu-system-s390x) if
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
>  configure | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/configure b/configure
> index dd73cce..4c9084b 100755
> --- a/configure
> +++ b/configure
> @@ -6522,6 +6522,19 @@ if test "$target_linux_user" = "yes" -o "$target_bsd_user" = "yes" ; then
>    ldflags="$ldflags $textseg_ldflags"
>  fi
>  
> +# Newer kernels on s390 check for an S390_PGSTE program header and
> +# enable the pgste page table extensions in that case. This makes
> +# the vm.allocate_pgste sysctl unnecessary. We enable this program
> +# header if
> +#  - the linker support --s390-pgste
> +#  - we build the system emulation (qemu-system-s390x)
> +#  - KVM is enabled
> +if $ld --help 2>/dev/null | grep ".--s390-pgste" >/dev/null 2>/dev/null ; then

>/dev/null 2>&1
(from has(){} definiton)

maybe even introduce

ld_has() {
    $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
}

I guess it also makes sense to test for s390x first, before checking for
ld support.

> +    if test "$target_softmmu" = "yes"  -a "$ARCH" = "s390x" -a "$kvm" = "yes" ; then
> +        ldflags="-Wl,--s390-pgste $ldflags"
> +    fi
> +fi
> +
>  echo "LDFLAGS+=$ldflags" >> $config_target_mak
>  echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
>  
> 

Happy to see this change :)

-- 

Thanks,

David
