Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6180FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA6720727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="jpK0ioT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA6720727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdIU-00036E-3b
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdC0-0006UE-Gt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdBy-00069u-V5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:32 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:36964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iWdBx-00062r-7G
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:30 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id B6E1C96EF2;
 Mon, 18 Nov 2019 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1574068764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAspjyT43V2EbafcLGKjM94Dx0dnFP9MywVsHrFuncQ=;
 b=jpK0ioT1L3HZ/fZa/dsNS1b6GfXpJ00zT4gVui6StpPLX8NemSA2gyKYpxdj3r6Kzo82Xt
 /MqtIfHf1hRqNb9++drdOoGG+bahOmu1Ind4CC2N/Xta5QfaG0wKQWNtQDgonq8GpS3vp0
 juw3Cin1AWQqylooIjlWOjTkDuES/kA=
Subject: Re: [RFC PATCH 01/11] gdbstub: move allocation of GDBState to one
 place
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-2-alex.bennee@linaro.org>
 <9f87f9e8-ecc6-398f-62b3-05a7f9af2366@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <422bfc5c-4d2d-a581-7bb2-8a2f8e113b35@greensocs.com>
Date: Mon, 18 Nov 2019 10:19:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <9f87f9e8-ecc6-398f-62b3-05a7f9af2366@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1574068764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAspjyT43V2EbafcLGKjM94Dx0dnFP9MywVsHrFuncQ=;
 b=FugR9RxUrNwDXHVfEoxRxYPv/kesJCxc0mVvadmXfphylACpeBgy226Ij2A+QslWyeY4XX
 wLXuFWOKx5RUNOnpExK2evzlrMSlfMMF5yyyP4+wC513ITTCLBlCTWMNVApTV4nr3KHWd3
 61bil8BXWnUqhHcLa9GqhUKQtZfPlqo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1574068764; a=rsa-sha256; cv=none;
 b=6goFMNKoll4iZh3QC4BhY+22A/TzRIk/H1l1qy1+16n434bdiasr5rGlVRMyoksWOHaCgw
 jDemPmQ9t7CMeVH1QUmdr/COcHZshtWDpDGpzk4XEt1oQwnZL/WL4QTqmT0gw2aFtynvco
 IbbRxmL0aqUqpACzR+s1b9/XObDB+Js=
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/18/19 8:41 AM, Richard Henderson wrote:
> On 11/15/19 6:29 PM, Alex Benn=C3=A9e wrote:
>> =20
>>  static GDBState *gdbserver_state;
>> =20
>> +static GDBState *gdb_allocate_state(void)
>> +{
>> +    g_assert(!gdbserver_state);
>> +    gdbserver_state =3D g_new0(GDBState, 1);
>> +    return gdbserver_state;
>> +}
>> +
>=20
> Actually, if we're only going to have one, why are we allocating it
> dynamically?  We might as well allocate it statically and drop the poin=
ter
> indirection.

In use_gdb_syscalls(), we check if gdbserver_state is NULL:
| /* -semihosting-config target=3Dauto */
| /* On the first call check if gdb is connected and remember. */
| if (gdb_syscall_mode =3D=3D GDB_SYS_UNKNOWN) {
| gdb_syscall_mode =3D (gdbserver_state ? GDB_SYS_ENABLED
|                                     : GDB_SYS_DISABLED);
| }

So we cannot drop the pointer or we have to add some flag to do this test=
.

Damien

