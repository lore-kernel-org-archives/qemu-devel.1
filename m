Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D955C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB90206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="GpvUJ88A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB90206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIG27-0002WE-8p
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iI7tZ-00021N-Am
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iI7tX-0002JP-U9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:04:32 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:54456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iI7tX-0002J1-CI; Wed, 09 Oct 2019 05:04:31 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7C8CD96EF2;
 Wed,  9 Oct 2019 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1570611867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFZC/uncAXmFB+eSCmPzmATbTLD3IKnXZWHMbc2saMw=;
 b=GpvUJ88AmQx4h6NnUn4Iyj2Uy7Zy6xNNW7qm4I/Rjm/uoPRXn2MohPQ0Th+kuMVr2w1HfU
 wUiXLpqK4szI9jaofpIESjVkbj7ZfjfobEaxGGnuDxMblr6y1fVjscMnSYputnEr9zdBJ8
 g473EjyPe5HY7lNSM63MIT5fFD+RxDk=
Subject: Re: [PATCH 11/11] hw/misc/vmcoreinfo: Convert reset handler to
 DeviceReset
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
 <20190926151733.25349-12-philmd@redhat.com>
 <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
 <20191008133219.GV4084@habkost.net>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <eb4eccc6-ef92-9a41-3d0d-f265166d5a98@greensocs.com>
Date: Wed, 9 Oct 2019 11:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191008133219.GV4084@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1570611867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFZC/uncAXmFB+eSCmPzmATbTLD3IKnXZWHMbc2saMw=;
 b=fVjiXuqNMAmOfHIlSVK5Q/Fo+yQe9Z1O4fhoQuymNUSqFlXkdif5P/OHeyELG9+ZepzSLE
 BFjraJTc12sN8IlbUSaR+tgSkQJ1Mt2ZhPJTjxQahTU4ix8flmiqX1ZnVE0VXacrcRjmiU
 RhN61BFlHbwzUQkkCCXUg1OYweAKXgY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1570611867; a=rsa-sha256; cv=none;
 b=d2P1pZExi+Zg+Gdx3IxFYQiAM+sO1KUHcNunTivhQEJvX2sA1ovdTtD+ziAdIBN+wpp27E
 RodVb+dptbWuf83DYBApjX1MGng5AvXUudvYFkYS+Q4Xx0e70EruJ+EgIz7EvLiP5ldV7b
 Z7kUeMGmAeOjCgXyQ4Ze4qDwLMVm6RY=
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/8/19 3:32 PM, Eduardo Habkost wrote:
> On Thu, Sep 26, 2019 at 06:02:47PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> On 9/26/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Convert the reset handler into a proper Device reset method.
>>
>> Marc-Andr=C3=A9 noticed this one is incorrect, because while being QDE=
V it is
>> not connected to a QBUS.
>>
>> Maybe we can add a Device::unconnected property, and when set, the
>> parent realize() calls 'qemu_register_reset(dev->reset, dev);'?
>> This might look the same, but at least Devices implementations could
>> stop to use this function...
>=20
> Can we make this automatic instead of requiring another explicit
> setting?
>=20
> Today we have at least 3 different ways of getting a device to be
> reset: qemu_register_reset(); explicit device_reset_all() call in
> another reset handler; and implicit device_reset_all() call done
> through parent buses/devices.  I wouldn't like to create a 4th
> method.
>=20
> What I really wish for, is a opt-out mechanism for reset (meaning
> all devices would be guaranteed to be reset unless they
> explicitly opt out), instead of 3 or 4 different opt-in
> mechanisms.
>=20

Sorry for the stupid question, but why would we not reset a device ? Are
there some cases when a device must be "initialized" not in its reset
state ?

Regarding the reset guarantee. Can this be done by doing first
qemu_register_reset() on each device and eventually unregistering
it in case of opt-out or wanting to reset it by other means (eg when
putting it into a bus) ?

Damien

