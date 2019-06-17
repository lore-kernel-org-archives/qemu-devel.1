Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF27C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5852064A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="domf7q0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5852064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcmDh-0005Re-3a
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 03:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hcmCa-0004wH-0B
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 03:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hcmCY-00025k-Pk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 03:37:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hcmCV-0001zC-Vu; Mon, 17 Jun 2019 03:37:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H7XYYJ118874;
 Mon, 17 Jun 2019 07:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=VI+qSJCX5VHnkHspCUjFA1ItEg5AGL/pVoQlaFCMcVE=;
 b=domf7q0yphoFtA63Qxw59jc208zIOgiXmmLlJ6oLltuGYPZwXpK9HReJ9VMl306p1COm
 fdswF4phLBK3k22pqUQtIwmhF0eQ3/exmT584ekZsRhvynDtYTIeERB9v7BLiFLDb3Qa
 amVJmzFELDPQmVpmt1PdFBWV4EsoHeF7bGgte18TVTpU6lkdwolW2YzW5wZGV5wnhLnZ
 n6+JFM6HT+sJN9AfSPhgGbXYQCtX81PStS7NvzHyiywiFPsC+CKpL5OoGU6VpbDMMIBR
 demI+USILcyuD/hf5kjWf5WGPXcfzZ3BtXfcVqYnuZheSoJnIJ4/65uL/92TqL0PennO bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmnvtfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 07:37:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H7b3CO082071;
 Mon, 17 Jun 2019 07:37:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t05x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 07:37:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5H7axiB006412;
 Mon, 17 Jun 2019 07:37:00 GMT
Received: from [10.0.5.157] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 00:36:59 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190617072040.yriunmoffbjhvqc5@sirius.home.kraxel.org>
Date: Mon, 17 Jun 2019 10:36:54 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECEA4896-C290-45A7-9574-D1704C63842C@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612115939.23825-8-shmuel.eiderman@oracle.com>
 <20190617072040.yriunmoffbjhvqc5@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 7/8] bootdevice: FW_CFG interface
 for LCHS values
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



> On 17 Jun 2019, at 10:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> We serialize this information in a similar way to the "bootorder"
>> interface.
>> The fw_cfg entry is "bootdevices" and it serializes a struct.
>=20
> Why "bootdevices"?  I'd suggest to use "geometry" or "lchs" instead.

True, if we don=E2=80=99t think an extension will be required in the =
future we might
as well call it =E2=80=9Clchs" or "bios-geometry=E2=80=9D.

>=20
>> At the moment the struct holds the values of logical CHS values but =
it
>> can be expanded easily due to the extendable ABI implemented.
>>=20
>> (In the future, we can pass the bootindex through "bootdevices" =
instead
>> "bootorder" - unifying all bootdevice information in one fw_cfg =
value)
>=20
> I don't think deprecating bootorder is useful.  Nobody cares about the
> disk geometry, except some legacy x86 bios guests.  So seabios will be
> the only firmware using this new interface.  Switching all firmware to =
a
> new fw_cfg file is pointless churn.
>=20
> Why make this extendable?  What possible extensions do you have in =
mind?

I=E2=80=99m not sure about this but if =E2=80=9Cbootorder=E2=80=9D was =
written in the first place using
such an extension this could have been useful.
I don=E2=80=99t have anything specific in mind.
I don=E2=80=99t think deprecating bootorder is useful either, just =
mentioned that it
will be possible if we would like to unify all disk values someday.

>=20
> Also note that with a possible extension you might end up in a =
situation
> where you have info A for device 1 and info B for device 2 and info =
A+B
> for device 3 while with your current patch there is no way to signal
> whenever info A or B is available for a given device.

Well for lchs (A) a non-existing value is 0, 0, 0 (uint32).
So at the moment we=E2=80=99re good.
We can signal other values with other magic numbers (such as -1 for =
bootorder)
or prefix the value with an additional boolean value =E2=80=9Cis =
signaled=E2=80=9D.

>=20
>> +/* Serialized as: struct size (4) + (device name\0 + device struct) =
x devices */
>> +char *get_boot_devices_info(size_t *size)
>> +{
>> +    FWLCHSEntry *i;
>> +    BootDeviceEntrySerialized s;
>> +    size_t total =3D 0;
>> +    char *list =3D NULL;
>=20
> if (QTAILQ_EMPTY(&fw_lchs)) {
> 	return NULL;
> }
>=20
>> +    if (!mc->legacy_fw_cfg_order) {
>                ^^^^^^^^^^^^^^^^^^^
> Hmm?

Only making this available in non-legacy mode.
Qemu complains in get_fw_cfg_order() (fw_cfg.c):

	warn_report("Unknown firmware file in legacy mode: %s", name);

Detected during qtests.


So overall, WDYT?
Keep it extendible for a low price of ABI + =E2=80=9Cbootdevices=E2=80=9D =
name.
Or go strict and rename to =E2=80=9Cbios-geometries=E2=80=9D?

(The ABI will not change too much anyway, the struct_size will disappear
and sizeof(12) struct of LCHS will be assumed)

Sam

>=20
> cheers,
>  Gerd
>=20


