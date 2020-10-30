Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348CC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C84F221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFBGXJ3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C84F221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYThc-00072f-7r
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYTgj-0006JP-OB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYTgg-0006lY-Ld
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IXQKQm8Whh0lbbh4x1ivFio19AaXhHD5+FG+V6PPeg=;
 b=QFBGXJ3Xg1abxjsKKcSHt5yD+EKeyDJpw0VEJHhHwKNJfbhbP1QBQ9uq+CU2Y2CTd18XUK
 4ra0myCrpF5DHTV7cAjpKGYi4+MsQAKZMbUbYdByp2kMMScQpJ6wVQuVU9u+w8N5ZdP73p
 EC2yOF9M4CYKWVDuO5G14ZoMFswbXHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-7Q6R9KIEMFeov7Z4S6PITQ-1; Fri, 30 Oct 2020 08:39:17 -0400
X-MC-Unique: 7Q6R9KIEMFeov7Z4S6PITQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497D810054FF;
 Fri, 30 Oct 2020 12:39:16 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E7D26EF62;
 Fri, 30 Oct 2020 12:39:08 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-9-armbru@redhat.com>
 <a30d57a6-2188-12fa-a1e5-e0c015e8f970@redhat.com>
 <87r1pgxexm.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH 08/11] sockets: Fix socket_sockaddr_to_address_unix() for
 abstract sockets
Message-ID: <472fded4-21d6-5dca-bc34-18c95828adc6@redhat.com>
Date: Fri, 30 Oct 2020 07:39:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87r1pgxexm.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 4:04 AM, Markus Armbruster wrote:

>>> +    addr->u.q_unix.path = g_strdup(su->sun_path);
>>
>> This is wrong on at least Linux, where su->sun_path need not be
>> NUL-terminated (allowing file-system Unix sockets to have one more byte
>> in their name);
> 
> Out of curiosity: is this usage portable?  I tried man pages and SUS, no
> luck.

On Linux, 'man 7 unix' says:

> BUGS
>        When binding a socket to an address, Linux is one  of  the  implementa‐
>        tions  that  appends a null terminator if none is supplied in sun_path.
>        In most cases  this  is  unproblematic:  when  the  socket  address  is
>        retrieved,  it  will  be  one  byte  longer than that supplied when the
>        socket was bound.  However, there is one case where confusing  behavior
>        can  result: if 108 non-null bytes are supplied when a socket is bound,
>        then the addition of the null terminator takes the length of the  path‐
>        name beyond sizeof(sun_path).  Consequently, when retrieving the socket
>        address (for example, via accept(2)), if the input addrlen argument for
>        the  retrieving  call  is specified as sizeof(struct sockaddr_un), then
>        the  returned  address  structure  won't  have  a  null  terminator  in
>        sun_path.
> 
>        In  addition, some implementations don't require a null terminator when
>        binding a socket (the addrlen argument is used to determine the  length
>        of  sun_path)  and when the socket address is retrieved on these imple‐
>        mentations, there is no null terminator in sun_path.

along with advice on using strnlen and/or overallocation to handle
various cases in a cleaner manner, and the caveat that if you always use
a name smaller than sun_path you can avoid the tricky code (at the
expense of one byte less in your namespace).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


