Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B034C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10279206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALFwvkbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10279206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdiO-00037q-BJ
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdT7-0003jr-Km
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:12:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdT6-0008U8-0T
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593612727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92FH5m9pGzl/UyiByXozmNsK+hpLUZSp72dWeVI02Og=;
 b=ALFwvkbMfyOtch5RuM7C6sIMXEVVS7q4QsxyYzi0i3EZEM6GmYgdC8+LpWbiRakLYDZ+Sg
 74xkkh8A5+I0LirKxe1cEdVJhH7Fscil7fApBPhBOW4wo+e2mwOwaUqcIglbr6lMMrjJN/
 hagplZ+36AdkO3CSskNpP4bxjqbH8sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-7d9YSBR8PI--ZeM3TQ-yGQ-1; Wed, 01 Jul 2020 10:12:05 -0400
X-MC-Unique: 7d9YSBR8PI--ZeM3TQ-yGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C2D8879510
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 14:12:04 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28A6490351;
 Wed,  1 Jul 2020 14:12:04 +0000 (UTC)
Subject: Re: [PATCH 2/2] target-i386: sev: fail query-sev-capabilities if QEMU
 cannot use SEV
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200630154521.552874-1-pbonzini@redhat.com>
 <20200630154521.552874-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d68fb8a7-8423-02c6-c1a5-8438161c654e@redhat.com>
Date: Wed, 1 Jul 2020 09:12:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630154521.552874-3-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 10:45 AM, Paolo Bonzini wrote:
> In some cases, such as if the kvm-amd "sev" module parameter is set
> to 0, SEV will be unavailable but query-sev-capabilities will still
> return all the information.  This tricks libvirt into erroneously
> reporting that SEV is available.  Check the actual usability of the
> feature and return the appropriate error if QEMU cannot use KVM
> or KVM cannot use SEV.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 70f9ee026f..22194b3e32 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -450,6 +450,15 @@ sev_get_capabilities(Error **errp)
>       uint32_t ebx;
>       int fd;
>   
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "KVM not enabled\n");
> +        return NULL;
> +    }
> +    if (kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, NULL) < 0) {
> +        error_setg(errp, "SEV is not enabled\n");

Patchew was correct: drop the two \n.  With that fix,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


