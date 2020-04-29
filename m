Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45A4C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EAB2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr4nSpxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EAB2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToBC-0002kS-ON
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jToAN-0001r7-26
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jToAL-00079U-Uo
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jToAL-00079D-Ab
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNd5EPOn+oXZg8dqiAe6HuSnscLpaHDHvGQfj8wAUoI=;
 b=Zr4nSpxnbXjDxiJyT82ylacijqC0d5oAmJ3h5P1cBbEl+FO35MZh7Dp4ffJ9dIRwMq3VjJ
 6inh1IHXWhFtLrlFNEHD+OjghdhbBdA6edLwaHqnuo3DXFUNtqFrmJDkE53Fwugg2ohKDj
 1l97iw+z+cP1PM4oVbY1a2B4+XONDwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-aJqb-IUAP7SxL_5h7gr16Q-1; Wed, 29 Apr 2020 10:58:22 -0400
X-MC-Unique: aJqb-IUAP7SxL_5h7gr16Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4963185389E;
 Wed, 29 Apr 2020 14:58:20 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80541605F7;
 Wed, 29 Apr 2020 14:58:18 +0000 (UTC)
Subject: Re: [PATCH 1/2] qemu-img: refactor dump_map_entry JSON format output
To: Eyal Moscovici <eyal.moscovici@oracle.com>, qemu-devel@nongnu.org
References: <20200322091117.79443-1-eyal.moscovici@oracle.com>
 <20200322091117.79443-2-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <487b9270-4e39-9a0d-ca7e-c261ee2f02c2@redhat.com>
Date: Wed, 29 Apr 2020 09:58:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200322091117.79443-2-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/22/20 4:11 AM, Eyal Moscovici wrote:
> Previously dump_map_entry identified whether we need to start a new JSON
> array based on whether start address == 0. In this refactor we remove
> this assumption as in following patches we will allow map to start from
> an arbitrary position.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---
>   qemu-img.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 

> @@ -2871,8 +2870,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
>           }
>           putchar('}');
>   
> -        if (!next) {
> -            printf("]\n");
> +        if (next) {
> +            printf(",\n");

As long as you're touching this, puts(",") is slightly more efficient 
than printf().  But what you have is not wrong.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


