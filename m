Received: from eggs.gnu.org ([2001:4830:134:3::10]:54333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eGtIj-0007ls-Pd
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eGtIf-0002p1-HV
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:08:21 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eGtIf-0002oh-B9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:08:17 -0500
Received: by mail-wm0-x244.google.com with SMTP id v186so21360295wma.2
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:08:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
	<CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <619db202-f919-c8e9-c881-ff08373f287d@redhat.com>
Date: Mon, 20 Nov 2017 22:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 20/11/2017 13:50, Peter Maydell wrote:
> More generally, this commit seems to assume that QEMU always
> does:
>  * set exception_index to something
>  * handle that
>  * clear exception_index to -1
> 
> but it's not clear to me that it's actually always the case
> that it gets cleared back to -1.

After returning from cpu_handle_interrupt, cpu_exec goes to
cpu_handle_exception which does

    if (cpu->exception_index >= EXCP_INTERRUPT) {
        *ret = cpu->exception_index;
        if (*ret == EXCP_DEBUG) {
            cpu_handle_debug_exception(cpu);
        }
        cpu->exception_index = -1;
        return true;
    } else {
        CPUClass *cc = CPU_GET_CLASS(cpu);
        qemu_mutex_lock_iothread();
        cc->do_interrupt(cpu);
        qemu_mutex_unlock_iothread();
        cpu->exception_index = -1;
    }

    return false;

Does ARM have a case where cc->do_interrupt can longjmp back to the
beginning of cpu_handle_exception?  But I still do not understand why
you don't eventually clear exception_index to -1.  Maybe there should be
an assertion for that before and after cpu_handle_interrupt.

Thanks,

Paolo
