Received: from eggs.gnu.org ([2001:4830:134:3::10]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dp6cb-0003Nz-3E
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 01:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dp6cW-0007tZ-80
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 01:42:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dp6cW-0007sx-1w
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 01:41:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15so1144671wrc.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 22:41:55 -0700 (PDT)
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-3-git-send-email-imammedo@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <d021bc33-5b0c-f5d2-e619-e06705a32043@tuxfamily.org>
Date: Tue, 5 Sep 2017 07:41:51 +0200
MIME-Version: 1.0
In-Reply-To: <1504533662-198084-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] cpu: make cpu_generic_init() abort
 QEMU on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04.09.2017 16:00, Igor Mammedov wrote:
> Almost every user of cpu_generic_init() checks for
> returned NULL and then reports failure in a custom way
> and aborts process.
> Some users assume that call can't fail and don't check
> for failure, though they should have checked for it.
> 
> In either cases cpu_generic_init() failure is fatal,
> so instead of checking for failure and reporting
> it various ways, make cpu_generic_init() report
> errors in consistent way and terminate QEMU on failure.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Even though it's tree wide change, it's trivial so all
> affected call sites are included within one patch.
[...]
> diff --git a/qom/cpu.c b/qom/cpu.c
> index d715890..307d638 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -61,7 +61,7 @@ CPUState *cpu_create(const char *typename)
>      if (err != NULL) {
>          error_report_err(err);
>          object_unref(OBJECT(cpu));
> -        return NULL;
> +        exit(EXIT_FAILURE);
>      }
>      return cpu;
>  }
> @@ -78,8 +78,9 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
>  
>      oc = cpu_class_by_name(typename, model_pieces[0]);
>      if (oc == NULL) {
> +        error_report("unable to find CPU model '%s'", model_pieces[0]);
>          g_strfreev(model_pieces);
> -        return NULL;
> +        exit(EXIT_FAILURE);
>      }
>  
>      cpu_type = object_class_get_name(oc);
> @@ -88,7 +89,7 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
>      g_strfreev(model_pieces);
>      if (err != NULL) {
>          error_report_err(err);
> -        return NULL;
> +        exit(EXIT_FAILURE);
>      }
>      return cpu_type;
>  }
> @@ -100,10 +101,8 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
>       */
>      const char *cpu_type = cpu_parse_features(typename, cpu_model);
>  
> -    if (cpu_type) {
> -        return cpu_create(cpu_type);
> -    }
> -    return NULL;
> +    assert(cpu_type);
> +    return cpu_create(cpu_type);
>  }

Not sure, but wouldn't it be better to do the error reporting and exit
in cpu_generic_init() instead? In case we ever might want to re-use the
create and parse_feature functions for device_add later (?), and then
the functions must not exit directly anymore...

 Thomas
