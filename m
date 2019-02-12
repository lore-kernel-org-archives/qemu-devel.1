Received: from eggs.gnu.org ([209.51.188.92]:53324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtaM1-0000cV-S9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtaM1-0004kA-3A
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:52:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtaM0-0004iZ-Qe
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:52:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so3212536wrx.9
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 07:52:12 -0800 (PST)
References: <20190212153025.25425-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40c87a8e-88d1-7113-1d33-2869234e767e@redhat.com>
Date: Tue, 12 Feb 2019 16:52:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190212153025.25425-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390x/kvm: add tracepoint to ioeventfd
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Hi Cornelia,

On 2/12/19 4:30 PM, Cornelia Huck wrote:
> Trace when assigning/unassigning.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c        | 2 ++
>  target/s390x/trace-events | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 15fdc168e1c5..7d61bd109092 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1886,6 +1886,8 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>          .addr = sch,
>          .len = 8,
>      };
> +    trace_kvm_s390_assign_subch_ioeventfd(kick.fd, kick.addr, assign,
> +                                          kick.datamatch);
>      if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
>          return -ENOSYS;
>      }
> diff --git a/target/s390x/trace-events b/target/s390x/trace-events
> index a84e316e4937..bdc22f42cdbb 100644
> --- a/target/s390x/trace-events
> +++ b/target/s390x/trace-events
> @@ -14,6 +14,7 @@ ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x
>  kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
>  kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
>  kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
> +kvm_s390_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, int datamatch) "fd: %d sch: @0x%x assign: %d vq: %d"

I noticed all s390x related trace events don't specify 's390' in the
event name, maybe you can simply strip it. If you agree, feel free to
apply that change directly yourself, no need for v2 ;)

Regardless the name used:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  # target/s390x/cpu.c
>  cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
> 
