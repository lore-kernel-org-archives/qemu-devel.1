Received: from eggs.gnu.org ([2001:4830:134:3::10]:43869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFRBK-0004h3-El
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFRBG-0006SW-Hq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:54:42 -0500
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <42cf0d57-96fe-8ec7-2952-543749495a1d@redhat.com>
Date: Thu, 16 Nov 2017 21:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171116170526.12643-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.11 3/3] s390x/tcg:
 fix DIAG 308 with > 1 VCPU (MTTCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 16.11.2017 18:05, David Hildenbrand wrote:
> Currently, multi threaded TCG with > 1 VCPU gets stuck during IPL, when
> the bios tries to switch to the loaded kernel via DIAG 308.
> 
> As run_on_cpu() is used, we run into a deadlock after handling the reset.
> We need the iolock (just like KVM).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 4afd90b969..d272851e1c 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -103,7 +103,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>          break;
>      case 0x308:
>          /* ipl */
> +        qemu_mutex_lock_iothread();
>          handle_diag_308(env, r1, r3);
> +        qemu_mutex_unlock_iothread();
>          r = 0;
>          break;
>      case 0x288:
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
