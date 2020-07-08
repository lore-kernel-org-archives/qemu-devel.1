Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3D6206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRY/zROx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3D6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIfP-0005rd-Rn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtINU-0001Zx-Re
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:17:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtINS-0000U8-UV
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qE29t9i0arRfIYNg/XRg+3yFtpkbxdAMVE0O/Y0bPw4=;
 b=FRY/zROxxP9q5Pxp84A6ttn9LRLd1QlQ8RyKfiqnSK4pPc+Cu+V/qba+qEO0tm265O7ZFl
 gPVm2soRXnwrOs5rCEhuZOUuhT2CvBwpd6GwShXB4xF1vIGRwr0F6dVqV+pqnGg+02hdKO
 c3w9D7C9skJ4qK3kPWWAaOeCnnCpM1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-ZqDD13RrM2OM7849dyWt-g-1; Wed, 08 Jul 2020 13:16:33 -0400
X-MC-Unique: ZqDD13RrM2OM7849dyWt-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC936800D5C;
 Wed,  8 Jul 2020 17:16:31 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDD605D9C9;
 Wed,  8 Jul 2020 17:16:22 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:16:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Mohammed Gamal <mgamal@redhat.com>
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
Message-ID: <20200708171621.GA780932@habkost.net>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619155344.79579-3-mgamal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mtosatti@redhat.com, Pedro Principeza <pedro.principeza@canonical.com>,
 kvm@vger.kernel.org, libvir-list@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, fw@gpiccoli.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CCing libvir-list, and people who were included in the OVMF
thread[1])

[1] https://lore.kernel.org/qemu-devel/99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com/

On Fri, Jun 19, 2020 at 05:53:44PM +0200, Mohammed Gamal wrote:
> If the CPU doesn't support GUEST_MAXPHYADDR < HOST_MAXPHYADDR we
> let QEMU choose to use the host MAXPHYADDR and print a warning to the
> user.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  target/i386/cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b1b311baa2..91c57117ce 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6589,6 +6589,17 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              uint32_t host_phys_bits = x86_host_phys_bits();
>              static bool warned;
>  
> +	    /*
> +	     * If host doesn't support setting physical bits on the guest,
> +	     * report it and return
> +	     */
> +	    if (cpu->phys_bits < host_phys_bits &&
> +		!kvm_has_smaller_maxphyaddr()) {
> +		warn_report("Host doesn't support setting smaller phys-bits."
> +			    " Using host phys-bits\n");
> +		cpu->phys_bits = host_phys_bits;
> +	    }
> +

This looks like a regression from existing behavior.  Today,
using smaller phys-bits doesn't crash most guests, and still
allows live migration to smaller hosts.  I agree using the host
phys-bits is probably a better default, but we shouldn't override
options set explicitly in the command line.

Also, it's important that we work with libvirt and management
software to ensure they have appropriate APIs to choose what to
do when a cluster has hosts with different MAXPHYADDR.

>              /* Print a warning if the user set it to a value that's not the
>               * host value.
>               */
> -- 
> 2.26.2
> 

-- 
Eduardo


