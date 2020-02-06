Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFEBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFDD206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXILPSpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFDD206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36275 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf8P-0008Cm-VV
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izete-0006Cj-DH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izetc-0004ZO-MX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:00:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izetc-0004VM-HL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580986832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=+rg27dlHYRZaxBCxoo0CQU8VDaQbMcMRvmbj0ClGVSo=;
 b=AXILPSpGrXHKzOhoiic6xP5EtTNodR0UhcGEcqq23l8qYewywq70zVSr9LQm6fjI3SGsWj
 Y194AWnE6Ma6MikmhmMMyK7NTfnmeFyEHgGtMoFrzNmugAroDz38l8inufLpGJnE/rsbtp
 e9SoPPMQ7rvPN9l62zTS7eUZniiHk+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Sh-vYLN9MBG36ImOjnT4Gg-1; Thu, 06 Feb 2020 06:00:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5212B8010CB;
 Thu,  6 Feb 2020 11:00:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2B15DA7E;
 Thu,  6 Feb 2020 11:00:21 +0000 (UTC)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <896302f7-ec21-6108-6dde-f5a7439d87ab@redhat.com>
Date: Thu, 6 Feb 2020 12:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Sh-vYLN9MBG36ImOjnT4Gg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 11.09, Christian Borntraeger wrote:
>=20
>=20
> On 05.02.20 19:21, Jason J. Herne wrote:
>> This fixes vfio-ccw when booting non-Linux operating systems. Without th=
is
>> struct being packed, a few extra bytes of low core memory get overwritte=
n when
>> we  assign a value to memory address 0 in jump_to_IPL_2. This is enough =
to
>> cause some non-Linux OSes of fail when booting.
>>
>> The problem was introduced by:
>> 5c6f0d5f46a77d77 "pc-bios/s390x: Fix reset psw mask".
>>
>> The fix is to pack the struct thereby removing the 4 bytes of padding th=
at get
>> added at the end, likely to allow an array of these structs to naturally=
 align
>> on an 8-byte boundary.
>>
>> Fixes: 5c6f0d5f46a7 ("pc-bios/s390x: Fix reset psw mask")
>> CC: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/jump2ipl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>> index da13c43cc0..1e9eaa037f 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -18,7 +18,7 @@
>>  typedef struct ResetInfo {
>>      uint64_t ipl_psw;
>>      uint32_t ipl_continue;
>> -} ResetInfo;
>> +} __attribute__((packed)) ResetInfo;
>> =20
>>  static ResetInfo save;
>=20
> Just looked into that.
>=20
> We do save the old content in "save" and restore the old memory content.
>=20
> static void jump_to_IPL_2(void)
> {
>     ResetInfo *current =3D 0;
>=20
>     void (*ipl)(void) =3D (void *) (uint64_t) current->ipl_continue;
> --->*current =3D save;
>     ipl(); /* should not return */
> }
>=20
> void jump_to_IPL_code(uint64_t address)
> {
>     /* store the subsystem information _after_ the bootmap was loaded */
>     write_subsystem_identification();
>=20
>     /* prevent unknown IPL types in the guest */
>     if (iplb.pbt =3D=3D S390_IPL_TYPE_QEMU_SCSI) {
>         iplb.pbt =3D S390_IPL_TYPE_CCW;
>         set_iplb(&iplb);
>     }
>=20
>     /*
>      * The IPL PSW is at address 0. We also must not overwrite the
>      * content of non-BIOS memory after we loaded the guest, so we
>      * save the original content and restore it in jump_to_IPL_2.
>      */
>     ResetInfo *current =3D 0;
>=20
> --->save =3D *current;

Right, and this should also work without your modification. I've stared
at the code a couple of weeks ago, looking for a very similar issue:

 https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03484.html

... but in the end, the problem was something else:

 https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03520.html

and the fix had been done in the startup code of the test:

 https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04225.html

So I'd guess that you face the very same problem here. That means, you
either have to convince the non-Linux OS to check their startup code
whether they depend on zeroed registers somewhere, or we fix this issue
for good in jump_to_IPL_2() by clearing the registers there before
jumping into the OS code (which we likely should do anyway since the OS
may expect a clean state).

 Thomas


