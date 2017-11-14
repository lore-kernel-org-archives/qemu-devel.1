Received: from eggs.gnu.org ([2001:4830:134:3::10]:36875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbPk-0005Mm-C1
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbPe-0002VE-J9
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:38:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbPe-0002Uc-Cs
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:38:02 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081812.27640.26372.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53ee2a7c-b305-c2c4-93a0-3441726194fb@redhat.com>
Date: Tue, 14 Nov 2017 14:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081812.27640.26372.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/26] cpu-exec: don't overwrite
 exception_index
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

On 14/11/2017 09:18, Pavel Dovgalyuk wrote:
> This patch adds a condition before overwriting exception_index fiels.
> It is needed when exception_index is already set to some meaningful value.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  accel/tcg/cpu-exec.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 61297f8..0473055 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -594,7 +594,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
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

Thanks, queued for 2.11.

Paolo
