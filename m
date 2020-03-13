Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4406C20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnU7GDPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4406C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCoaM-00054X-EM
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCoZS-00048o-9c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCoZR-0000P8-7m
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCoZR-0000K6-4G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584122284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOg+qiDCgh/bdQKhu8ipfiaFC8F8QtJxFAUPBB9XuLY=;
 b=RnU7GDPuCx2/ifqaL+xFwrUxqmxdx8GOUmYoKlpGwa3le7Yrp/AA99wxXMlhR38SWUMYjk
 XrUsn2kypGzbZhFqdM0zIyTbxe/dM2YYS5NvR1g8hlq3vDVpT3jUgat0nbIqTEr9WA1yEo
 bx55V0yEYoASmYGx4sZIma4RjdsU3b8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-MuPqJ9UCP3ajygcmfuaUmw-1; Fri, 13 Mar 2020 13:57:46 -0400
X-MC-Unique: MuPqJ9UCP3ajygcmfuaUmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B918C801E66;
 Fri, 13 Mar 2020 17:57:44 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D405C8FBED;
 Fri, 13 Mar 2020 17:57:43 +0000 (UTC)
Subject: Re: [PATCH 1/3] Use &error_abort instead of separate assert()
To: Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-2-armbru@redhat.com>
 <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <563f6769-74f4-f532-0e76-fe5875742ee1@redhat.com>
Date: Fri, 13 Mar 2020 12:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 ashijeetacharya@gmail.com, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 12:37 PM, Alexander Bulekov wrote:
> On 200313 1805, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> 
>> index 1a99277d60..aa9eee6ebf 100644
>> --- a/tests/qtest/fuzz/qos_fuzz.c
>> +++ b/tests/qtest/fuzz/qos_fuzz.c
>> @@ -57,8 +57,7 @@ static void qos_set_machines_devices_available(void)
>>       QList *lst;
>>       Error *err = NULL;
> Can this err declaration be removed? Don't think it's used anywhere
> else.

Correct, it is not.  With that additional line gone,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


