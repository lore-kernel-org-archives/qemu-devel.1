Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F992073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhFYY+zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F992073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOV3-0007pG-NH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOF8-00059I-44
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:08:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOF6-0001q7-5T
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593792527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BeWoJTYp6xJWOYltcJ0gnZl4BgZYS7m1swlm9Bsjaes=;
 b=FhFYY+zOMDZjw9fgBJocBePsqoYnbctgwVhhHEBF36MC+P4RuPvcwdDuOBJ5hzbufr9Jk1
 tGigMM4rltZC5yLm6YrrVlaX0fXKitdMMxa9i5+Aq+yJp3Fw2Ozprtf2lxvQk1/lIJdpIO
 6G9NBubS6dkmDy+NndXwwZ9uS38nd/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-Yw5kQ7t_PdSu1QwcUE6Lbw-1; Fri, 03 Jul 2020 12:08:45 -0400
X-MC-Unique: Yw5kQ7t_PdSu1QwcUE6Lbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA07186A206
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 16:08:44 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC7FD7166C;
 Fri,  3 Jul 2020 16:08:43 +0000 (UTC)
Date: Fri, 3 Jul 2020 17:08:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] target-i386: sev: fail query-sev-capabilities if
 QEMU cannot use SEV
Message-ID: <20200703160841.GA6680@work-vm>
References: <20200630154521.552874-1-pbonzini@redhat.com>
 <20200630154521.552874-3-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630154521.552874-3-pbonzini@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> In some cases, such as if the kvm-amd "sev" module parameter is set
> to 0, SEV will be unavailable but query-sev-capabilities will still
> return all the information.  This tricks libvirt into erroneously
> reporting that SEV is available.  Check the actual usability of the
> feature and return the appropriate error if QEMU cannot use KVM
> or KVM cannot use SEV.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/sev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 70f9ee026f..22194b3e32 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -450,6 +450,15 @@ sev_get_capabilities(Error **errp)
>      uint32_t ebx;
>      int fd;
>  
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "KVM not enabled\n");
> +        return NULL;
> +    }
> +    if (kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, NULL) < 0) {
> +        error_setg(errp, "SEV is not enabled\n");

Can you make that 'SEV is not enabled in KVM' so it's obvious
that it's the KVM side and not the qemu side (like you've
done in the previous patch).

Dave

> +        return NULL;
> +    }
> +
>      fd = open(DEFAULT_SEV_DEVICE, O_RDWR);
>      if (fd < 0) {
>          error_setg_errno(errp, errno, "Failed to open %s",
> -- 
> 2.26.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


