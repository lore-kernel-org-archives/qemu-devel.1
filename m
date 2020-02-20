Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6214FC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B48524654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhO9kyAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B48524654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4how-0007S8-9z
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j4hoF-0006xN-SH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j4hoD-0000tv-9V
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:07:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j4hoD-0000tS-2S
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582189668;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwy7+pediWNcl1I522RD5AhmgfZvRNkSfJmtJ6NNYsc=;
 b=BhO9kyAxuBqN4PhBWKU28dIkf+Let4qN2dshjcKhQqOnDSfBlXXl+/AB7xKrH4+FWZDI4R
 05X/DQ93Tv2OPrWAQM6q+PgMs4+lPi+6RvszlpgKJ6bUsfbJR+ssj2wJyLtr6mTBJu1J/F
 gWqAY2WVEcOxu93uu+Fyi7ZS1MUOy6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-hu-eyb8BM6epE1stkq_S8Q-1; Thu, 20 Feb 2020 04:07:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D95EA18AB2C0;
 Thu, 20 Feb 2020 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-80.bne.redhat.com [10.64.54.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A4F1BC6D;
 Thu, 20 Feb 2020 09:07:31 +0000 (UTC)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200220060108.143668-1-gshan@redhat.com>
 <5740f743-f6f6-54bc-9b0e-7c5d9feed486@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <a0282662-a43e-00b9-02d1-18635ac459ae@redhat.com>
Date: Thu, 20 Feb 2020 20:07:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <5740f743-f6f6-54bc-9b0e-7c5d9feed486@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hu-eyb8BM6epE1stkq_S8Q-1
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, shan.gavin@gmail.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 2/20/20 7:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing the chardev maintainers:
>=20
> ./scripts/get_maintainer.pl -f chardev/char-fe.c
> "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (maintainer:Charac=
ter device...)
> Paolo Bonzini <pbonzini@redhat.com> (reviewer:Character device...)
> qemu-devel@nongnu.org (open list:All patches CC here)
>=20

Thanks for keeping right persons copied :)

>=20
> On 2/20/20 7:01 AM, Gavin Shan wrote:
>> Currently, PL011 is used by ARM virt board by default. It's possible to
>> block the system from booting. With below parameters in command line, th=
e
>> backend could run into endless attempts of transmitting packets, which
>> can't succeed because of running out of sending buffer. The socket might
>> be not accepted n server side. It's not correct because disconnected
>> serial port shouldn't stop the system from booting.
>>
>> =C2=A0=C2=A0=C2=A0 -machine virt,gic-version=3D3 -cpu max -m 4096
>> =C2=A0=C2=A0=C2=A0 -monitor none -serial tcp:127.0.0.1:50900
>=20
> Is the behavior similar when using the 'nowait' option?
>=20

The issue happens on TCP client side, but 'nowait' is used for TCP
server according to the following document. I got same behavior after
giving a 'nowait' in my case.

https://qemu.weilnetz.de/doc/qemu-doc.html   (search 'nowait')

nowait specifies that QEMU should not block waiting for a client to connect
to a listening socket.

>>
>> The issue can be reproduced by starting a program which listens on TCP
>> port 50900 and then sleep without accepting any incoming connections. On
>> the other hand, a VM is started with above parameters and modified qemu
>> where the PL011 is flooded with 5000K data after it's created. Eventuall=
y,
>> the flooding won't proceed and stops after transmitting 2574K data. It's
>> basically to simulate tons of output from EDK-II and demonstrates how th=
e
>> tons of output can block the system from booting.
>>
>> This fixes the issue by using newly added API qemu_chr_fe_try_write_all(=
),
>> which provides another type of service (best-effort). It's different fro=
m
>> qemu_chr_fe_write_all() as the data will be dropped if the backend has
>> been running into so-called broken state or 50 attempts of transmissions=
.
>> The broken state is cleared if the data is transmitted at once.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> =C2=A0 chardev/char-fe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 15 +++++++++++++--
>> =C2=A0 chardev/char.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 20 ++++++++++++++------
>> =C2=A0 hw/char/pl011.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 5 +----
>> =C2=A0 include/chardev/char-fe.h | 14 ++++++++++++++
>> =C2=A0 include/chardev/char.h=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++--
>> =C2=A0 5 files changed, 46 insertions(+), 14 deletions(-)
>>
>> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>> index f3530a90e6..6558fcfb94 100644
>> --- a/chardev/char-fe.c
>> +++ b/chardev/char-fe.c
>> @@ -39,7 +39,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *=
buf, int len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 return qemu_chr_write(s, buf, len, false);
>> +=C2=A0=C2=A0=C2=A0 return qemu_chr_write(s, buf, len, false, false);
>> =C2=A0 }
>> =C2=A0 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, in=
t len)
>> @@ -50,7 +50,18 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 return qemu_chr_write(s, buf, len, true);
>> +=C2=A0=C2=A0=C2=A0 return qemu_chr_write(s, buf, len, true, false);
>> +}
>> +
>> +int qemu_chr_fe_try_write_all(CharBackend *be, const uint8_t *buf, int =
len)
>> +{
>> +=C2=A0=C2=A0=C2=A0 Chardev *s =3D be->chr;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!s) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return qemu_chr_write(s, buf, len, true, true);
>> =C2=A0 }
>> =C2=A0 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 87237568df..cd17fac123 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -106,9 +106,8 @@ static void qemu_chr_write_log(Chardev *s, const uin=
t8_t *buf, size_t len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> -static int qemu_chr_write_buffer(Chardev *s,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint8_t *buf, int le=
n,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *offset, bool write_al=
l)
>> +static int qemu_chr_write_buffer(Chardev *s, const uint8_t *buf, int le=
n,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *offset, bool write_al=
l, bool best_effort)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ChardevClass *cc =3D CHARDEV_GET_CLASS(s)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int res =3D 0;
>> @@ -119,7 +118,14 @@ static int qemu_chr_write_buffer(Chardev *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retry:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D cc->chr_w=
rite(s, buf + *offset, len - *offset);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res < 0 && er=
rno =3D=3D EAGAIN && write_all) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
best_effort && s->retries > 50) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 g_usleep(100);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
best_effort) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 s->retries++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto retry;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -127,6 +133,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->retries =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *offset +=3D res;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!write_all) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> @@ -140,7 +147,8 @@ static int qemu_chr_write_buffer(Chardev *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res;
>> =C2=A0 }
>> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_=
all)
>> +int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool write_all, bool best_effort)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int res;
>> @@ -148,11 +156,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf,=
 int len, bool write_all)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_chr_replay(s) && replay_mode =3D=
=3D REPLAY_MODE_PLAY) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replay_char_write=
_event_load(&res, &offset);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(offset <=
=3D len);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_write_buffer(s, buf=
, offset, &offset, true);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_write_buffer(s, buf=
, offset, &offset, true, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 res =3D qemu_chr_write_buffer(s, buf, len, &offset, =
write_all);
>> +=C2=A0=C2=A0=C2=A0 res =3D qemu_chr_write_buffer(s, buf, len, &offset, =
write_all, best_effort);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_chr_replay(s) && replay_mode =3D=
=3D REPLAY_MODE_RECORD) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replay_char_write=
_event_save(res, offset);
>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>> index 13e784f9d9..348188f49e 100644
>> --- a/hw/char/pl011.c
>> +++ b/hw/char/pl011.c
>> @@ -179,11 +179,8 @@ static void pl011_write(void *opaque, hwaddr offset=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (offset >> 2) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0: /* UARTDR */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ??? Check if transmitter =
is enabled.=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch =3D value;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX this blocks entire th=
read. Rewrite to use
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * qemu_chr_fe_write an=
d background I/O callbacks */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_write_all(&s->ch=
r, &ch, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_try_write_all(&s=
->chr, &ch, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->int_level |=3D=
 PL011_INT_TX;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pl011_update(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
>> index a553843364..18281ccfca 100644
>> --- a/include/chardev/char-fe.h
>> +++ b/include/chardev/char-fe.h
>> @@ -220,6 +220,20 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_=
t *buf, int len);
>> =C2=A0=C2=A0 */
>> =C2=A0 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, in=
t len);
>> +/**
>> + * qemu_chr_fe_try_write_all:
>> + * @buf: the data
>> + * @len: the number of bytes to send
>> + *
>> + * Write data to a character backend from the front end.=C2=A0 This fun=
ction will
>> + * send data from the front end to the back end. It provides function a=
s to
>> + * @qemu_chr_fe_write_all, except the data will be dropped after 50 att=
empts
>> + * of transmissions are done.
>> + *
>> + * Returns: the number of bytes consumed (0 if no associated Chardev)
>> + */
>> +int qemu_chr_fe_try_write_all(CharBackend *be, const uint8_t *buf, int =
len);
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * qemu_chr_fe_read_all:
>> =C2=A0=C2=A0 * @buf: the data buffer
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index 00589a6025..425a007a0a 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -65,6 +65,7 @@ struct Chardev {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *filename;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int logfd;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int be_open;
>> +=C2=A0=C2=A0=C2=A0 int retries;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSource *gsource;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GMainContext *gcontext;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(features, QEMU_CHAR_FEATUR=
E_LAST);
>> @@ -221,8 +222,9 @@ void qemu_chr_set_feature(Chardev *chr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ChardevFeature feature);
>> =C2=A0 QemuOpts *qemu_chr_parse_compat(const char *label, const char *fi=
lename,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool permit_mux_mon);
>> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_=
all);
>> -#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, tru=
e)
>> +int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool write_all, bool best_effort);
>> +#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, tru=
e, false)
>> =C2=A0 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>> =C2=A0 #define TYPE_CHARDEV "chardev"
>>

Thanks,
Gavin


