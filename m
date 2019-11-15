Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB9C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 21:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0813220733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 21:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiH7f7Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0813220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVjBi-0007jh-2D
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 16:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVjAY-0006r9-EH
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 16:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVjAV-0005Zt-Pw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 16:30:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVjAV-0005Yk-Et
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 16:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573853414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lYWMkZZiaulypyhni8YO70bQ86gXc3YrlRubpo3PN4=;
 b=eiH7f7PrlH9IzTuX+OupdGoLYml2iT3W61BvWgikIZJaR/jnLvIgeW6p8mR9UwE7ZcYzyj
 uBz5HQp0T2gLhArCm7SxwoIZ0+c3LdWhX4VOc8eUCCJsVdruhFVp5QiQi0VwvwaYE0ksKw
 Cr8nOFM6/T789mhK7x6/lP+X1IVr0vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-ycE7aQbDMQWlHvl-2_86Pg-1; Fri, 15 Nov 2019 16:30:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31365802682;
 Fri, 15 Nov 2019 21:30:10 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51A4E6609A;
 Fri, 15 Nov 2019 21:30:09 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] nbd: Don't send oversize strings
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-4-eblake@redhat.com>
 <d9106b80-ee4c-ef0c-0e53-ef4e9ab9c906@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <15cf4691-d890-4ff9-d7fb-11af12d523f6@redhat.com>
Date: Fri, 15 Nov 2019 15:30:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d9106b80-ee4c-ef0c-0e53-ef4e9ab9c906@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ycE7aQbDMQWlHvl-2_86Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 11:08 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.11.2019 5:46, Eric Blake wrote:
>> Qemu as server currently won't accept export names larger than 256
>> bytes, nor create dirty bitmap names longer than 1023 bytes, so most
>> uses of qemu as client or server have no reason to get anywhere near
>> the NBD spec maximum of a 4k limit per string.
>>
>> However, we weren't actually enforcing things, ignoring when the
>> remote side violates the protocol on input, and also having several
>> code paths where we send oversize strings on output (for example,
>> qemu-nbd --description could easily send more than 4k).  Tighten
>> things up as follows:
>>
>> client:
>> - Perform bounds check on export name and dirty bitmap request prior
>>     to handing it to server
>> - Validate that copied server replies are not too long (ignoring
>>     NBD_INFO_* replies that are not copied is not too bad)
>> server:
>> - Perform bounds check on export name and description prior to
>>     advertising it to client
>> - Reject client name or metadata query that is too long
>> - Adjust things to allow full 4k name limit rather than previous
>>     256 byte limit
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; I'm queuing 1-3 in my NBD tree for -rc2.

>=20
> Still, same doubt about putting over-sized strings into error messages. I=
f you
> decide to drop them, keep my r-b.
>=20
> =3D=3D=3D=3D=3D=3D
>=20
> Not very simple to review, as I need to check that all assertions will no=
t fire.
> Hope you don't mind me doing it here)

Not at all; your thorough review is appreciated.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


