Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1144C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC092067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1wnbKEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC092067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih7Pr-0003Wo-RA
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 02:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih7PH-00033y-Ku
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih7PG-0002sU-FJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:36:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih7PG-0002nh-B0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576568193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOaJnuPtvZ0igsC2ovIN1cc8+zn4/KUI0cDuybQzIPk=;
 b=h1wnbKEJ7ntwmY/Zcx8OV37iQNko4Ciq+tOhLmeKrM5O23RQfjXRtCj8tjMWOQ+EhOegHv
 NrwuYm8w72C+dJ8e6weNYVW7gRmdxfFnTnS5p/cVu79xaC2CR7NP6R8kVffJOiifN8oTAo
 4VgvnjCxCUqPeO2anQmTJPaJ53BS/m8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-pmmVZK_ePFeLzYx1eTjX7w-1; Tue, 17 Dec 2019 02:36:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169B48024DD;
 Tue, 17 Dec 2019 07:36:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D606360BE0;
 Tue, 17 Dec 2019 07:36:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5537611386A7; Tue, 17 Dec 2019 08:36:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC] qapi: Allow getting flat output from
 'query-named-block-nodes'
References: <42dae98e1f6a9f444f48a20192f45195337824f0.1576246045.git.pkrempa@redhat.com>
 <836c1a18-b67d-0426-2137-8f464e4e5c9b@redhat.com>
Date: Tue, 17 Dec 2019 08:36:29 +0100
In-Reply-To: <836c1a18-b67d-0426-2137-8f464e4e5c9b@redhat.com> (Eric Blake's
 message of "Fri, 13 Dec 2019 09:23:35 -0600")
Message-ID: <87lfrbjtdu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pmmVZK_ePFeLzYx1eTjX7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/13/19 8:11 AM, Peter Krempa wrote:
>> When a management application manages node names there's no reason to
>> recurse into backing images in the output of query-named-block-nodes.
>>
>> Add a parameter to the command which will return just the top level
>> structs.
>
> At one point, Kevin was working on a saner command that tried to cut
> out on more than just the redundant nesting.  But this is certainly a
> quick-and-easy fix to ease libvirt's use of the existing command,
> while we decide whether to add a saner new command.

What exactly is the problem libvirt is having with the existing
query-named-block-nodes?

>>
>> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>> ---
>>   block.c               |  5 +++--
>>   block/qapi.c          | 10 ++++++++--
>>   blockdev.c            | 12 ++++++++++--
>>   include/block/block.h |  2 +-
>>   include/block/qapi.h  |  4 +++-
>>   monitor/hmp-cmds.c    |  2 +-
>>   qapi/block-core.json  |  6 +++++-
>>   7 files changed, 31 insertions(+), 10 deletions(-)
>>
>
>> +++ b/blockdev.c
>> @@ -3707,9 +3707,17 @@ void qmp_drive_backup(DriveBackup *arg, Error **e=
rrp)
>>       }
>>   }
>>
>> -BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
>> +BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
>> +                                                 bool flat,
>> +                                                 Error **errp)
>>   {
>> -    return bdrv_named_nodes_list(errp);
>> +    bool return_flat =3D false;
>> +
>> +    if (has_flat) {
>> +        return_flat =3D flat;
>> +    }
>
> This could be shortened as 'bool return_flat =3D has_flat && flat;', but
> that's not essential.

I'd prefer that.

Even return_flat =3D flat would do, because !has_flat implies !flat when
flat is bool.  Matter of taste.

>> +
>> +    return bdrv_named_nodes_list(return_flat, errp);
>>   }
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Un-snipping the QAPI schema change:

>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0cf68fea14..bd651106bd 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1752,6 +1752,8 @@
>>  #
>>  # Get the named block driver list
>>  #
>> +# @flat: don't recurse into backing images if true. Default is false (S=
ince 5.0)
>> +#
>>  # Returns: the list of BlockDeviceInfo
>>  #
>>  # Since: 2.0

What does it mean not to recurse?  Sounds like flat: false asks for a
subset of the full set.  How exactly is the subset defined?

>> @@ -1805,7 +1807,9 @@
>>  #                    } } ] }
>>  #
>>  ##
>> -{ 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' =
] }
>> +{ 'command': 'query-named-block-nodes',
>> +  'returns': [ 'BlockDeviceInfo' ],
>> +  'data': { '*flat': 'bool' } }
>>=20
>>  ##
>>  # @XDbgBlockGraphNodeType:


