Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TDI-0003hk-Fy
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TDC-00010j-Vf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:02:52 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:52215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TDC-00010c-Qa
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:02:46 -0400
Received: by mail-qt0-x236.google.com with SMTP id q4so31565210qtq.8
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:02:46 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-27-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab1c14fe-95c3-0954-ec16-3ff43c2037f5@linaro.org>
Date: Fri, 6 Oct 2017 10:02:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-27-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 26/30] s390x/tcg: switch to new SIGP
 handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/28/2017 04:37 PM, David Hildenbrand wrote:
>  static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
>  {
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
>      check_privileged(s);
> -    potential_page_fault(s);
> -    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, o->in1);
> +    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
>      set_cc_static(s);
>      tcg_temp_free_i32(r1);
> +    tcg_temp_free_i32(r3);
>      return NO_EXIT;
>  }

You want to change insn-data.def as well.

-    C(0xae00, SIGP,    RS_a,  Z,   r3_o, a2, 0, 0, sigp, 0)
+    C(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
