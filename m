Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B5AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338D120757
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJI1147Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338D120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBTc-0002gq-EL
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEBSs-0002IR-LW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEBSr-0004DN-08
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:36:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEBSq-0004CO-Sj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584448616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9zn95ZdyZm5ejS0RD/a0J3gi6BQbAad3Psn3rBjfSM=;
 b=dJI1147YyUUQck7QoGlx/GVx1Chp+5J8+gVU+FPVwBN3nSMSiYLeGdmS3WJKYJAV6TLN+p
 pFMJNhPrU4MbMFzwOh+IxpEg3jWbPFNDPSJJvH1GONB+eBzIhXTYYqYRmtjb0T8fu9fqzy
 tAGRIuoZEGtZ5obEiBWimYMVw1gLtdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-H_GMHhPoM9KV6jp3rCEAfg-1; Tue, 17 Mar 2020 08:36:54 -0400
X-MC-Unique: H_GMHhPoM9KV6jp3rCEAfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAC0100550D;
 Tue, 17 Mar 2020 12:36:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D70C310016EB;
 Tue, 17 Mar 2020 12:36:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67B291138404; Tue, 17 Mar 2020 13:36:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] net: Complete qapi-fication of netdev_add
References: <20200312211440.3767626-1-eblake@redhat.com>
Date: Tue, 17 Mar 2020 13:36:51 +0100
In-Reply-To: <20200312211440.3767626-1-eblake@redhat.com> (Eric Blake's
 message of "Thu, 12 Mar 2020 16:14:40 -0500")
Message-ID: <87fte79mzg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lekiravi@yandex-team.ru, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> We've had all the required pieces for doing a type-safe representation
> of netdev_add as a flat union for quite some time now (since
> 0e55c381f6 in v2.7.0, released in 2016), but did not make the final
> switch to using it because of concern about whether a command-line
> regression in accepting "1" in place of 1 for integer arguments would
> be problematic.  Back then, we did not have the deprecation cycle to
> allow us to make progress.  But now that we have waited so long, other
> problems have crept in: for example, our desire to add
> qemu-storage-daemon is hampered by the inability to express net
> objects, and we are unable to introspect what we actually accept.
> Additionally, our round-trip through QemuOpts silently eats any
> argument that expands to an array, rendering dnssearch, hostfwd, and
> guestfwd useless through QMP:
>
> {"execute": "netdev_add", "arguments": { "id": "netdev0",
>   "type": "user", "dnssearch": [
>     { "str": "8.8.8.8" }, { "str": "8.8.4.4" }
>   ]}}
>
> So without further ado, let's turn on proper QAPI.
>
> There are a few places where the QMP 'netdev_add' command is now
> more strict: anywhere that the QAPI lists an integer member, we
> now require a strict JSON integer (previously, we allowed both
> integers and strings, because the conversion from QMP to QemuOpts
> back to QObject collapsed them into integers).  For example,
> pre-patch, both of these examples succeed, but post-patch, the
> second example now fails:
>
> {'execute':'netdev_add',
>   'arguments':{'id':'net1', 'type':'hubport', 'hubid':1}}
> {"return": {}}
> {'execute':'netdev_add',
>   'arguments':{'id':'net2', 'type':'hubport', 'hubid':"2"}}
> {"error": {"class": "GenericError", "desc": "Invalid parameter type for '=
hubid', expected: integer"}}
>
> But this stricter QMP is desirable, and introspection is sufficient
> for any affected applications to make sure they use it correctly.
>
> In qmp_netdev_add(), we still have to create a QemuOpts object
> so that qmp_netdev_del() will be able to remove a hotplugged
> network device; but the opts->head remains empty since we now
> manage all parsing through the QAPI object rather than QemuOpts.
>
> Reported-by: Alex Kirillov <lekiravi@yandex-team.ru>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/net.json     | 14 +-------------
>  include/net/net.h |  1 -
>  monitor/misc.c    |  2 --
>  net/net.c         |  6 +++---
>  4 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/qapi/net.json b/qapi/net.json
> index 1cb9a7d782b4..cebb1b52e3b1 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -39,18 +39,8 @@
>  #
>  # Add a network backend.
>  #
> -# @type: the type of network backend. Possible values are listed in
> -#        NetClientDriver (excluding 'none' and 'nic')
> -#
> -# @id: the name of the new network backend
> -#
>  # Additional arguments depend on the type.
>  #
> -# TODO: This command effectively bypasses QAPI completely due to its
> -#       "additional arguments" business.  It shouldn't have been added t=
o
> -#       the schema in this form.  It should be qapified properly, or
> -#       replaced by a properly qapified command.
> -#
>  # Since: 0.14.0
>  #
>  # Returns: Nothing on success
> @@ -64,9 +54,7 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'netdev_add',
> -  'data': {'type': 'str', 'id': 'str'},
> -  'gen': false }                # so we can get the additional arguments
> +{ 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true }
>
>  ##
>  # @netdev_del:
> diff --git a/include/net/net.h b/include/net/net.h
> index e175ba9677dc..96e6eae8176e 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -203,7 +203,6 @@ void net_cleanup(void);
>  void hmp_host_net_add(Monitor *mon, const QDict *qdict);
>  void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
>  void netdev_add(QemuOpts *opts, Error **errp);
> -void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp);
>
>  int net_hub_id_for_client(NetClientState *nc, int *id);
>  NetClientState *net_hub_port_find(int hub_id);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index c3bc34c099dd..41a86e7012a1 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -247,8 +247,6 @@ static void monitor_init_qmp_commands(void)
>                           qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
>      qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
>                           QCO_NO_OPTIONS);
> -    qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
> -                         QCO_NO_OPTIONS);
>      qmp_register_command(&qmp_commands, "object-add", qmp_object_add,
>                           QCO_NO_OPTIONS);
>
> diff --git a/net/net.c b/net/net.c
> index 9e93c3f8a1e2..a2065aabede2 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1170,7 +1170,7 @@ void netdev_add(QemuOpts *opts, Error **errp)
>      net_client_init(opts, true, errp);
>  }
>
> -void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp)
> +void qmp_netdev_add(Netdev *netdev, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      QemuOptsList *opts_list;
> @@ -1181,12 +1181,12 @@ void qmp_netdev_add(QDict *qdict, QObject **ret, =
Error **errp)
>          goto out;
>      }
>
> -    opts =3D qemu_opts_from_qdict(opts_list, qdict, &local_err);
> +    opts =3D qemu_opts_create(opts_list, netdev->id, 1, &local_err);
>      if (local_err) {
>          goto out;
>      }
>
> -    netdev_add(opts, &local_err);
> +    net_client_init1(netdev, true, &local_err);
>      if (local_err) {
>          qemu_opts_del(opts);
>          goto out;

netdev_add() is a trivial wrapper around net_client_init(), which is a
not-so-trivial wrapper around net_client_init1().  Calling it directly
skips what's done in net_client_init().  Let's have a look:

    static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp=
)
    {
        gchar **substrings =3D NULL;
        void *object =3D NULL;
        Error *err =3D NULL;
        int ret =3D -1;
        Visitor *v =3D opts_visitor_new(opts);

        const char *type =3D qemu_opt_get(opts, "type");

        if (is_netdev && type && is_help_option(type)) {
            show_netdevs();
            exit(0);

Bypassing this makes QMP command

    {"execute": "netdev_add", "arguments": {"type": "help"}}

fail instead of print help to stdout and exit.  I consider this a bug
fix.  Broken in 547203ead4 'net: List available netdevs with "-netdev
help"', v2.12.0.

Needs a mention in commit message and perhaps release notes.

        } else {
            /* Parse convenience option format ip6-net=3Dfec0::0[/64] */
            const char *ip6_net =3D qemu_opt_get(opts, "ipv6-net");

            if (ip6_net) {
                char *prefix_addr;
                unsigned long prefix_len =3D 64; /* Default 64bit prefix le=
ngth. */

                substrings =3D g_strsplit(ip6_net, "/", 2);
                if (!substrings || !substrings[0]) {
                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "ipv6-ne=
t",
                               "a valid IPv6 prefix");
                    goto out;
                }

                prefix_addr =3D substrings[0];

                /* Handle user-specified prefix length. */
                if (substrings[1] &&
                    qemu_strtoul(substrings[1], NULL, 10, &prefix_len))
                {
                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                               "ipv6-prefixlen", "a number");
                    goto out;
                }

                qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort=
);
                qemu_opt_set_number(opts, "ipv6-prefixlen", prefix_len,
                                    &error_abort);
                qemu_opt_unset(opts, "ipv6-net");
            }

        }

Bypassing this loses argument "ip6-net", sugar for "ipv6-prefix" and
"ipv6-prefixlen".  Introduced in commit 7aac531ef2 "qapi-schema,
qemu-options & slirp: Adding Qemu options for IPv6 addresses", v2.6.0.
It seems to be entirely undocumented, even for -netdev and HMP.

I'm leaning towards treating this as the culling of an accidental
misfeature.

Needs a mention in commit message and perhaps release notes.

I'm half tempted to cull it from HMP and -netdev, too.

        if (is_netdev) {
            visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
        } else {
            visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
        }

Bypassing this is the point of this patch.

        if (!err) {
            ret =3D net_client_init1(object, is_netdev, &err);
        }

        if (is_netdev) {
            qapi_free_Netdev(object);
        } else {
            qapi_free_NetLegacy(object);
        }

    out:
        error_propagate(errp, err);
        g_strfreev(substrings);
        visit_free(v);
        return ret;
    }


