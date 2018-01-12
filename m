Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eZzIc-0007Ry-Cr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eZzIX-0006IU-Cc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:23:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eZzIX-0006Cb-6P
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:23:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76675C04AC4A
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:22:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 687986046B
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:22:58 +0000 (UTC)
Date: Fri, 12 Jan 2018 08:22:58 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1027552109.5988061.1515763378153.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180112130416.rsdydqy4popkugrm@sirius.home.kraxel.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-38-marcandre.lureau@redhat.com>
	<20180112130416.rsdydqy4popkugrm@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 37/51] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

----- Original Message -----
> > diff --git a/ui/vnc.h b/ui/vnc.h
> > index 694cf32ca9..5572bfdc9e 100644
> > --- a/ui/vnc.h
> > +++ b/ui/vnc.h
> > @@ -291,7 +291,9 @@ struct VncState
> >      bool encode_ws;
> >      bool websocket;
> >  
> > +#ifdef CONFIG_VNC
> >      VncClientInfo *info;
> > +#endif
> 
> Is this header files used even on !vnc builds?

Yes, in qmp.c.

it looks like it is possible to cleanup the code to not include it (same for spice etc), but I would rather keep this for a future TODO.

> 
> > diff --git a/hmp.c b/hmp.c
> > index 2d72f94193..0612ddc621 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -613,6 +613,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict
> > *qdict)
> >      qapi_free_BlockStatsList(stats_list);
> >  }
> >  
> > +#ifdef CONFIG_VNC
> >  /* Helper for hmp_info_vnc_clients, _servers */
> >  static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
> >                                    const char *name)
> > @@ -700,6 +701,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
> >      qapi_free_VncInfo2List(info2l);
> >  
> >  }
> > +#endif
> 
> Move to ui/vnc.c, so we don't need #ifdef here?

Not so simple either. hmp-commands-info.h (needed for the function declaration) is built per target, but not ui/vnc.c. Again, some future cleanup?

thanks
