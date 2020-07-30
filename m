Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD08C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5492F20663
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQcUIEws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5492F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BE2-0001fJ-Di
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BCy-0000nO-Rn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:15:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BCx-0000ud-3B
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LZqcLBs1ulEw8l14bQMjxZjn+DR+IwLm5uMe9oxz3Y=;
 b=WQcUIEwsKCC5skYwT0sqbTQnQGoRyRCbuYryr0MQrGTX3DCfCVaDHlr5AI0j88EKN+CNZp
 Q6kdJulDCVf7FyC+2KrEVnVvOWUJo3fywI3vsV4m7BB/w+y303okl/ISAOmSDItAp/VwDZ
 MZmtaevnJ2QcFs1bPG0Yq1JgWIf7tsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ffoYt4wIMmSFinRg87yshg-1; Thu, 30 Jul 2020 12:14:59 -0400
X-MC-Unique: ffoYt4wIMmSFinRg87yshg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F6318C63C1;
 Thu, 30 Jul 2020 16:14:58 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E359587B03;
 Thu, 30 Jul 2020 16:14:46 +0000 (UTC)
Subject: Re: [PATCH V1 05/32] savevm: QMP command for cprload
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-6-git-send-email-steven.sistare@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <654553cb-e071-0498-fe66-78ddda3942e9@redhat.com>
Date: Thu, 30 Jul 2020 11:14:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-6-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 10:14 AM, Steve Sistare wrote:
> Provide the cprload QMP command.  The VM is created from the file produced
> by the cprsave command.  Guest RAM is restored in-place from the shared
> memory backend file, and guest block devices are used as is.  The contents
> of such devices must not be modified between the cprsave and cprload
> operations.  If the VM was running at cprsave time, then VM execution
> resumes.

Is it always wise to unconditionally resume, or might this command need 
an additional optional knob that says what state (paused or running) to 
move into?

> 
> Syntax:
>    {'command':'cprload', 'data':{'file':'str'}}
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> ---

> +++ b/qapi/migration.json
> @@ -1635,3 +1635,14 @@
>   ##
>   { 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
>   
> +##
> +# @cprload:
> +#
> +# Start virtual machine from checkpoint file that was created earlier using
> +# the cprsave command.
> +#
> +# @file: name of checkpoint file
> +#
> +# Since 5.0

another 5.2 instance. I'll quit pointing it out for the rest of the series.

> +##
> +{ 'command': 'cprload', 'data': { 'file': 'str' } }
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 660537a..8478778 100644

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


