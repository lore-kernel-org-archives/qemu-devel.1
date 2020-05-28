Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D452D208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5xTxsL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D452D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQNW-0005At-1A
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeQIn-0005Ul-Lv
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:43:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeQIl-0002aP-EP
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590702177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEPU9uSwfGK4wj+zeMIUYzbBhMnaoMqy91xMH5axK6w=;
 b=S5xTxsL/vWxKGSDEQSFCAufYH7nnugrHnPszCbc50itQEZ1vphDAC8tjGNjXvF+6gOyn0H
 C31LxOnbAmw/aRt2xpRoJ5ZRf9+TCczOd1kE4gz0VBdO77ovpERVAE6LxYKhgq5ynm9dqx
 q8D1hBc3bWgrrk+SBK3w2e6NJFfh7ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-6R6T9my2NK-A_xyBREmo7g-1; Thu, 28 May 2020 17:42:55 -0400
X-MC-Unique: 6R6T9my2NK-A_xyBREmo7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 386158005AA;
 Thu, 28 May 2020 21:42:54 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5685C1C3;
 Thu, 28 May 2020 21:42:53 +0000 (UTC)
Subject: Re: [PATCH 1/2] sev: add sev-inject-launch-secret
To: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, jejb@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
 <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1f13641f-c4d9-3414-2afc-f89df39e7967@redhat.com>
Date: Thu, 28 May 2020 16:42:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:42:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tobin@ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 3:51 PM, Tobin Feldman-Fitzthum wrote:
> From: Tobin Feldman-Fitzthum <tobin@ibm.com>
> 
> AMD SEV allows a guest owner to inject a secret blob
> into the memory of a virtual machine. The secret is
> encrypted with the SEV Transport Encryption Key and
> integrity is guaranteed with the Transport Integrity
> Key. Although QEMU faciliates the injection of the
> launch secret, it cannot access the secret.
> 
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
> ---

> +++ b/qapi/misc-target.json
> @@ -200,6 +200,26 @@
>   { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>     'if': 'defined(TARGET_I386)' }
>   
> +##
> +# @sev-inject-launch-secret:
> +#
> +# This command injects a secret blob into memory of SEV guest.
> +#
> +# @packet-header: the launch secret packet header encoded in base64
> +#
> +# @secret: the launch secret data to be injected encoded in base64
> +#
> +# @gpa: the guest physical address where secret will be injected.
> +        GPA provided here will be ignored if guest ROM specifies
> +        the a launch secret GPA.

Missing # on the wrapped lines.

> +#
> +# Since: 5.0.0

You've missed 5.0, and more sites tend to use x.y instead of x.y.z 
(although we aren't consistent); this should be 'Since: 5.1'

> +#
> +##
> +{ 'command': 'sev-inject-launch-secret',
> +  'data': { 'packet_hdr': 'str', 'secret': 'str', 'gpa': 'uint64' },

This does not match your documentation above, which named it 
'packet-header'.  Should 'gpa' be optional, to account for the case 
where ROM specifies it?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


