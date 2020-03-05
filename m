Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFEEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9A205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nvol41tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pLE-00053P-Bi
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9pKN-0003un-SZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9pKM-00066a-Fs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:10:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9pKM-00064N-BE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ai78hO+qH+uqyZg9Mamcj6w2vQyadmSV06iIgWeclWE=;
 b=Nvol41tn3TIGgUA77CXWAFNksbrjVw9HL68rYmjhJCvhR9eR6WncTDRJ09RISaiF+fOalv
 Nwv19ghSEKpkpWxyCPu4qNjvysUabynvWSteIfEf9zuTeq2B+xMOARYr5e1fwkEgQ3+Gd9
 CIL5TLkMaKhKIyAuaMLvZ4wnY+xsX/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-bQvArdOKMw-vBsORZ1ow0Q-1; Thu, 05 Mar 2020 07:10:05 -0500
X-MC-Unique: bQvArdOKMw-vBsORZ1ow0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03A4100550E;
 Thu,  5 Mar 2020 12:10:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0CBE5DA7B;
 Thu,  5 Mar 2020 12:10:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10ABA11386A6; Thu,  5 Mar 2020 13:10:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v5 4/5] qcow2: add zstd cluster compression
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-5-dplotnikov@virtuozzo.com>
 <e95bf0d3-7caf-91a1-b8cd-615d6d1a9d9d@virtuozzo.com>
Date: Thu, 05 Mar 2020 13:10:00 +0100
In-Reply-To: <e95bf0d3-7caf-91a1-b8cd-615d6d1a9d9d@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Mar 2020 12:56:40 +0300")
Message-ID: <87eeu7f1ev.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 04.03.2020 16:35, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>>    time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|zstd]
>>                    src.img [zlib|zstd]_compressed.img
>> decompress cmd
>>    time ./qemu-img convert -O qcow2
>>                    [zlib|zstd]_compressed.img uncompressed.img
>>
>>             compression               decompression
>>           zlib       zstd           zlib         zstd
>> ------------------------------------------------------------
>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>> user     65.0       15.8            5.3          2.5
>> sys       3.3        0.2            2.0          2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Looks a bit like I've reviewed only QAPI part, when actually my r-b is fo=
r full patch...
>
> May be
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>           [QAPI part]
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No objection.

We habitually use

  Acked-by: Markus Armbruster <armbru@redhat.com>
  Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I'm okay with that, too.


