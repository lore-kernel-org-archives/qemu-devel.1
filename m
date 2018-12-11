Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWWVP-0001kc-Nr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWWVH-0004cu-D1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gWWVG-0004cC-Qc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:27 -0500
Date: Mon, 10 Dec 2018 20:06:23 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181211010623.GA25029@flamenco>
References: <20181207155911.12710-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207155911.12710-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, patches@linaro.org

On Fri, Dec 07, 2018 at 15:59:11 +0000, Peter Maydell wrote:
> We use cpu_stop_current() to ensure the current CPU has stopped
> from places like qemu_system_reset_request(). Unfortunately its
> current implementation has a race. It calls qemu_cpu_stop(),
> which sets cpu->stopped to true even though the CPU hasn't
> actually stopped yet. The main thread will look at the flags
> set by qemu_system_reset_request() and call pause_all_vcpus().
> pause_all_vcpus() waits for every cpu to have cpu->stopped true,
> so it can continue (and we will start the system reset operation)
> before the vcpu thread has got back to its top level loop.
> 
> Instead, just set cpu->stop and call cpu_exit(). This will
> cause the vcpu to exit back to the top level loop, and there
> (as part of the wait_io_event code) it will call qemu_cpu_stop().
> 
> This fixes bugs where the reset request appeared to be ignored
> or the CPU misbehaved because the reset operation started
> to change vcpu state while the vcpu thread was still using it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		E.
