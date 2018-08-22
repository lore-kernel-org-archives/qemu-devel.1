Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fsV9e-0002kx-OV
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fsV9c-0000aC-Ux
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:34:42 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
	<20180822144039.5796-3-pavel.zbitskiy@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7bfde681-ebd9-a13e-3935-95c65d4fae24@twiddle.net>
Date: Wed, 22 Aug 2018 08:34:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180822144039.5796-3-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] target/s390x: exception on
 non-aligned LPSW(E)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Alexander Graf <agraf@suse.de>

On 08/22/2018 07:40 AM, Pavel Zbitskiy wrote:
> @@ -2828,9 +2828,13 @@ static DisasJumpType op_lpp(DisasContext *s, DisasOps *o)
>  
>  static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
>  {
> +    TCGv_i32 t0;
>      TCGv_i64 t1, t2;
>  
>      check_privileged(s);
> +    t0 = tcg_const_i32(8);
> +    gen_helper_check_alignment(cpu_env, o->in2, t0);
> +    tcg_temp_free_i32(t0);
>      per_breaking_event(s);

This can be done without an external call.

-    tcg_gen_qemu_ld32u(t1, o->in2, get_mem_index(s));
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s),
+                        MO_TEUL | MO_ALIGN_8);

(Which, for annoying reasons, will only have effect in
system mode, but that's true of many other alignment
checks as well.)


r~
