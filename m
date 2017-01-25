Received: from eggs.gnu.org ([2001:4830:134:3::10]:46435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWLA1-0006T4-9G
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWL9w-0008G0-5l
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWL9v-0008Fs-OJ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:50:35 -0500
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071713.4572.36636.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96675d3f-9d53-bde1-f6da-7cb0b1f41316@redhat.com>
Date: Wed, 25 Jan 2017 11:50:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170124071713.4572.36636.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 03/14] replay: exception replay fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> @@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  #ifndef CONFIG_USER_ONLY
>      } else if (replay_has_exception()
>                 && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
> +        /* Break the execution loop in case of running out of TB cache.
> +           This is needed to make flushing of the TB cache, because
> +           real flush is queued to be executed outside the cpu loop. */
> +        cpu->exception_index = EXCP_INTERRUPT;
>          /* try to cause an exception pending in the log */
>          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
>          *ret = -1;

Why is replay_has_exception() related to be running out of TB cache?

Paolo
