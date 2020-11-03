Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627B9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF63722277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJnTmlnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF63722277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpwQ-0001xj-Iw
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpvP-00013Q-EM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpvM-0003DL-E6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604385366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mv8cClp2zIDi4pd6r6mHxpJ7DL6izVIgfX2y9sxMmVg=;
 b=VJnTmlnu2Y4ZY2Di0wEpfEgtIcyQ4xf5ycb+sKttPV0Gr7mUUkSqttOfIa/Am3SXJ4BC7Q
 YiQkLyDVe7fEQE7ToQYCbB4b6Czt1/ciec61ofIFE+9gGKfd25V3Kd1hcHhHm3Q4Q4in+l
 H2AJcDpASQWOEUliv/l/5HbbLZSht9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-XI6QfvWJN2q1wq2UWrLOtw-1; Tue, 03 Nov 2020 01:36:05 -0500
X-MC-Unique: XI6QfvWJN2q1wq2UWrLOtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D0C188C126;
 Tue,  3 Nov 2020 06:36:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD9C16F142;
 Tue,  3 Nov 2020 06:35:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BBAA1132BD6; Tue,  3 Nov 2020 07:35:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 11/11] sockets: Make abstract UnixSocketAddress
 depend on CONFIG_LINUX
References: <20201102094422.173975-1-armbru@redhat.com>
 <20201102094422.173975-12-armbru@redhat.com>
 <e98fe4e1-b641-97ef-e697-11281d085c04@redhat.com>
Date: Tue, 03 Nov 2020 07:35:56 +0100
In-Reply-To: <e98fe4e1-b641-97ef-e697-11281d085c04@redhat.com> (Eric Blake's
 message of "Mon, 2 Nov 2020 08:12:57 -0600")
Message-ID: <87lffjoskz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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

> On 11/2/20 3:44 AM, Markus Armbruster wrote:
>> The abstract socket namespace is a non-portable Linux extension.  An
>> attempt to use it elsewhere should fail with ENOENT (the abstract
>> address looks like a "" pathname, which does not resolve).  We report
>> this failure like
>> 
>>     Failed to connect socket abc: No such file or directory
>> 
>> Tolerable, although ENOTSUP would be better.
>> 
>> However, introspection lies: it has @abstract regardless of host
>> support.  Easy enough to fix: since Linux provides them since 2.2,
>> 'if': 'defined(CONFIG_LINUX)' should do.
>> 
>> The above failure becomes
>> 
>>     Parameter 'backend.data.addr.data.abstract' is unexpected
>> 
>> I consider this an improvement.
>> 
>
> Commit message lacks mention of the fact that we are now explicitly not
> outputting 'strict' for non-abstract sockets (in fact, that change could

I trust you mean 'tight'.

> be squashed in 9/11 if you wanted to do it there).

Less churn.  I'll do it if I need to respin.

>                                                     But as this cleans
> up the code I mentioned in 9/11, I'll leave it up to Dan if the commit
> message needs a tweak; the end result is fine if we don't feel like a v3
> spin just for moving hunks around.

Neglecting to mention the change in the commit message isn't *too* bad,
because the change "only" corrects something new in this series, which
makes a future question "why did this go away?" relatively unlikely.

That said, I'm happy to respin if you think it's worthwhile.  Just ask.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/chardev/char-socket.c
>> @@ -444,14 +444,20 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>>          break;
>>      case SOCKET_ADDRESS_TYPE_UNIX:
>>      {
>> +        const char *tight = "", *abstract = "";
>>          UnixSocketAddress *sa = &s->addr->u.q_unix;
>>  
>> -        return g_strdup_printf("%sunix:%s%s%s%s", prefix,
>> -                               s->addr->u.q_unix.path,
>> -                               sa->has_abstract && sa->abstract
>> -                               ? ",abstract" : "",
>> -                               sa->has_tight && sa->tight
>> -                               ? ",tight" : "",
>
> Unconditional output if tight is true (which is its stated default)...
>
>> +#ifdef CONFIG_LINUX
>> +        if (sa->has_abstract && sa->abstract) {
>> +            abstract = ",abstract";
>> +            if (sa->has_tight && sa->tight) {
>> +                tight = ",tight";
>> +            }
>> +        }
>> +#endif
>> +
>> +        return g_strdup_printf("%sunix:%s%s%s%s", prefix, sa->path,
>> +                               abstract, tight,
>
> ...vs. the now-nicer conditional where tight is only present if abstract.


