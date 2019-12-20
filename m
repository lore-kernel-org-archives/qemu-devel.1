Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85686C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D9C2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PR/Snl9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D9C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHkJ-0003fx-D2
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiHj0-0002Py-R5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiHiz-0008Q3-B5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:49:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiHiz-0008NC-3Z
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576846184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTDJLdbJSnmyKsrmGayzka1QijWpKBAd6sMRgDG9Z/A=;
 b=PR/Snl9/x2mmp3qYFpm528+qHSkqaYl4Px/V51sWvJe0LHFiDAEqUEzFEUQ3Foh3TOp+7l
 uMTJKc8NSZbgtdAqtDxuq5PjW2QxIyrT8y9/hDWm1Hn1ksqHLtoAJSCzQw7INYHVVavTBS
 7OfeOzMqrzijimimGXZS4vHV2UyetxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-7rqVhNG7MyCXifVwRwZLrA-1; Fri, 20 Dec 2019 07:49:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A070D10054E3;
 Fri, 20 Dec 2019 12:49:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E5195DA2C;
 Fri, 20 Dec 2019 12:49:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C0A111386A7; Fri, 20 Dec 2019 13:49:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
Date: Fri, 20 Dec 2019 13:49:32 +0100
In-Reply-To: <20191220102656.GD4019@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 20 Dec 2019 11:26:56 +0100")
Message-ID: <87lfr7go0z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7rqVhNG7MyCXifVwRwZLrA-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
>> fuse-export-add allows mounting block graph nodes via FUSE on some
>> existing regular file.  That file should then appears like a raw disk
>> image, and accesses to it result in accesses to the exported BDS.
>>=20
>> Right now, we only set up the mount point and tear all mount points down
>> in bdrv_close_all().  We do not implement any access functions, so
>> accessing the mount point only results in errors.  This will be
>> addressed by a followup patch.
>>=20
>> The set of exported nodes is kept in a hash table so we can later add a
>> fuse-export-remove that allows unmounting.
>>=20
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 145c268bb6..03f8d1b537 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -317,6 +317,29 @@
>>  ##
>>  { 'command': 'nbd-server-stop' }
>> =20
>> +##
>> +# @fuse-export-add:
>> +#
>> +# Exports a block graph node on some (file) mountpoint as a raw image.
>> +#
>> +# @node-name: Node to be exported
>> +#
>> +# @mountpoint: Path on which to export the block device via FUSE.
>> +#              This must point to an existing regular file.
>> +#
>> +# @writable: Whether clients should be able to write to the block
>> +#            device via the FUSE export. (default: false)
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'command': 'fuse-export-add',
>> +  'data': {
>> +      'node-name': 'str',
>> +      'mountpoint': 'str',
>> +      '*writable': 'bool'
>> +  },
>> +  'if': 'defined(CONFIG_FUSE)' }
>
> Can this use a BlockExport union from the start like I'm introducing in
> the storage daemon series, together with a generic block-export-add?
>
> It also looks like node-name and writable should be part of the common
> base of BlockExport. Unfortunately this would mean that I can't use the
> same BlockExportNbd for the existing nbd-server-add command any more. I
> guess I could somehow get a shared base type for both, though.
>
> Markus, any thoughts on these QAPI interfaces?

Context?  How far back should I read?


