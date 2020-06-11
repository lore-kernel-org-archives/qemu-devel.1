Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDCD206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJMM6+cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDCD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOJB-000262-3J
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjOI1-0000rg-1Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:34:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjOI0-0001ME-5p
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591886083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATHR/4CgCIuK21hluS6yPJOlcBxu/Ut3sfoImaSIqUE=;
 b=jJMM6+cFVlh4gn+h42pVfCXdnga6ii8KpeCpq9s/HCEDAaG3NxGBYeEGka9ZvOl4Yrk3p6
 g1l+zeg9d/A/wimXxo677kJzmcttDYsQblPs0+ILtNBH3ezP2nK/XjGB0QzDt4BfmgNQaf
 Nljo57k2X9KeFEPIGeFn7MCiWu5YPys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-fe5dpNK3NAaR5_xBsXLnmw-1; Thu, 11 Jun 2020 10:34:41 -0400
X-MC-Unique: fe5dpNK3NAaR5_xBsXLnmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96D8818A8222
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 14:34:40 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 365B9610F2;
 Thu, 11 Jun 2020 14:34:40 +0000 (UTC)
Subject: Re: [PATCH 1/2] qmp: Add 'openfd' command
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com
References: <20200611111703.159590-1-dgilbert@redhat.com>
 <20200611111703.159590-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c436ff28-fc42-5ed2-c152-39f06592298c@redhat.com>
Date: Thu, 11 Jun 2020 09:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611111703.159590-2-dgilbert@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 6/11/20 6:17 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The existing 'getfd' command imports an fd from the monitor via
> SCM rights.
> This command allows qemu to open the file for itself; this is convenient
> primarily in testing, or with simple QMP clients.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   monitor/misc.c | 48 ++++++++++++++++++++++++++++++++++++++----------
>   qapi/misc.json | 23 ++++++++++++++++++++++-
>   2 files changed, 60 insertions(+), 11 deletions(-)
> 

> +++ b/qapi/misc.json
> @@ -952,7 +952,7 @@
>   ##
>   # @closefd:
>   #
> -# Close a file descriptor previously passed via SCM rights
> +# Close a named file descriptor
>   #
>   # @fdname: file descriptor name
>   #
> @@ -968,6 +968,27 @@
>   ##
>   { 'command': 'closefd', 'data': {'fdname': 'str'} }
>   
> +##
> +# @openfd:
> +#
> +# Open a file descriptor.  The file is opened read-write.

Should this mention that this is shorthand for opening the file 
externally then using getfd on that fd?  And if we add that 
cross-reference, should we add the reverse reference in the docs for getfd?

> +#
> +# @fdname: file descriptor name
> +# @filename: file name
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "openfd", "arguments": { "fdname": "null",
> +#                                          "filename": "/dev/null" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'openfd', 'data': {'fdname': 'str', 'filename': 'str'} }
> +
>   ##
>   # @MemoryInfo:
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


