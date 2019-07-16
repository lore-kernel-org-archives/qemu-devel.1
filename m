Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F8C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A4820693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYWRb8Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A4820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOyz-0007BQ-2X
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnOym-0006ly-Tt
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnOyl-0006AK-L2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:02:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnOyl-00069S-CK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:02:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so19044541wme.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q6C40gmUPp2FOjOrOQTCS+TKYW7nnu7DgidqIYP3odY=;
 b=dYWRb8Lt163Z65oZMZyes+bEUeu97KP8hoji3n24WrQTUm9NXwoNrbi0TbRzG1H4l1
 vjG5f77ac+LBNM3JYeei1DxLixJFLwLlMkcQX8sYkNWZBEawyZISqWKe4r4DnHALUcTh
 YH+Z/pwqMs4Cv12Vii7MKDQoNkgi9aXBKd86E7QJlKWmMVlwZDtNoTFiCLb9CNtErIqZ
 M5TLzXi6yw56yBlppMJkWGv/NXer8RmUfnekWUrRRmLwxqspH2fN2rJvlIFaLk3X5ngt
 W+VBZ7NLqZkXmIgIhO0GsYhPS+5isC/CC+/LyoKKKyAh4NN61nNl13Ma6wC+h7KqQtw6
 FoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q6C40gmUPp2FOjOrOQTCS+TKYW7nnu7DgidqIYP3odY=;
 b=b7/VLjvzHFD4MdJrYByY+NERQ5JQYQfPZIKW/LNdkcnZFVyxGnyLrUCKZ+B0N42+Ej
 2biqI1KVUvxXz7Z2OComEIWrg2ai35NOxvPvQUrUe1/5VWhyBmow6WsZvLzytGkphfH7
 HMejUctkO27AsEGKe6CsxhGLluIg1A3PeDNGqksVNdoGbhryvZfc6AeGaZZrb94Rqjxv
 dkde5+cBisy8SYYGIPd0pk4Z80i3jpibsYXtU2aKf+d6kss+jyS4YdfYM2ZGqHk7Bjhg
 saDHx/9/0WzSV7oyxjT+PEHtQOiRMZ3CKAbapgPAnzxOIp38C8vFPn7IYiXizYWDvqxH
 LPbA==
X-Gm-Message-State: APjAAAXRhRQaSHR0zPqcjabAzlGhM1Sq3h2YdDajGM0pxrPJUSEEpeoV
 6HhZsTXWK1hweKTABRMV1MYaGg==
X-Google-Smtp-Source: APXvYqx/FExO65na/omAZzdgtZnccT905n5u+KA/I6wvhuXvt2ZRSXs1j75xnkuec5NfRFzirgzDjA==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr30311805wmj.94.1563289373663; 
 Tue, 16 Jul 2019 08:02:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t24sm19397847wmj.14.2019.07.16.08.02.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 08:02:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A76621FF87;
 Tue, 16 Jul 2019 16:02:52 +0100 (BST)
References: <20190716140133.8578-1-alex.bennee@linaro.org>
 <CAFEAcA8V2h3pqC_g5aaD2gsv08c18YZKRcxLM+hDNuMv_C55=Q@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8V2h3pqC_g5aaD2gsv08c18YZKRcxLM+hDNuMv_C55=Q@mail.gmail.com>
Date: Tue, 16 Jul 2019 16:02:52 +0100
Message-ID: <87blxuuin7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1] linux-user: unparent CPU
 object before unref
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
Cc: Riku Voipio <riku.voipio@iki.fi>, 1836558@bugs.launchpad.net,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Ccing the QOM maintainers to make sure we have the
> QOM lifecycle operations right here...
>
> On Tue, 16 Jul 2019 at 15:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> When a CPU object is created it is parented during it's realize stage.
>> If we don't unparent before the "final" unref we will never finzalize
>> the object leading to a memory leak. For most setups you probably
>> won't notice but with anything that creates and destroys a lot of
>> threads this will add up. This goes especially for architectures which
>> allocate a lot of memory in their CPU structures.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1836558
>> Cc: 1836558@bugs.launchpad.net
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/syscall.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 39a37496fed..4c9313fd9d0 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7183,6 +7183,7 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
>>                            NULL, NULL, 0);
>>              }
>>              thread_cpu =3D NULL;
>> +            object_unparent(OBJECT(cpu));
>>              object_unref(OBJECT(cpu));
>>              g_free(ts);
>>              rcu_unregister_thread();
>
> I think (as I mentioned on IRC) that we also need to unrealize
> the CPU object, because target/ppc at least does some freeing
> of memory in its unrealize method. I think we do that by
> setting the QOM "realize" property back to "false" -- but that
> might barf if we try it on a CPU that isn't hotpluggable...

I have tried:

             thread_cpu =3D NULL;
+            object_unparent(OBJECT(cpu));
+            object_property_set_bool(OBJECT(cpu), false, "realized", NULL);
             object_unref(OBJECT(cpu));

but it didn't manifestly change anything (i.e. both with and without
setting realized the thread allocated stuff is freed). Valgrind still
complains about:

=3D=3D22483=3D=3D 6,656 bytes in 26 blocks are possibly lost in loss record=
 1,639 of 1,654
=3D=3D22483=3D=3D    at 0x483577F: malloc (vg_replace_malloc.c:299)
=3D=3D22483=3D=3D    by 0x4D7F8D0: g_malloc (in /usr/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0.5800.3)
=3D=3D22483=3D=3D    by 0x27D692: create_new_table (translate_init.inc.c:92=
52)
=3D=3D22483=3D=3D    by 0x27D7CD: register_ind_in_table (translate_init.inc=
.c:9291)
=3D=3D22483=3D=3D    by 0x27D975: register_dblind_insn (translate_init.inc.=
c:9337)
=3D=3D22483=3D=3D    by 0x27DBBB: register_insn (translate_init.inc.c:9384)
=3D=3D22483=3D=3D    by 0x27DE4E: create_ppc_opcodes (translate_init.inc.c:=
9449)
=3D=3D22483=3D=3D    by 0x27E79C: ppc_cpu_realize (translate_init.inc.c:981=
8)
=3D=3D22483=3D=3D    by 0x2C6FE8: device_set_realized (qdev.c:834)
=3D=3D22483=3D=3D    by 0x2D1E3D: property_set_bool (object.c:2076)
=3D=3D22483=3D=3D    by 0x2D00B3: object_property_set (object.c:1268)
=3D=3D22483=3D=3D    by 0x2D3185: object_property_set_qobject (qom-qobject.=
c:26)

But I don't know if that is just because the final exit_group of the
main CPU just exits without attempting to clean-up. However it is better
than it was.

--
Alex Benn=C3=A9e

