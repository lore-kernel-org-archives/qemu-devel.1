Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923B122277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLvXUEz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923B122277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpoo-0006yW-L2
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpo3-00068r-2K
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpo1-0000q3-DI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604384912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjXOHkDwRJhpW1HrGLn0fLmJkVTe0pQs6dIGzByFfNY=;
 b=SLvXUEz5Naco9zC08h9RuL751CJNSanwXe6W5PE9EaVXS3qUVpW3EQa6OF/Ra3Tg0VIKbi
 A1ZhD49gy1cPBjpRieJmRh7V8iNc3Pq3QRsL4RHbUM1+zlxOBFNroGgMlF4tLYI+WWmiOL
 7R5chM+IglpLcO/YcBpoG2YdK7+aVwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-iMP6YIpjP8CKPrzkmSgX2w-1; Tue, 03 Nov 2020 01:28:30 -0500
X-MC-Unique: iMP6YIpjP8CKPrzkmSgX2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C638015C3;
 Tue,  3 Nov 2020 06:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 400BF5C230;
 Tue,  3 Nov 2020 06:28:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E58C11132BD6; Tue,  3 Nov 2020 07:28:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 09/11] char-socket: Fix qemu_chr_socket_address() for
 abstract sockets
References: <20201102094422.173975-1-armbru@redhat.com>
 <20201102094422.173975-10-armbru@redhat.com>
 <9f594cfb-2138-c12d-f6f7-6a4653e78087@redhat.com>
Date: Tue, 03 Nov 2020 07:28:20 +0100
In-Reply-To: <9f594cfb-2138-c12d-f6f7-6a4653e78087@redhat.com> (Eric Blake's
 message of "Mon, 2 Nov 2020 08:08:24 -0600")
Message-ID: <87r1pbosxn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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

> On 11/2/20 3:44 AM, Markus Armbruster wrote:
>> Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
>> support" neglected to update qemu_chr_socket_address().  It shows
>> shows neither @abstract nor @tight.  Fix that.
>> 
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  chardev/char-socket.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 1ee5a8c295..dc1cf86ecf 100644
>> --- a/chardev/char-socket.c
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
>>                                 s->is_listen ? ",server" : "");
>
> Gets modified again in 11/11, so I can accept this as a strict
> improvement, even if it is not the final form.

You're right, PATCH 11's change is better done here already.  Will tidy
up if I need to respin for some other reason.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

>
>>          break;
>> +    }
>>      case SOCKET_ADDRESS_TYPE_FD:
>>          return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
>>                                 s->is_listen ? ",server" : "");
>> 


