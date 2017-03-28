Received: from eggs.gnu.org ([2001:4830:134:3::10]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1csoPZ-0002QH-JM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1csoPW-0004Su-AZ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1csoPW-0004Rc-1B
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:31:34 -0400
Date: Tue, 28 Mar 2017 12:31:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170328123126.509579f2@Igors-MacBook-Pro.local>
In-Reply-To: <20170327144815.8043-3-ehabkost@redhat.com>
References: <20170327144815.8043-1-ehabkost@redhat.com>
	<20170327144815.8043-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 2/2] i386: Don't override -cpu
 options on -cpu host/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Collin L . Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, "Jason J
	. Herne" <jjherne@linux.vnet.ibm.com>

On Mon, 27 Mar 2017 11:48:15 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The existing code for "host" and "max" CPU models overrides every
> single feature in the CPU object at realize time, even the ones
> that were explicitly enabled or disabled by the user using
> "feat=on" or "feat=off", while features set using +feat/-feat are
> kept.
> 
> This means "-cpu host,+invtsc" works as expected, while
> "-cpu host,invtsc=on" doesn't.
> 
> This was a known bug, already documented in a comment inside
> x86_cpu_expand_features(). What makes this bug worse now is that
> libvirt 3.0.0 and newer now use "feat=on|off" instead of
> +feat/-feat when it detects a QEMU version that supports it (see
> libvirt commit d47db7b16dd5422c7e487c8c8ee5b181a2f9cd66).
> 
> Change the feature property getter/setter to set a
> env->user_features field, to keep track of features that were
> explicitly changed using QOM properties. Then make the
> max_features code not override user features when handling "-cpu
> host" and "-cpu max".
> 
> This will also allow us to remove the plus_features/minus_features
> hack in the future, but I plan to do that after 2.9.0 is
> released.
> 
> Reported-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Changes v1 -> v2:
> * Don't clear existing bits on env->features (they are already
>   supposed to be all zeroes) (Igor)
> * Fix typo on comment (Igor)
> * Moved feature word getter/setter parameter changes to separate
>   patch (Igor)
> ---
>  target/i386/cpu.h |  2 ++
>  target/i386/cpu.c | 13 +++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 07401ad9fe..c4602ca80d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1147,6 +1147,8 @@ typedef struct CPUX86State {
>      uint32_t cpuid_vendor3;
>      uint32_t cpuid_version;
>      FeatureWordArray features;
> +    /* Features that were explicitly enabled/disabled */
> +    FeatureWordArray user_features;
>      uint32_t cpuid_model[12];
>  
>      /* MTRRs */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index feefa5b8a4..13c0985f11 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3373,15 +3373,19 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>      GList *l;
>      Error *local_err = NULL;
>  
> -    /*TODO: cpu->max_features incorrectly overwrites features
> -     * set using "feat=on|off". Once we fix this, we can convert
> +    /*TODO: Now cpu->max_features doesn't overwrite features
> +     * set using QOM properties, and we can convert
>       * plus_features & minus_features to global properties
>       * inside x86_cpu_parse_featurestr() too.
>       */
>      if (cpu->max_features) {
>          for (w = 0; w < FEATURE_WORDS; w++) {
> -            env->features[w] =
> -                x86_cpu_get_supported_feature_word(w, cpu->migratable);
> +            /* Override only features that weren't set explicitly
> +             * by the user.
> +             */
> +            env->features[w] |=
> +                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> +                ~env->user_features[w];
>          }
>      }
>  
> @@ -3731,6 +3735,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
>      } else {
>          cpu->env.features[fp->w] &= ~fp->mask;
>      }
> +    cpu->env.user_features[fp->w] |= fp->mask;
>  }
>  
>  static void x86_cpu_release_bit_prop(Object *obj, const char *name,
