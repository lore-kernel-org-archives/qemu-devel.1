Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9972DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636A92073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/b9uyjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636A92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifM6B-0001Bf-CK
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifM5a-0000m6-EV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifM5Z-00062c-6j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:52:58 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifM5Y-0005yg-Ue
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:52:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so2181295wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=amLTAAoNIzO5eiG0dOJm0h1zTBCY79WF2KIc0ogmLyE=;
 b=J/b9uyjtABakHWJVEH/d5v5oPdVvR+41I2RyvTzQ94GhuSGfxq79/skPyZSGEot6Vp
 QJwOmzraS1bVc56yyW8mzJyiqVGDyMklX9QYm8avw971SmkK1gBv91ZtrFA09/+pgolx
 lmbqa2P/6vX2nz9xOmmgCPJEdAnqhZk7ABHVRL8BOLd4X3lqh40EXo4jMKjQyOrYkxfw
 Ckz9rO91J/jJrShpiWl0XMlLvCEogrBaPCywqj9vG0z6221PLqIEaO6UZD+BhPuP+nVT
 M/QG/8zWj1pS4Xnb9HjTBDs7S4BL+bHcw7ZXzamuIM08qAiZVvYdExRjfMicfwb61vFC
 A9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=amLTAAoNIzO5eiG0dOJm0h1zTBCY79WF2KIc0ogmLyE=;
 b=bK5Lv6/56yZC4JWGAJS+q7p5o9RP+NfxCWta85vpleC12Buw9wCc53YUFgafebexnm
 swEao3pX3B1p+P7S/sNQW6cZQ8vTeEvNDGu/3CqHwoc6BSY4ccb5j9q7XKpgiPdZ9Ozp
 KIFCHlif+hxFSqmcm9IAXGR849QZLZDmPdltpI1SdhzoCXONebXFlYXQUUowigOdmw0K
 4rRpGqmzPpwcoCRGCr8QK5USRkWJ056kHAfnLWqEEkZxFEMLDIyT4nz3dJ6WWH2fi5+N
 o1yC/i+9EwcxgDSj74Z0chLsjDbQ48AaQZ/bpA0RcfvxaaF5Zu57Whzd1UYDrHcx1Bu2
 29Mw==
X-Gm-Message-State: APjAAAVHLdLHhEF+bW+dSJeCtewYOc7iKuR212R7la2V+10umQM9ol4H
 uDbIQCr7GNvnhAGpsL+jQzGRUg==
X-Google-Smtp-Source: APXvYqxieD86Yx20NN04F6uG8J+/F6dJmFgnbnywlcNzOXGvH4ijxFPBomtqYoKoO5wrCBmyPq+bSQ==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr5937885wrj.68.1576147975245;
 Thu, 12 Dec 2019 02:52:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm5909641wmm.0.2019.12.12.02.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 02:52:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31CDF1FF87;
 Thu, 12 Dec 2019 10:52:53 +0000 (GMT)
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
 <871rta3czj.fsf@linaro.org>
 <c0457ff2-0141-34b5-980f-4f7ae8a65b09@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
In-reply-to: <c0457ff2-0141-34b5-980f-4f7ae8a65b09@greensocs.com>
Date: Thu, 12 Dec 2019 10:52:53 +0000
Message-ID: <87v9ql24u2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


Damien Hedde <damien.hedde@greensocs.com> writes:

> On 12/11/19 7:59 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>=20
>>> Since we can now send packets of arbitrary length:
>>> simplify gdb_monitor_write() and send the whole payload
>>> in one packet.
>>=20
>> Do we know gdb won't barf on us. Does the negotiated max packet size
>> only apply to data sent to the gdbserver?
>
> Yes the negociated packet size is only about packet we can receive.
> Qutoting the gdb doc:
> | =E2=80=98PacketSize=3Dbytes=E2=80=99
> |
> |    The remote stub can accept packets up to at least bytes in length.
> | GDB will send packets up to this size for bulk transfers, and will
> | never send larger packets.
>
> The qSupported doc also says that "Any GDB which sends a =E2=80=98qSuppor=
ted=E2=80=99
> packet supports receiving packets of unlimited length".
> I did some digging and qSupported appeared in gdb 6.6 (december 2006).
> And gdb supported arbitrary sized packet even before that (6.4.9 2006
> too).

I think that is worth a comment for the function gdb_monitor_write
quoting the spec and the versions. With that comment:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>>=20
>>>
>>> Suggested-by: Luc Michel <luc.michel@greensocs.com>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>>  gdbstub.c | 23 +++--------------------
>>>  1 file changed, 3 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index 93b26f1b86..ef999abee2 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, int eve=
nt)
>>>      }
>>>  }
>>>=20=20
>>> -static void gdb_monitor_output(GDBState *s, const char *msg, int len)
>>> -{
>>> -    g_autoptr(GString) buf =3D g_string_new("O");
>>> -    memtohex(buf, (uint8_t *)msg, len);
>>> -    put_packet(buf->str);
>>> -}
>>> -
>>>  static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
>>>  {
>>> -    const char *p =3D (const char *)buf;
>>> -    int max_sz;
>>> -
>>> -    max_sz =3D (MAX_PACKET_LENGTH / 2) + 1;
>>> -    for (;;) {
>>> -        if (len <=3D max_sz) {
>>> -            gdb_monitor_output(&gdbserver_state, p, len);
>>> -            break;
>>> -        }
>>> -        gdb_monitor_output(&gdbserver_state, p, max_sz);
>>> -        p +=3D max_sz;
>>> -        len -=3D max_sz;
>>> -    }
>>> +    g_autoptr(GString) hex_buf =3D g_string_new("O");
>>> +    memtohex(hex_buf, buf, len);
>>> +    put_packet(hex_buf->str);
>>>      return len;
>>>  }
>>=20
>>=20


--=20
Alex Benn=C3=A9e

