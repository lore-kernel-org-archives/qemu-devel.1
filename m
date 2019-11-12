Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAC821D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC6W1tdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAC821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUY3n-0000b4-CO
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1iUY2i-0007hh-A4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1iUY2h-0005GZ-5D
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:25:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1iUY2h-0005G8-1O
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573572318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z67yfXaSOWDYhSiwyMrm96n26qIeGtERwwBi3Wv+KeM=;
 b=jC6W1tdQYt4tjVGhNUIgpQ3Vbh/e8rJoTLIQsgVzsgur71cOio/4TWlg7ZSdZb43glLuwN
 asG9PCOTtz/IuCRMKpRXgpi48Ksz8PaW8XtXMH7BJCx99+nOfXZG19QWz9MUtXswFVa0tu
 je5vUzB/2O5wD1EepqQEgUy0Uxz72YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-8W45cQgoNfqHAqHMRVNdgQ-1; Tue, 12 Nov 2019 10:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418BC8C652F
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 15:25:16 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87692816E;
 Tue, 12 Nov 2019 15:25:12 +0000 (UTC)
Subject: Re: [PATCH 2/2] vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
To: Cornelia Huck <cohuck@redhat.com>
References: <cover.1573468531.git.mprivozn@redhat.com>
 <14247f68a13c7b9292b91eb7df02de9b9d248544.1573468531.git.mprivozn@redhat.com>
 <20191111121523.4e692f1f.cohuck@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <cdaf4c86-7704-367e-e044-383c34cbbc1e@redhat.com>
Date: Tue, 12 Nov 2019 16:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111121523.4e692f1f.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8W45cQgoNfqHAqHMRVNdgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/19 12:15 PM, Cornelia Huck wrote:
> On Mon, 11 Nov 2019 11:37:42 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
>=20
>> The qemu_vfio_open_pci() allocates this QEMUVFIOState structure
>> but free counterpart is missing. Since we already have
>> qemu_vfio_close() which does cleanup of the state, it looks like
>> a perfect place to free the structure too.
>>
>> =3D=3D178278=3D=3D 528 (360 direct, 168 indirect) bytes in 1 blocks are =
definitely lost in loss record 6,605 of 6,985
>> =3D=3D178278=3D=3D    at 0x4A35476: calloc (vg_replace_malloc.c:752)
>> =3D=3D178278=3D=3D    by 0x51B1158: g_malloc0 (in /usr/lib64/libglib-2.0=
.so.0.6000.6)
>> =3D=3D178278=3D=3D    by 0xA68613: qemu_vfio_open_pci (vfio-helpers.c:42=
8)
>> =3D=3D178278=3D=3D    by 0x9779EA: nvme_init (nvme.c:606)
>> =3D=3D178278=3D=3D    by 0x97830F: nvme_file_open (nvme.c:795)
>> =3D=3D178278=3D=3D    by 0x8E9439: bdrv_open_driver (block.c:1293)
>> =3D=3D178278=3D=3D    by 0x8E9E1C: bdrv_open_common (block.c:1553)
>> =3D=3D178278=3D=3D    by 0x8ED264: bdrv_open_inherit (block.c:3083)
>> =3D=3D178278=3D=3D    by 0x8ED79D: bdrv_open (block.c:3176)
>> =3D=3D178278=3D=3D    by 0x5DA5C1: bds_tree_init (blockdev.c:670)
>> =3D=3D178278=3D=3D    by 0x5E2B64: qmp_blockdev_add (blockdev.c:4354)
>> =3D=3D178278=3D=3D    by 0x5ECB1D: configure_blockdev (vl.c:1202)
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   util/vfio-helpers.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index 813f7ec564..5ff91c1e5c 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -721,4 +721,5 @@ void qemu_vfio_close(QEMUVFIOState *s)
>>       close(s->device);
>>       close(s->group);
>>       close(s->container);
>> +    g_free(s);
>=20
> Not sure if freeing the parameter passed in via a function called
> 'close' isn't too surprising... it's not that obvious that the caller
> is also relinquishing its reference to the QEMUVFIOState; maybe rename
> the function to qemu_vfio_close_and_free() or so?

Alright, I'll rename the function. I worry that if free is left as an=20
exercise to caller then it'll be always forgotten about. That's why I=20
put the call into close function.

Michal


