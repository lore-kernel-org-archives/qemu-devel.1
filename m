Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E4C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392AB2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C//DTaIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392AB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtLe-00026K-Ct
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdtEK-0003jP-RD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdt1I-0008Qh-SQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:06:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdswS-0003xB-J2; Thu, 20 Jun 2019 05:01:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K8x7M5171103;
 Thu, 20 Jun 2019 09:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=LaeeNML1WYL+wk4WBx6sCx7PDbr7BSO2H5ieMfek64w=;
 b=C//DTaIKA0Cw/yyyBTUcUtw6ZrXqibYRngYBPk2j9BhUrcI8Pu1RDrQD/uoUHhEgIJsn
 NadlqvTSvU9fNOzScio1AdauBq0h6JHF6RxB3IGoERE6APcedJ+w0bwiLOcYjO2oxyCV
 iyW+czSpPedG4YnJd6Fe6Hggab/t5p0WoAJsHBBIUAssegZTDvfqXl66AnVgNZ2futAP
 LImNScTGaj97ofRVCZ0+bPday+vywDFsOOoQmsR39lOUtSp3nQkMfTo85eqkguSP/r7C
 FH31ZoqgfFPMnTdLiHX/BAXxSKwCouIPC2m8pBxSYF+cumTzS8jRSUMgPRr0UB6MH/VV HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t7809fw65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 09:01:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K90VBL119295;
 Thu, 20 Jun 2019 09:01:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t77yp979e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 09:01:10 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5K9183q015647;
 Thu, 20 Jun 2019 09:01:09 GMT
Received: from [10.0.0.38] (/79.180.42.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Jun 2019 01:52:15 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190620054224.hfspxgorpd6mjxca@sirius.home.kraxel.org>
Date: Thu, 20 Jun 2019 11:52:01 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECC27FB9-1975-4C78-9584-BC82BB7FA34B@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-5-shmuel.eiderman@oracle.com>
 <20190620054224.hfspxgorpd6mjxca@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 4/4] geometry: Apply LCHS
 values for boot devices
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 20 Jun 2019, at 8:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>> +static int
>> +overriden_lchs_supplied(struct drive_s *drive)
>> +{
>> +    return drive->lchs.cylinder || drive->lchs.head || =
drive->lchs.sector;
>> +}
>=20
>> +    case TRANSLATION_MACHINE:
>=20
> Hmm, why this name?  Doesn't look intuitive to me.

TRANSLATION_HOST?

>=20
>> +        desc =3D "overriden";
>=20
> I'd name that "host-supplied" or "fw-cfg=E2=80=9D.

=E2=80=9Chost-supplied=E2=80=9D?

>=20
>> +        cylinders =3D drive->lchs.cylinder;
>> +        heads =3D drive->lchs.head;
>> +        if (heads > 255)
>> +            heads =3D 255;
>=20
> I suggest to move these sanity checks to overriden_lchs_supplied(), =
then
> ignore the override altogether when heads or sectors is out of range
> instead of trying to fixup things.

Sounds reasonable.
I=E2=80=99ll rename to host_lchs_supplied()?

WDYT?

>=20
> The other patches look all sane to me.
>=20
> cheers,
>  Gerd
>=20


