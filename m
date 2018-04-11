Received: from eggs.gnu.org ([2001:4830:134:3::10]:45717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f653O-0007S2-DI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f653N-0006I8-2t
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:00:06 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1f653M-0006Hi-Tr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:00:05 -0400
Received: by mail-ot0-x230.google.com with SMTP id v64-v6so271950otb.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 19:00:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410211534.26079-1-ehabkost@redhat.com>
References: <20180410211534.26079-1-ehabkost@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 11 Apr 2018 10:00:03 +0800
Message-ID: <CANRm+CwTCHCz5y-UW+0-C0_WeamyzrrQ8F69Amfa-G5tNrAA0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] i386: Don't automatically enable
 FEAT_KVM_HINTS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

2018-04-11 5:15 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> The assumption in the cpu->max_features code is that anything
> enabled on GET_SUPPORTED_CPUID should be enabled on "-cpu host".
> This shouldn't be the case for FEAT_KVM_HINTS.
>
> This adds a new FeatureWordInfo::no_autoenable_flags field, that
> can be used to prevent FEAT_KVM_HINTS bits to be enabled
> automatically.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks for the patch, Eduardo!
Tested-by: Wanpeng Li <wanpengli@tencent.com>

Regards,
Wanpeng Li

> ---
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1a6b082b6f..a20fe26573 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -295,6 +295,8 @@ typedef struct FeatureWordInfo {
>      uint32_t tcg_features; /* Feature flags supported by TCG */
>      uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
>      uint32_t migratable_flags; /* Feature flags known to be migratable */
> +    /* Features that shouldn't be auto-enabled by "-cpu host" */
> +    uint32_t no_autoenable_flags;
>  } FeatureWordInfo;
>
>  static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> @@ -400,6 +402,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_KVM_FEATURES,
> +        /*
> +         * KVM hints aren't auto-enabled by -cpu host, they need to be
> +         * explicitly enabled in the command-line.
> +         */
> +        .no_autoenable_flags = ~0U,
>      },
>      [FEAT_HYPERV_EAX] = {
>          .feat_names = {
> @@ -4062,7 +4069,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               */
>              env->features[w] |=
>                  x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> -                ~env->user_features[w];
> +                ~env->user_features[w] & \
> +                ~feature_word_info[w].no_autoenable_flags;
>          }
>      }
>
> --
> 2.14.3
>
