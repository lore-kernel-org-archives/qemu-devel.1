Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5011220578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEwdSyTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5011220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuOl-0004q8-9T
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNuNQ-0002JT-UP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNuNO-00064c-QU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:51:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNuNO-00064A-MH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571989873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ATwRXB9PJ+nflcJPXGv328O1uY1JwoAsqnhbGQXOOk=;
 b=hEwdSyTgEzub3r5SY+A6neIhyA0nRIE89Li7H2XvnEWTciLECRPkP2ZYvlzzP1fjx3HEza
 eXpRzuclhvJL9A0YzyGJvm5XLAL3NgXgUM8NEswHgcY+B8LXcfY6XtrKye++et23nRPXyS
 ZojEZiu9JP5rsJtdG3QgIyCo9bNp+f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-5BfM57FkOnetmmMiDsieyw-1; Fri, 25 Oct 2019 03:51:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B83F7801E5C;
 Fri, 25 Oct 2019 07:51:10 +0000 (UTC)
Received: from localhost (ovpn-117-235.ams2.redhat.com [10.36.117.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 998F25D713;
 Fri, 25 Oct 2019 07:51:02 +0000 (UTC)
Date: Fri, 25 Oct 2019 09:51:00 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 06/11] qapi: add failover negotiated event
Message-ID: <20191025075100.i6dqqvnepghhd7ve@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-7-jfreimann@redhat.com>
 <878sp9mlpb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <878sp9mlpb.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5BfM57FkOnetmmMiDsieyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 07:35:28AM +0200, Markus Armbruster wrote:
>We ask patch submitters to cc: subject matter experts for review.  You
>did.  When such patches touch the QAPI schema, it's best to cc the qapi
>schema maintainers (Eric Blake and me) as well, because we can't require
>all subject matter experts to be fluent in the QAPI schema language and
>conventions.  I found this one more or less by chance.

Sorry about that, I'll make sure to get the right people next time.
>
>Jens Freimann <jfreimann@redhat.com> writes:
>
>> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY
>> feature was not negotiated during virtio feature negotiation. If this
>> event is received it means any primary devices hotplugged before
>> this were were never really added to QEMU devices.
>
>Too many negations for my poor old brain to process.

I'll try to explain better :)=20
>
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  qapi/net.json | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 728990f4fb..8c5f3f1fb2 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -737,3 +737,19 @@
>>  ##
>>  { 'command': 'announce-self', 'boxed': true,
>>    'data' : 'AnnounceParameters'}
>> +
>> +##
>> +# @FAILOVER_NEGOTIATED:
>> +#
>> +# Emitted when VIRTIO_NET_F_STANDBY was negotiated during feature negot=
iation
>> +#
>> +# Since: 4.2
>> +#
>> +# Example:
>> +#
>> +# <- { "event": "FAILOVER_NEGOTIATED",
>> +#      "data": {} }
>> +#
>> +##
>> +{ 'event': 'FAILOVER_NEGOTIATED',
>> +  'data': {} }
>
>The commit message at least tries to explain intended use.  The doc
>string does not.  Should it?

Sure, I'll add it.=20

Thanks for the review!

regards,
Jens=20


