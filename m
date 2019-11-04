Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC65ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A379C217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="QaE//GrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A379C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRb6W-0002iw-KR
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 07:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iRb2p-0001QW-Fl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iRb2o-0007mR-EG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:01:15 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:41256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iRb2l-0007ic-8s; Mon, 04 Nov 2019 07:01:11 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5E18496EF0;
 Mon,  4 Nov 2019 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1572868865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Ze2mKNbmdnrfOAKSXjH+RHL1wUmdmo8i3y7JYnOqjE=;
 b=QaE//GrRgn5WcHw6d93rEhXjyCafulEvFTU6+9eU+YUjng+aDjbqMLpfKQ5qd+wV4mu1hi
 JbGRGvFru13c7GGV4dz+PrAnLGMiQnT4IIhfZRQA3+fRHMrIjYtHAc7JkM9Y5+LlM36UCb
 zqFj28UUmiomRgh935WJpcpV5zZeUCs=
Subject: Re: [PATCH v5 08/13] hw/core: deprecate old reset functions and
 introduce new ones
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-9-damien.hedde@greensocs.com>
 <41ee0633-c8c8-10ce-1372-4804f25273d0@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b434efd9-490a-85f4-9f22-c40bb0a9ed77@greensocs.com>
Date: Mon, 4 Nov 2019 13:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <41ee0633-c8c8-10ce-1372-4804f25273d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1572868866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Ze2mKNbmdnrfOAKSXjH+RHL1wUmdmo8i3y7JYnOqjE=;
 b=EDDoZbQ6fDb4lTp+EfTT81aPBI/OwCrn66UU9xGbAM6+3Rvp98U2l4PxjHS9HFhIKukMqc
 pLFwUwVQGgVVzye9PV898DXoW5XfXePK2S1KKfv8p1lg533u0BuGTqD1KED7aJPKDmllQB
 0nQnM+F8YP5nS4EA7gNovyk/8drNzhk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1572868866; a=rsa-sha256; cv=none;
 b=F38cMoNJhVVF8fLejTeFLX+V7qzeH6dP7f3eufb92pJkZ2qWfoPiL5+PW5+p9eTtMHdrt7
 aZeuiWxN4kvxJa7p8BPFo1xO9J39T4pAxCv1zSVQWd0Yj5jxBnVAeRmCC4nqN3ZubnGP7F
 GqMORqvWp2Td6gBLb5wSPnM8F4gEyTY=
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/1/19 12:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/18/19 5:06 PM, Damien Hedde wrote:
>> Deprecate device_legacy_reset(), qdev_reset_all() and
>> qbus_reset_all() to be replaced by new functions
>> device_cold_reset() and bus_cold_reset() which uses resettable API.
>>
>> Also introduce resettable_cold_reset_fn() which may be used as a
>> replacement for qdev_reset_all_fn and qbus_reset_all_fn().
>>
>> Following patches will be needed to look at legacy reset call sites
>> and switch to resettable api. The legacy functions will be removed
>> when unused.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>> [...]>> =C2=A0 +void resettable_cold_reset_fn(void *opaque)
>> +{
>> +=C2=A0=C2=A0=C2=A0 resettable_reset((Object *) opaque, RESET_TYPE_COL=
D);
>=20
> Why not take a Object* argument?

This function is used to register a reset callback with
qemu_register_reset() (path 10 and 11), so we need void* to match the
prototype.



