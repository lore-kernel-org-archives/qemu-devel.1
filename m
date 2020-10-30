Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE66C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7B120704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFKPBhgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7B120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQMM-0001Dl-Ug
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQLA-0000Px-Sr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYQL4-0004cG-TX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqkKm2DKHVXnuRWXt2UN87LCKoR93rPH4SmK7euC3tw=;
 b=XFKPBhgGIwJiMa478ZffBLWSrIScJ9JTcx2IT7lLVwPCZnzmOyAGaFqW5+R6GRh+7ZmFrr
 LEb6kSw24mdG4ry+eYmXlppIfNKj9OeQ+EGeGZPUEAYSTW4BeE0p7BoqU9OkNilqpbcKvi
 OFZImlmrDYqlLhqPGtptL70l2O6Xpuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-rAlKbs8kP5-rw65pGDzjbA-1; Fri, 30 Oct 2020 05:04:46 -0400
X-MC-Unique: rAlKbs8kP5-rw65pGDzjbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F8041868422;
 Fri, 30 Oct 2020 09:04:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFC495D98C;
 Fri, 30 Oct 2020 09:04:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49405113865F; Fri, 30 Oct 2020 10:04:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 08/11] sockets: Fix socket_sockaddr_to_address_unix()
 for abstract sockets
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-9-armbru@redhat.com>
 <a30d57a6-2188-12fa-a1e5-e0c015e8f970@redhat.com>
Date: Fri, 30 Oct 2020 10:04:37 +0100
In-Reply-To: <a30d57a6-2188-12fa-a1e5-e0c015e8f970@redhat.com> (Eric Blake's
 message of "Thu, 29 Oct 2020 14:38:37 -0500")
Message-ID: <87r1pgxexm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> support" neglected to update socket_sockaddr_to_address_unix().  The
>> function returns a non-abstract socket address for abstract
>> sockets (wrong) with a null @path (also wrong; a non-optional QAPI str
>> member must never be null).
>> 
>> The null @path is due to confused code going back all the way to
>> commit 17c55decec "sockets: add helpers for creating SocketAddress
>> from a socket".
>> 
>> Add the required special case, and simplify the confused code.
>> 
>> Fixes: 776b97d3605ed0fc94443048fdf988c7725e38a9
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/qemu-sockets.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index c802d5aa0a..801c5e3957 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -1264,10 +1264,20 @@ socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
>>  
>>      addr = g_new0(SocketAddress, 1);
>>      addr->type = SOCKET_ADDRESS_TYPE_UNIX;
>> -    if (su->sun_path[0]) {
>> -        addr->u.q_unix.path = g_strndup(su->sun_path, sizeof(su->sun_path));
>> +#ifdef CONFIG_LINUX
>> +    if (!su->sun_path[0]) {
>> +        /* Linux abstract socket */
>> +        addr->u.q_unix.path = g_strndup(su->sun_path + 1,
>> +                                        sizeof(su->sun_path) - 1);
>> +        addr->u.q_unix.has_abstract = true;
>> +        addr->u.q_unix.abstract = true;
>> +        addr->u.q_unix.has_tight = true;
>> +        addr->u.q_unix.tight = !su->sun_path[sizeof(su->sun_path) - 1];
>
> This is questionable - how can you tell from the last byte whether the
> name was created as tight or not?

I plead temporary insanity.  See my reply to Paolo.

>> +        return addr;
>>      }
>> +#endif
>>  
>> +    addr->u.q_unix.path = g_strdup(su->sun_path);
>
> This is wrong on at least Linux, where su->sun_path need not be
> NUL-terminated (allowing file-system Unix sockets to have one more byte
> in their name);

Out of curiosity: is this usage portable?  I tried man pages and SUS, no
luck.

>                 you need the strndup that you replaced above, in order
> avoid reading beyond the end of the array.

You're right.  Prone to allocate a bit more than necessary (always
sizeof(su->sun_path) + 1 bytes), but that doesn't matter.


