Received: from eggs.gnu.org ([2001:4830:134:3::10]:39028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0cPq-0002ty-1U
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0cPm-0004RE-T7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:20:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d0cPm-0004Qf-KK
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:20:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3INE95Z021535
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:20:04 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29wqq12xet-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:20:04 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Apr 2017 17:20:02 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170323113913.26974-2-vfeenstr@redhat.com>
References: <20170323113913.26974-1-vfeenstr@redhat.com>
	<20170323113913.26974-2-vfeenstr@redhat.com>
Date: Tue, 18 Apr 2017 18:19:51 -0500
Message-Id: <149255759173.17401.5142145020558512567@loki>
Subject: Re: [Qemu-devel] [PATCH v5] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: sameeh@daynix.com, marcandre.lureau@gmail.com

Quoting Vinzenz 'evilissimo' Feenstra (2017-03-23 06:39:13)
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> =

> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
> =

> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>  qga/commands.c       | 29 +++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> =

> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..3b5789c 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,32 @@ int ga_parse_whence(GuestFileWhence *whence, Error *=
*errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info =3D g_new0(GuestTimezone, 1);
> +    GTimeZone *tz =3D g_time_zone_new_local();
> +    if (tz =3D=3D NULL) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> +                   "Couldn't retrieve local timezone");
> +        goto error;
> +    }
> +
> +    gint64 now =3D g_get_real_time() / G_USEC_PER_SEC;
> +    gint32 intv =3D g_time_zone_find_interval(tz, G_TIME_TYPE_UNIVERSAL,=
 now);
> +    info->offset =3D g_time_zone_get_offset(tz, intv);
> +    gchar const *name =3D g_time_zone_get_abbreviation(tz, intv);

Declarations should all go at the start of the block. Since it's a
trivial change and I was late in reviewing this I was planning on applying
and just fixing it up in my tree, but I just noticed a bigger issue:

Our minimum glib version is 2.22 for non-mingw builds, and 2.30 for
mingw, whereas the required versions for these functions are:

  g_time_zone_new_local         2.26
  g_get_real_time               2.28
  g_time_zone_find_interval     2.26
  g_time_zone_get_offset        2.26
  g_time_zone_get_abbreviation  2.26
  g_time_zone_unref             2.26

So assuming there's no simple alternative implementations for these, I think
what we need is a configure probe for glib >=3D 2.28 in order to enable this
interface for non-mingw builds, and to stub it out with QERR_UNSUPPORTED
errors otherwise.

> +    if (name !=3D NULL) {
> +        info->has_zone =3D true;
> +        info->zone =3D g_strdup(name);
> +    }
> +    g_time_zone_unref(tz);
> +
> +    return info;
> +
> +error:
> +    g_time_zone_unref(tz);

Harmless, but since "error" label is only reachable when tz =3D=3D NULL I t=
hink you
can drop this.

> +    g_free(info);
> +    return NULL;
> +}
> +
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..5183ea2 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,29 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in seconds, negative numbers for time zones we=
st of
> +#           GMT, positive numbers for east
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestTimezone',
> +  'data':   { '*zone': 'str', 'offset': 'int' } }
> +
> +
> +##
> +# @guest-get-timezone:
> +#
> +# Retrieves the timezone information from the guest.
> +#
> +# Returns: A GuestTimezone dictionary.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-timezone',
> +  'returns': 'GuestTimezone' }
> -- =

> 2.9.3
> =

>=20
