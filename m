Received: from eggs.gnu.org ([2001:4830:134:3::10]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUBe4-0000w5-0f
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUBe0-0001Xf-0E
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:25:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUBdx-0001Vp-Su
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:25:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so16167363wra.6
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 06:25:43 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3dafcb3b-ff92-07f7-dc71-04a5e0aa01c4@redhat.com>
Date: Tue, 4 Dec 2018 15:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/arm: Free name string in
 ARMCPRegInfo hashtable entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 4/12/18 14:29, Peter Maydell wrote:
> When we add a new entry to the ARMCPRegInfo hash table in
> add_cpreg_to_hashtable(), we allocate memory for tehe

"for the"?

> ARMCPRegInfo struct itself, and we also g_strdup() the
> name string. So the hashtable's value destructor function
> must free the name string as well as the struct.
> 
> Spotted by clang's leak sanitizer. The leak here is a
> small one-off leak at startup, because we don't support
> CPU hotplug, and so the only time when we destroy
> hash table entries is for the case where ARM_CP_OVERRIDE
> means we register a wildcard entry and then override it later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/cpu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 60411f6bfe0..b84a6c0e678 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -642,6 +642,20 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
>      return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
>  }
>  
> +static void cpreg_hashtable_data_destroy(gpointer data)
> +{
> +    /*
> +     * Destroy function for cpu->cp_regs hashtable data entries.
> +     * We must free the name string because it was g_strdup()ed in
> +     * add_cpreg_to_hashtable(). It's OK to cast away the 'const'
> +     * from r->name because we know we definitely allocated it.
> +     */
> +    ARMCPRegInfo *r = data;
> +
> +    g_free((void *)r->name);
> +    g_free(r);
> +}
> +
>  static void arm_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
> @@ -649,7 +663,7 @@ static void arm_cpu_initfn(Object *obj)
>  
>      cs->env_ptr = &cpu->env;
>      cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
> -                                         g_free, g_free);
> +                                         g_free, cpreg_hashtable_data_destroy);
>  
>      QLIST_INIT(&cpu->pre_el_change_hooks);
>      QLIST_INIT(&cpu->el_change_hooks);
> 
