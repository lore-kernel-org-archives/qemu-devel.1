Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95FC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D8620658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQV2nkke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D8620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMkl-0002xb-Gk
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1jGMjR-0002RG-Bt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1jGMjJ-0000yG-Pl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:03:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1jGMjJ-0000wC-H3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:02:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NCx9CK025915;
 Mon, 23 Mar 2020 13:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=references : from :
 to : cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BrPx09eJhBssdP5COR5sv41Rt6oriU1XVbT4OdiDkSA=;
 b=VQV2nkkeKdRnvrCFLD/MM+gXUFJ3Am6wY7IpGmIoRfcIiojYETgfV8/Pkg/8KnMprF/f
 NRD2uDiLKS3fSSUPicveJhtVBFE91W2LeQWJSt3k+Id9e7vJbZwWFqjXGtbscbntlxVR
 Ln2nzCKle8yHWfOum5ciNEvwVL2Ax3P90Bj9bD0xsYlBHEei2b++58PtiQwu5g4/+qbf
 6hrom7csQRXitf/bjWum4705gSnhmr9XLwYun8Ysbmy5no/SdZU6cQntIa4ozTLZ5uFh
 ruSyAkIg/W+V8Qaka2CyKvkR0jVWpZqLCgDBz+NwGQ0dxycS2r2s3eONmCr4q5vlmhNy 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ywabqxdxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 13:02:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NCvdSQ132339;
 Mon, 23 Mar 2020 13:02:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yxw7fa81n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 13:02:53 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ND2ral023673;
 Mon, 23 Mar 2020 13:02:53 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 23 Mar 2020 06:02:52 -0700
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with ESMTP id B5BD0609052A;
 Mon, 23 Mar 2020 13:02:47 +0000 (GMT)
References: <20200322161219.17757-1-philmd@redhat.com>
User-agent: mu4e 1.2.0; emacs 27.0.90
From: Darren Kenny <darren.kenny@oracle.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH-for-5.0] ui/input-linux: Do not ignore ioctl() return value
In-reply-to: <20200322161219.17757-1-philmd@redhat.com>
Date: Mon, 23 Mar 2020 13:02:47 +0000
Message-ID: <m2eetjcjgo.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=1 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230075
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 writes:

> Fix warnings reported by Clang static code analyzer:
>
>     CC      ui/input-linux.o
>       ui/input-linux.c:343:9: warning: Value stored to 'rc' is never read
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relmap=
);
>           ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       ui/input-linux.c:351:9: warning: Value stored to 'rc' is never read
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap=
);
>           ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       ui/input-linux.c:354:13: warning: Value stored to 'rc' is never read
>               rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
>               ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       ui/input-linux.c:357:13: warning: Value stored to 'rc' is never read
>               rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
>               ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       ui/input-linux.c:365:9: warning: Value stored to 'rc' is never read
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap);
>           ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       ui/input-linux.c:366:9: warning: Value stored to 'rc' is never read
>           rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
>           ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  ui/input-linux.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index a7b280b25b..ef37b14d6f 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -334,13 +334,15 @@ static void input_linux_complete(UserCreatable *uc,=
 Error **errp)
>=20=20
>      rc =3D ioctl(il->fd, EVIOCGBIT(0, sizeof(evtmap)), &evtmap);
>      if (rc < 0) {
> -        error_setg(errp, "%s: failed to read event bits", il->evdev);
> -        goto err_close;
> +        goto err_read_event_bits;
>      }
>=20=20
>      if (evtmap & (1 << EV_REL)) {
>          relmap =3D 0;
>          rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relmap);
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>          if (relmap & (1 << REL_X)) {
>              il->has_rel_x =3D true;
>          }
> @@ -349,12 +351,25 @@ static void input_linux_complete(UserCreatable *uc,=
 Error **errp)
>      if (evtmap & (1 << EV_ABS)) {
>          absmap =3D 0;
>          rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap);
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>          if (absmap & (1 << ABS_X)) {
>              il->has_abs_x =3D true;
>              rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
> +            if (rc < 0) {
> +                error_setg(errp, "%s: failed to get get absolute X value=
",
> +                           il->evdev);
> +                goto err_close;
> +            }
>              il->abs_x_min =3D absinfo.minimum;
>              il->abs_x_max =3D absinfo.maximum;
>              rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
> +            if (rc < 0) {
> +                error_setg(errp, "%s: failed to get get absolute Y value=
",
> +                           il->evdev);
> +                goto err_close;
> +            }
>              il->abs_y_min =3D absinfo.minimum;
>              il->abs_y_max =3D absinfo.maximum;
>          }
> @@ -363,7 +378,14 @@ static void input_linux_complete(UserCreatable *uc, =
Error **errp)
>      if (evtmap & (1 << EV_KEY)) {
>          memset(keymap, 0, sizeof(keymap));
>          rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap);
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>          rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
> +        if (rc < 0) {
> +            error_setg(errp, "%s: failed to get global key state", il->e=
vdev);
> +            goto err_close;
> +        }
>          for (i =3D 0; i < KEY_CNT; i++) {
>              if (keymap[i / 8] & (1 << (i % 8))) {
>                  if (linux_is_button(i)) {
> @@ -390,6 +412,9 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
>      il->initialized =3D true;
>      return;
>=20=20
> +err_read_event_bits:
> +    error_setg(errp, "%s: failed to read event bits", il->evdev);
> +
>  err_close:
>      close(il->fd);
>      return;


