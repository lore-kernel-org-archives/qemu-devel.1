Received: from eggs.gnu.org ([2001:4830:134:3::10]:59370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWKhb-0007oR-0h
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWKhX-0004Ef-RH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:21:19 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWKhX-0004EZ-JE
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:21:15 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so41425728wmi.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 02:21:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1477674916-6795-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1477674916-6795-2-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac1ae748-c69c-e2df-d59f-aa5301674928@redhat.com>
Date: Wed, 25 Jan 2017 11:21:12 +0100
MIME-Version: 1.0
In-Reply-To: <1477674916-6795-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] move vm_start to cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: palves@redhat.com, borntraeger@de.ibm.com



On 28/10/2016 19:15, Claudio Imbrenda wrote:
> * moves the call to qemu_clock_enable away from resume_all_vcpus, and
>   add an explicit call to it before each instance of resume_all_vcpus
>   in the code.

This change adds useless duplication, and isn't matched by a similar
change to pause_all_vcpus.  You need to justify it; I suppose it is
because the next patch will not call resume_all_cpus?

Most of the callers of pause_all_vcpus/resume_all_vcpus don't let timers
run, so the clock need not be disabled and enabled.  Maybe the right
places to call qemu_clock_enable are cpu_disable_ticks and
cpu_enable_ticks?  That should work for you.

In that case, please make the first patch the qemu_clock_enable
movement; the second patch the introduction of vm_prepare_start; the
third patch the gdbstub change.

> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 3728a1e..5fa074b 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -5,6 +5,7 @@
>  bool qemu_in_vcpu_thread(void);
>  void qemu_init_cpu_loop(void);
>  void resume_all_vcpus(void);
> +void resume_some_vcpus(CPUState **cpus);
>  void pause_all_vcpus(void);
>  void cpu_stop_current(void);
>  void cpu_ticks_init(void);

This function doesn't exist.

Paolo
