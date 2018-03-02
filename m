Received: from eggs.gnu.org ([2001:4830:134:3::10]:49747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eriuS-00080w-1Z
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eriuO-0007Uf-Ua
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:31:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eriuO-0007UU-P3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:31:28 -0500
Date: Fri, 2 Mar 2018 11:31:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180302113118.GC3154@work-vm>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-15-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180228211028.83970-15-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 14/28] hmp: add 'info sev' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> The command can be used to show the SEV information when memory
> encryption is enabled on AMD platform.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>=20
> Hi Dave,
>=20
> I updated the patch to address your comment on making this x86 specific=
, but
> still kept your R-b, if you don't agree with changes then let me know.

Yes, that's fine, thanks.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave


> thanks
>=20
>  hmp-commands-info.hx  | 16 ++++++++++++++++
>  hmp.h                 |  1 +
>  target/i386/monitor.c | 20 ++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>=20
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ad590a4ffb2b..ddfcd5adcca6 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -867,6 +867,22 @@ Display the amount of initially allocated and pres=
ent hotpluggable (if
>  enabled) memory in bytes.
>  ETEXI
> =20
> +#if defined(TARGET_I386)
> +    {
> +        .name       =3D "sev",
> +        .args_type  =3D "",
> +        .params     =3D "",
> +        .help       =3D "show SEV information",
> +        .cmd        =3D hmp_info_sev,
> +    },
> +#endif
> +
> +STEXI
> +@item info sev
> +@findex info sev
> +Show SEV information.
> +ETEXI
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.h b/hmp.h
> index 1143db44a760..4ca1a77b2c1f 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -146,5 +146,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *q=
dict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> +void hmp_info_sev(Monitor *mon, const QDict *qdict);
> =20
>  #endif
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index e2f02c4be95c..e664030dbd72 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -29,6 +29,7 @@
>  #include "qapi/qmp/qdict.h"
>  #include "hw/i386/pc.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/sev.h"
>  #include "hmp.h"
>  #include "sev_i386.h"
>  #include "qmp-commands.h"
> @@ -680,3 +681,22 @@ SevInfo *qmp_query_sev(Error **errp)
> =20
>      return info;
>  }
> +
> +void hmp_info_sev(Monitor *mon, const QDict *qdict)
> +{
> +    SevInfo *info =3D sev_get_info();
> +
> +    if (info && info->enabled) {
> +        monitor_printf(mon, "handle: %d\n", info->handle);
> +        monitor_printf(mon, "state: %s\n", SevState_str(info->state));
> +        monitor_printf(mon, "build: %d\n", info->build_id);
> +        monitor_printf(mon, "api version: %d.%d\n",
> +                       info->api_major, info->api_minor);
> +        monitor_printf(mon, "debug: %s\n",
> +                       info->policy & SEV_POLICY_NODBG ? "off" : "on")=
;
> +        monitor_printf(mon, "key-sharing: %s\n",
> +                       info->policy & SEV_POLICY_NOKS ? "off" : "on");
> +    } else {
> +        monitor_printf(mon, "SEV is not enabled\n");
> +    }
> +}
> --=20
> 2.14.3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
