Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993ECC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6842C2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v0RdklsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6842C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTh9-000174-Jd
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jxTgG-0000UG-2M; Mon, 20 Jul 2020 07:10:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jxTgD-000143-U5; Mon, 20 Jul 2020 07:09:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KB9lZi057594;
 Mon, 20 Jul 2020 11:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZOMzm1Kxvlis28sH8SEJP1cGp6fTHe5i7/HG9cmAgcU=;
 b=v0RdklsZwfPobasxEZoOaB3Ds3l7BJN9ZEd5s+67GJKt3E2XU/w8CcHccRMp/gmp1OZ2
 Gi6dCIPrvae/xfBUWNsXEs5cKLQfcRSJW7GhdcpSFp7qVCSWSPWB+1YpnUPS6tnkNaZk
 +RjhHN8HVNOZRjnNfYEtFnrH6dRfrVYrE4+8f10waA3dLLkAWQEma4VX0p7SK3d0p2n9
 sOdCngyzw6Oo7i7+D0AFJzNfm+rdBgcTHEexwdm7Pkz5ZmxBXD/7q4KwUi7qtBTB02xn
 jY7kCH2EXUet7dNumXvVU6X4J7nMInfOyOyV5aWzJEDBb5BNB70sFLY/yw6+FG3hAB4W gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 32bpkaxfkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 Jul 2020 11:09:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KAw6MB167381;
 Mon, 20 Jul 2020 11:07:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 32d9wb0p2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2020 11:07:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06KB7jDA023818;
 Mon, 20 Jul 2020 11:07:45 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 20 Jul 2020 04:07:45 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id ACB29CEC2C2; Mon, 20 Jul 2020 12:07:47 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH-for-5.1 v2] hw/ide: Avoid #DIV/0! FPU exception by
 setting CD-ROM sector count
In-Reply-To: <20200717133847.10974-1-f4bug@amsat.org>
References: <20200717133847.10974-1-f4bug@amsat.org>
Date: Mon, 20 Jul 2020 12:07:47 +0100
Message-ID: <m2eep68mws.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200079
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:09:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-07-17 at 15:38:47 +02, Philippe Mathieu-Daud=C3=A9 wrote:
> libFuzzer found an undefined behavior (#DIV/0!) in ide_set_sector()
> when using a CD-ROM (reproducer available on the BugLink):
>
>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
>   =3D=3D12163=3D=3DERROR: UndefinedBehaviorSanitizer: FPE on unknown addr=
ess 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T=
12163)
>
> Fix by initializing the CD-ROM number of sectors in ide_dev_initfn().
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: b2df431407 ("ide scsi: Mess with geometry only for hard disk devic=
es")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1887309
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The changes LGTM, presume the 'shrug' is OK to leave in ;)

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

> ---
> Since v1:
> - Allow zero-sized drive images (not sure why we need them)
>   but display a friendly message that this is unsupported
>
> Unrelated but interesting:
> http://www.physics.udel.edu/~watson/scen103/cdsoln.html
> ---
>  hw/ide/qdev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 27ff1f7f66..005d73bdb9 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -201,6 +201,15 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveK=
ind kind, Error **errp)
>                                errp)) {
>              return;
>          }
> +    } else {
> +        uint64_t nb_sectors;
> +
> +        blk_get_geometry(dev->conf.blk, &nb_sectors);
> +        if (!nb_sectors) {
> +            warn_report("Drive image of size zero is unsupported for 'id=
e-cd', "
> +                        "use at your own risk =C2=AF\\_(=E3=83=84)_/=C2=
=AF");
> +        }
> +        dev->conf.secs =3D nb_sectors;
>      }
>      if (!blkconf_apply_backend_options(&dev->conf, kind =3D=3D IDE_CD,
>                                         kind !=3D IDE_CD, errp)) {
> --=20
> 2.21.3

