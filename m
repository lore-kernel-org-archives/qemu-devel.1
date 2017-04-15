Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czM4O-0002FF-CN
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 07:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czM4N-0005Gl-C8
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 07:40:48 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-6-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <73257eb8-edfd-ae0b-a5fa-b1194de568d8@twiddle.net>
Date: Sat, 15 Apr 2017 04:40:35 -0700
MIME-Version: 1.0
In-Reply-To: <1491959850-30756-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] tcg: add jr opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, Claudio Fontana <claudio.fontana@huawei.com>, Alexander Graf <agraf@suse.de>, alex.bennee@linaro.org, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/11/2017 06:17 PM, Emilio G. Cota wrote:
> This will be used by TCG targets to implement a fast path
> for indirect branches.
>
> I only have implemented and tested this on an i386 host, so
> make this opcode optional and mark it as not implemented by
> other TCG backends.

I don't think this is quite the right abstraction.  In particular, if we can 
always return a valid address from the helper, we can eliminate a conditional 
branch.

I think this should work as follows:

(1) tb_ret_addr gets moved into TCGContext so that it's available for other 
code to see.

(2) Have a generic helper

void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
{
     TranslationBlock *tb = tb_from_jmp_cache(env, addr);
     return tb ? tb->tc_ptr : tcg_ctx.tb_ret_addr;
}

(3) Emit TCG opcodes like

	call t0,lookup_tb_ptr,env,addr
	jmp_tb t0

(4) Emit code for jmp_tb like

	mov	%rax,%rdx	// save target into new register
	xor	%eax,%eax	// set return value a-la exit_tb
	jmp	*%edx		// branch to tb or epilogue.

(5) There needs to be a convenience function in tcg/tcg-op.c.  If the host does 
not support jmp_tb, we should just generate exit_tb like we do now.  There 
should be no ifdefs inside target/*.



r~
