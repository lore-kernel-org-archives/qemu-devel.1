Received: from eggs.gnu.org ([2001:4830:134:3::10]:37528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dbAV0-0003II-Qz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dbAUy-000220-Qz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dbAUy-00021G-IJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AA4240803
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 19:00:31 +0000 (UTC)
Date: Fri, 28 Jul 2017 20:00:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170728190024.GC3008@work-vm>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170727154126.11339-17-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Add #if defined(CONFIG_VNC) in generated code, and adjust the
> qmp/hmp code accordingly.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

> diff --git a/hmp.c b/hmp.c
> index fd80dce758..9454c634bd 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -605,6 +605,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict =
*qdict)
>      qapi_free_BlockStatsList(stats_list);
>  }
> =20
> +#ifdef CONFIG_VNC
>  /* Helper for hmp_info_vnc_clients, _servers */
>  static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
>                                    const char *name)
> @@ -692,6 +693,12 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict=
)
>      qapi_free_VncInfo2List(info2l);
> =20
>  }
> +#else
> +void hmp_info_vnc(Monitor *mon, const QDict *qdict)
> +{
> +    warn_report("VNC support is disabled");
> +}
> +#endif

I'm OK with this, so

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

although you might just be able to add a #ifdef in hmp-commands-info.hx
and avoid the is disabled function, or you might find that with the QMP
returning an error the HMP just passes that error on.

Dave

>  #ifdef CONFIG_SPICE
>  void hmp_info_spice(Monitor *mon, const QDict *qdict)
> @@ -1708,12 +1715,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict=
)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +#ifdef CONFIG_VNC
>  static void hmp_change_read_arg(void *opaque, const char *password,
>                                  void *readline_opaque)
>  {
>      qmp_change_vnc_password(password, NULL);
>      monitor_read_command(opaque, 1);
>  }
> +#endif
> =20
>  void hmp_change(Monitor *mon, const QDict *qdict)
>  {
> @@ -1724,6 +1733,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      BlockdevChangeReadOnlyMode read_only_mode =3D 0;
>      Error *err =3D NULL;
> =20
> +#ifdef CONFIG_VNC
>      if (strcmp(device, "vnc") =3D=3D 0) {
>          if (read_only) {
>              monitor_printf(mon,
> @@ -1738,7 +1748,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>              }
>          }
>          qmp_change("vnc", target, !!arg, arg, &err);
> -    } else {
> +    } else
> +#endif
> +    {
>          if (read_only) {
>              read_only_mode =3D
>                  qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
> diff --git a/qmp.c b/qmp.c
> index b86201e349..2c90dacb56 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
>      }
>  }
> =20
> -#ifndef CONFIG_VNC
> -/* If VNC support is enabled, the "true" query-vnc command is
> -   defined in the VNC subsystem */
> -VncInfo *qmp_query_vnc(Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
> -    return NULL;
> -};
> -
> -VncInfo2List *qmp_query_vnc_servers(Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
> -    return NULL;
> -};
> -#endif
> -
>  #ifndef CONFIG_SPICE
>  /*
>   * qmp-commands.hx ensures that QMP command query-spice exists only
> @@ -403,23 +387,17 @@ static void qmp_change_vnc(const char *target, bo=
ol has_arg, const char *arg,
>          qmp_change_vnc_listen(target, errp);
>      }
>  }
> -#else
> -void qmp_change_vnc_password(const char *password, Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
> -}
> -static void qmp_change_vnc(const char *target, bool has_arg, const cha=
r *arg,
> -                           Error **errp)
> -{
> -    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
> -}
>  #endif /* !CONFIG_VNC */
> =20
>  void qmp_change(const char *device, const char *target,
>                  bool has_arg, const char *arg, Error **errp)
>  {
>      if (strcmp(device, "vnc") =3D=3D 0) {
> +#ifdef CONFIG_VNC
>          qmp_change_vnc(target, has_arg, arg, errp);
> +#else
> +        error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
> +#endif
>      } else {
>          qmp_blockdev_change_medium(true, device, false, NULL, target,
>                                     has_arg, arg, false, 0, errp);
> --=20
> 2.14.0.rc0.1.g40ca67566
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
