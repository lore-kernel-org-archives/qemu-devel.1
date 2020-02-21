Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED5C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E8F206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NrTpoVPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E8F206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5A1f-0005BL-5V
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j5A0r-0004j6-Vs
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j5A0q-0000B5-VG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:14:45 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:48173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j5A0q-0008Uq-Cd; Fri, 21 Feb 2020 10:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=10GLkAv+F2bUb2vil2+jEU372eo/1bc1IPTo4nkjOvQ=; 
 b=NrTpoVPoDbIZeG/fvIKBKD7/TMe9Y6ugua+0U476i0f/QxM8GOc+Mup1l/72m52KVZfNeC9nnM0G1f8LUDLZLshz314HQ/ucCoSxL0FTVn3TgiaAwxYK2cwmLeK7S1xIXswqlsaPuWsIadUxtADdmUV8+wRy7NDe0yvT+xwAMxS9Nd6B1GmTdHcvB3FNB3tFVhsKIz5ntOqVZpWgsiNwA5PC9Z2GANCRsrDCNBV7t74EFDrnWUrsKusnFW/IFVe/p0YUiYyznmXP+dkybFtIWR6lTeeRimLqOEdeNVKfuncbK1ZLHOLkWJI7GBwIsczu3Ah/shHRW+2VjFmlb4azCw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j5A0W-0003e9-T5; Fri, 21 Feb 2020 16:14:24 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j5A0W-0001VL-JH; Fri, 21 Feb 2020 16:14:24 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 12/27] qcow2: Replace QCOW2_CLUSTER_* with
 QCOW2_SUBCLUSTER_*
In-Reply-To: <fffa7706-d88e-2c81-4b48-72d7e2df4bf2@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <ed8f4e6adb5390e31c217a6d6c21b77ef202437a.1577014346.git.berto@igalia.com>
 <fffa7706-d88e-2c81-4b48-72d7e2df4bf2@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 21 Feb 2020 16:14:24 +0100
Message-ID: <w515zg0q8fj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 21 Feb 2020 12:35:55 PM CET, Max Reitz wrote:
>> @@ -2223,22 +2227,23 @@ static coroutine_fn int qcow2_co_preadv_part(Blo=
ckDriverState *bs,
>>          }
>>=20=20
>>          qemu_co_mutex_lock(&s->lock);
>> -        ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &clust=
er_offset);
>> +        ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes,
>> +                                       &cluster_offset, &type);
>
> I wonder whether this is kind of a bug fix here.  It=E2=80=99s entirely p=
ossible
> that @ret isn=E2=80=99t set after this, and then we get to the =E2=80=9Co=
ut=E2=80=9D label,
> which has a check on =E2=80=9Cif (ret =3D=3D 0)=E2=80=9D.

I think that in order to get to "if (ret =3D=3D 0)" you would first need to
run aio_task_pool_new(), and that codepath guarantees that @ret is set.

Berto

