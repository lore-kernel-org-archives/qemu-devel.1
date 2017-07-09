Received: from eggs.gnu.org ([2001:4830:134:3::10]:56428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU7Lo-0002wA-Ng
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 04:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU7Ll-0008M3-Hl
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 04:13:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU7Ll-0008LX-9u
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 04:13:53 -0400
Date: Sun, 9 Jul 2017 04:13:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709081351.GA24967@flamenco>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-10-git-send-email-pbonzini@redhat.com>
	<20170706202652.GA18201@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706202652.GA18201@flamenco>
Subject: Re: [Qemu-devel] [PATCH 09/22] monitor: disable "info jit" and
 "info opcount" if !TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: yang.zhong@intel.com, thuth@redhat.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, rth@twiddle.net

On Thu, Jul 06, 2017 at 16:26:52 -0400, Emilio G. Cota wrote:
> On Tue, Jul 04, 2017 at 13:12:02 +0200, Paolo Bonzini wrote:
> > Reviewed-by: Richard Henderson <rth@twiddle.net>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(snip)
> > +++ b/accel/tcg/translate-all.c
> > @@ -1851,6 +1851,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
> >  
> >      tb_lock();
> >  
> > +    if (!tcg_enabled()) {
> > +        cpu_fprintf(f, "TCG not enabled\n");
> > +        return;
> > +    }
> 
> Sorry I missed this before it was merged, but:
> 
> - We're returning with tb_lock held
> - This check is redundant; see b7da97eef ("monitor: Check whether TCG
>   is enabled before running the "info jit" code") which was merged
>   in April (hmp_info_jit is the only caller of dump_exec_info).
> 
> I suggest we get rid of the check, although moving it above tb_lock is
> also OK with me.

Patch here:
  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02072.html

This other patch fixes another issue introduced in this series, please
have a look as well:
  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02058.html

Cheers,

		Emilio
