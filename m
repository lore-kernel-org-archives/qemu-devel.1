Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACA2C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40FD206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIvjv26h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40FD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQQR-0003OF-KX
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQPi-0002hN-9s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQPg-0006Hw-O8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8w7XmGxAwTmDwZG3uTJykfwMZytNP6pOdBNVpYXGn4=;
 b=hIvjv26hn80eclisriRrysVwwGfi0LGRbnHk+m5rNi2Y0pCKggvOOz7uaM/eXOLB84tE3v
 Jz1xLAfTTLootvaCJveLnktYxV22AIWol6zYB8/64yRPMARbYquwTv6K6UboYhGQpTFiCQ
 YPtfe1p/wpczDx/jPvNVwtZ6kGKpiC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-1dvI2_EnNSOkbV1O366Kqw-1; Fri, 30 Oct 2020 05:09:34 -0400
X-MC-Unique: 1dvI2_EnNSOkbV1O366Kqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 107698049C8;
 Fri, 30 Oct 2020 09:09:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9756A10027AA;
 Fri, 30 Oct 2020 09:09:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28A8D113865F; Fri, 30 Oct 2020 10:09:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 09/11] char-socket: Fix qemu_chr_socket_address() for
 abstract sockets
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-10-armbru@redhat.com>
 <c95ba994-8753-8240-9c3c-8cd14f21729a@redhat.com>
Date: Fri, 30 Oct 2020 10:09:25 +0100
In-Reply-To: <c95ba994-8753-8240-9c3c-8cd14f21729a@redhat.com> (Eric Blake's
 message of "Thu, 29 Oct 2020 14:41:11 -0500")
Message-ID: <87lffoxepm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/29/20 8:38 AM, Markus Armbruster wrote:
>> Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
>> support" neglected to update qemu_chr_socket_address().  It shows
>> shows neither @abstract nor @tight.  Fix that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  chardev/char-socket.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>
>> +++ b/chardev/char-socket.c
>> @@ -443,10 +443,18 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>>                                 s->is_listen ? ",server" : "");
>>          break;
>>      case SOCKET_ADDRESS_TYPE_UNIX:
>> -        return g_strdup_printf("%sunix:%s%s", prefix,
>> +    {
>> +        UnixSocketAddress *sa = &s->addr->u.q_unix;
>> +
>> +        return g_strdup_printf("%sunix:%s%s%s%s", prefix,
>>                                 s->addr->u.q_unix.path,
>> +                               sa->has_abstract && sa->abstract
>> +                               ? ",abstract" : "",
>> +                               sa->has_tight && sa->tight
>> +                               ? ",tight" : "",
>
> Why are we appending ',tight' when it is not abstract?  tight only makes
> a difference for abstract sockets, so omitting it for normal sockets
> makes more sense.

We don't bother to reject @tight when @abstract is false.  Not bothering
to suppress it here is consistently careless.

I'm trying to make this pig less wrong, I'm not trying to make it less
ugly.

> Or put another way, why are we using 2 bools to represent three sensible
> states, instead of a single 3-state enum?

Because the QAPI interface got merged without proper review by the QAPI
maintainers?

>>                                 s->is_listen ? ",server" : "");
>>          break;
>> +    }
>>      case SOCKET_ADDRESS_TYPE_FD:
>>          return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
>>                                 s->is_listen ? ",server" : "");
>> 


