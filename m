Received: from eggs.gnu.org ([2001:4830:134:3::10]:58552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSW7-0005zI-VN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSW4-0003lx-4H
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecSW3-0003l3-UP
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:59:16 -0500
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084417.7100.69568.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aca12788-c119-3046-ee8f-e7b3d4cc59bb@redhat.com>
Date: Fri, 19 Jan 2018 09:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180119084417.7100.69568.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 13/23] cpus: only take BQL for
 sleeping threads
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

On 19/01/2018 09:44, Pavel Dovgalyuk wrote:
>      while (all_cpu_threads_idle()) {
> +        qemu_mutex_lock_iothread();
>          stop_tcg_kick_timer();
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> +        qemu_mutex_unlock_iothread();
>      }

cpu_has_work cannot be called outside BQL yet.  You first need to access
cpu->interrupt_request with atomics.

In general, testing the condition outside the mutex is a very dangerous
pattern (and I'm usually the one who enjoys dangerous patterns).

But also, taking a slightly wider look:

>  static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
>  {
>      while (all_cpu_threads_idle()) {
> +        qemu_mutex_lock_iothread();
>          stop_tcg_kick_timer();
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> +        qemu_mutex_unlock_iothread();
>      }
>  
>      start_tcg_kick_timer();
>  
>      qemu_wait_io_event_common(cpu);
> -
> -    qemu_mutex_unlock_iothread();
>  }
>  

You are adding a qemu_mutex_lock_iothread to a function that wasn't
there before.  Either it was broken before, or it is now.

Paolo
