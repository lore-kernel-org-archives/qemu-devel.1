Received: from eggs.gnu.org ([2001:4830:134:3::10]:41412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diEM7-0006Us-Ok
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diEM6-0001a7-Rl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diEM6-0001Zh-LQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F958750D4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 06:32:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<20170728190024.GC3008@work-vm>
Date: Thu, 17 Aug 2017 08:32:29 +0200
In-Reply-To: <20170728190024.GC3008@work-vm> (David Alan Gilbert's message of
	"Fri, 28 Jul 2017 20:00:25 +0100")
Message-ID: <87o9rer9fm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> Add #if defined(CONFIG_VNC) in generated code, and adjust the
>> qmp/hmp code accordingly.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>> diff --git a/hmp.c b/hmp.c
>> index fd80dce758..9454c634bd 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -605,6 +605,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *=
qdict)
>>      qapi_free_BlockStatsList(stats_list);
>>  }
>>=20=20
>> +#ifdef CONFIG_VNC
>>  /* Helper for hmp_info_vnc_clients, _servers */
>>  static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
>>                                    const char *name)
>> @@ -692,6 +693,12 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>>      qapi_free_VncInfo2List(info2l);
>>=20=20
>>  }
>> +#else
>> +void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>> +{
>> +    warn_report("VNC support is disabled");

error_report(), please (see below).

>> +}
>> +#endif
>
> I'm OK with this, so
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> although you might just be able to add a #ifdef in hmp-commands-info.hx
> and avoid the is disabled function, or you might find that with the QMP
> returning an error the HMP just passes that error on.

Let's compare failures when !CONFIG_VNC:

(a) Marc-Andr=C3=A9's patch as is:

        (qemu) info vnc
        warning: VNC support is disabled

    Drop the "warning: " (because it ain't; the command failed), and this
    is fine.

(b) Compiling them out completely (#ifdef in hmp-commands*.hx):

        unknown command: 'vnc'

    HMP bug; should be something like

        Unknown command: 'info vnc'

    but that's not this series' problem.

    Good enough for me.

(c) Forwarding the QMP error verbatim

        The command query-vnc has not been found

    No good.

(d) Handling CommandNotFound

    More work than (a) for the same result.

As far as I'm concerned, feel free to do (a) or (b).

[...]
