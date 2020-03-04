Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCDAC3F2D7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA00922522
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ns7S5813"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA00922522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9WrB-0007EN-P2
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 11:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j9WqW-0006n2-TT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j9WqV-0004pj-6p
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:26:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j9WqU-0004n9-T8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 11:26:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024GNsnO148722;
 Wed, 4 Mar 2020 16:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=bV0/PrnWmwr4lxRERzEyvHtGMR/UeSAlij8UGl9AW+c=;
 b=ns7S5813s1cWXALPgwJaAktEVN8RsEGRSvffCL8B96xxdv6Hqpnlvj6Fq4Fq/M5xt6BG
 Re+uwNaLjSei+bRnIHzLAJK72a7cW4LPMNNx4LcTRokO4KcPgB9FuT/vGRJX3xdIDdID
 4uAJDPhWJB7oRc4RoiCdTPrm9vDpCZm1h60OnGihbGN4Bg53dedw1jJMtaj49lPCT0w0
 JTASO2MMJWNbVVzOI+dbRG6bw7bAKX79Ksd+bVBdl7dR/dNYBEPf/MqBHng/i93u9GAM
 xVYYHXcaHBNxaIpDi2N4talkIQFFSaV4mMUtLnSEewJD5INwb+fr+ejOuSwf1h3MUy9q AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2yffcuqfwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 16:25:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024GCwLh191464;
 Wed, 4 Mar 2020 16:25:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yg1rrexkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 16:25:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024GPdgS011692;
 Wed, 4 Mar 2020 16:25:39 GMT
Received: from flaka (/174.244.65.58) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 08:25:38 -0800
Date: Wed, 4 Mar 2020 08:25:34 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200304162533.GA314@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
 <20200302174745.GP1679990@redhat.com>
 <20200302223937.GA29775@flaka>
 <20200304110032.GA1851428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304110032.GA1851428@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040119
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 024GNsnO148722
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

On Wed, Mar 04, 2020 at 11:00:32AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 02, 2020 at 02:39:37PM -0800, Elena Ufimtseva wrote:
> > On Mon, Mar 02, 2020 at 05:47:45PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > > typo "multi" in patch subject.
> > > >
> > Thank Philippe, will fix.
> > =20
> > > > On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > > > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > >=20
> > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > ---
> > > > >   v4 -> v5:
> > > > >    - Added "exec" suboption to get the executable's name
> > > > >    - Addressed feedback about variable names
> > > > >    - Removed redundant check for spawning a process
> > > > >=20
> > > > >   hw/proxy/qemu-proxy.c         | 68 ++++++++++++++++++++++++++=
+++++++----------
> > > > >   include/hw/proxy/qemu-proxy.h |  2 +-
> > > > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > > > > index 828bbd7..d792e86 100644
> > > > > --- a/hw/proxy/qemu-proxy.c
> > > > > +++ b/hw/proxy/qemu-proxy.c
> > > > > @@ -19,19 +19,50 @@
> > > > >   static void pci_proxy_dev_realize(PCIDevice *dev, Error **err=
p);
> > > > > +static int add_argv(char *opts_str, char **argv, int argc)
> > > > > +{
> > > > > +    int max_args =3D 64;
> > > > > +
> > > > > +    if (argc < max_args - 1) {
> > > > > +        argv[argc++] =3D opts_str;
> > > > > +        argv[argc] =3D 0;
> > > > > +    } else {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    return argc;
> > > > > +}
> > > > > +
> > > > > +static int make_argv(char *opts_str, char **argv, int argc)
> > > > > +{
> > > > > +    int max_args =3D 64;
> > > > > +
> > > > > +    char *p2 =3D strtok(opts_str, " ");
> > > > > +    while (p2 && argc < max_args - 1) {
> > > > > +        argv[argc++] =3D p2;
> > > > > +        p2 =3D strtok(0, " ");
> > > > > +    }
> > > > > +    argv[argc] =3D 0;
> > > >=20
> > > > Is there a GLib function to do that?
> > >
> >=20
> > Hi Daniel
> >=20
> > > g_shell_parse_argv() perhaps
> > >
> >=20
> > Thanks for the suggestion.
> >=20
> > >   https://developer.gnome.org/glib/stable/glib-Shell-related-Utilit=
ies.html
> > >=20
> > >=20
> > > Though my preference would be to avoid the need to do this at all, =
by
> > > not accepting a raw shell command line string in the first place.
> > >
> > Can you please clarify? Did you mean that it would be better if Qemu =
somehow
> > verifies the options and then passes it to a remote process via a mes=
sage?
>=20
> I've not been able to trace the code paths back all the way, so I can't
> point to where I think needs fixing. I assuming that something, somewhe=
re
> in this patch series should starts out with a binary name and a list of=
 argv
> as an array of char *. ie a "char **argv".  At some point this array ge=
ts
> mashed together into a single 'char *' string where all the argv are se=
parated
> by a space. This patch now tries to parse this and turn it back into a
> "char **argv" array.
>=20
> So my key point is that we should try hard to avoid this intermediate
> shell command line string stage entirely. Always keep the argv in an ar=
ray
> form, and never mash them together such that they then need parsing aga=
in.
>
Hi Daniel

Thank you for explanation.
At this point there is no intermediate stage as we grab the arguments
as a raw string from the command line option -remote:

-remote rid=3D8,exec=3Dqemu-scsi-dev,command=3D"-drive id=3Ddrive_image2,=
,file=3D/root/remote-process-disk.img"

So the command=3D"" string is being later parsed into the array and remot=
e process
gets spawned with the "char **argv".

Stefan expressed his concern that its not convenient to use due to
the double escaping commas, spaces, quotes and we do agree with that.
We were seeking an advice on what is the better approach.

Few things we discussed internally is to have the remote drive
command line options passed over by messages or using QMP.

Thank you!
Elena


> I understand this is probably more complex, because we're having to pas=
s
> this across processes, via QemuOpts IIUC, but I still believe it is imp=
ortant
> to have this data kept in array format if at all practical.
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

