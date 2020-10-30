Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2083AC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAE620709
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqowqjhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAE620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQEA-0004Nv-8j
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQCu-0003hd-L2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQCs-0001dT-V9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXXgglTZhMDuW7zTaszIV69IP/PZEcPSzyWKDpWqvKQ=;
 b=ZqowqjhJi3/TAlDxcKcL4uQRZkHWJmqZPoKGzNy3kJvsY7bdwYwAjc3uaAgB4BZ3cXnEkz
 jbGpSb0SjAdfaG178awPAZQDNUCz6kTf8wUlOcHGG4e4TurjvV8NVHHZbC+FFyD0k4Dpux
 ZZPsRmpTWdP5KXqj52rf+U/NM1/UACA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-zoTNg6Y6OOSg6Mhxt4z8YQ-1; Fri, 30 Oct 2020 04:56:20 -0400
X-MC-Unique: zoTNg6Y6OOSg6Mhxt4z8YQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E813803650;
 Fri, 30 Oct 2020 08:56:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75ADE5B4A4;
 Fri, 30 Oct 2020 08:56:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0427A113865F; Fri, 30 Oct 2020 09:56:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/11] sockets: Fix socket_sockaddr_to_address_unix()
 for abstract sockets
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-9-armbru@redhat.com>
 <81648f6a-5eae-d8a2-f9a2-518dc1331cd7@redhat.com>
Date: Fri, 30 Oct 2020 09:56:11 +0100
In-Reply-To: <81648f6a-5eae-d8a2-f9a2-518dc1331cd7@redhat.com> (Paolo
 Bonzini's message of "Thu, 29 Oct 2020 18:47:35 +0100")
Message-ID: <87wnz8xfbo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/10/20 14:38, Markus Armbruster wrote:
>> +        /* Linux abstract socket */
>> +        addr->u.q_unix.path = g_strndup(su->sun_path + 1,
>> +                                        sizeof(su->sun_path) - 1);
>> +        addr->u.q_unix.has_abstract = true;
>> +        addr->u.q_unix.abstract = true;
>> +        addr->u.q_unix.has_tight = true;
>> +        addr->u.q_unix.tight = !su->sun_path[sizeof(su->sun_path) - 1];
>> +        return addr;
>
> I think this should be
>
>     addr->u.q_unit.tight = salen < sizeof(*su);
>
> Paolo

You're right, my code is wrong.

The case "@path just fits" is ambiguous: @tight doesn't matter then.
Your code arbitrarily picks tight=false then.  Picking the default
tight=true would perhaps be a bit nicer.  Not worth complicating the
code.


