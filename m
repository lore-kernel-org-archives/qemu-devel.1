Received: from eggs.gnu.org ([2001:4830:134:3::10]:55494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZKVq-0005nR-7y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZKVm-0000pG-7w
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:50:06 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZKVl-0000ow-W5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:50:02 -0500
Received: by mail-pg0-x235.google.com with SMTP id z20so9118469pgv.6
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 09:50:01 -0800 (PST)
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
Date: Wed, 10 Jan 2018 09:49:57 -0800
MIME-Version: 1.0
In-Reply-To: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com

On 01/10/2018 05:48 AM, Pavel Dovgalyuk wrote:
> Flushing TB cache is required because TBs key in the cache may match
> different code which existed in the previous state.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> ---
>  exec.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index 4722e52..ff31e71 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>         version_id is increased. */
>      cpu->interrupt_request &= ~0x01;
>      tlb_flush(cpu);
> +    tb_flush(cpu);

I'm not necessarily objecting, but what do you mean by "may match different code"?

What this patch suggests is that the inputs to the computation of TB->FLAGS are
different for some unspecified reason.  Without further explanation, to me this
suggests a bug in vmstate save/restore.

What is the observed problem here?


r~
