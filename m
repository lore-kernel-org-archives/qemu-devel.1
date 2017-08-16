Received: from eggs.gnu.org ([2001:4830:134:3::10]:46185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di43J-0007UW-UF
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di43F-0004fb-Rh
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:32:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1di43F-0004ci-IS
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:32:25 -0400
Date: Wed, 16 Aug 2017 16:32:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170816193218.GF3108@localhost.localdomain>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-9-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500040339-119465-9-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/28] x86: extract legacy cpu features
 format parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 14, 2017 at 03:51:59PM +0200, Igor Mammedov wrote:
> Move cpu_model +-feat parsing into a separate file so that it
> could be reused later for parsing similar format of sparc target
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/cpu.h                     |   6 ++
>  default-configs/i386-bsd-user.mak     |   1 +
>  default-configs/i386-linux-user.mak   |   1 +
>  default-configs/i386-softmmu.mak      |   1 +
>  default-configs/x86_64-bsd-user.mak   |   1 +
>  default-configs/x86_64-linux-user.mak |   1 +
>  default-configs/x86_64-softmmu.mak    |   1 +
>  target/i386/cpu.c                     | 124 ++-------------------------
>  util/Makefile.objs                    |   1 +
>  util/legacy_cpu_features_parser.c     | 153 ++++++++++++++++++++++++++++++++++
>  10 files changed, 172 insertions(+), 118 deletions(-)
>  create mode 100644 util/legacy_cpu_features_parser.c
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 7bfd50c..60aea03 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -1039,4 +1039,10 @@ extern const struct VMStateDescription vmstate_cpu_common;
>  
>  #define UNASSIGNED_CPU_INDEX -1
>  
> +int cpu_legacy_apply_features(Object *obj, GList *features, bool enable,
> +                              Error **errp);
> +
> +void cpu_legacy_parse_featurestr(const char *typename, char *features,
> +                                 GList **plus_features, GList **minus_features,
> +                                 Error **errp);

plus_features and minus_features only exist because of a (now
fixed) bug in the handling of cpu->max_features, and we don't
need them anymore, see the comment at x86_cpu_expand_features():

    /*TODO: Now cpu->max_features doesn't overwrite features
     * set using QOM properties, and we can convert
     * plus_features & minus_features to global properties
     * inside x86_cpu_parse_featurestr() too.
     */

Let's remove them instead of exposing this unnecessary misfeature
on the generic API.

-- 
Eduardo
