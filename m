Received: from eggs.gnu.org ([2001:4830:134:3::10]:49537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyxM-0007NR-Bk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyxI-0004fs-Gc
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:03:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etyxI-0004ek-Az
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:03:48 -0500
Date: Thu, 8 Mar 2018 17:03:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308170334.GJ4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-24-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 23/28] qmp: add
 query-sev-launch-measure command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On Thu, Mar 08, 2018 at 06:48:56AM -0600, Brijesh Singh wrote:
> The command can be used by libvirt to retrieve the measurement of SEV g=
uest.
> This measurement is a signature of the memory contents that was encrypt=
ed
> through the LAUNCH_UPDATE_DATA.
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  monitor.c             |  7 +++++++
>  qapi/misc.json        | 29 +++++++++++++++++++++++++++++
>  target/i386/monitor.c | 17 +++++++++++++++++
>  3 files changed, 53 insertions(+)
>=20
> diff --git a/monitor.c b/monitor.c
> index 2225cf5030dc..d53ecc5ddab3 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -984,6 +984,7 @@ static void qmp_unregister_commands_hack(void)
>  #ifndef TARGET_I386
>      qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>      qmp_unregister_command(&qmp_commands, "query-sev");
> +    qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
>  #endif
>  #ifndef TARGET_S390X
>      qmp_unregister_command(&qmp_commands, "dump-skeys");
> @@ -4110,6 +4111,12 @@ SevInfo *qmp_query_sev(Error **errp)
>      error_setg(errp, QERR_FEATURE_DISABLED, "query-sev");
>      return NULL;
>  }
> +
> +SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
> +{
> +    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure"=
);
> +    return NULL;
> +}
>  #endif
> =20
>  #ifndef TARGET_S390X
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 14681729f8fc..a39c43aa64b1 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3277,3 +3277,32 @@
>  #
>  ##
>  { 'command': 'query-sev', 'returns': 'SevInfo' }
> +
> +##
> +# @SevLaunchMeasureInfo:
> +#
> +# SEV Guest Launch measurement information
> +#
> +# @data: the measurement value encoded in base64
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
> +
> +##
> +# @query-sev-launch-measure:
> +#
> +# Query the SEV guest launch information.
> +#
> +# Returns: The @SevLaunchMeasureInfo for the guest
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "query-sev-launch-measure" }
> +# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
> +#
> +##
> +{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureI=
nfo' }
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 7df31c3cdf1b..e5596bbc0fc2 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -720,3 +720,20 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict=
)
>          monitor_printf(mon, "SEV is not enabled\n");
>      }
>  }
> +
> +SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
> +{
> +    char *data;
> +    SevLaunchMeasureInfo *info;
> +
> +    data =3D sev_get_launch_measurement();
> +    if (!data) {
> +        error_setg(errp, "Measurement is not available");
> +        return NULL;
> +    }
> +
> +    info =3D g_malloc0(sizeof(*info));

Minor preference for   g_new0(SevLaunchMeasureInfo, 1);

> +    info->data =3D data;
> +
> +    return info;
> +}

Regardless though

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
