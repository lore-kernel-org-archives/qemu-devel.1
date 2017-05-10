Received: from eggs.gnu.org ([2001:4830:134:3::10]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Ody-0001ve-IV
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Odv-0000Av-EA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8Odv-0000Ah-4v
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B744C448D84
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 10:14:49 +0000 (UTC)
Date: Wed, 10 May 2017 11:14:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170510101443.GB4230@work-vm>
References: <1494388889-3558-1-git-send-email-peterx@redhat.com>
	<1494388889-3558-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494388889-3558-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/3] utils: provide size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Moving the algorithm from print_type_size() into size_to_str() so that
> other component can also leverage it. With that, refactor
> print_type_size().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu-common.h        |  1 +
>  qapi/string-output-visitor.c | 22 ++++++----------------
>  util/cutils.c                | 23 +++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d218821..d7d0448 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -145,6 +145,7 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
>  int parse_debug_env(const char *name, int max, int initial);
>  
>  const char *qemu_ether_ntoa(const MACAddr *mac);
> +char *size_to_str(double val);
>  void page_size_init(void);
>  
>  /* returns non-zero if dump is in progress, otherwise zero is
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 94ac821..53c2175 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -211,10 +211,8 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
>                              Error **errp)
>  {
>      StringOutputVisitor *sov = to_sov(v);
> -    static const char suffixes[] = { 'B', 'K', 'M', 'G', 'T', 'P', 'E' };
> -    uint64_t div, val;
> -    char *out;
> -    int i;
> +    uint64_t val;
> +    char *out, *psize;
>  
>      if (!sov->human) {
>          out = g_strdup_printf("%"PRIu64, *obj);
> @@ -223,19 +221,11 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
>      }
>  
>      val = *obj;
> -
> -    /* The exponent (returned in i) minus one gives us
> -     * floor(log2(val * 1024 / 1000).  The correction makes us
> -     * switch to the higher power when the integer part is >= 1000.
> -     */
> -    frexp(val / (1000.0 / 1024.0), &i);
> -    i = (i - 1) / 10;
> -    assert(i < ARRAY_SIZE(suffixes));
> -    div = 1ULL << (i * 10);
> -
> -    out = g_strdup_printf("%"PRIu64" (%0.3g %c%s)", val,
> -                          (double)val/div, suffixes[i], i ? "iB" : "");
> +    psize = size_to_str(val);
> +    out = g_strdup_printf("%"PRIu64" (%s)", val, psize);
>      string_output_set(sov, out);
> +
> +    g_free(psize);
>  }
>  
>  static void print_type_bool(Visitor *v, const char *name, bool *obj,
> diff --git a/util/cutils.c b/util/cutils.c
> index 50ad179..c562d87 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -619,3 +619,26 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
>  
>      return ret;
>  }
> +
> +/*
> + * Please free the buffer after use.
> + */
> +char *size_to_str(double val)
> +{
> +    static const char *suffixes[] = { "", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei" };
> +    unsigned long div;
> +    int i;
> +
> +    /*
> +     * The exponent (returned in i) minus one gives us
> +     * floor(log2(val * 1024 / 1000).  The correction makes us
> +     * switch to the higher power when the integer part is >= 1000.
> +     * (see e41b509d68afb1f for more info)
> +     */
> +    frexp(val / (1000.0 / 1024.0), &i);
> +    i = (i - 1) / 10;
> +    assert(i < ARRAY_SIZE(suffixes));
> +    div = 1ULL << (i * 10);
> +
> +    return g_strdup_printf("%0.3g %sB", val / div, suffixes[i]);
> +}

Right, I think I'm happy with that;  Paolo, Markus - make sense to you?

Dave

> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
