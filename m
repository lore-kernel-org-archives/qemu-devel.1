Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66B1212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GlaiRUoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66B1212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRyj-0000FR-00
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLRxk-0007lb-Ne; Thu, 24 Sep 2020 10:11:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9836
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLRxj-0001Z4-29; Thu, 24 Sep 2020 10:11:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08OE1NPR144484; Thu, 24 Sep 2020 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=CCFxlP2dhJyQYLJkDHB3rxUzY43pWUloVph1J1QAgCo=;
 b=GlaiRUoVts6QA+EGUJfINYWBLOmVYIvegidc8arpvzeUpG7p/F7Aj0cuT2dZgV0XcXhp
 jZerZbU00o3Q5wQgVbN4jXGlnQYJyaeZQQYsuiX/ibzJbSNRquJSuUYrRm98ElGZ2naZ
 mT7+VzyEBEPuiiyDdDdyyJLrdwAzuD+ShQSyoprkDrPJpT4ll8vSugSihqh0hTkw2C7d
 xugp8xPZWrRidxJ4+nSe+w/VUNsNZaO2Yjvl1DxIv7A+5tDxYi5lI7NUsqvhNLWxakJI
 pY6Uy6Jdu0ujtQVnfRBt7k66oQVMfs/WQTpvolX/OzVwLxF93oFmXCEJy3WYh4hyLihn pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33rvs8rkky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 10:11:05 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08OE1bY1146085;
 Thu, 24 Sep 2020 10:11:04 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33rvs8rkjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 10:11:04 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08OE8PkK011383;
 Thu, 24 Sep 2020 14:11:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 33n98gwb36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 14:11:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08OEAxEg16777534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 14:11:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6CFF52065;
 Thu, 24 Sep 2020 14:10:59 +0000 (GMT)
Received: from marcibm (unknown [9.145.161.105])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 76CBD52051;
 Thu, 24 Sep 2020 14:10:59 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] pc-bios/s390-ccw: break loop if a null block number
 is reached
In-Reply-To: <e5067875-2c38-a114-5752-926c208dedb2@redhat.com>
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
 <20200924085926.21709-3-mhartmay@linux.ibm.com>
 <e5067875-2c38-a114-5752-926c208dedb2@redhat.com>
Date: Thu, 24 Sep 2020 16:10:59 +0200
Message-ID: <87lfgznu30.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-24_08:2020-09-24,
 2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=1 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009240102
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:11:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Janosch Frank <frankja@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 01:49 PM +0200, Thomas Huth <thuth@redhat.com> wrot=
e:
> On 24/09/2020 10.59, Marc Hartmayer wrote:
>> Break the loop if `cur_block_nr` is a null block number because this
>> means that the end of chunk is reached. In this case we will try to
>> boot the default entry.
>>=20
>> Fixes: ba831b25262a ("s390-ccw: read stage2 boot loader data to find men=
u")
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 0d29dceaa3cc..08f16c5595a3 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -192,7 +192,7 @@ static int eckd_get_boot_menu_index(block_number_t s=
1b_block_nr)
>>      for (i =3D 0; i < STAGE2_BLK_CNT_MAX; i++) {
>>          cur_block_nr =3D eckd_block_num(&s1b->seek[i].chs);
>>=20=20
>> -        if (!cur_block_nr) {
>> +        if (!cur_block_nr || is_null_block_number(cur_block_nr)) {
>>              break;
>>          }
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> I'll queue the two patches on my s390-ccw bios branch. Just let me know
> if you'd like to have the "< ... - 3" changed into "<=3D ... - 4" in the
> first patch, I can tweak it directly if you like.

Yes, please change it to <=3D =E2=80=A6 - 4. Thanks!

>
>  Thomas
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

