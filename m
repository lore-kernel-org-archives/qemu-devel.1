Received: from eggs.gnu.org ([2001:4830:134:3::10]:54937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTUUh-0006xG-67
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTUUe-0004eR-2I
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTUUd-0004e4-P0
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E0DF7F3E0
	for <qemu-devel@nongnu.org>; Fri,  7 Jul 2017 14:44:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170705144302.32017-1-dgilbert@redhat.com>
Date: Fri, 07 Jul 2017 16:44:19 +0200
In-Reply-To: <20170705144302.32017-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 5 Jul 2017 15:43:02 +0100")
Message-ID: <87r2xsqpbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hmp: Update info vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com, lcapitulino@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The QMP query-vnc interfaces have gained a lot more information that
> the HMP interfaces hasn't got yet. Update it.
>
> Note the output format has changed, but this is HMP so that's OK.
>
> In particular, this now includes client information for reverse
> connections:
>
> -vnc :0
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>   Auth: none (Sub: none)
>
>   (Now connect a client)
>
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>   Client: 127.0.0.1:51828 (ipv4)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
>
> -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
>
> -vnc :1,password,id=rev -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
> rev:
>   Server: 0.0.0.0:5901 (ipv4)
>     Auth: vnc (Sub: none)
>   Client: 127.0.0.1:53616 (ipv4)
>     x509_dname: none
>     username: none
>   Auth: vnc (Sub: none)
>
> This was originally RH bz 1461682
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 67 insertions(+), 31 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index dee40284c1..c11a5fe2c6 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -600,50 +600,86 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
>      qapi_free_BlockStatsList(stats_list);
>  }
>  
> +/* Helper for hmp_info_vnc_clients, _servers */

Not sure this comment is worth its keep.

> +static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
> +                                  const char *name)
> +{
> +    monitor_printf(mon, "  %s: %s:%s (%s%s)\n",
> +                   name,
> +                   info->host,
> +                   info->service,
> +                   NetworkAddressFamily_lookup[info->family],
> +                   info->websocket ? " (Websocket)" : "");
> +}
> +
> +/* Helper displaying and euth and crypt info */

"euth"?  Do you mean "auth"?

Not sure this comment is worth its keep.

> +static void hmp_info_vnc_authcrypt(Monitor *mon, const char *indent,
> +                                   VncPrimaryAuth auth,
> +                                   VncVencryptSubAuth *vencrypt)
> +{
> +    monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
> +                   VncPrimaryAuth_lookup[auth],
> +                   vencrypt ? VncVencryptSubAuth_lookup[*vencrypt] : "none");
> +}
> +
> +static void hmp_info_vnc_clients(Monitor *mon, VncClientInfoList *client)
> +{
> +    while (client) {
> +        VncClientInfo *cinfo = client->value;
> +
> +        hmp_info_VncBasicInfo(mon, (VncBasicInfo *)cinfo, "Client");

QAPI provides a type-safe conversion from type to base type:
qapi_TYPE_base().  You could write qapi_VncClientInfo_base(cinfo) here.
More conversions to base type below.

> +        monitor_printf(mon, "    x509_dname: %s\n",
> +                       cinfo->x509_dname ?
> +                       cinfo->x509_dname : "none");
> +        monitor_printf(mon, "    username: %s\n",
> +                       cinfo->has_sasl_username ?
> +                       cinfo->sasl_username : "none");

When an optional QAPI member FOO is a pointer, checking FOO instead of
has_FOO is totally fine.  But mixing the two in one breath looks odd.

I'd like to get rid of the redundant has_FOOs some day.

> +
> +        client = client->next;
> +    }

I prefer to keep loop control in one place, and I also prefer not to
change parameters:

       for (cl = client; cl; cl = cl->next) {

Matter of taste; your artistic license applies.  More of the same below.

> +}
> +
> +static void hmp_info_vnc_servers(Monitor *mon, VncServerInfo2List *server)
> +{
> +    while (server) {
> +        VncServerInfo2 *sinfo = server->value;
> +        hmp_info_VncBasicInfo(mon, (VncBasicInfo *)sinfo, "Server");
> +        hmp_info_vnc_authcrypt(mon, "    ", sinfo->auth,
> +                               sinfo->has_vencrypt ? &sinfo->vencrypt : NULL);
> +        server = server->next;
> +    }
> +}
> +
>  void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>  {
> -    VncInfo *info;
> +    VncInfo2List *info2l;
>      Error *err = NULL;
> -    VncClientInfoList *client;
>  
> -    info = qmp_query_vnc(&err);
> +    info2l = qmp_query_vnc_servers(&err);
>      if (err) {
>          error_report_err(err);
>          return;
>      }
> -
> -    if (!info->enabled) {
> -        monitor_printf(mon, "Server: disabled\n");
> -        goto out;
> -    }
> -
> -    monitor_printf(mon, "Server:\n");
> -    if (info->has_host && info->has_service) {
> -        monitor_printf(mon, "     address: %s:%s\n", info->host, info->service);
> -    }
> -    if (info->has_auth) {
> -        monitor_printf(mon, "        auth: %s\n", info->auth);
> +    if (!info2l) {
> +        monitor_printf(mon, "None\n");
> +        return;
>      }
>  
> -    if (!info->has_clients || info->clients == NULL) {
> -        monitor_printf(mon, "Client: none\n");
> -    } else {
> -        for (client = info->clients; client; client = client->next) {
> -            monitor_printf(mon, "Client:\n");
> -            monitor_printf(mon, "     address: %s:%s\n",
> -                           client->value->host,
> -                           client->value->service);
> -            monitor_printf(mon, "  x509_dname: %s\n",
> -                           client->value->x509_dname ?
> -                           client->value->x509_dname : "none");
> -            monitor_printf(mon, "    username: %s\n",
> -                           client->value->has_sasl_username ?
> -                           client->value->sasl_username : "none");
> +    while (info2l) {
> +        VncInfo2 *info = info2l->value;
> +        monitor_printf(mon, "%s:\n", info->id);
> +        hmp_info_vnc_servers(mon, info->server);
> +        hmp_info_vnc_clients(mon, info->clients);
> +        hmp_info_vnc_authcrypt(mon, "  ", info->auth,
> +                          info->has_vencrypt ? &info->vencrypt : NULL);
> +        if (info->has_display) {
> +            monitor_printf(mon, "  Display: %s\n", info->display);
>          }
> +        info2l = info2l->next;

Looks like you've squashed two things together: factoring out helpers
(without changing output), and extending output.  I'd keep them
separate.  You decide.

>      }
>  
> -out:
> -    qapi_free_VncInfo(info);
> +    qapi_free_VncInfo2List(info2l);
> +
>  }
>  
>  #ifdef CONFIG_SPICE
