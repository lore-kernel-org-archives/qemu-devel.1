Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F67C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3961D2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNSqYvjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3961D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjKM-0003zO-7a
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOjJP-0003Ty-PF
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOjJO-0008Sn-Oa
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:46:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOjJO-0008SQ-Ku
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586962006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+ZwMAQ2iAnlwWMs/gULWBkVLWAeamXQUcrZd6eIC3A=;
 b=WNSqYvjdDam2EUlVuDCplGMprN6FNqtsVKCFwTBoKWVD+FEF6zYP/I4flCF36gV0+mmEjN
 z1xHV2wONNE1/gbxyJ0yHiLrTuOQWvOBTlD5tLm/XO37s3B0cxGh3N9bNTdUBuDzthk7UN
 qWvzim1N8qj+tCLNAxwhznBDiv4ptsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-U6Seu9ZjO3yztNoRZqtcTA-1; Wed, 15 Apr 2020 10:46:44 -0400
X-MC-Unique: U6Seu9ZjO3yztNoRZqtcTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52842107ACCC;
 Wed, 15 Apr 2020 14:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D79711A267;
 Wed, 15 Apr 2020 14:46:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AAF711385C8; Wed, 15 Apr 2020 16:46:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 2/5] qobject: Factor out helper
 json_pretty_newline()
References: <20200415083048.14339-1-armbru@redhat.com>
 <20200415083048.14339-3-armbru@redhat.com>
 <344e1038-827a-7dea-7e73-b83b899673ed@redhat.com>
Date: Wed, 15 Apr 2020 16:46:41 +0200
In-Reply-To: <344e1038-827a-7dea-7e73-b83b899673ed@redhat.com> (Eric Blake's
 message of "Wed, 15 Apr 2020 07:28:13 -0500")
Message-ID: <87lfmwg626.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/15/20 3:30 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/qjson.c | 40 ++++++++++++++++------------------------
>>   1 file changed, 16 insertions(+), 24 deletions(-)
>>
>> diff --git a/qobject/qjson.c b/qobject/qjson.c
>> index db36101f3b..f3c62711b9 100644
>> --- a/qobject/qjson.c
>> +++ b/qobject/qjson.c
>> @@ -159,21 +159,28 @@ typedef struct ToJsonIterState
>>     static void to_json(const QObject *obj, QString *str, int
>> pretty, int indent);
>>   +static void json_pretty_newline(QString *str, bool pretty, int
>> indent)
>> +{
>> +    int i;
>> +
>> +    if (pretty) {
>> +        qstring_append(str, "\n");
>> +        for (i =3D 0 ; i < indent ; i++) {
>
> Why are you keeping the spaces before ; ?  Yes, I know they were
> copied-and-pasted from the old code, but as long as you are
> refactoring, fixing the style is worthwhile.

Makes sense.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


