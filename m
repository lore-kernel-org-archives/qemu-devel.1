Received: from eggs.gnu.org ([2001:4830:134:3::10]:46853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgzvS-0007qm-IN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgzvP-0000nV-FA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:23:42 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-3-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7ceb696b-d4b3-86a6-a1db-47e46de7dcb4@twiddle.net>
Date: Fri, 24 Feb 2017 07:23:31 +1100
MIME-Version: 1.0
In-Reply-To: <1487879800-12352-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/15] target/ppc: update ov flag from
 remaining paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
> @@ -320,22 +320,24 @@ target_ulong helper_divo(CPUPPCState *env, target_ulong arg1,
>                           target_ulong arg2)
>  {
>      uint64_t tmp = (uint64_t)arg1 << 32 | env->spr[SPR_MQ];
> +    int ov;
>
>      if (((int32_t)tmp == INT32_MIN && (int32_t)arg2 == (int32_t)-1) ||
>          (int32_t)arg2 == 0) {
> -        env->so = env->ov = 1;
> +        ov = 1;
>          env->spr[SPR_MQ] = 0;
>          return INT32_MIN;
>      } else {
>          env->spr[SPR_MQ] = tmp % arg2;
>          tmp /= (int32_t)arg2;
>          if ((int32_t)tmp != tmp) {
> -            env->so = env->ov = 1;
> +            ov = 1;
>          } else {
> -            env->ov = 0;
> +            ov = 0;
>          }
>          return tmp;
>      }
> +    helper_update_ov_legacy(env, ov);
>  }
>

You're attempting to run the helper after "return".


r~
