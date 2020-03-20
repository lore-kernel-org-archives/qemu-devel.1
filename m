Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D383C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1A420752
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s+mMehN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1A420752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJjX-0003u6-J5
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <konrad.wilk@oracle.com>) id 1jFJbI-0007uV-Qd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <konrad.wilk@oracle.com>) id 1jFJbH-0005jz-K5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:30:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
 id 1jFJbH-0005ir-Ah
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:30:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KFO4Ap127250;
 Fri, 20 Mar 2020 15:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=etDS1RdG8ZHZ9bwLSzxE7kro9u06Ld287oKPRC6z3r8=;
 b=s+mMehN3vKSxM/pTnF5vmgk8AQyNmNd8ZFnXUnKcUMMcrMOeTPCaazJuc/t+wA2asW3i
 pv8ZMjvc/ajU3qlq3rXiLwqBqdFUF+tzl/+N+oD2biQqjRgTXGRDo518oHHEBOHRGHZ8
 0OpwIejPIrup4In39IeSwgfSFEuWp6XZCOThU4YfwC//PONFLo1AkDz7dJT6IFv4hMaN
 DpMqU8xYeWQaAvQS7EbzUUghi0DiTC8viCwtaT4vldzzqL++RpQB3LrTs31DmruqnJCa
 1xcR38/+skTlz1iLDYSwFcqLS8NsSvlyj1Ks9+vSMx4VR1qVaC9QAKW+n4nZCXcVfJt8 zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yub27e602-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2020 15:30:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KFMrLU078224;
 Fri, 20 Mar 2020 15:30:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2ys8ty9wq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2020 15:30:15 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02KFUDg1027210;
 Fri, 20 Mar 2020 15:30:13 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 20 Mar 2020 08:30:12 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 83F816A00F1; Fri, 20 Mar 2020 11:30:16 -0400 (EDT)
Date: Fri, 20 Mar 2020 11:30:16 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 13/13] microvm/acpi: use GSI 16-23 for virtio
Message-ID: <20200320153016.GK4541@char.us.oracle.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-14-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319080117.7725-14-kraxel@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200064
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 09:01:17AM +0100, Gerd Hoffmann wrote:
> With ACPI enabled and IO-APIC being properly declared in the ACPI tables
> we can use interrupt lines 16-23 for virtio and avoid shared interrupts.

7 interrupt lines? Is there a specific requirements of which
ones should be assigned to what device?

Or perhaps - could you include /proc/interrupts in the commit if that is OK?

> 
> With acpi disabled we continue to use lines 8-15.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/microvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 834b10aee0a2..139181daed06 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -122,7 +122,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>  
>      kvmclock_create();
>  
> -    mms->virtio_irq_base = 8;
> +    mms->virtio_irq_base = acpi_enabled ? 16 : 8;
>      for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
>                               VIRTIO_MMIO_BASE + i * 512,
> -- 
> 2.18.2
> 

