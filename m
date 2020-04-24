Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B21C55197
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1CE20857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbi1Yh9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1CE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4dg-0005IN-FD
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 16:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS4cq-0004kl-I1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS4co-0006qt-Vg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:08:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS4co-0006ef-Di
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587758915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1zy/ibFG+dLjW17C/6gpzOrBZ+TQaIHUrj8AFgYX/A=;
 b=Dbi1Yh9gsC9BWDROwjO9qcRMWMYI40B0Ktk9zifuKovG8telRTgKcr2Xpnl4H0oFiPUvkj
 2/u6w1DBm5nbzRs8+l1MIr/njm14qVXXHf9EUvXZKi5FUSLTHOLzVkb54x2nsn2iNEZU9L
 9XurHUz+53Kq09ZU5ncVzY63Z7H1BGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-SyZeQDUjPriuA5n-Kp07NA-1; Fri, 24 Apr 2020 16:08:31 -0400
X-MC-Unique: SyZeQDUjPriuA5n-Kp07NA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D96802EB1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 20:08:30 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C828196AE;
 Fri, 24 Apr 2020 20:08:30 +0000 (UTC)
Subject: Re: [PATCH 06/11] error: Use error_reportf_err() where appropriate
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <44cf6721-88fa-acd3-b051-43e81b37506a@redhat.com>
Date: Fri, 24 Apr 2020 15:08:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424192027.11404-7-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

On 4/24/20 2:20 PM, Markus Armbruster wrote:
> Replace
> 
>      error_report("...: %s", ..., error_get_pretty(err));
> 
> by
> 
>      error_reportf_err(err, "...: ", ...);

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   chardev/char-socket.c | 5 +++--
>   hw/sd/pxa2xx_mmci.c   | 4 ++--
>   hw/sd/sd.c            | 4 ++--
>   hw/usb/dev-mtp.c      | 9 +++++----
>   qemu-nbd.c            | 7 +++----
>   scsi/qemu-pr-helper.c | 4 ++--
>   6 files changed, 17 insertions(+), 16 deletions(-)

Although it touches NBD, I'm happy for this to go through your tree with 
the larger series.

> +++ b/qemu-nbd.c
> @@ -856,8 +856,7 @@ int main(int argc, char **argv)
>           }
>           tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
>           if (local_err) {
> -            error_report("Failed to get TLS creds %s",
> -                         error_get_pretty(local_err));
> +            error_reportf_err(local_err, "Failed to get TLS creds ");

Odd one out for not using ':' in the message, but that's independent of 
this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


