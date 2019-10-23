Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A79BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449F920650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPUhVhzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449F920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFAE-0005lz-7v
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNEtB-00086G-SL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNEtA-0003oQ-Ls
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:33:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNEtA-0003oK-Hr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571830396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eU5g1UeZOxkZuc38LGAeFmPpsDbBPjfhepyp9TW5HI=;
 b=UPUhVhzsg+44moRRJWsQj+F47XrR+iWMX6zQFbgATYgPg9InHY+KQr9UlUfL+GpaIy0evA
 WSJie9WesxJMddluA0aX6SRkiHoo7nWiQ0d6Mw528t9hbHTQXeAU3IFPrS9led2KuDOve+
 GmUbtTMjhYDJnwRV+gm6tgdBrv15rfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-7EGQ1fTJNBC_Lle9iKDNiQ-1; Wed, 23 Oct 2019 07:33:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A401800D6B;
 Wed, 23 Oct 2019 11:33:09 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A84219C70;
 Wed, 23 Oct 2019 11:33:07 +0000 (UTC)
Subject: Re: [PATCH v10 3/3] iotests: test nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
 <20191009084158.15614-4-vsementsov@virtuozzo.com>
 <0c87e5cd-cddf-b91a-3cca-fa3af9799d2b@redhat.com>
 <45ff7437-6b8a-c430-5a19-06ccd9742f5e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6d0245f0-7d31-fe32-48ad-3964d18eda20@redhat.com>
Date: Wed, 23 Oct 2019 06:33:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <45ff7437-6b8a-c430-5a19-06ccd9742f5e@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7EGQ1fTJNBC_Lle9iKDNiQ-1
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 3:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.10.2019 4:31, Eric Blake wrote:
>> On 10/9/19 3:41 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add test, which starts backup to nbd target and restarts nbd server
>>> during backup.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---

>>> +vm.qmp_log('blockdev-backup', device=3D'drive0', sync=3D'full', target=
=3D'backup0',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 speed=3D(=
1 * 1024 * 1024))
>>
>> This starts the job throttled, to give us time...
>>
>>> +
>>> +# Wait for some progress
>>> +t =3D 0
>>> +while t < wait_limit:
>>> +=C2=A0=C2=A0=C2=A0 jobs =3D vm.qmp('query-block-jobs')['return']
>>> +=C2=A0=C2=A0=C2=A0 if jobs and jobs[0]['offset'] > 0:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>>> +=C2=A0=C2=A0=C2=A0 time.sleep(wait_step)
>>> +=C2=A0=C2=A0=C2=A0 t +=3D wait_step
>>> +
>>> +if jobs and jobs[0]['offset'] > 0:
>>> +=C2=A0=C2=A0=C2=A0 log('Backup job is started')
>>> +
>>> +log('Kill NBD server')
>>> +srv.kill()
>>> +srv.wait()
>>> +
>>> +jobs =3D vm.qmp('query-block-jobs')['return']
>>> +if jobs and jobs[0]['offset'] < jobs[0]['len']:
>>> +=C2=A0=C2=A0=C2=A0 log('Backup job is still in progress')
>>> +
>>> +vm.qmp_log('block-job-set-speed', device=3D'drive0', speed=3D0)

Ah, I overlooked this line in my late-night review.

>>> +
>>> +# Emulate server down time for 1 second
>>> +time.sleep(1)
>>
>> ...but once we restart,...
>>
>>> +
>>> +log('Start NBD server')
>>> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
>>> +
>>> +e =3D vm.event_wait('BLOCK_JOB_COMPLETED')
>>
>> ...should we unthrottle the job to allow the test to complete slightly f=
aster after the reconnect?=C2=A0 But that can be done as an improvement on =
top, if it helps.
>=20
> It is done above, before time.sleep(1)

Yep, so I feel better now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


