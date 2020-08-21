Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF85C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052CC208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oSvl7Y8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052CC208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k92ls-00043Z-8m
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k92l0-0003AB-JS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:50:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24296
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k92ky-0007Kf-6C
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:50:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07L8VriF146671
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 04:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=vNg9iIl8DN105DaQrnQNisPNw22KI9xeLydoMS/zGxo=;
 b=oSvl7Y8/iqXWszlB3B3gYC7R9qb1Rl2UQIi8FZD+dUnABnya0ztEvVlPJ8ztuMQGBs1/
 dY7Q0ka4TbZlL55b2rqoa/x9l9pBTRFeggowLHTAG+m+R8c/ZLA3HV2LrbCkGTucf6QV
 0M/GQho+Q++cPyb7Q0Xk5tza+MonNCReDcq9+e6EC/QSjKjLTAnwnZJIx5TpqAnxB0P1
 V8+43YYzSI5GoHJm1+QxQqL7GqMC1lT+5kFDrk2eHas2+3JtmKzuC1MxsqovhfZlyUP4
 xuR9EM1OAIQRZrA030fbeXjt/F7VMjYnGQe0OWG9TRBojwuXIPWEqwoeiLijFZEGKOmX xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3314ee8ayd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 04:50:37 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07L8lSbh194537
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 04:50:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3314ee8axs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 04:50:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L8nhNb031690;
 Fri, 21 Aug 2020 08:50:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 3304um44dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 08:50:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07L8oX6p29294916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2020 08:50:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD945A404D;
 Fri, 21 Aug 2020 08:50:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 751ADA4040;
 Fri, 21 Aug 2020 08:50:32 +0000 (GMT)
Received: from marcibm (unknown [9.145.60.23])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 21 Aug 2020 08:50:32 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 2/2] libvhost-user: handle endianness as mandated by the
 spec
In-Reply-To: <20200803112626.67f55526.cohuck@redhat.com>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
 <20200730140731.32912-3-mhartmay@linux.ibm.com>
 <20200803112626.67f55526.cohuck@redhat.com>
Date: Fri, 21 Aug 2020 10:50:30 +0200
Message-ID: <87blj4fkmh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-21_06:2020-08-19,
 2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210075
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:50:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 11:26 AM +0200, Cornelia Huck <cohuck@redhat.com> w=
rote:
> On Thu, 30 Jul 2020 16:07:31 +0200
> Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
>
>> Since virtio existed even before it got standardized, the virtio
>> standard defines the following types of virtio devices:
>>=20
>>  + legacy device (pre-virtio 1.0)
>>  + non-legacy or VIRTIO 1.0 device
>>  + transitional device (which can act both as legacy and non-legacy)
>>=20
>> Virtio 1.0 defines the fields of the virtqueues as little endian,
>> while legacy uses guest's native endian [1]. Currently libvhost-user
>> does not handle virtio endianness at all, i.e. it works only if the
>> native endianness matches with whatever is actually needed. That means
>> things break spectacularly on big-endian targets. Let us handle virtio
>> endianness for non-legacy as required by the virtio specification
>> [1].=20
>
> Maybe add
>
> "and fence legacy virtio, as there is no safe way to figure out the
> needed endianness conversions for all cases."

Okay.

>
>> The fencing of legacy virtio devices is done in
>> `vu_set_features_exec`.
>
> Not that I disagree with fencing legacy virtio, but looking at some
> vhost-user* drivers, I'm not sure everything will work as desired for
> those (I might be missing something, though.)
>
> - vhost-user-blk lists VERSION_1 in the supported features, but
>   vhost-user-scsi doesn't... is there some inheritance going on that
>   I'm missing?
> - vhost-user-gpu-pci inherits from virtio-gpu-pci, so I guess it's fine
> - vhost-user-input should also always have been virtio-1
>
> So, has anybody been using vhost-user-scsi and can confirm that it
> still works, or at least can be made to work?

Unfortunately, I don=E2=80=99t have the required hardware :/ Can please any=
body
verify this?

>
>>=20
>> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01=
.html#x1-210003
>>=20
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
>>  1 file changed, 43 insertions(+), 34 deletions(-)
>
> The code change per se LGTM.

Thanks for the feedback!

>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

