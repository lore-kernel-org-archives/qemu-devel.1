Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07501C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C317F215A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSplOEb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C317F215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5x7-0002Wi-3X
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5wI-0001mt-Vf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5wH-0003jJ-Tu
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:32:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS5wH-0003Zv-E6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587763968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeAqk35EEoZmKppQw5dnfrwP8WLasSK5XA0JJuLEluA=;
 b=aSplOEb7OtUNSYnBkJFH0WBpWbOMeVfrZnLOpA0KvwII3dmH0zvCHOfDW1n+3NljsxfJCs
 RzHMICVmTLxB2V6IG5G5Q5mXXJZrHF4R20O2nctT+a4McRBbehW0mC+mnPterJ6r/IcdeL
 jp6fVg0wSiYEeiSULPZHtB7NAkZTLbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-U2Rgg7vOOLaL9DXqugfTAg-1; Fri, 24 Apr 2020 17:32:42 -0400
X-MC-Unique: U2Rgg7vOOLaL9DXqugfTAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6270E835B42;
 Fri, 24 Apr 2020 21:32:41 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A86B65D9CA;
 Fri, 24 Apr 2020 21:32:40 +0000 (UTC)
Subject: Re: [PATCH] linux-user: Drop unnecessary check in dup3 syscall
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200424205755.GA26282@ls3530.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <56bb3ce2-9b70-7470-d4f4-563b617849d2@redhat.com>
Date: Fri, 24 Apr 2020 16:32:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424205755.GA26282@ls3530.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:11:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 4/24/20 3:57 PM, Helge Deller wrote:
> Drop the extra check in dup3() if anything other than FD_CLOEXEC (aka
> O_CLOEXEC) was given. Instead simply rely on any error codes returned by
> the host dup3() syscall.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..ebf0d38321 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8301,12 +8310,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>   #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
>       case TARGET_NR_dup3:
>       {
> -        int host_flags;
> -
> -        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
> -            return -EINVAL;
> -        }
> -        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
> +        int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);

I don't think this is quite correct.  target_to_host_bitmask() silently 
ignores unknown bits, and a user that was relying on bit 0x40000000 to 
cause an EINVAL will not fail with this change (unless bit 0x40000000 
happens to be one of the bits translated by fcntl_flags_tbl).  The 
open() syscall is notorious for ignoring unknown bits rather than 
failing with EINVAL, and it is has come back to haunt kernel developers; 
newer syscalls like dup3() learned from the mistake, and we really do 
want to catch unsupported bits up to make it easier for future kernels 
to define meanings to those bits without them being silently swallowed 
when run on older systems that did not know what those bits meant.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


