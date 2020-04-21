Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4FA2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxB0aJ7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4FA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQkzG-0005Mv-1W
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 00:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQkyJ-0004qN-J3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQkyJ-0006LP-67
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:57:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQkyI-0006I8-Nv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587445041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gURgSjXDDOdGebhB/YRjeElODf7qLTiY5ZT3TWC4M10=;
 b=FxB0aJ7Bpb68yw0AWS9PScB3uyTh2PnrCnIsu90Xn6VOxwYogbFcRMTwsiNQIEpRSHGHWo
 htnWZ5coh+ky1u7hvkMOtxPb2+1qjcXayWxDiY7WSM8uIzJ1GZUTYM67T+WEiCdpoT3r7r
 W+QxNo6bpuURNtfURIC/iBAw2666YJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-NJ9g23P6O6yzoEfQBLHP9g-1; Tue, 21 Apr 2020 00:57:17 -0400
X-MC-Unique: NJ9g23P6O6yzoEfQBLHP9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD1DDB65;
 Tue, 21 Apr 2020 04:57:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 759F86092D;
 Tue, 21 Apr 2020 04:57:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C90CF11358BC; Tue, 21 Apr 2020 06:57:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 4/4] smbus: Fix spd_data_generate() for number of banks > 2
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-5-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201623041.29873@zero.eik.bme.hu>
Date: Tue, 21 Apr 2020 06:57:13 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004201623041.29873@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Mon, 20 Apr 2020 16:37:30 +0200 (CEST)")
Message-ID: <87pnc15tcm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:40:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>> spd_data_generate() splits @ram_size bytes into @nbanks RAM banks of
>> 1 << sz_log2 MiB each, like this:
>>
>>    size =3D ram_size >> 20; /* work in terms of megabytes */
>>    [...]
>>    nbanks =3D 1;
>>    while (sz_log2 > max_log2 && nbanks < 8) {
>>        sz_log2--;
>>        nbanks++;
>>    }
>>
>> Each iteration halves the size of a bank, and increments the number of
>> banks.  Wrong: it should double the number of banks.
>
> Hmm, why? SPD data has: spd[5]: Number of RAM banks on module (1=E2=80=93=
255)
> (and for DDR2: Ranks-1 (0=E2=80=937)). So nothing says it has to be power=
 of 2
> even if it's commonly 2 or 4. Does this break anything that needs this
> to be power of 2? Otherwise I thik this change is wrong.

Yes, SPD data does not require the number of banks to be a power of two.
But that's not why the loop above is wrong.  To see, let's execute it on
e-paper for type =3D SDR (thus max_log2 =3D 9) and ram_size =3D 2048 MiB:

    iteration   sz_log2  nbanks  bank size  total size
    0           11       1       2048 MiB   2048 MiB
    1           10       2       1024 MiB   2048 MiB
    2            9       3        512 MiB   1536 MiB    Oops!

The loop is wrong, because it fails to maintain its invariant

    nbanks * (1ull << sz_log2) =3D=3D size

If you ever need magic to come up with nbanks that aren't powers of two,
you'll have to replace this loop.

But I'd rip it out instead, and ...

>> The bug goes back all the way to commit b296b664ab "smbus: Add a
>> helper to generate SPD EEPROM data".
>>
>> It can't bite because spd_data_generate()'s current users pass only
>> @ram_size that result in *zero* iterations:
>>
>>    machine     RAM size    #banks  type    bank size
>>    fulong2e     256 MiB         1   DDR      256 MiB
>>    sam460ex    2048 MiB         1   DDR2    2048 MiB
>>                1024 MiB         1   DDR2    1024 MiB
>>                 512 MiB         1   DDR2     512 MiB
>>                 256 MiB         1   DDR2     256 MiB
>>                 128 MiB         1   SDR      128 MiB
>>                  64 MiB         1   SDR       64 MiB
>>                  32 MiB         1   SDR       32 MiB
>>
>> Apply the obvious, minimal fix.  I admit I'm tempted to rip out the
>> unused (and obviously untested) feature instead, because YAGNI.

... have the board code pass the number of banks.

>> Note that this is not the final result, as spd_data_generate() next
>> increases #banks from 1 to 2 if possible.  This is done "to avoid a
>> bug in MIPS Malta firmware".  We don't even use this function with
>> machine type malta.  *Shrug*
>
> The code that is generalised here is originally from MIPS Malta and
> the idea was to change that as well to use this but nobody did that so
> far.
>
> Regards,
> BALATON Zoltan
>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> hw/i2c/smbus_eeprom.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 07fbbf87f1..e199fc8678 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -229,7 +229,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram=
_addr_t ram_size)
>>     nbanks =3D 1;
>>     while (sz_log2 > max_log2 && nbanks < 8) {
>>         sz_log2--;
>> -        nbanks++;
>> +        nbanks *=3D 2;
>>     }
>>
>>     assert(size =3D=3D (1ULL << sz_log2) * nbanks);
>>


