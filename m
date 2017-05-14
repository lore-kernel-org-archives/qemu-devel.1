Received: from eggs.gnu.org ([2001:4830:134:3::10]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dA0oe-0001Yz-Pg
	for qemu-devel@nongnu.org; Sun, 14 May 2017 17:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dA0oe-0002nU-3m
	for qemu-devel@nongnu.org; Sun, 14 May 2017 17:12:36 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dA0od-0002m9-Sb
	for qemu-devel@nongnu.org; Sun, 14 May 2017 17:12:36 -0400
Received: by mail-pf0-x244.google.com with SMTP id f27so2964798pfe.0
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 14:12:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170513155816.17294-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a4f70b68-ec18-4237-79fa-b106bc3e29d0@twiddle.net>
Date: Sun, 14 May 2017 14:12:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170513155816.17294-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: 'nop' instruction with 'lock'
 prefix is illegal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 05/13/2017 08:58 AM, Pranith Kumar wrote:
> The instruction "lock nopl (%rax)" should raise an exception. However,
> we don't do that since we do not check for lock prefix for nop
> instructions. The following patch adds this check and makes the
> behavior similar to hardware.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>   target/i386/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 1d1372fb43..76f4ccd3b4 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -7881,6 +7881,9 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
>           gen_nop_modrm(env, s, modrm);
>           break;
>       case 0x119: case 0x11c ... 0x11f: /* nop (multi byte) */
> +        if (prefixes & PREFIX_LOCK) {
> +            goto illegal_op;
> +        }
>           modrm = cpu_ldub_code(env, s->pc++);
>           gen_nop_modrm(env, s, modrm);
>           break;
> 
Surely you'd also want to make this change for 0x11a and 0x11b.  Which would 
also simplify that code a bit.

That said, there's *lots* of missing LOCK prefix checks.  What brings this one 
in particular to your attention?


r~
