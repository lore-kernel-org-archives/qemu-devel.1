Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FEC35666
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 12:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF0E20656
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 12:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF0E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5TrE-0004G3-Hn
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 07:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j5TqU-0003iB-Ep
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 07:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j5TqT-0002BV-3A
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 07:25:22 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:43606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1j5TqS-00029I-MC
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 07:25:21 -0500
Received: from localhost (unknown [192.168.167.13])
 by regular1.263xmail.com (Postfix) with ESMTP id 48886246;
 Sat, 22 Feb 2020 20:25:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [223.72.82.35])
 by smtp.263.net (postfix) whith ESMTP id
 P15418T139868881516288S1582374309652393_; 
 Sat, 22 Feb 2020 20:25:09 +0800 (CST)
X-UNIQUE-TAG: <e98cab485fe81cffc2ddb12f4a4a95fa>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: gang.chen.5i5j@gmail.com
X-SENDER-IP: 223.72.82.35
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
 <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
 <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
 <f3bea474-468b-5818-9f69-5463be6d9b2a@emindsoft.com.cn>
 <2ab8ed82-dadd-2d5e-5bbc-69a67ba89e26@redhat.com>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <22cf9eb4-7d48-5eb1-5d4e-38d83c0a3f40@emindsoft.com.cn>
Date: Sat, 22 Feb 2020 20:25:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2ab8ed82-dadd-2d5e-5bbc-69a67ba89e26@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.150.70.206
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/2/22 =E4=B8=8B=E5=8D=883:37, Paolo Bonzini wrote:
> On 22/02/20 03:10, Chen Gang wrote:
>> Set C1 to 1 if stack overflow occurred; set to 0 otherwise".
>>
>> In helper_fxam_ST0, I guess, we need "env->fpus |=3D 0x200" (but I don=
't
>> know wheter it will be conflict with SIGND(temp)). And we have to stil=
l
>> need foverflow, because all env->fptags being 0 doesn't mean overflow.
>=20
> No, you need to add "env->fpus |=3D 0x200" and "env->fpus &=3D ~0x200"
> directly to fpush, fpop, etc.
>=20

OK. The content below is my next TODO, welcome your opinions.

When overflow occurs, for me, we need keep everything no touch except
set C1 flag. In fxam, we don't clear C1, but keep no touch for clearning
C1 in another places.

When underflow occurs, for me, we need keep everything no touch except
set env->fpstt 8, so the next consecutive fpop/f[i]stp* can be checked
easier, and the next fpush/f[i]ld* can work well in normal.

For fxam, we check env->fpstt =3D=3D 8 and env->fptags for empty. And whe=
n
env->fpstt is 8, it need be set 7 before used in fincstp and ffree_STN.

Thanks.



