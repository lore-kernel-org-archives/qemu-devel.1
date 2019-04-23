Received: from eggs.gnu.org ([209.51.188.92]:59872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0oU-0000ID-00
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0cb-0003zD-Q5
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0cb-0003y9-He
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:58:25 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-18-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0d4f60b4-84b7-6d36-b8d6-8107675200ff@redhat.com>
Date: Tue, 23 Apr 2019 20:58:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/38] tcg: Add gvec expanders for vector
 shift by scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 20.04.19 09:34, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.h |   7 ++
>  tcg/tcg-op.h      |   4 +
>  tcg/tcg-op-gvec.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c  |  54 ++++++++++++
>  4 files changed, 275 insertions(+)
> 
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index a0e0902f6c..f9c6058e92 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -318,6 +318,13 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
>  void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz);
>  
> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);

I assume all irrelevant bits of the shift have to be masked off by the
caller, right?

On s390x, I would use it for (one variant of) VECTOR ELEMENT SHIFT like
this:


+static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    const uint8_t d2 = get_field(s->fields, d2) &
+                       (NUM_VEC_ELEMENT_BITS(es) - 1);
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v3 = get_field(s->fields, v3);
+    TCGv_i32 shift;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    shift = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(shift, o->addr1);
+    tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
+
+    switch (s->fields->op2) {
+    case 0x30:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(shli, es, v1, v3, d2);
+        } else {
+            gen_gvec_fn_2s(shls, es, v1, v3, shift);
+        }
+        break;
+    case 0x3a:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(sari, es, v1, v3, d2);
+        } else {
+            gen_gvec_fn_2s(sars, es, v1, v3, shift);
+        }
+        break;
+    case 0x38:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(shri, es, v1, v3, d2);
+        } else {
+            gen_gvec_fn_2s(shrs, es, v1, v3, shift);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_temp_free_i32(shift);
+    return DISAS_NEXT;
+}

Does it still make sense to special-case the const immediate case?

-- 

Thanks,

David / dhildenb
