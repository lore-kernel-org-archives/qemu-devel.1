Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B6C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099E21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="5JIV9Oc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjvY-0003yR-Ul
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifjpO-0006w7-7D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifjpL-0000cG-Uk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:13:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:39226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ifjpL-0000Y1-8p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:13:47 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 2F72496EF0;
 Fri, 13 Dec 2019 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576239224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4h+Tpe1bgg9RxVaI1c0u10O2LKCLBITWj2yz7gPrUw=;
 b=5JIV9Oc+d2wPq3z0uBiMP1+l9C7Hx1W/A6OZq9o+S8VTnSgphr5prtloSmm2qS6TtxyyAu
 40wvIq06qN7RvRoOKJtxduMnP6snZGvT2VgtVGI1SBf/DVXhVgEbsgJhedoicF5skIi4+j
 g9gWbh2dONuBSvQuBnM081nQsTSjEq0=
From: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
 <871rta3czj.fsf@linaro.org>
 <c0457ff2-0141-34b5-980f-4f7ae8a65b09@greensocs.com>
 <87v9ql24u2.fsf@linaro.org>
Message-ID: <e6f663bd-fca8-6aa8-4bdc-f6279e0cbf3b@greensocs.com>
Date: Fri, 13 Dec 2019 13:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87v9ql24u2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576239224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4h+Tpe1bgg9RxVaI1c0u10O2LKCLBITWj2yz7gPrUw=;
 b=nan6MTTmLxETnKPMnZSdVXrHcUkRDg76F4k87Pampxk55urh3QHx9m0UttGcfmnRKzUL1L
 Syn4E86bfuULQvbBFUchBAjOA+VNsLKFOlF14oapW3b14t7kmPWcTYxxHvlUEwbIeNzIOB
 0Bjnl0RXEz/nIFYYYI9jhXlSZhP6CWE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576239224; a=rsa-sha256; cv=none;
 b=OAEUQMjnPEFLN3H3OmUzwbmT/I3qWJcn9DQz1bwAz8GRIcYR6qBZAaOmM3MtoTOkr41Plw
 io5ZKJ93pnfKxVttatmeV4Uk0bT+WknMZs76PEwzJikNr6PwQqn9/g415CTEKJJApD/qQT
 gOYzDPRjGCwWB2yIgzWO9a+OY9UgwGc=
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


On 12/12/19 11:52 AM, Alex Benn=C3=A9e wrote:
>=20
> Damien Hedde <damien.hedde@greensocs.com> writes:
>=20
>> On 12/11/19 7:59 PM, Alex Benn=C3=A9e wrote:
>>>
>>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>>
>>>> Since we can now send packets of arbitrary length:
>>>> simplify gdb_monitor_write() and send the whole payload
>>>> in one packet.
>>>
>>> Do we know gdb won't barf on us. Does the negotiated max packet size
>>> only apply to data sent to the gdbserver?
>>
>> Yes the negociated packet size is only about packet we can receive.
>> Qutoting the gdb doc:
>> | =E2=80=98PacketSize=3Dbytes=E2=80=99
>> |
>> |    The remote stub can accept packets up to at least bytes in length=
.
>> | GDB will send packets up to this size for bulk transfers, and will
>> | never send larger packets.
>>
>> The qSupported doc also says that "Any GDB which sends a =E2=80=98qSup=
ported=E2=80=99
>> packet supports receiving packets of unlimited length".
>> I did some digging and qSupported appeared in gdb 6.6 (december 2006).
>> And gdb supported arbitrary sized packet even before that (6.4.9 2006
>> too).
>=20
> I think that is worth a comment for the function gdb_monitor_write
> quoting the spec and the versions. With that comment:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20

Good idea ! Is that ok if I add these comments in the 1st patch along
with the gdbstate.last_packet field ? it seems a more central place.
I can still add a short note for gdb_monitor_write().

Damien

