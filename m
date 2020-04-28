Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A01206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etUk0FRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A01206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRHe-0007Mg-N6
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTREb-00039z-3B
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTREL-0004Px-P2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:29:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTREL-0004PU-Ac
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588084140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkcPLRihDgEW9O2S+bV9k8O0FmMbiw6g3J1lX4ZeZ4E=;
 b=etUk0FRSsNRe8Kpwt4UylbxAx80OMaKVcWgDqMxRV+8YQEDCccmKW6/2uPEHiance8RBNk
 VafMd7YlhcdBcMfgE78VooqJ+YZQTmkc9P/r/TFs+40YLKbQRcPWCLD78wDrodT/Hysp0X
 tYnf1QE4pw8D63E1ZpXcTZsGOHnYbA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-yPeCLCdCNHuxVJQ6maOMsw-1; Tue, 28 Apr 2020 10:28:58 -0400
X-MC-Unique: yPeCLCdCNHuxVJQ6maOMsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75778904DB;
 Tue, 28 Apr 2020 14:28:47 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64B3E5D76C;
 Tue, 28 Apr 2020 14:28:46 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: Add blk_make_empty()
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-4-mreitz@redhat.com>
 <d4cab7f2-2a64-82fb-5eed-1345ebc3367a@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f9db63b9-f150-44c3-c082-c9fced168471@redhat.com>
Date: Tue, 28 Apr 2020 09:28:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d4cab7f2-2a64-82fb-5eed-1345ebc3367a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:55 AM, Eric Blake wrote:

>> +++ b/include/sysemu/block-backend.h
>> @@ -266,4 +266,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend=20
>> *blk_in, int64_t off_in,
>> =C2=A0 const BdrvChild *blk_root(BlockBackend *blk);
>> +int blk_make_empty(BlockBackend *blk, Error **errp);
>> +
>=20
> Again, a flag parameter to allow use of BDRV_REQ_NO_FALLBACK would be nic=
e.

Or maybe not, after reading Kevin's responses.  Making an image empty is=20
not the same as making it read as zero.  If we can't come up with a use=20
for a flag, then deferring the addition of a flag until later is a=20
perfectly reasonable approach (rather than adding a flag now that will=20
never get set to anything other than 0).  This isn't quite the same as a=20
public API where we would regret being locked out of a flag down the road.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


