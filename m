Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CA5C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD20207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD20207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulHc-0006Ih-Mh
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1iulH5-0005mj-7J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1iulH4-0004et-7S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:48:31 -0500
Received: from kerio.kamp.de ([195.62.97.192]:58329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1iulH1-0004Yl-OC; Thu, 23 Jan 2020 17:48:27 -0500
X-Footer: a2FtcC5kZQ==
Received: from [82.141.7.52] ([79.200.90.31]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 23 Jan 2020 23:48:15 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Peter Lieven <pl@kamp.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Date: Thu, 23 Jan 2020 23:48:16 +0100
Message-Id: <BFA6442C-B2B1-4EA7-97B1-CC1DE7A1855B@kamp.de>
References: <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
In-Reply-To: <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: iPhone Mail (17C54)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, ronniesahlberg@gmail.com, felipe@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.01.2020 um 21:38 schrieb John Snow <jsnow@redhat.com>:
>=20
> =EF=BB=BF
>=20
>> On 1/23/20 12:05 PM, Kevin Wolf wrote:
>> In iscsi_co_block_status(), we may have received num_descriptors =3D=3D 0=

>> from the iscsi server. Therefore, we can't unconditionally access
>> lbas->descriptors[0]. Add the missing check.
>>=20
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> block/iscsi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index cbd57294ab..c8feaa2f0e 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -753,7 +753,7 @@ retry:
>>     }
>>=20
>>     lbas =3D scsi_datain_unmarshall(iTask.task);
>> -    if (lbas =3D=3D NULL) {
>> +    if (lbas =3D=3D NULL || lbas->num_descriptors =3D=3D 0) {
>>         ret =3D -EIO;
>>         goto out_unlock;
>>     }
>>=20
>=20
> Naive question: Does the specification allow for such a response? Is
> this inherently an error?

The spec says the answer SHALL contain at least one lbasd. So I think threat=
ing zero as an error is okay

Anyway,

Reviewed-by: Peter Lieven <pl@kamp.de>

Peter



