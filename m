Received: from eggs.gnu.org ([2001:4830:134:3::10]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJWV-0003TJ-Iv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJWP-0005Dn-78
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:25:52 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJWO-0005D0-Vz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:25:49 -0400
Received: by mail-wr0-x230.google.com with SMTP id c11so37994572wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:25:48 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-13-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-13-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:25:45 +0100
Message-ID: <87fue18yo6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/22] translate-all: report correct avg
 host TB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Since commit 6e3b2bfd6 ("tcg: allocate TB structs before the
> corresponding translated code") we are not fully utilizing
> code_gen_buffer for translated code, and therefore are
> incorrectly reporting the amount of translated code as well as
> the average host TB size. Address this by:
>
> - Making the conscious choice of misreporting the total translated code;
>   doing otherwise would mislead users into thinking "-tb-size" is not
>   honoured.
>
> - Expanding tb_tree_stats to accurately count the bytes of translated code on
>   the host, and using this for reporting the average tb host size,
>   as well as the expansion ratio.
>
> In the future we might want to consider reporting the accurate numbers for
> the total translated code, together with a "bookkeeping/overhead" field to
> account for the TB structs.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index aa3a08b..aa71292 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -898,9 +898,20 @@ static void page_flush_tb(void)
>      }
>  }
>
> +static __attribute__((unused))
> +gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
> +{
> +    const TranslationBlock *tb = value;
> +    size_t *size = data;
> +
> +    *size += tb->tc_size;
> +    return false;
> +}
> +

I think having the __attribute__ stuff is confusing. Why don't we just
do what the newer debug stuff does:

modified   accel/tcg/translate-all.c
@@ -66,6 +66,12 @@
 /* make various TB consistency checks */
 /* #define DEBUG_TB_CHECK */

+#if defined(DEBUG_TB_FLUSH)
+#define DEBUG_TB_FLUSH_GATE 1
+#else
+#define DEBUG_TB_FLUSH_GATE 0
+#endif
+
 #if !defined(CONFIG_USER_ONLY)
 /* TB consistency checks only implemented for usermode emulation.  */
 #undef DEBUG_TB_CHECK
@@ -948,8 +954,7 @@ static void page_flush_tb(void)
     }
 }

-static __attribute__((unused))
-gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
+static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 {
     const TranslationBlock *tb = value;
     size_t *size = data;
@@ -958,11 +963,22 @@ gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
     return false;
 }

+static void dump_tb_sizes(void)
+{
+    if (DEBUG_TB_FLUSH_GATE) {
+        size_t host_size = 0;
+        int nb_tbs;
+
+        g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
+        nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
+        fprintf(stderr, "qemu: flush code_size=%zu nb_tbs=%d avg_tb_size=%zu\n",
+                tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
+    }
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
-    size_t host_size __attribute__((unused)) = 0;
-    int nb_tbs __attribute__((unused));

     tb_lock();

@@ -973,12 +989,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         goto done;
     }

-#if defined(DEBUG_TB_FLUSH)
-    g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
-    nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
-    fprintf(stderr, "qemu: flush code_size=%zu nb_tbs=%d avg_tb_size=%zu\n",
-           tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
-#endif
+    dump_tb_sizes();


Which will a) ensure all the debug code is compiled even when not
enabled and b) the compiler won't bitch at you when it optimises stuff
away.

Better?

--
Alex Bennée
