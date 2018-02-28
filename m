Received: from eggs.gnu.org ([2001:4830:134:3::10]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0pp-0008Gl-Ro
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0po-00079Z-Tx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:27:49 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:40957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1er0po-00079C-OO
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:27:48 -0500
Received: by mail-ot0-x232.google.com with SMTP id l12so2029398otj.7
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 04:27:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519815685-29200-5-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-5-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2018 12:27:27 +0000
Message-ID: <CAFEAcA-Q+_87n3-s5TnJK=90FJFL=MAA_3VDN4OQxBEvxbFOkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] target/arm: Add
 arm_gdb_set_sysreg() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 28 February 2018 at 11:01, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> This is a callback to set the cp-regs registered by the dynamic XML.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>>> Some of our customers need to connect to Qemu using our tool TRACE32=C2=
=AE
>>> via GDB,
>>> and for some use case they need to have write access to some particular
>>> cpregs.
>>> So, it will be nice to have this capability!
>>> Usually, a user won't modify these registers unless he knows what he is
>>> doing!
>
>> I also still don't really like using write_raw_cp_reg() here --
>> it will bypass some behaviour you want and in some cases will
>> just break the emulation because invariants we assume will
>> hold no longer hold. It would be a lot lot safer to not
>> provide write access at all, only read access.
>
> Adding to that our customers may need this write access, our tool TRACE32=
=C2=AE
> needs this also in some particular cases. For example: temporary disablin=
g MMU
> to do a physical memory access.

By clearing the SCTLR bit? That's a good example of a case that
won't work reliably. If you clear the SCTLR.M bit via raw_write
this will not perform the tlb_flush() that it needs to, which
means that if anything does a memory access via the QEMU TLB
it may get the wrong cached results. If you always clear the
bit, do one gdb memory access then set the bit then it will
probably not run into problems but you're walking on thin ice.

thanks
-- PMM
