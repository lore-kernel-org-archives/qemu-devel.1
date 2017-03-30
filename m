Received: from eggs.gnu.org ([2001:4830:134:3::10]:40386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctbeG-0003kz-LF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ctbeD-0000LV-H0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:06:04 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ctbeD-0000LC-BD
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:06:01 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k6so58906214wre.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:06:01 -0700 (PDT)
References: <20170330164657.50c75e8c@nial.brq.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170330164657.50c75e8c@nial.brq.redhat.com>
Date: Thu, 30 Mar 2017 16:05:58 +0100
Message-ID: <87k2764xex.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-2.9 crashes in tcg_handle_interrupt() during
 winx64 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, KONRAD Frederic <fred.konrad@greensocs.com>, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


Igor Mammedov <imammedo@redhat.com> writes:

> (PS: resend due to wrong qemu-devel mail list address in original
> email)

Le *sigh* another way of x86 generating IRQs ;-)

Could you test this please?

target/i386/misc_helper: wrap BQL around another IRQ generator

Anything that calls into HW emulation must be protected by the BQL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

1 file changed, 2 insertions(+)
target/i386/misc_helper.c | 2 ++

modified   target/i386/misc_helper.c
@@ -156,7 +156,9 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
         break;
     case 8:
         if (!(env->hflags2 & HF2_VINTR_MASK)) {
+            qemu_mutex_lock_iothread();
             cpu_set_apic_tpr(x86_env_get_cpu(env)->apic_state, t0);
+            qemu_mutex_unlock_iothread();
         }
         env->v_tpr = t0 & 0x0f;
         break;
--
Alex Bennée
