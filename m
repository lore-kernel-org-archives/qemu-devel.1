Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD05C2D0CE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 18:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079BE20718
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBSaNo3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079BE20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ildJ3-00081W-54
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 13:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ildIS-0007am-DG
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 13:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ildIR-0000bq-BD
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 13:28:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ildIR-0000Yz-6n
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577644087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEtNjlYwPYbHAiQ6bbd0QXhqxpzdN9WWSE8qYoHKQcs=;
 b=HBSaNo3M31vUuRsG65ALvDtWBrCDWIucqiR2/qEhVM1zXFyoyqtI56mcyskfy/na6FD0IV
 I4cl6R59kRWUUWibwM1uxNCaHXs36Rd5nFNz5Z6biq37sFQpMM24kZRZJsYI+tX2jnyIQu
 H1JQ2SKYrMEtPE7BhtaeCWcZJAn8vLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-Zb2CUpqNNfmlGU-1N5MFlg-1; Sun, 29 Dec 2019 13:28:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E39800D41
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 18:28:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-53.ams2.redhat.com [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 663745D9E1;
 Sun, 29 Dec 2019 18:28:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 3/4] migration-test: Make sure that multifd and cancel
 works
In-Reply-To: <20191218162513.GI3707@work-vm> (David Alan Gilbert's message of
 "Wed, 18 Dec 2019 16:25:13 +0000")
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-4-quintela@redhat.com>
 <20191218162513.GI3707@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Sun, 29 Dec 2019 19:27:56 +0100
Message-ID: <87imlzkmvn.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Zb2CUpqNNfmlGU-1N5MFlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Test that this sequerce works:

>> +    /* 1 ms should make it not converge*/
>> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>> +    /* 1GB/s */
>> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>
> This is copied from postcopy_prepare, note that I dropped that bandwidth
> quite a bit in 513aa2c because we were seeing TCG on slow hosts converge
> even at 1ms, because the vCPU wasn't dirtying pages quickly.
>

We have to use a #define to have everything using the same.  Right now,
I am using the same that preoopy_tcp and that multifd :-(

>> +    migrate_set_parameter_int(from, "multifd-channels", 16);
>> +    migrate_set_parameter_int(to, "multifd-channels", 16);
>> +
>> +    migrate_set_capability(from, "multifd", "true");
>> +    migrate_set_capability(to, "multifd", "true");
>> +
>> +    /* Start incoming migration from the 1st socket */
>> +    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
>> +                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }=
}");
>> +    qobject_unref(rsp);
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    uri =3D migrate_get_socket_address(to, "socket-address");
>> +
>> +    migrate(from, uri, "{}");
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    printf("before cancel\n");
>> +    migrate_cancel(from);
>> +    printf("after cancel\n");
>
> Do you really want those printf's for normal operation?

Obviously no, thanks.

>> +
>> +    /* 300ms it should converge */
>> +    migrate_set_parameter_int(from, "downtime-limit", 600);
>
> Comment doesn't match parameter!

Ooops.

>
> With those fixed;

>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.


