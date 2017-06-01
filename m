Received: from eggs.gnu.org ([2001:4830:134:3::10]:40137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGLdA-0005JA-0S
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGLd6-0006J3-VA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dGLd6-0006Hg-N3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:38:52 -0400
References: <20170531220129.27724-1-aurelien@aurel32.net>
	<20170531220129.27724-31-aurelien@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ea25b082-923d-6c7d-bca3-b4adbd412419@redhat.com>
Date: Thu, 1 Jun 2017 10:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170531220129.27724-31-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 30/30] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 01.06.2017 00:01, Aurelien Jarno wrote:
> At the same time fix the TCG version of get_max_cpu_model to return the
> maximum model like on KVM. Remove the ETF2 and long-displacement

I don't understand the part
"fix the TCG version of get_max_cpu_model to return the maximum model
like on KVM".

Can you elaborate?

> facilities from the additional features as it is included in the z800.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/cpu_models.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index fc3cb25cc3..c13bbd852c 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -668,8 +668,6 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>      static const int feats[] = {
>          S390_FEAT_STFLE,
>          S390_FEAT_EXTENDED_IMMEDIATE,
> -        S390_FEAT_EXTENDED_TRANSLATION_2,
> -        S390_FEAT_LONG_DISPLACEMENT,
>          S390_FEAT_LONG_DISPLACEMENT_FAST,
>          S390_FEAT_ETF2_ENH,
>          S390_FEAT_STORE_CLOCK_FAST,
> @@ -696,9 +694,9 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>      if (kvm_enabled()) {
>          kvm_s390_get_host_cpu_model(&max_model, errp);
>      } else {
> -        /* TCG emulates a z900 (with some optional additional features) */
> -        max_model.def = &s390_cpu_defs[0];
> -        bitmap_copy(max_model.features, max_model.def->default_feat,
> +        /* TCG emulates a z800 (with some optional additional features) */
> +        max_model.def = s390_find_cpu_def(0x2066, 7, 3, NULL);
> +        bitmap_copy(max_model.features, max_model.def->full_feat,
>                      S390_FEAT_MAX);
>          add_qemu_cpu_model_features(max_model.features);
>      }
> @@ -956,8 +954,9 @@ static void s390_qemu_cpu_model_initfn(Object *obj)
>      S390CPU *cpu = S390_CPU(obj);
>  
>      cpu->model = g_malloc0(sizeof(*cpu->model));
> -    /* TCG emulates a z900 (with some optional additional features) */
> -    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
> +    /* TCG emulates a z800 (with some optional additional features) */
> +    memcpy(&s390_qemu_cpu_defs, s390_find_cpu_def(0x2066, 7, 3, NULL),
> +           sizeof(s390_qemu_cpu_defs));

No changing the qemu model without compatibility handling.

Thanks!

-- 

Thanks,

David
