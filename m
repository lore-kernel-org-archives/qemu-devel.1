Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3704C2D0C8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F452073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="k3gtycse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F452073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKzN-0004A4-JQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 04:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifKwa-0003Np-J2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifKwX-0006bD-Fd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:39:36 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:48418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ifKwW-0006Wd-W1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:39:33 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id B73DE96EF0;
 Thu, 12 Dec 2019 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576143570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sO+kwccQiwKHBwMYapaCV8YaaaZAxAfC4XTinO+0EZ8=;
 b=k3gtycsePVafJqzexpfkrW5E8XcqTjzOq+UznWe58kYQ8Y9mEZQ8NCdNIOEB6ICu9+0eBl
 OLoSEtSp8qpMcr7xebWK9HGGDfuqH1X/tuh3F2cPR5V0wH9jTAl6ze9VzPOg9+u+nEber7
 SkVGgkcXz/B/zY0q4lo0RReSVkzrKqI=
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
 <e1b2e3a7-a40a-3e0f-ce83-bfacd28aedeb@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <ff6cafe8-9cd2-09be-cda0-5eb48b284693@greensocs.com>
Date: Thu, 12 Dec 2019 10:39:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e1b2e3a7-a40a-3e0f-ce83-bfacd28aedeb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576143570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sO+kwccQiwKHBwMYapaCV8YaaaZAxAfC4XTinO+0EZ8=;
 b=J/tTaubK1pXh2KMQSdWsEY7y48NdJ3xW8lNO4OsAeq9wMPu4y11ulLs/1SBgJyFu7FcC0L
 LtY3KDDKLAehvZwU5r4EMB3v3N9/4mOLXIks3fa9yS3EXPdFs4dFkJDYUf+qPubl7oCzq0
 nyh4Qk4MYwyZYMeFiKRZs/UjsXkfKxk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576143570; a=rsa-sha256; cv=none;
 b=spC2sZcCjkk1yL/OwXWjpi9hFzswLKlP74bkd1/+sSnx1co2RrM6LCIZgfhIK4oGP8K0cX
 6VExpL2BpviXC4SsZt/yjRk7xNhyQuIm7EPBK7nhhUujb/hB9FwTvzj82rc0dwzGMaruPK
 P0+N5rmEdOmvrvqxfGwUYHgNppHY3D4=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/11/19 7:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/11/19 5:05 PM, Damien Hedde wrote:
>> Since we can now send packets of arbitrary length:
>> simplify gdb_monitor_write() and send the whole payload
>> in one packet.
>=20
> While we can send arbitrary length on the wire, we advertise
> PacketSize=3DMAX_PACKET_LENGTH in handle_query_supported().
>=20
> We can raise this limit however.

Hi Philippe,

This parameter is only about the packet size we can handle (packets we
can receive).

--
Damien

