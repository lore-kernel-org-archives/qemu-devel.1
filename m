Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E59AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305DE2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoLj3EFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305DE2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgZ3N-0007gT-6S
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgZ2Q-0007Ao-Ds
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:26:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgZ2P-00076d-GE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591212416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3rsp1lITzHuJ3hon2Fq1CyznwPEk23zrr+ZQMRUygU=;
 b=JoLj3EFcV0lPuE0H3gNOXe0QGaKube0RB0msQTQlE0tg5x0bfkL4/N7W9NARHQ4rilWehf
 pRcKGet/TrUr1O4cPTsr+eMHlGReudkFX8+taUIkL4rw01gSlmQNK2gZGPcylL1y4sUVka
 9UaH+sIs1ULTYxYldnDDN5o6P+IE4kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-jWfkU_qONUmxXK063zNXRA-1; Wed, 03 Jun 2020 15:26:51 -0400
X-MC-Unique: jWfkU_qONUmxXK063zNXRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313D4185695A;
 Wed,  3 Jun 2020 19:26:50 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 857A25C240;
 Wed,  3 Jun 2020 19:26:46 +0000 (UTC)
Subject: Re: [PATCH v3] osdep: Make MIN/MAX evaluate arguments only once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200603013603.2400199-1-eblake@redhat.com>
 <03a13d47-fe7d-88e5-b92e-3c396591f9c7@linaro.org>
 <ecef14ce-47ca-749e-25b4-8e3ee378bd34@redhat.com>
 <2e894b8d-a510-0689-83dc-f6c8da16410e@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b4edd86c-a4cc-0b1d-ae28-009fe0a471e1@redhat.com>
Date: Wed, 3 Jun 2020 14:26:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2e894b8d-a510-0689-83dc-f6c8da16410e@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 15:26:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 crosthwaite.peter@gmail.com, quintela@redhat.com, f4bug@amsat.org,
 dgilbert@redhat.com, kraxel@redhat.com, dirty.ice.hu@gmail.com,
 pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 11:32 AM, Richard Henderson wrote:

>>> I'd prefer we generate a compile-time error than a runtime trap (or nothing,
>>> depending on compiler flags controlling __builtin_unreachable).
>>
>> What we have DOES produce a compile-time error.  If either expression to
>> MIN_CONST() is not actually const, the fact that __builtin_unreachable()
>> returns void causes a compilation failure because a value is expected.
> 
> Ah!  Well, that's good and certainly sufficient for my needs.
> 
> I do now wonder if it wouldn't be clearer to use "(void)0"
> instead of __builtin_unreachable, and add a note to the comment just above.

Yes, I just tested; using "((void)0)" in place of 
"__builtin_unreachable()" has the same effect (no change to valid use, 
and still a compiler error on misuse). gcc:

/home/eblake/qemu/qemu-img.c: In function ‘is_allocated_sectors’:
/home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as 
it ought to be
  1225 |             i = MIN_CONST(i, n);
       |               ^

clang:

/home/eblake/qemu/qemu-img.c:1225:15: error: assigning to 'int' from 
incompatible type 'void'
             i = MIN_CONST(i, n);
               ^ ~~~~~~~~~~~~~~~


Of course, a comment explaining the intent can't hurt either.  I'll wait 
to see if this gathers any other comments before spinning a v4 with that 
change.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


