Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA0E20769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqir8LVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA0E20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZPi-0000Mt-RE
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMZOW-0007uS-8E
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMZOU-0003nG-TQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:47:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMZOU-0003ju-QP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586447222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SnoqIWJLdqz7zO7Umi3yzoNXL2HaHL7mANxY0tVX3g=;
 b=Xqir8LVimHfIWyMWGXAyxCU+FRtUVEg0mlmY3a5JJ6HoaTNSeN8cbPX94WGcq0bq9Wwab3
 HgYr8ByAWfbRK53kou6sZdfxjDMwR1o9iTMrhezjbTXY59vSGiDffrnvB49ftX7jaZb2gK
 jp58A67nbZVxa6yr7SqQanWVxFg2xSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-eoFD45Q8MiGaVf8zLzBeew-1; Thu, 09 Apr 2020 11:46:59 -0400
X-MC-Unique: eoFD45Q8MiGaVf8zLzBeew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172CD8017FC;
 Thu,  9 Apr 2020 15:46:58 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93E6352735;
 Thu,  9 Apr 2020 15:46:57 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
 <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
 <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
 <713d39ff-29f6-f9e0-bbbc-c9b26ffd28a0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5a8099d6-3885-2bfe-f85a-477c5cc76a45@redhat.com>
Date: Thu, 9 Apr 2020 10:46:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <713d39ff-29f6-f9e0-bbbc-c9b26ffd28a0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 10:01 AM, Max Reitz wrote:
> On 09.04.20 16:32, Eric Blake wrote:
>> On 4/9/20 9:10 AM, Max Reitz wrote:
>>
>>>>
>>>> What happens when an operation attempts to unmap things?=C2=A0 Do we r=
eject
>>>> all unmap operations when data-file-raw is set (thus leaving a cluster
>>>> marked as allocated at all times, if we can first guarantee that
>>>> preallocation set things up that way)?
>>> No, unmap operations currently work.=C2=A0 qcow2_free_any_clusters() pa=
sses
>>> them through to the external data file.
>>>
>>> The problem is that the unmap also zeroes the L2 entry, so if you then
>>> write data to the raw file, it won=E2=80=99t be visible from the qcow2 =
side of
>>> things.=C2=A0 However, I=E2=80=99m not sure whether we support modifica=
tions of a raw
>>> file when it is already =E2=80=9Cin use=E2=80=9D by a qcow2 image, so m=
aybe that=E2=80=99s fine.
>>
>> We don't support concurrent modification. But if the guest is running
>> and unmaps things, then shuts off, then we edit the raw file offline,
>> then we restart the guest, the guest should see the results of those
>> offline edits.
>=20
> Should it?  The specification doesn=E2=80=99t say anything about that.
>=20
> In fact, I think we have always said we explicitly discourage that
> because this might lead to outdated metadata; even though we usually
> meant =E2=80=9Cdirty bitmaps=E2=80=9D by that.

Hmm.  Kevin, I'd really like your opinion here.  The point of the=20
raw-external-data flag is to state that "qemu MUST ensure that whatever=20
is done to this image while the guest is running is reflected through to=20
the raw file, so that after the guest stops, the raw file alone is still=20
viable to see what the guest saw".  But as you say, there's a difference=20
between "the raw file will read what the guest saw" and "we can now edit=20
the raw file without regards to the qcow2 wrapper but later reuse of the=20
qcow2 wrapper won't be corrupted by those edits".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


