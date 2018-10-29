Received: from eggs.gnu.org ([2001:4830:134:3::10]:49462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHFG6-00014s-Ir
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHFG1-0002rc-08
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:39:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHFG0-0002q6-D5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:39:32 -0400
Date: Mon, 29 Oct 2018 17:39:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181029213927.GA19216@flamenco>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-5-cota@braap.org> <87zhuw90eu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhuw90eu.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v4 05/71] cpu: move run_on_cpu to cpus-common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Oct 29, 2018 at 16:34:49 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > We don't pass a pointer to qemu_global_mutex anymore.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> As discussed on IRC I don't fundamentally object to this being in
> cpus-common given we have the other work queue stuff there. However
> given it now lives there we should assert we are in system emulation
> mode so if a user-mode instruction attempts to use one of the
> _run_on_cpu() functions we break.

Thanks for looking into this. I fixed up the commit to add stubs for
cpu_lock/unlock, since the former cpu->work_mutex has to keep working.

I'm not convinced about adding an "assert(!user-mode)" to run_on_cpu.
Given that now it does not depend on the BQL, it could actually
work in user-mode if called. If we really wanted to make sure
that no user-mode would call it, then a compile-time check
would be better than an assert. But again, I fail to see what
we'd gain from that.

For context, do_run_on_cpu et al. were moved to cpus-common.c by
d148d90ee8 ("cpus-common: move CPU work item management to
common code", 2016-09-27). The point was to consolidate the
run-on-cpu code in a common (softmmu & user-mode) file, since
user-mode needed async_run_on_cpu for exclusive work.

Now we can finally make run_on_cpu generic as well.

Thanks,

		Emilio
