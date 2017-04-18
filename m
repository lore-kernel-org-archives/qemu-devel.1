Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U5Q-0008GM-N6
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U5M-0003id-Fi
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:26:32 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:36075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0U5M-0003iI-9g
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:26:28 -0400
Received: by mail-pf0-x234.google.com with SMTP id 194so42520711pfv.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:26:28 -0700 (PDT)
Date: Tue, 18 Apr 2017 23:26:24 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170418142624.GC2599@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<b1be5af9a1d304f55847efeab706e88e3b9b1afa.1492384862.git.shorne@gmail.com>
	<5447c3cd-4b64-3b71-fd77-33a29f225104@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5447c3cd-4b64-3b71-fd77-33a29f225104@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 4/7] target/openrisc: implement shadow
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 01:11:53AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > Shadow registers are part of the openrisc spec along with sr[cid], as
> > part of the fast context switching feature.  When exceptions occur,
> > instead of having to save registers to the stack if enabled the CID will
> > increment and a new set of registers will be available.
> > 
> > This patch only implements shadow registers which can be used as extra
> > scratch registers via the mfspr and mtspr if required.  This is
> > implemented in a way where it would be easy to add on the fast context
> > switching, currently cid is hardcoded to 0.
> 
> I'm not especially keen on this half-conversion.
> If CID cannot be changed, then
> 
> > -    target_ulong gpr[32];     /* General registers */
> > +    target_ulong shadow_gpr[16][32]; /* Shadow registers */
> > +    target_ulong * gpr;       /* General registers (backed by shadow) */
> 
> this pointer should not be necessary.  Just use a union, or even just
> 
>     target_ulong gpr[32];
>     target_ulong shadow_gpr[15][32];
> 
> for now.
> 
> Alternately, add accessor functions that take the whole ENV (which would be
> able to read CID, when needed).  C.f.
> 
>     uint64_t cpu_alpha_load_gr(CPUAlphaState *env, unsigned reg);
>     void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);

Actually, I started off writing it this way, but there were a lot of places
that used env->gpr.  I had some regex's to replace everything, but in the
end I thought using the gpr pointer was just easier.

Using the union would work as well, but it wouldnt help to allow switching
of cid.  My idea with the pointer was that if cid was updates I could
update the pointer at that time.

Ill rework this to use the accessor functions.

-Stafford

> If/when CID can be changed, then we can talk about various ways
> that this can be modeled within TCG.
> 
> 
> r~
