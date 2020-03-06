Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81113C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5C720658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCPJ1Pvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5C720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAFng-0002IC-9Z
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jAFn1-0001sr-8n
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jAFmz-0006xG-3l
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:25:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jAFmy-0006uw-V9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583511927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hung3O84KQqPUovBIYL29ksjbJQQDvi3OdzAd8CAJG0=;
 b=TCPJ1PvuJxY+myQCHniw5/UdMgSIZlRh5e5iMQvWOjwYfbUSb7t+weCr8abXEn+KL8eTDO
 /tsg+ksqx103c2ShzgcDxmA5+IkEHlDIf4mb280CA5namL8rnKVdVdKdMw3DwlLyzTlBEj
 h+NYtg23UhzGckomxueSQSqCF95tNZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-RZ1vQP-YPKeVdbs8zgZwoQ-1; Fri, 06 Mar 2020 11:25:23 -0500
X-MC-Unique: RZ1vQP-YPKeVdbs8zgZwoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A977802581;
 Fri,  6 Mar 2020 16:25:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93EF95DA2C;
 Fri,  6 Mar 2020 16:25:15 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:25:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200306162514.GB1438162@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
 <20200302174745.GP1679990@redhat.com>
 <20200302223937.GA29775@flaka>
 <20200304110032.GA1851428@redhat.com> <20200304162533.GA314@flaka>
 <20200304163357.GE1851428@redhat.com> <20200304223743.GA5151@flaka>
 <20200305082114.GA2108759@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305082114.GA2108759@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, Jagannathan Raman <jag.raman@oracle.com>,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 08:21:14AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 04, 2020 at 02:37:43PM -0800, Elena Ufimtseva wrote:
> > On Wed, Mar 04, 2020 at 04:33:57PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Wed, Mar 04, 2020 at 08:25:34AM -0800, Elena Ufimtseva wrote:
> > > > On Wed, Mar 04, 2020 at 11:00:32AM +0000, Daniel P. Berrang=E9 wrot=
e:
> > > > > On Mon, Mar 02, 2020 at 02:39:37PM -0800, Elena Ufimtseva wrote:
> > > > > > On Mon, Mar 02, 2020 at 05:47:45PM +0000, Daniel P. Berrang=E9 =
wrote:
> > > > > > > On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Da=
ud=E9 wrote:
> > > > > > > > typo "multi" in patch subject.
> > > > > > > >
> > > > > > Thank Philippe, will fix.
> > > > > > =20
> > > > > > > > On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > > > > > > > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.co=
m>
> > > > > > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > > > > > ---
> > > > > > > > >   v4 -> v5:
> > > > > > > > >    - Added "exec" suboption to get the executable's name
> > > > > > > > >    - Addressed feedback about variable names
> > > > > > > > >    - Removed redundant check for spawning a process
> > > > > > > > >=20
> > > > > > > > >   hw/proxy/qemu-proxy.c         | 68 ++++++++++++++++++++=
+++++++++++++----------
> > > > > > > > >   include/hw/proxy/qemu-proxy.h |  2 +-
> > > > > > > > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.=
c
> > > > > > > > > index 828bbd7..d792e86 100644
> > > > > > > > > --- a/hw/proxy/qemu-proxy.c
> > > > > > > > > +++ b/hw/proxy/qemu-proxy.c
> > > > > > > > > @@ -19,19 +19,50 @@
> > > > > > > > >   static void pci_proxy_dev_realize(PCIDevice *dev, Error=
 **errp);
> > > > > > > > > +static int add_argv(char *opts_str, char **argv, int arg=
c)
> > > > > > > > > +{
> > > > > > > > > +    int max_args =3D 64;
> > > > > > > > > +
> > > > > > > > > +    if (argc < max_args - 1) {
> > > > > > > > > +        argv[argc++] =3D opts_str;
> > > > > > > > > +        argv[argc] =3D 0;
> > > > > > > > > +    } else {
> > > > > > > > > +        return 0;
> > > > > > > > > +    }
> > > > > > > > > +
> > > > > > > > > +    return argc;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int make_argv(char *opts_str, char **argv, int ar=
gc)
> > > > > > > > > +{
> > > > > > > > > +    int max_args =3D 64;
> > > > > > > > > +
> > > > > > > > > +    char *p2 =3D strtok(opts_str, " ");
> > > > > > > > > +    while (p2 && argc < max_args - 1) {
> > > > > > > > > +        argv[argc++] =3D p2;
> > > > > > > > > +        p2 =3D strtok(0, " ");
> > > > > > > > > +    }
> > > > > > > > > +    argv[argc] =3D 0;
> > > > > > > >=20
> > > > > > > > Is there a GLib function to do that?
> > > > > > >
> > > > > >=20
> > > > > > Hi Daniel
> > > > > >=20
> > > > > > > g_shell_parse_argv() perhaps
> > > > > > >
> > > > > >=20
> > > > > > Thanks for the suggestion.
> > > > > >=20
> > > > > > >   https://developer.gnome.org/glib/stable/glib-Shell-related-=
Utilities.html
> > > > > > >=20
> > > > > > >=20
> > > > > > > Though my preference would be to avoid the need to do this at=
 all, by
> > > > > > > not accepting a raw shell command line string in the first pl=
ace.
> > > > > > >
> > > > > > Can you please clarify? Did you mean that it would be better if=
 Qemu somehow
> > > > > > verifies the options and then passes it to a remote process via=
 a message?
> > > > >=20
> > > > > I've not been able to trace the code paths back all the way, so I=
 can't
> > > > > point to where I think needs fixing. I assuming that something, s=
omewhere
> > > > > in this patch series should starts out with a binary name and a l=
ist of argv
> > > > > as an array of char *. ie a "char **argv".  At some point this ar=
ray gets
> > > > > mashed together into a single 'char *' string where all the argv =
are separated
> > > > > by a space. This patch now tries to parse this and turn it back i=
nto a
> > > > > "char **argv" array.
> > > > >=20
> > > > > So my key point is that we should try hard to avoid this intermed=
iate
> > > > > shell command line string stage entirely. Always keep the argv in=
 an array
> > > > > form, and never mash them together such that they then need parsi=
ng again.
> > > > >
> > > > Hi Daniel
> > > >=20
> > > > Thank you for explanation.
> > > > At this point there is no intermediate stage as we grab the argumen=
ts
> > > > as a raw string from the command line option -remote:
> > > >=20
> > > > -remote rid=3D8,exec=3Dqemu-scsi-dev,command=3D"-drive id=3Ddrive_i=
mage2,,file=3D/root/remote-process-disk.img"
> > > >=20
> > > > So the command=3D"" string is being later parsed into the array and=
 remote process
> > > > gets spawned with the "char **argv".
> > > >=20
> > > > Stefan expressed his concern that its not convenient to use due to
> > > > the double escaping commas, spaces, quotes and we do agree with tha=
t.
> > > > We were seeking an advice on what is the better approach.
> > >=20
> > > I've not looked closely enough to understand the range of different
> > > options we need to be able to pass to the remote QEMU ? Is it just
> > > "-drive" options, or can it be absolutely any QEMU option ?
> > >=20
> > > If it is just -drive, then I could imagine a -remote-drive option
> > > such that we end up with with a set of args
> > >=20
> > >    $QEMU \
> > >    -remote rid=3D8,exec=3Dqemu-scsi-dev \
> > >    -remote-drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-proces=
s-disk1.img \
> > >    -remote-drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-proces=
s-disk2.img \
> > >    -remote rid=3D9,exec=3Dqemu-scsi-dev \
> > >    -remote-drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-proces=
s-disk3.img \
> > >    -remote-drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-proces=
s-disk4.img
> > >=20
> > > And this gets turned into 2 execs:
> > >=20
> > >    qemu-scsi-dev \
> > >    -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1=
.img \
> > >    -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2=
.img
> > >   =20
> > >    qemu-scsi-dev \
> > >    -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3=
.img \
> > >    -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4=
.img
> > >=20
> > >=20
> > > Or maybe instead of having a '-remote-drive' arg, we can make the '-d=
rive'
> > > arg take an optional "rid" attribute to associate it with the remote =
process
> > >=20
> > >    $QEMU \
> > >    -remote rid=3D8,exec=3Dqemu-scsi-dev \
> > >    -drive rid=3D8,id=3Ddrive_image1,file=3D/root/remote-process-disk1=
.img \
> > >    -drive rid=3D8,id=3Ddrive_image2,file=3D/root/remote-process-disk2=
.img \
> > >    -remote rid=3D9,exec=3Dqemu-scsi-dev \
> > >    -drive rid=3D9,id=3Ddrive_image3,file=3D/root/remote-process-disk3=
.img \
> > >    -drive rid=3D9,id=3Ddrive_image4,file=3D/root/remote-process-disk4=
.img
> > >=20
> > > When 'rid' is seen, instead of creating a local block backend, the
> > > args get used for the remote process.
> > >=20
> > > This would have the nice user behaviour that you can take an existing
> > > QEMU command line, and turn it into a multi-process command line
> > > simply by adding the '-remote ...' arg, and adding 'rid=3DNN' to
> > > each -drive. Nothing else about your existing command line need
> > > change.
> >=20
> > This does look good, especially unmodified -drive.
> > And -monitor for the remote process could also be similarly added
> > with only rid specified instead of plugging it into the raw string.
> >=20
> > Stefan did mention in the another patch that he thinks that adding
> > -remote option is too invasive and suggested using -object itself
> > to further separate remote process devices.
> >=20
> > So to compile both replies, the command line for the remote process
> > will look something like this:
> >=20
> >=20
> > -object remote-device,id=3Drid0,exec=3Dqemu-scsi-dev \
> > -device remote-pci-device,id=3Dscsi0,remote-device=3Drid0 \
> > -device scsi-hd,drive=3Ddrive_image1,bus=3Dscsi0.0,scsi-id=3D0,remote-d=
evice=3Drid0 \
> > -drive id=3Ddrive_image3,file=3D/root/remote-process-disk3.img,remote-d=
evice=3Drid0 \
> > -drive id=3Ddrive_image4,file=3D/root/remote-process-disk4.img,remote-d=
evice=3Drid0 \
> > -monitor unix:/home/qmp-sock,,server,,nowait,remote-device=3Drid0
> >=20
> > And in experimental version we imply that remote-pci-device is the LSI =
controller.
> > For vfio-over-socket it will represent any remote PCI device.
> >=20
> > What your thoughts on this?
>=20
> Looks like a reasonable idea to me. I guess I'm not sure how much the blo=
ck
> maintainers will like having a -drive additional property. Probably depen=
ds
> how much it impacts the code paths processing it.

Not all of the remote program's command-line options may be known to
QEMU, so passing through just a few options like -drive does not fix the
problem.

I suggest just providing the arguments as a single string parameter like
this patch series already does, but make sure to consider the escaping
rules for commas and other special characters.

Stefan

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ieWoACgkQnKSrs4Gr
c8hW/QgAlWQOblJkxxSbftBvh4unD2o4k1mF+2zs8G5uSCpRhP+QtV18ZHJG3NQk
vi+bTCce0hTJQAV9v+9bb70m6VGb+lMtTRhzRRPE14pZZZOWLtCRiLEsFVlXS64l
iseGTFEVZTvBJWxClA4fT1slZUkvqctN6Fdi3SM4w0AZHzpCGDvZMQnJyJ4o/mM4
HF2+dHajEaagBc6JcOXcMUcxUlhyiJAsUrH/DBXWCVjyrP4vqKg7pdaKfmCh8wL3
eyyElYyZTQNTAirRg/Prw4WgZ75Ez1THbK1Ya3kLsS+k8nX55NSdtCEMRy7LCGDm
6sQOgGe4VkWWbF+5fu2yAEDLBtIzrw==
=OtnH
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--


