Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB77206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="qh5VFORX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB77206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifLXX-0006VP-4p
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifLUZ-0005fm-E7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifLUX-0003wL-Ta
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:14:43 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:49360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ifLUX-0003sh-Ad
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:14:41 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F37B196EF0;
 Thu, 12 Dec 2019 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576145678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1haVX07faPVHEWC8cvmaTvsXKawhYXaSjIcOlARbpA=;
 b=qh5VFORXbrXJYL+FhPah6t89IQ8TjdbulmoYqTL8pKlY9Fg+V8I8ARLH8/IoHEpYr+xwHF
 hCCJMXWKY0zKExAv6aAysgWFTzSpMO+kXhKc7ePX1zFNYN8ZETOGp/5QHDkJw5aP0SElJf
 Lh3u3v2rblCBcmSGtWgTpTBVZ8dCVsg=
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
 <871rta3czj.fsf@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <c0457ff2-0141-34b5-980f-4f7ae8a65b09@greensocs.com>
Date: Thu, 12 Dec 2019 11:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <871rta3czj.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576145679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1haVX07faPVHEWC8cvmaTvsXKawhYXaSjIcOlARbpA=;
 b=z+xSRceESpl9cbbDf7D5PDB84kOqfaJJBwT02/3Ab+zG5ZffAOKan7IaAGjoeyKTRdi8m9
 7hGS/u8qtKO9z8zoZFE45FfvjdhVzRZvmuXh3bb+f3xWEGQf/P4OQCJ0kkuzf7O9vAXryx
 yNX/UAqdSmGpUT/KgaXUrsymtLkIih8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576145679; a=rsa-sha256; cv=none;
 b=pxMnGphg+E1rnjaC8jBtv2Rjj9pCMauKg7zKaDnDIXwtutCF3uoSfBt2Njkh3wf3s8wz08
 Ka5EduhSVuYJoZDwsHBZYCSpo4PSqlnC+osOy/D+JXyX6LOr8xwV9/fQBocBKuLPLu86gy
 o/9Vur9gspc58Uz7bLJi/YFbe+h1CJ0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/11/19 7:59 PM, Alex Benn=C3=A9e wrote:
>=20
> Damien Hedde <damien.hedde@greensocs.com> writes:
>=20
>> Since we can now send packets of arbitrary length:
>> simplify gdb_monitor_write() and send the whole payload
>> in one packet.
>=20
> Do we know gdb won't barf on us. Does the negotiated max packet size
> only apply to data sent to the gdbserver?

Yes the negociated packet size is only about packet we can receive.
Qutoting the gdb doc:
| =E2=80=98PacketSize=3Dbytes=E2=80=99
|
|    The remote stub can accept packets up to at least bytes in length.
| GDB will send packets up to this size for bulk transfers, and will
| never send larger packets.

The qSupported doc also says that "Any GDB which sends a =E2=80=98qSuppor=
ted=E2=80=99
packet supports receiving packets of unlimited length".
I did some digging and qSupported appeared in gdb 6.6 (december 2006).
And gdb supported arbitrary sized packet even before that (6.4.9 2006 too=
).

>=20
>>
>> Suggested-by: Luc Michel <luc.michel@greensocs.com>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  gdbstub.c | 23 +++--------------------
>>  1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 93b26f1b86..ef999abee2 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, int ev=
ent)
>>      }
>>  }
>> =20
>> -static void gdb_monitor_output(GDBState *s, const char *msg, int len)
>> -{
>> -    g_autoptr(GString) buf =3D g_string_new("O");
>> -    memtohex(buf, (uint8_t *)msg, len);
>> -    put_packet(buf->str);
>> -}
>> -
>>  static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int le=
n)
>>  {
>> -    const char *p =3D (const char *)buf;
>> -    int max_sz;
>> -
>> -    max_sz =3D (MAX_PACKET_LENGTH / 2) + 1;
>> -    for (;;) {
>> -        if (len <=3D max_sz) {
>> -            gdb_monitor_output(&gdbserver_state, p, len);
>> -            break;
>> -        }
>> -        gdb_monitor_output(&gdbserver_state, p, max_sz);
>> -        p +=3D max_sz;
>> -        len -=3D max_sz;
>> -    }
>> +    g_autoptr(GString) hex_buf =3D g_string_new("O");
>> +    memtohex(hex_buf, buf, len);
>> +    put_packet(hex_buf->str);
>>      return len;
>>  }
>=20
>=20

