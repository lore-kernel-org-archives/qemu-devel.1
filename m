Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC0C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CF221739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFAKfaXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CF221739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9WzY-0001NL-Mc
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 11:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j9Wyp-0000vZ-CP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j9Wyn-0003xN-4Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:34:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j9Wym-0003vf-SR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583339679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLGIEQtwY7Xbaweg4AUIxeX70Q2/MrudKQUsO/tWdH0=;
 b=eFAKfaXYHoBciKAq3FmhE0MUPWKbxRg+tQ18VDHM7IevLniEIJ0unUrsEEUG/Apm/7OjUM
 VQVZKP6MZxR0twCUptlJjxlc60LHhv4sG1+xEYUQcGPfWXqzhgjx8Fm6qutlt+l+IHglIv
 wcg14W8U9pLnT4PDsG2BsTQ8XoI9v14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-CmauRs1mPLWjAExU1MivKg-1; Wed, 04 Mar 2020 11:34:27 -0500
X-MC-Unique: CmauRs1mPLWjAExU1MivKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C871405;
 Wed,  4 Mar 2020 16:34:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4783E272CB;
 Wed,  4 Mar 2020 16:34:00 +0000 (UTC)
Date: Wed, 4 Mar 2020 16:33:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200304163357.GE1851428@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
 <20200302174745.GP1679990@redhat.com>
 <20200302223937.GA29775@flaka>
 <20200304110032.GA1851428@redhat.com> <20200304162533.GA314@flaka>
MIME-Version: 1.0
In-Reply-To: <20200304162533.GA314@flaka>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 04, 2020 at 08:25:34AM -0800, Elena Ufimtseva wrote:
> On Wed, Mar 04, 2020 at 11:00:32AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Mar 02, 2020 at 02:39:37PM -0800, Elena Ufimtseva wrote:
> > > On Mon, Mar 02, 2020 at 05:47:45PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > > > > typo "multi" in patch subject.
> > > > >
> > > Thank Philippe, will fix.
> > > =20
> > > > > On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > > > > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > >=20
> > > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > > ---
> > > > > >   v4 -> v5:
> > > > > >    - Added "exec" suboption to get the executable's name
> > > > > >    - Addressed feedback about variable names
> > > > > >    - Removed redundant check for spawning a process
> > > > > >=20
> > > > > >   hw/proxy/qemu-proxy.c         | 68 ++++++++++++++++++++++++++=
+++++++----------
> > > > > >   include/hw/proxy/qemu-proxy.h |  2 +-
> > > > > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > >=20
> > > > > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > > > > > index 828bbd7..d792e86 100644
> > > > > > --- a/hw/proxy/qemu-proxy.c
> > > > > > +++ b/hw/proxy/qemu-proxy.c
> > > > > > @@ -19,19 +19,50 @@
> > > > > >   static void pci_proxy_dev_realize(PCIDevice *dev, Error **err=
p);
> > > > > > +static int add_argv(char *opts_str, char **argv, int argc)
> > > > > > +{
> > > > > > +    int max_args =3D 64;
> > > > > > +
> > > > > > +    if (argc < max_args - 1) {
> > > > > > +        argv[argc++] =3D opts_str;
> > > > > > +        argv[argc] =3D 0;
> > > > > > +    } else {
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    return argc;
> > > > > > +}
> > > > > > +
> > > > > > +static int make_argv(char *opts_str, char **argv, int argc)
> > > > > > +{
> > > > > > +    int max_args =3D 64;
> > > > > > +
> > > > > > +    char *p2 =3D strtok(opts_str, " ");
> > > > > > +    while (p2 && argc < max_args - 1) {
> > > > > > +        argv[argc++] =3D p2;
> > > > > > +        p2 =3D strtok(0, " ");
> > > > > > +    }
> > > > > > +    argv[argc] =3D 0;
> > > > >=20
> > > > > Is there a GLib function to do that?
> > > >
> > >=20
> > > Hi Daniel
> > >=20
> > > > g_shell_parse_argv() perhaps
> > > >
> > >=20
> > > Thanks for the suggestion.
> > >=20
> > > >   https://developer.gnome.org/glib/stable/glib-Shell-related-Utilit=
ies.html
> > > >=20
> > > >=20
> > > > Though my preference would be to avoid the need to do this at all, =
by
> > > > not accepting a raw shell command line string in the first place.
> > > >
> > > Can you please clarify? Did you mean that it would be better if Qemu =
somehow
> > > verifies the options and then passes it to a remote process via a mes=
sage?
> >=20
> > I've not been able to trace the code paths back all the way, so I can't
> > point to where I think needs fixing. I assuming that something, somewhe=
re
> > in this patch series should starts out with a binary name and a list of=
 argv
> > as an array of char *. ie a "char **argv".  At some point this array ge=
ts
> > mashed together into a single 'char *' string where all the argv are se=
parated
> > by a space. This patch now tries to parse this and turn it back into a
> > "char **argv" array.
> >=20
> > So my key point is that we should try hard to avoid this intermediate
> > shell command line string stage entirely. Always keep the argv in an ar=
ray
> > form, and never mash them together such that they then need parsing aga=
in.
> >
> Hi Daniel
>=20
> Thank you for explanation.
> At this point there is no intermediate stage as we grab the arguments
> as a raw string from the command line option -remote:
>=20
> -remote rid=3D8,exec=3Dqemu-scsi-dev,command=3D"-drive id=3Ddrive_image2,=
,file=3D/root/remote-process-disk.img"
>=20
> So the command=3D"" string is being later parsed into the array and remot=
e process
> gets spawned with the "char **argv".
>=20
> Stefan expressed his concern that its not convenient to use due to
> the double escaping commas, spaces, quotes and we do agree with that.
> We were seeking an advice on what is the better approach.

I've not looked closely enough to understand the range of different
options we need to be able to pass to the remote QEMU ? Is it just
"-drive" options, or can it be absolutely any QEMU option ?

If it is just -drive, then I could imagine a -remote-drive option
such that we end up with with a set of args

   $QEMU \
   -remote rid=3D8,exec=3Dqemu-scsi-dev \
   -remote-drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk=
1.img \
   -remote-drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk=
2.img \
   -remote rid=3D9,exec=3Dqemu-scsi-dev \
   -remote-drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk=
3.img \
   -remote-drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk=
4.img

And this gets turned into 2 execs:

   qemu-scsi-dev \
   -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1.img \
   -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2.img
  =20
   qemu-scsi-dev \
   -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3.img \
   -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4.img


Or maybe instead of having a '-remote-drive' arg, we can make the '-drive'
arg take an optional "rid" attribute to associate it with the remote proces=
s

   $QEMU \
   -remote rid=3D8,exec=3Dqemu-scsi-dev \
   -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1.img \
   -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2.img \
   -remote rid=3D9,exec=3Dqemu-scsi-dev \
   -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3.img \
   -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4.img

When 'rid' is seen, instead of creating a local block backend, the
args get used for the remote process.

This would have the nice user behaviour that you can take an existing
QEMU command line, and turn it into a multi-process command line
simply by adding the '-remote ...' arg, and adding 'rid=3DNN' to
each -drive. Nothing else about your existing command line need
change.

> Few things we discussed internally is to have the remote drive
> command line options passed over by messages or using QMP.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


