Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623D8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3554B2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3554B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLL2-0002df-BI
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mhartmay@linux.ibm.com>) id 1iaJ9z-0006UI-6d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mhartmay@linux.ibm.com>) id 1iaJ9u-0008VH-Sq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:44:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mhartmay@linux.ibm.com>)
 id 1iaJ9u-0008Qf-Ig
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:44:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASCgwiO060820
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 07:44:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whmt0njpj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 07:44:33 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mhartmay@linux.ibm.com>;
 Thu, 28 Nov 2019 12:44:31 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 12:44:27 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xASChk4w41746848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 12:43:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B7204C052;
 Thu, 28 Nov 2019 12:44:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4D734C040;
 Thu, 28 Nov 2019 12:44:25 +0000 (GMT)
Received: from marcibm (unknown [9.152.224.228])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Nov 2019 12:44:25 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
In-Reply-To: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
Date: Thu, 28 Nov 2019 13:44:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19112812-0028-0000-0000-000003C11C48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112812-0029-0000-0000-0000248426F4
Message-Id: <87lfs09nmq.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=1 mlxscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280112
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Thu, 28 Nov 2019 09:21:54 -0500
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 01:33 PM +0100, Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
> The existing s390 bios gets the LOADPARM information from the system using
> an SCLP call that specifies a buffer length too small to contain all the
> output.
>
> The recent fixes in the SCLP code have exposed this bug, since now the
> SCLP call will return an error (as per architecture) instead of
> writing partially and completing successfully.
>
> The solution is simply to specify the full page length as the SCCB
> length instead of a smaller size.
>
> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> Fixes: 9a22473c70f3 ("pc-bios/s390-ccw: get LOADPARM stored in SCP Read I=
nfo")
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index c0223fa..7251f9a 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      ReadInfo *sccb =3D (void *)_sccb;
>
>      memset((char *)_sccb, 0, sizeof(ReadInfo));
> -    sccb->h.length =3D sizeof(ReadInfo);
> +    sccb->h.length =3D SCCB_SIZE;
>      if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>          ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
>      }
> --=20
> 2.7.4

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Matthias Hartmann
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294


