Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyH5f-0004Do-Ez
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyH5a-0001Rt-GH
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:46:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fyH5Y-0001Kv-I8
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:46:21 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de1f3585-6201-789d-721d-04707caad93e@redhat.com>
Date: Fri, 7 Sep 2018 08:46:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] qdev-monitor: print help to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/07/2018 02:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> qdev_device_help() is used from command line "-device help", or from
> HMP "device_add". If used from command line, print help to stdout
> (it is only printed on explicit demand).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/monitor/monitor.h |  2 ++
>   monitor.c                 | 16 +++++++++++++---
>   qdev-monitor.c            | 32 +++++++++++++++++++-------------
>   3 files changed, 34 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 2ef5e04b37..e7667fda35 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -47,4 +47,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int du=
p_fd);
>   void monitor_fdset_dup_fd_remove(int dup_fd);
>   int monitor_fdset_dup_fd_find(int dup_fd);
>  =20
> +void out_vprintf(FILE *stream, const char *fmt, va_list ap) GCC_FMT_AT=
TR(2, 0);

Perhaps name this monitor_vfprintf()?  (That would match the fact that=20
you are using it like normal vfprintf).

> +++ b/qdev-monitor.c
> @@ -104,22 +104,31 @@ static bool qdev_class_has_alias(DeviceClass *dc)
>       return (qdev_class_get_alias(dc) !=3D NULL);
>   }
>  =20
> +static void out_printf(const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    out_vprintf(stdout, fmt, ap);
> +    va_end(ap);
> +}

But this name seems reasonable.

And I just now see that Thomas also complained about the monitor.h=20
naming, but I like 'monitor_vfprintf' better than his 'mon_file_vprintf'.

If an improved name is your only change,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
