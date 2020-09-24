Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15071C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF14212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="msoKs9mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF14212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRyd-00005e-Ql
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLRwq-0006kT-At; Thu, 24 Sep 2020 10:10:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLRwn-0001L7-VR; Thu, 24 Sep 2020 10:10:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08OE2POb021727; Thu, 24 Sep 2020 10:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=CdVjKfKvUT64WRt79Q8UFmeZpAXQnilOuwjpHg/OGAw=;
 b=msoKs9mMSsJRy0DFh3ZZBuLb2l9/De1+pY1xXEeMv7wLHeskAFJgbXjkbGV7/xjrcZxX
 RxJyWpugifv3Rc22BoycUm2icD4hk05bsLpecVqpAFgTqyVi4bfrpui5EIFjpwxuSz7H
 /2I1hsBs5Ss6yisGLxUG5H3Qu8lKKaEJXEPfsadDIM5UuwlMsm2hXb9uSJi9JaErJOCW
 w1M6bxWzsgKG9Wk3NAJo/9th12vaLBvMmNk6vYObMNpyM+2M6uLbsjTvfXwHj81CZX2Z
 pQffdbdmjLLXwid9mWPeUmYAOWt2Epmz2ClKFcgI8oIbHJlFBoaA4tkWtocYfaFNfB2k lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rvur8cc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 10:10:07 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08OE3Ywh026980;
 Thu, 24 Sep 2020 10:10:06 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rvur8cae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 10:10:06 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08OE9AAd011009;
 Thu, 24 Sep 2020 14:10:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 33p1f3ta12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 14:10:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08OEA1oF32113070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 14:10:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21D58AE056;
 Thu, 24 Sep 2020 14:10:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9593AE051;
 Thu, 24 Sep 2020 14:10:00 +0000 (GMT)
Received: from marcibm (unknown [9.145.161.105])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 24 Sep 2020 14:10:00 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] pc-bios/s390-ccw: fix off-by-one error
In-Reply-To: <1382e6fb-4af4-00ff-958a-c109cadfad43@redhat.com>
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
 <20200924085926.21709-2-mhartmay@linux.ibm.com>
 <1382e6fb-4af4-00ff-958a-c109cadfad43@redhat.com>
Date: Thu, 24 Sep 2020 16:09:59 +0200
Message-ID: <87o8lvnu4o.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-24_08:2020-09-24,
 2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240102
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Janosch Frank <frankja@linux.ibm.com>, "Collin L.
 Walling" <walling@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 12:02 PM +0200, Philippe Mathieu-Daud=C3=A9 <philmd=
@redhat.com> wrote:
> Hi Marc,
>
> On 9/24/20 10:59 AM, Marc Hartmayer wrote:
>> This error takes effect when the magic value "zIPL" is located at the
>> end of a block. For example if s2_cur_blk =3D 0x7fe18000 and the magic
>> value "zIPL" is located at 0x7fe18ffc - 0x7fe18fff.
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
>> index 97205674e59a..0d29dceaa3cc 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -163,7 +163,7 @@ static bool find_zipl_boot_menu_banner(int *offset)
>>      int i;
>>=20=20
>>      /* Menu banner starts with "zIPL" */
>> -    for (i =3D 0; i < virtio_get_block_size() - 4; i++) {
>> +    for (i =3D 0; i < virtio_get_block_size() - 3; i++) {
>
> Easier to review as:
>
>        for (i =3D 0; i <=3D virtio_get_block_size() - 4; i++) {

Yep.

>
> Even easier defining ZIPL_MAGIC_SIZE instead of the magic '4'.

I thought about adding such a macro as well. Makes even more sense with
your proposed change.

>
>>          if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
>>              *offset =3D i;
>>              return true;
>>=20
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

