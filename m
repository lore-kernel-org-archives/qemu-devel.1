Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4E3214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ6OhR4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4E3214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pBg-0002hh-NB
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j8pB4-0002IH-1f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j8pB1-0004Tp-VM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:48:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j8pB1-0004Tj-R2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583171303;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUCwVeofdQK87zg+rQHTzbms1WdFy3LxWL164VKI59Q=;
 b=WZ6OhR4kWSlLkvzEgqzxWqR39eq/e+soATpn8M8t21r8gU+DzUfFGshLGIVD1t/SB7OwLT
 ImQHZpgl+P2ALtRdZbBQXvtgK6EW+AMGaIOfEj6ghur0KCdks7y7wT0fBfR+mX9wJlkgDN
 fPBJ5M79RwnNvdVUyWxp3kdl3is5SNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-4OYk-KtGOb-EcyCoqLMLUA-1; Mon, 02 Mar 2020 12:48:06 -0500
X-MC-Unique: 4OYk-KtGOb-EcyCoqLMLUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22557107ACCC;
 Mon,  2 Mar 2020 17:48:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D37D85C1C3;
 Mon,  2 Mar 2020 17:47:48 +0000 (UTC)
Date: Mon, 2 Mar 2020 17:47:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200302174745.GP1679990@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> typo "multi" in patch subject.
>=20
> On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> >=20
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > ---
> >   v4 -> v5:
> >    - Added "exec" suboption to get the executable's name
> >    - Addressed feedback about variable names
> >    - Removed redundant check for spawning a process
> >=20
> >   hw/proxy/qemu-proxy.c         | 68 +++++++++++++++++++++++++++++++++-=
---------
> >   include/hw/proxy/qemu-proxy.h |  2 +-
> >   2 files changed, 54 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > index 828bbd7..d792e86 100644
> > --- a/hw/proxy/qemu-proxy.c
> > +++ b/hw/proxy/qemu-proxy.c
> > @@ -19,19 +19,50 @@
> >   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> > +static int add_argv(char *opts_str, char **argv, int argc)
> > +{
> > +    int max_args =3D 64;
> > +
> > +    if (argc < max_args - 1) {
> > +        argv[argc++] =3D opts_str;
> > +        argv[argc] =3D 0;
> > +    } else {
> > +        return 0;
> > +    }
> > +
> > +    return argc;
> > +}
> > +
> > +static int make_argv(char *opts_str, char **argv, int argc)
> > +{
> > +    int max_args =3D 64;
> > +
> > +    char *p2 =3D strtok(opts_str, " ");
> > +    while (p2 && argc < max_args - 1) {
> > +        argv[argc++] =3D p2;
> > +        p2 =3D strtok(0, " ");
> > +    }
> > +    argv[argc] =3D 0;
>=20
> Is there a GLib function to do that?

g_shell_parse_argv() perhaps

  https://developer.gnome.org/glib/stable/glib-Shell-related-Utilities.html


Though my preference would be to avoid the need to do this at all, by
not accepting a raw shell command line string in the first place.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


