Received: from eggs.gnu.org ([2001:4830:134:3::10]:36120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjYYw-0007zF-B9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjYYt-000559-8g
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:47:02 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjYYt-000537-3P
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:46:59 -0500
Received: by mail-pg0-x242.google.com with SMTP id 16so2019486pga.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 13:46:58 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4054a3ea-c278-11c3-9c0a-5ec952ef8598@twiddle.net>
Date: Fri, 3 Mar 2017 08:46:48 +1100
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/11] translate-all: exit
 cpu_restore_state early if translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 03/03/2017 06:53 AM, Alex Bennée wrote:
> The translation code uses cpu_ld*_code which can trigger a tlb_fill
> which if it fails will attempt a fault resolution. This never works
> during translation as the TB being generated hasn't been added yet.
> However with the new locking regime we end up double locking the
> tb_lock(). As the tcg_ctx.cpu is only set during translation we use
> this to short circuit the restore code and return with a fail.

We *should* have retaddr == 0 for this case, which indicates that we should not 
attempt to restore state.  Are you seeing a non-zero value?

Hmm.. Or rather we should not have called cpu_restore_state in the first place. 
  What is the call chain leading to this point?

Is this in fact linux-user, not softmmu, as you imply from tlb_fill?  Because 
handle_cpu_signal will in fact pass a genuine non-zero retaddr for the SIGSEGV 
resulting from a cpu_ld*_code from a non-mapped address.

So... for linux-user I think the qemu_log is unnecessary -- that's just the way 
things are.  For softmmu, I don't know what to think except that we shouldn't 
have gotten here.


r~
