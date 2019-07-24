Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E8EC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 22:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B982054F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZxPrDWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B982054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqPdU-0002wh-EC
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 18:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <venu.busireddy@oracle.com>) id 1hqPdJ-0002XB-JF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <venu.busireddy@oracle.com>) id 1hqPdI-0006uc-Hk
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:21:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
 id 1hqPdI-0006t8-AE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:21:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OMK0Zn160107;
 Wed, 24 Jul 2019 22:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ntMGBoLvAPl2fZ90JNrWfxFL0+9xudUvDBqMYvlm3TQ=;
 b=HZxPrDWZqO4AG+qJ92OqM0nBG96eymIIgstJztwiuaCPnO0SfGCbW0Oc72pKlq7Ltz1s
 jmOw5+Ed+0yRsP7vdyw8PdUFJ4RJonOzm5B4w/zhHO7vJrVkEL/Jlyz9qCQ6h5790l3x
 RZfHHQ0waIW+vgfCLU756bZMgezM7YXPpFcdlE5GDJnV4NX8EkBOvKT7R9OxVoW5JUyc
 rey9zif1uI21SMjl89s+rkamZbfZjTvL5Gzv5jECvCtwDd/4xvmCUE5kdZ4An0CpVW30
 5y2aDUL/eDjEGqQKtjDiP26mYwASNDObNM/AtYmsvIzake6H/YQHRkBIDiRVDvy7vdNa Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2tx61c04qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 22:21:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OMHaI2126027;
 Wed, 24 Jul 2019 22:21:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2tx60xfnus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 22:21:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6OML5Re009229;
 Wed, 24 Jul 2019 22:21:05 GMT
Received: from vbusired-dt (/10.154.170.122)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 24 Jul 2019 15:21:05 -0700
Date: Wed, 24 Jul 2019 17:21:04 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190724222104.GA306@vbusired-dt>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-7-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240238
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240238
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH v2 06/13] doc: update AMD SEV to include
 Live migration flow
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-07-10 20:23:03 +0000, Singh, Brijesh wrote:
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  docs/amd-memory-encryption.txt | 42 +++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
> index abb9a976f5..374f4b0a94 100644
> --- a/docs/amd-memory-encryption.txt
> +++ b/docs/amd-memory-encryption.txt
> @@ -89,7 +89,47 @@ TODO
>  
>  Live Migration
>  ----------------
> -TODO
> +AMD SEV encrypts the memory of VMs and because a different key is used
> +in each VM, the hypervisor will be unable to simply copy the
> +ciphertext from one VM to another to migrate the VM. Instead the AMD SEV Key
> +Management API provides sets of function which the hypervisor can use
> +to package a guest page for migration, while maintaining the confidentiality
> +provided by AMD SEV.
> +
> +SEV guest VMs have the concept of private and shared memory. The private
> +memory is encrypted with the guest-specific key, while shared memory may
> +be encrypted with the hypervisor key. The migration APIs provided by the
> +SEV API spec should be used for migrating the private pages. The
> +KVM_GET_PAGE_ENC_BITMAP ioctl can be used to get the guest page encryption
> +bitmap. The bitmap can be used to check if the given guest page is
> +private or shared.
> +
> +Before initiating the migration, we need to know the targets machine's public
> +Diffie-Hellman key (PDH) and certificate chain. It can be retrieved
> +with the 'query-sev-capabilities' QMP command or using the sev-tool. The
> +migrate-set-sev-info object can be used to pass the target machine's PDH and
> +certificate chain.
> +
> +e.g
> +(QMP) migrate-sev-set-info pdh=<target_pdh> plat-cert=<target_cert_chain> \

'migrate-sev-set-info' needs to be changed to 'migrate-set-sev-info'.

> +       amd-cert=<amd_cert>
> +(QMP) migrate tcp:0:4444
> +
> +
> +During the migration flow, the SEND_START is called on the source hypervisor
> +to create outgoing encryption context. The SEV guest policy dectates whether
> +the certificate passed through the migrate-sev-set-info command will be

Same here.

> +validate. SEND_UPDATE_DATA is called to encrypt the guest private pages.
> +After migration is completed, SEND_FINISH is called to destroy the encryption
> +context and make the VM non-runnable to protect it against the cloning.
> +
> +On the target machine, RECEIVE_START is called first to create an
> +incoming encryption context. The RECEIVE_UPDATE_DATA is called to copy
> +the receieved encrypted page into guest memory. After migration has
> +completed, RECEIVE_FINISH is called to make the VM runnable.
> +
> +For more information about the migration see SEV API Appendix A
> +Usage flow (Live migration section).
>  
>  References
>  -----------------
> -- 
> 2.17.1
> 
> 

