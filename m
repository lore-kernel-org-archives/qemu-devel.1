Received: from eggs.gnu.org ([2001:4830:134:3::10]:46018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK3a8-000284-W5
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK3a8-00048P-7g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:47:56 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK3a7-000471-Sc
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:47:56 -0500
Received: by mail-oi1-x244.google.com with SMTP id k19-v6so11057046oic.11
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 07:47:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105153520.18528-1-eric.auger@redhat.com>
References: <20181105153520.18528-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 15:47:34 +0000
Message-ID: <CAFEAcA-9gig3vNVF0QwpCPGCrA_1NOTrd=ALnA924jHJEWa4mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH for-3.1] hw/arm/sysbus-fdt: Only
 call match_fn callback if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>

On 5 November 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
> Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
> compatible value) introduced a match_fn callback which gets called
> for each registered combo to check whether a sysbus device can be
> dynamically instantiated. However the callback gets called even if
> the device type does not match the binding combo typename field.
>
> Let's change the add_fdt_node() logic so that we first check the
> type and if the match_fn callback is defined, then we also call it.
>
> Binding combos only requesting a type check do not define the
> match_fn callback.
>
> Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
> DT compatible value)
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/sysbus-fdt.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 0e24c803a1..a44cf7f255 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -449,7 +449,7 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
>      return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
>  }
>
> -#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
> +#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), NULL}
>
>  /* list of supported dynamic sysbus bindings */
>  static const BindingEntry bindings[] = {
> @@ -481,10 +481,18 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
>      for (i = 0; i < ARRAY_SIZE(bindings); i++) {
>          const BindingEntry *iter = &bindings[i];
>
> -        if (iter->match_fn(sbdev, iter)) {
> -            ret = iter->add_fn(sbdev, opaque);
> -            assert(!ret);
> -            return;
> +        if (type_match(sbdev, iter)) {
> +            if (iter->match_fn) {
> +                if (iter->match_fn(sbdev, iter)) {

"if (!iter->match_fn || iter->match_fn(sbdev, iter)) {"

would let you avoid duplicating the code in the body
of this if and the else clause later.

(Or you could have a match_always() function that always
returns true instead of having to special case NULL.)

> +                    ret = iter->add_fn(sbdev, opaque);
> +                    assert(!ret);
> +                    return;
> +                }
> +            } else {
> +                ret = iter->add_fn(sbdev, opaque);
> +                assert(!ret);
> +                return;
> +            }
>          }

thanks
-- PMM
