Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A2FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2969D208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnbHy6fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2969D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8tlm-0002G6-As
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 17:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j8tl9-0001qM-PJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j8tl8-0001P6-7J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:41:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j8tl7-0001Mw-UE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:41:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022McQxB142229;
 Mon, 2 Mar 2020 22:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=kQ7LqmKQUok8TUNZ/jtm/a0iuAtZVP/KiSTZ282Xyq0=;
 b=fnbHy6fZhGOdTpkoDDk7ZwyA9jaklRXTDyEIk0Y0QOz6A+E1vhn0zcVvLW+FX2S4rn7T
 KTWX4SKr4/GN+aIyWzZg39j4T7yufdesREszNmbQhlM4dkYRSxayZ6CDpSwJnX8IRqgD
 8l7r75nna2s23Lkk0ganDh/nSv/kQN56zIV12JCT0VHngEeB0r5b54BYWdrn+qmUkU9O
 kDG2hkaLZxLS+BCvi5ZDu4CCwhFh41FNXXLJMXm7wQCZUptFzDwA6q518qKqqsgUM5O1
 soCzFP/qrPo5Hq54/P2R460JjVKMXVGaCRNAqf5OAqdwk0PGjJ0z3x6jbdYGPMVZpiSA 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yffwqjw5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 22:41:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022McPSU169312;
 Mon, 2 Mar 2020 22:39:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yg1p2t40a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 22:39:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 022MdfCf017518;
 Mon, 2 Mar 2020 22:39:41 GMT
Received: from flaka (/174.244.65.58) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Mar 2020 14:39:41 -0800
Date: Mon, 2 Mar 2020 14:39:37 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200302223937.GA29775@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
 <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
 <20200302174745.GP1679990@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302174745.GP1679990@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020147
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 022McQxB142229
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

On Mon, Mar 02, 2020 at 05:47:45PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 02, 2020 at 06:36:13PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > typo "multi" in patch subject.
> >
Thank Philippe, will fix.
=20
> > On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > >=20
> > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > ---
> > >   v4 -> v5:
> > >    - Added "exec" suboption to get the executable's name
> > >    - Addressed feedback about variable names
> > >    - Removed redundant check for spawning a process
> > >=20
> > >   hw/proxy/qemu-proxy.c         | 68 ++++++++++++++++++++++++++++++=
+++----------
> > >   include/hw/proxy/qemu-proxy.h |  2 +-
> > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > > index 828bbd7..d792e86 100644
> > > --- a/hw/proxy/qemu-proxy.c
> > > +++ b/hw/proxy/qemu-proxy.c
> > > @@ -19,19 +19,50 @@
> > >   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> > > +static int add_argv(char *opts_str, char **argv, int argc)
> > > +{
> > > +    int max_args =3D 64;
> > > +
> > > +    if (argc < max_args - 1) {
> > > +        argv[argc++] =3D opts_str;
> > > +        argv[argc] =3D 0;
> > > +    } else {
> > > +        return 0;
> > > +    }
> > > +
> > > +    return argc;
> > > +}
> > > +
> > > +static int make_argv(char *opts_str, char **argv, int argc)
> > > +{
> > > +    int max_args =3D 64;
> > > +
> > > +    char *p2 =3D strtok(opts_str, " ");
> > > +    while (p2 && argc < max_args - 1) {
> > > +        argv[argc++] =3D p2;
> > > +        p2 =3D strtok(0, " ");
> > > +    }
> > > +    argv[argc] =3D 0;
> >=20
> > Is there a GLib function to do that?
>

Hi Daniel

> g_shell_parse_argv() perhaps
>

Thanks for the suggestion.

>   https://developer.gnome.org/glib/stable/glib-Shell-related-Utilities.=
html
>=20
>=20
> Though my preference would be to avoid the need to do this at all, by
> not accepting a raw shell command line string in the first place.
>
Can you please clarify? Did you mean that it would be better if Qemu some=
how
verifies the options and then passes it to a remote process via a message=
?

Thanks!

Elena
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

