Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CAEC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E28A206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEqfwfFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E28A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLgmL-0001DJ-80
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jLgle-0000ib-Q7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jLgld-0005TO-D6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:27:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jLgld-0005Sc-2W
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586237238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fGOb894axs0XJifkvixqa9caiiR06E1mZ3Cl7g6RL0=;
 b=FEqfwfFJEunYwCrPhycCXOSfilG2yHxeuTiA8lPim2YyJOMK8TKFRKXMnqnosCghX8UTTr
 eq/+JV9FbhcOHbVD6iZucce1jk+74IcieAfG+ejTXVDhMSe10m4SKGyp/wy+X3eC5nCjv4
 TB1Ks1P7JzS6N9nbGnChrCCkyD68AK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-08nPnoCOPy27oa8vmU-_wg-1; Tue, 07 Apr 2020 01:27:17 -0400
X-MC-Unique: 08nPnoCOPy27oa8vmU-_wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5852800D50;
 Tue,  7 Apr 2020 05:27:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FED15C1BB;
 Tue,  7 Apr 2020 05:27:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3E9811385C8; Tue,  7 Apr 2020 07:27:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH for-5.0] xen-block: Fix uninitialized variable
References: <20200406164207.1446817-1-anthony.perard@citrix.com>
 <325e0ffb-2f1b-cbfd-6b24-0d912a9aabe2@redhat.com>
 <20200406171637.GU4088@perard.uk.xensource.com>
Date: Tue, 07 Apr 2020 07:27:13 +0200
In-Reply-To: <20200406171637.GU4088@perard.uk.xensource.com> (Anthony PERARD's
 message of "Mon, 6 Apr 2020 18:16:37 +0100")
Message-ID: <87imibzwzy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, xen-devel@lists.xenproject.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anthony PERARD <anthony.perard@citrix.com> writes:

> On Mon, Apr 06, 2020 at 06:50:41PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 4/6/20 6:42 PM, Anthony PERARD wrote:
>> > Since 7f5d9b206d1e ("object-add: don't create return value if
>> > failed"), qmp_object_add() don't write any value in 'ret_data', thus
>> > has random data. Then qobject_unref() fails and abort().
>> >=20
>> > Fix by initialising 'ret_data' properly.
>>=20
>> Or move qobject_unref() after the error check?
>>=20
>> -- >8 --
>> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
>> index 07bb32e22b..f3f1cbef65 100644
>> --- a/hw/block/xen-block.c
>> +++ b/hw/block/xen-block.c
>> @@ -869,7 +869,6 @@ static XenBlockIOThread *xen_block_iothread_create(c=
onst
>> char *id,
>>      qdict_put_str(opts, "id", id);
>>      qmp_object_add(opts, &ret_data, &local_err);
>>      qobject_unref(opts);
>> -    qobject_unref(ret_data);
>>=20
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>> @@ -878,6 +877,7 @@ static XenBlockIOThread *xen_block_iothread_create(c=
onst
>> char *id,
>>          g_free(iothread);
>>          return NULL;
>>      }
>> +    qobject_unref(ret_data);
>
> That won't help, qmp_object_add() doesn't change the value of ret_data
> at all. The other users of qmp_object_add() passes an initialised
> 'ret_data', so we should do the same I think.

Since the QMP core does it, other callers should do it, too.

For QAPI commands that don't return anything, the marshaller should not
use @ret_data, let alone store through it.  qmp_object_add() complies.
Thus, assert(!ret_data) would do.  qobject_unref(ret_data) is also
correct.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


