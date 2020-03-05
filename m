Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF02C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB79B20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTnu/Dxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB79B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lmC-0004N0-24
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j9llO-0003pH-Q0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j9llM-000291-Kr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j9llM-00027g-Eo
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583396507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4kMQJI/LFLcYHiOC2TTuMA47LVcapdr+6Ao1Z7TDoA=;
 b=FTnu/DxqrhxM/Dafzuxkp3QV8EF+vNoksA56Kgt+O/AJICmSr5YUDmc+1Xfo6nTCpw/VCn
 A/zA+GP15/A/9LTwHdL4ac7T3h1Xw0VRt7bi3rzXs60LzqmD1TlwinWGxfTYTrkLgnkjwZ
 oBRmzFJEf9aAc/igKs8CRmcaSbLMw/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-SJoIi6yrOwmvBrzLvRSBLA-1; Thu, 05 Mar 2020 03:21:34 -0500
X-MC-Unique: SJoIi6yrOwmvBrzLvRSBLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BEA3800D50;
 Thu,  5 Mar 2020 08:21:32 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A408A19C6A;
 Thu,  5 Mar 2020 08:21:17 +0000 (UTC)
Date: Thu, 5 Mar 2020 08:21:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200305082114.GA2108759@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
 <20200302174745.GP1679990@redhat.com>
 <20200302223937.GA29775@flaka>
 <20200304110032.GA1851428@redhat.com> <20200304162533.GA314@flaka>
 <20200304163357.GE1851428@redhat.com> <20200304223743.GA5151@flaka>
MIME-Version: 1.0
In-Reply-To: <20200304223743.GA5151@flaka>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 04, 2020 at 02:37:43PM -0800, Elena Ufimtseva wrote:
> On Wed, Mar 04, 2020 at 04:33:57PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Mar 04, 2020 at 08:25:34AM -0800, Elena Ufimtseva wrote:
> > > On Wed, Mar 04, 2020 at 11:00:32AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Mon, Mar 02, 2020 at 02:39:37PM -0800, Elena Ufimtseva wrote:
> > > > > On Mon, Mar 02, 2020 at 05:47:45PM +0000, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > > On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Daud=
=C3=A9 wrote:
> > > > > > > typo "multi" in patch subject.
> > > > > > >
> > > > > Thank Philippe, will fix.
> > > > > =20
> > > > > > > On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > > > > > > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > > > >=20
> > > > > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > > > > ---
> > > > > > > >   v4 -> v5:
> > > > > > > >    - Added "exec" suboption to get the executable's name
> > > > > > > >    - Addressed feedback about variable names
> > > > > > > >    - Removed redundant check for spawning a process
> > > > > > > >=20
> > > > > > > >   hw/proxy/qemu-proxy.c         | 68 ++++++++++++++++++++++=
+++++++++++----------
> > > > > > > >   include/hw/proxy/qemu-proxy.h |  2 +-
> > > > > > > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > > > > > > > index 828bbd7..d792e86 100644
> > > > > > > > --- a/hw/proxy/qemu-proxy.c
> > > > > > > > +++ b/hw/proxy/qemu-proxy.c
> > > > > > > > @@ -19,19 +19,50 @@
> > > > > > > >   static void pci_proxy_dev_realize(PCIDevice *dev, Error *=
*errp);
> > > > > > > > +static int add_argv(char *opts_str, char **argv, int argc)
> > > > > > > > +{
> > > > > > > > +    int max_args =3D 64;
> > > > > > > > +
> > > > > > > > +    if (argc < max_args - 1) {
> > > > > > > > +        argv[argc++] =3D opts_str;
> > > > > > > > +        argv[argc] =3D 0;
> > > > > > > > +    } else {
> > > > > > > > +        return 0;
> > > > > > > > +    }
> > > > > > > > +
> > > > > > > > +    return argc;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int make_argv(char *opts_str, char **argv, int argc=
)
> > > > > > > > +{
> > > > > > > > +    int max_args =3D 64;
> > > > > > > > +
> > > > > > > > +    char *p2 =3D strtok(opts_str, " ");
> > > > > > > > +    while (p2 && argc < max_args - 1) {
> > > > > > > > +        argv[argc++] =3D p2;
> > > > > > > > +        p2 =3D strtok(0, " ");
> > > > > > > > +    }
> > > > > > > > +    argv[argc] =3D 0;
> > > > > > >=20
> > > > > > > Is there a GLib function to do that?
> > > > > >
> > > > >=20
> > > > > Hi Daniel
> > > > >=20
> > > > > > g_shell_parse_argv() perhaps
> > > > > >
> > > > >=20
> > > > > Thanks for the suggestion.
> > > > >=20
> > > > > >   https://developer.gnome.org/glib/stable/glib-Shell-related-Ut=
ilities.html
> > > > > >=20
> > > > > >=20
> > > > > > Though my preference would be to avoid the need to do this at a=
ll, by
> > > > > > not accepting a raw shell command line string in the first plac=
e.
> > > > > >
> > > > > Can you please clarify? Did you mean that it would be better if Q=
emu somehow
> > > > > verifies the options and then passes it to a remote process via a=
 message?
> > > >=20
> > > > I've not been able to trace the code paths back all the way, so I c=
an't
> > > > point to where I think needs fixing. I assuming that something, som=
ewhere
> > > > in this patch series should starts out with a binary name and a lis=
t of argv
> > > > as an array of char *. ie a "char **argv".  At some point this arra=
y gets
> > > > mashed together into a single 'char *' string where all the argv ar=
e separated
> > > > by a space. This patch now tries to parse this and turn it back int=
o a
> > > > "char **argv" array.
> > > >=20
> > > > So my key point is that we should try hard to avoid this intermedia=
te
> > > > shell command line string stage entirely. Always keep the argv in a=
n array
> > > > form, and never mash them together such that they then need parsing=
 again.
> > > >
> > > Hi Daniel
> > >=20
> > > Thank you for explanation.
> > > At this point there is no intermediate stage as we grab the arguments
> > > as a raw string from the command line option -remote:
> > >=20
> > > -remote rid=3D8,exec=3Dqemu-scsi-dev,command=3D"-drive id=3Ddrive_ima=
ge2,,file=3D/root/remote-process-disk.img"
> > >=20
> > > So the command=3D"" string is being later parsed into the array and r=
emote process
> > > gets spawned with the "char **argv".
> > >=20
> > > Stefan expressed his concern that its not convenient to use due to
> > > the double escaping commas, spaces, quotes and we do agree with that.
> > > We were seeking an advice on what is the better approach.
> >=20
> > I've not looked closely enough to understand the range of different
> > options we need to be able to pass to the remote QEMU ? Is it just
> > "-drive" options, or can it be absolutely any QEMU option ?
> >=20
> > If it is just -drive, then I could imagine a -remote-drive option
> > such that we end up with with a set of args
> >=20
> >    $QEMU \
> >    -remote rid=3D8,exec=3Dqemu-scsi-dev \
> >    -remote-drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-=
disk1.img \
> >    -remote-drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-=
disk2.img \
> >    -remote rid=3D9,exec=3Dqemu-scsi-dev \
> >    -remote-drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-=
disk3.img \
> >    -remote-drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-=
disk4.img
> >=20
> > And this gets turned into 2 execs:
> >=20
> >    qemu-scsi-dev \
> >    -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1.i=
mg \
> >    -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2.i=
mg
> >   =20
> >    qemu-scsi-dev \
> >    -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3.i=
mg \
> >    -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4.i=
mg
> >=20
> >=20
> > Or maybe instead of having a '-remote-drive' arg, we can make the '-dri=
ve'
> > arg take an optional "rid" attribute to associate it with the remote pr=
ocess
> >=20
> >    $QEMU \
> >    -remote rid=3D8,exec=3Dqemu-scsi-dev \
> >    -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1.i=
mg \
> >    -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2.i=
mg \
> >    -remote rid=3D9,exec=3Dqemu-scsi-dev \
> >    -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3.i=
mg \
> >    -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4.i=
mg
> >=20
> > When 'rid' is seen, instead of creating a local block backend, the
> > args get used for the remote process.
> >=20
> > This would have the nice user behaviour that you can take an existing
> > QEMU command line, and turn it into a multi-process command line
> > simply by adding the '-remote ...' arg, and adding 'rid=3DNN' to
> > each -drive. Nothing else about your existing command line need
> > change.
>=20
> This does look good, especially unmodified -drive.
> And -monitor for the remote process could also be similarly added
> with only rid specified instead of plugging it into the raw string.
>=20
> Stefan did mention in the another patch that he thinks that adding
> -remote option is too invasive and suggested using -object itself
> to further separate remote process devices.
>=20
> So to compile both replies, the command line for the remote process
> will look something like this:
>=20
>=20
> -object remote-device,id=3Drid0,exec=3Dqemu-scsi-dev \
> -device remote-pci-device,id=3Dscsi0,remote-device=3Drid0 \
> -device scsi-hd,drive=3Ddrive_image1,bus=3Dscsi0.0,scsi-id=3D0,remote-dev=
ice=3Drid0 \
> -drive id=3Ddrive_image3,file=3D/root/remote-process-disk3.img,remote-dev=
ice=3Drid0 \
> -drive id=3Ddrive_image4,file=3D/root/remote-process-disk4.img,remote-dev=
ice=3Drid0 \
> -monitor unix:/home/qmp-sock,,server,,nowait,remote-device=3Drid0
>=20
> And in experimental version we imply that remote-pci-device is the LSI co=
ntroller.
> For vfio-over-socket it will represent any remote PCI device.
>=20
> What your thoughts on this?

Looks like a reasonable idea to me. I guess I'm not sure how much the block
maintainers will like having a -drive additional property. Probably depends
how much it impacts the code paths processing it.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


