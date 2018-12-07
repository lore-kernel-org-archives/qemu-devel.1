Received: from eggs.gnu.org ([2001:4830:134:3::10]:55063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVEwJ-0002GO-HH
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVEwG-0003dy-AD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:09:03 -0500
Date: Fri, 7 Dec 2018 13:08:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181207130853.20506345.cohuck@redhat.com>
In-Reply-To: <1544135058-21380-3-git-send-email-walling@linux.ibm.com>
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
	<1544135058-21380-3-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390: cpu feature for diagnose 318
 andlimit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

On Thu,  6 Dec 2018 17:24:17 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> Diagnose 318 is a new z14.2 CPU feature. Since we are able to emulate
> it entirely via KVM, we can add guest support for earlier models. A
> new CPU feature for diagnose 318 (shortened to diag318) will be made
> available to guests starting with the zEC12-full CPU model.
> 
> The z14.2 adds a new read SCP info byte (let's call it byte 134) to
> detect the availability of diag318. Because of this, we have room for
> one less VCPU and thus limit the max VPUs supported in a configuration
> to 247 (down from 248).
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>.
> ---
>  hw/s390x/sclp.c                 | 2 ++
>  include/hw/s390x/sclp.h         | 2 ++
>  target/s390x/cpu.h              | 2 +-
>  target/s390x/cpu_features.c     | 3 +++
>  target/s390x/cpu_features.h     | 1 +
>  target/s390x/cpu_features_def.h | 3 +++
>  target/s390x/gen-features.c     | 1 +
>  target/s390x/kvm.c              | 1 +
>  8 files changed, 14 insertions(+), 1 deletion(-)
> 

> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 8c2320e..594b4a4 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -52,7 +52,7 @@
>  
>  #define MMU_USER_IDX 0
>  
> -#define S390_MAX_CPUS 248
> +#define S390_MAX_CPUS 247

Isn't that already problematic if you try to migrate from an older QEMU
with all possible vcpus defined? IOW, don't you really need a way that
older machines can still run with one more vcpu?

>  
>  typedef struct PSW {
>      uint64_t mask;
