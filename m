Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B405C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B4A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mjnhySDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B4A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxlR-0000l8-Vj
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1iAxgp-0004ue-NB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1iAxUP-0003DV-U7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:32:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1iAxUP-0003Ch-Jk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:32:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JETcXX106650;
 Thu, 19 Sep 2019 14:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=LSuAbkBFezedcCQlhqnSdMYTUe6oMicT4male1uRfTA=;
 b=mjnhySDWbqDO2i2SA3kA3pM4ecsSHDL5qCslgV8wHHf6OGfphXvJ1IohRau01zkommSw
 ALXvCYlOFhWkU6EWIeK9hgWlN0DmsOzmHR3tVrefF59hWY4TPgzLaRYqRCJLzmymMLfX
 NDgoBfXdV6YQuqQmb0XZKbrE2a6ocr6sXvFIzaeI6TcWy+kVdlylq6MQ5iuF0za56oKx
 8fJ8eAihNxDdbmd9SYZAXLlcFndwnO9Tp3uZvCnChrRsk3KvV7bwF9TPm7zEjlv98QG+
 vo4NWPyqUictUvH+H7GRd8Fhqo60GG2f6waRleMBftMxyq5W4j7EiJw8YlgTg6N6y9Lr zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2v3vb54dsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2019 14:32:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JEOIdP122133;
 Thu, 19 Sep 2019 14:32:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2v3vbg7mt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2019 14:32:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8JEWped002779;
 Thu, 19 Sep 2019 14:32:52 GMT
Received: from [192.168.14.112] (/79.183.239.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 19 Sep 2019 07:32:51 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 6/7] target/i386: add VMX features
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1568716480-9973-7-git-send-email-pbonzini@redhat.com>
Date: Thu, 19 Sep 2019 17:32:48 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0C3DD36-966F-46CC-8705-903112BECBC2@oracle.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
 <1568716480-9973-7-git-send-email-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=678
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=749 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Sep 2019, at 13:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> Add code to convert the VMX feature words back into MSR values,
> allowing the user to enable/disable VMX features as they wish.  The =
same
> infrastructure enables support for limiting VMX features in named
> CPU models.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> +static uint64_t make_vmx_msr_value(uint32_t index, uint32_t features)
> +{
> +    uint32_t default1, can_be_one, can_be_zero;
> +    uint32_t must_be_one;
> +
> +    switch (index) {
> +    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> +        default1 =3D 0x00000016;
> +        break;
> +    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
> +        default1 =3D 0x0401e172;
> +        break;
> +    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> +        default1 =3D 0x000011ff;
> +        break;
> +    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
> +        default1 =3D 0x00036dff;
> +        break;
> +    case MSR_IA32_VMX_PROCBASED_CTLS2:
> +        default1 =3D 0;
> +        break;
> +    default:
> +        abort();
> +    }
> +

See below.

> +    /*
> +     * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
> +     * not change them for backwards compatibility.
> +     */
> +    uint64_t fixed_vmx_basic =3D kvm_vmx_basic & =
0x003c1fff7fffffffULL;
> +
> +    /*
> +     * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) =
can
> +     * change in the future but are always zero for now, clear them =
to be
> +     * future proof.  Bits 32-63 in theory could change, though KVM =
does
> +     * not support dual-monitor treatment and probably never will; =
mask
> +     * them out as well.
> +     */
> +    uint64_t fixed_vmx_misc =3D kvm_vmx_misc & 0x0e00001f;

I haven=E2=80=99t yet read deeply entire patch-series but I=E2=80=99m =
definitely against having
these hard-coded values in code instead of explicitly building proper =
bitmap
with well-defined bit names. This is error-prone and less readable.
(E.g. Am I suppose as a reader to convert 0x0401e172 to which =
processor-based controls it represents?)

-Liran



