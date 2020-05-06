Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FABC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8242073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ngeba1Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8242073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGux-0002nC-9z
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWGjK-0000n0-I9; Wed, 06 May 2020 05:52:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWGjI-0005GE-MK; Wed, 06 May 2020 05:52:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0469nExg010611;
 Wed, 6 May 2020 09:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : subject : from
 : to : cc : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xNte2sPIQONrxMh4kopWLxS/WxObBHFeLrhWpVIZ1YE=;
 b=Ngeba1KnYnERQDQyzeDl6m7lFJY9K1a7+T3AI2vTZZDF7lFrWdro3XlsbV1ZXlHjAlxi
 N3lrEtt+c2DCjP2VG9TC2oJqfMUuI9Q/4kXzGXREYSX2kTAgpXv4U+QzYRm45UC66L6k
 yr2tN26SSyY/ITFA3aOOXVY2CbU38qQFgx1iLCkuPMTI/QRFeYW0HJyscaNIjKw3UDVf
 NUMWMrUck0qYPHYo8y83ATuvT8WKJrQBcrKDLXAUUR85WINsp5WkPtV+mImQHj+B0w98
 fvoGnpuVFghhzSSmCVrwNLwyehSXvp8hIsWvZs+M6Vo2Qc7+GpsdEniKDk3U9Tig2QNu sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30usgq0guj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 09:52:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0469pjpe061162;
 Wed, 6 May 2020 09:52:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30t1r7ctex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 09:52:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0469qXNw032165;
 Wed, 6 May 2020 09:52:33 GMT
Received: from [10.74.121.227] (/10.74.121.227)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 02:52:33 -0700
User-Agent: Microsoft-MacOutlook/10.1e.0.191013
Date: Wed, 06 May 2020 12:52:22 +0300
Subject: Re: [PATCH 2/2] qemu-img: Add --start-offset and --max-length to map
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: Eric Blake <eblake@redhat.com>, <qemu-devel@nongnu.org>
Message-ID: <D5701B9A-BC36-4F70-BE80-D4BC4D6B4DA5@oracle.com>
Thread-Topic: [PATCH 2/2] qemu-img: Add --start-offset and --max-length to map
References: <20200322091117.79443-1-eyal.moscovici@oracle.com>
 <20200322091117.79443-3-eyal.moscovici@oracle.com>
 <30f82564-3807-89d4-e7b1-923868f15705@redhat.com>
In-Reply-To: <30f82564-3807-89d4-e7b1-923868f15705@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060076
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eyal.moscovici@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:52:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_QP_LONG_LINE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com,
 Yoav Elnekave <yoav.elnekave@oracle.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the review. I will send V2 based on QEMU version 5.0.

=EF=BB=BFOn 29/04/2020, 18:06, "Eric Blake" <eblake@redhat.com> wrote:

    On 3/22/20 4:11 AM, Eyal Moscovici wrote:
    > The mapping operation of large disks especially ones stored over a
    > long chain of QCOW2 files can take a long time to finish.
    > Additionally when mapping fails there was no way recover by
    > restarting the mapping from the failed location.
    >=20
    > The new options, --start-offset and --max-length allows the user to
    > divide these type of map operations into shorter independent tasks.
    >=20
    > Acked-by: Mark Kanda <mark.kanda@oracle.com>
    > Co-developed-by: Yoav Elnekave <yoav.elnekave@oracle.com>
    > Signed-off-by: Yoav Elnekave <yoav.elnekave@oracle.com>
    > Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
    > ---
    >   docs/tools/qemu-img.rst |  2 +-
    >   qemu-img-cmds.hx        |  4 ++--
    >   qemu-img.c              | 30 +++++++++++++++++++++++++++++-
    >   3 files changed, 32 insertions(+), 4 deletions(-)
    >=20
    > diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
    > index 0080f83a76..924e89f679 100644
    > --- a/docs/tools/qemu-img.rst
    > +++ b/docs/tools/qemu-img.rst
    > @@ -519,7 +519,7 @@ Command description:
    >       ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCo=
w2``
    >       for qcow2 images).
    >  =20
    > -.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--outp=
ut=3DOFMT] [-U] FILENAME
    > +.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--star=
t-offset=3Doffset] [--max-length=3Dlen] [--output=3DOFMT] [-U] FILENAME
   =20
    Consistency with the rest of the line says this should be=20
    [--start-offset=3DOFFSET] [--max-length=3DLEN]

Will fix.
   =20
    >  =20
    >     Dump the metadata of image *FILENAME* and its backing file chain.
    >     In particular, this commands dumps the allocation state of every =
sector
    > diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
    > index c9c54de1df..35f832816f 100644
    > --- a/qemu-img-cmds.hx
    > +++ b/qemu-img-cmds.hx
    > @@ -63,9 +63,9 @@ SRST
    >   ERST
    >  =20
    >   DEF("map", img_map,
    > -    "map [--object objectdef] [--image-opts] [-f fmt] [--output=3Dofmt=
] [-U] filename")
    > +    "map [--object objectdef] [--image-opts] [-f fmt] [--start-offse=
t=3Doffset] [--max-length=3Dlen] [--output=3Dofmt] [-U] filename")
   =20
    this one is fine,
   =20
    >   SRST
    > -.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--outp=
ut=3DOFMT] [-U] FILENAME
    > +.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--star=
t-offset=3DOFFSET] [--max-length=3DLEN] [--output=3DOFMT] [-U] FILENAME
   =20
    this one has the same problem as the .rst.
   =20
    > @@ -3005,6 +3009,26 @@ static int img_map(int argc, char **argv)
    >           case OPTION_OUTPUT:
    >               output =3D optarg;
    >               break;
    > +        case 's':
    > +            start_offset =3D cvtnum(optarg);
    > +            if (start_offset < 0) {
    > +                error_report("Invalid start offset specified! You ma=
y use "
    > +                             "k, M, G, T, P or E suffixes for ");
    > +                error_report("kilobytes, megabytes, gigabytes, terab=
ytes, "
    > +                             "petabytes and exabytes.");
   =20
    Pre-existing elsewhere in the file, but this seems rather verbose -=20
    shouldn't we have cvtnum() (or another wrapper function) give this extr=
a=20
    information about what is valid, rather than open-coding it at every=20
    client of cvtnum()?

You are probably right I will send a patch that adds the error message  abo=
ut the units to cvtnum().
   =20
    > +                return 1;
    > +            }
    > +            break;
    > +        case 'l':
    > +            max_length =3D cvtnum(optarg);
    > +            if (max_length < 0) {
    > +                error_report("Invalid max length specified! You may =
use "
    > +                             "k, M, G, T, P or E suffixes for ");
    > +                error_report("kilobytes, megabytes, gigabytes, terab=
ytes, "
    > +                             "petabytes and exabytes.");
    > +                return 1;
    > +            }
    > +            break;
    >           case OPTION_OBJECT: {
    >               QemuOpts *opts;
    >               opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
    > @@ -3050,7 +3074,11 @@ static int img_map(int argc, char **argv)
    >           printf("[");
    >       }
    >  =20
    > +    curr.start =3D start_offset;
    >       length =3D blk_getlength(blk);
    > +    if (max_length !=3D -1) {
    > +        length =3D MIN(start_offset + max_length, length);
    > +    }
   =20
    Pre-existing, but where does this code check for length =3D=3D -1?  But you=
r=20
    MIN() doesn't make it any worse (if we fail to get length, we merely=20
    skip the loop).

I don't think there is a check. I will add a check in a different patch.
   =20
    >       while (curr.start + curr.length < length) {
    >           int64_t offset =3D curr.start + curr.length;
    >           int64_t n;
    >=20
   =20
    Overall, the idea makes sense to me.  But I'm not sure which maintainer=
=20
    should actually incorporate the patch.
   =20
    Reviewed-by: Eric Blake <eblake@redhat.com>
   =20
    --=20
    Eric Blake, Principal Software Engineer
    Red Hat, Inc.           +1-919-301-3226
    Virtualization:  qemu.org | libvirt.org
   =20
   =20



