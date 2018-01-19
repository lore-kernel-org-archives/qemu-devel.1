Received: from eggs.gnu.org ([2001:4830:134:3::10]:55644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSL9-0004R1-Mo
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSL9-0007nU-1s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecSL8-0007m2-Rj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:47:58 -0500
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084242.7100.17598.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4e29219-8fa3-464c-3f62-2efec1cdab5b@redhat.com>
Date: Fri, 19 Jan 2018 09:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180119084242.7100.17598.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 01/23] This patch adds a condition
 before overwriting exception_index fields.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 19/01/2018 09:42, Pavel Dovgalyuk wrote:
> It is needed when exception_index is already set to some meaningful value.
> 

Pavel, very frankly, this commit message is awful, and for two reasons.

First, it should include the high level overview of the bug ("XYZ does
not work") and the description of why XYZ does not work (what is the
meaningful value?  who set it?)

Second, it also resets cpu->exception_index to -1 in after calling
cc->cpu_exec_interrupt.  Why is this correct?  Who was clearing it
before?  Is that clearing still needed?  What does
cc->cpu_exec_interrupt even have to do with cpu->exception_index, since
exceptions are handled by cc->do_interrupt?

And so on.

Paolo

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/cpu-exec.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 280200f..9cc6972 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -585,6 +585,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          else {
>              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
>                  replay_interrupt();
> +                cpu->exception_index = -1;
>                  *last_tb = NULL;
>              }
>              /* The target hook may have updated the 'cpu->interrupt_request';
> @@ -606,7 +607,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      if (unlikely(atomic_read(&cpu->exit_request)
>          || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
>          atomic_set(&cpu->exit_request, 0);
> -        cpu->exception_index = EXCP_INTERRUPT;
> +        if (cpu->exception_index == -1) {
> +            cpu->exception_index = EXCP_INTERRUPT;
> +        }
>          return true;
>      }
>  
> 
