Received: from eggs.gnu.org ([2001:4830:134:3::10]:50360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diHB1-0001N3-5A
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diHAw-000725-8F
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diHAv-00071o-Um
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D72117DCFA
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 09:33:12 +0000 (UTC)
Date: Thu, 17 Aug 2017 10:33:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170817093305.GA2235@work-vm>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<20170728190024.GC3008@work-vm> <87o9rer9fm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o9rer9fm.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
> > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> >> Add #if defined(CONFIG_VNC) in generated code, and adjust the
> >> qmp/hmp code accordingly.
> >>=20
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> >> diff --git a/hmp.c b/hmp.c
> >> index fd80dce758..9454c634bd 100644
> >> --- a/hmp.c
> >> +++ b/hmp.c
> >> @@ -605,6 +605,7 @@ void hmp_info_blockstats(Monitor *mon, const QDi=
ct *qdict)
> >>      qapi_free_BlockStatsList(stats_list);
> >>  }
> >> =20
> >> +#ifdef CONFIG_VNC
> >>  /* Helper for hmp_info_vnc_clients, _servers */
> >>  static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
> >>                                    const char *name)
> >> @@ -692,6 +693,12 @@ void hmp_info_vnc(Monitor *mon, const QDict *qd=
ict)
> >>      qapi_free_VncInfo2List(info2l);
> >> =20
> >>  }
> >> +#else
> >> +void hmp_info_vnc(Monitor *mon, const QDict *qdict)
> >> +{
> >> +    warn_report("VNC support is disabled");
>=20
> error_report(), please (see below).
>=20
> >> +}
> >> +#endif
> >
> > I'm OK with this, so
> >
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > although you might just be able to add a #ifdef in hmp-commands-info.=
hx
> > and avoid the is disabled function, or you might find that with the Q=
MP
> > returning an error the HMP just passes that error on.
>=20
> Let's compare failures when !CONFIG_VNC:
>=20
> (a) Marc-Andr=E9's patch as is:
>=20
>         (qemu) info vnc
>         warning: VNC support is disabled
>=20
>     Drop the "warning: " (because it ain't; the command failed), and th=
is
>     is fine.
>=20
> (b) Compiling them out completely (#ifdef in hmp-commands*.hx):
>=20
>         unknown command: 'vnc'
>=20
>     HMP bug; should be something like
>=20
>         Unknown command: 'info vnc'
>=20
>     but that's not this series' problem.

I'll fix that missing 'info'

Dave

>     Good enough for me.
>=20
> (c) Forwarding the QMP error verbatim
>=20
>         The command query-vnc has not been found
>=20
>     No good.
>=20
> (d) Handling CommandNotFound
>=20
>     More work than (a) for the same result.
>=20
> As far as I'm concerned, feel free to do (a) or (b).
>=20
> [...]
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
