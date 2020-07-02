Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81061C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F752088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T67m2YM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F752088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr7Gq-0006KN-Er
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 18:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7Fu-0005Ji-HX; Thu, 02 Jul 2020 18:00:30 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7Fr-00040t-N0; Thu, 02 Jul 2020 18:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Nd8vyBcL4O3lhHford2YBpbZCUqbvArkxdNRZDhuDRA=; 
 b=T67m2YM2Gxz+u5aqAo1GQtFeGbNHn6A13PnDQAY5ZocYB3btaS0jHRwUhg/owFDJ25D0T/TE2m2bjm00IZ2i6mL0o6ora+u/qHIwEnIMmgIZm1X47rL45PaPjBdfll/epQ7RbB4ciE59vVdCIWvM9bTQNiLbhlgZcbXYnufYuXo82T7yL7Djlvh1/kc5E4z8qKRrOaHw4uVw0bUM/XllEmmuus3i4pUZ69ICRkZ9kLLhJyugzlybiJH3uyTVDjfWb0Nl74PYCt0toRUojh9jX2zxa2Q6Let1T8joTsCdZ+XrLZYlrttSZw5bExPWzjXKjew4sEYOIkUP2zN00wGE+w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jr7FR-0001BA-Qt; Fri, 03 Jul 2020 00:00:01 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jr7FR-0002JH-Ep; Fri, 03 Jul 2020 00:00:01 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 14/34] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
In-Reply-To: <6c06d36e-c074-fff0-fad8-fa96962b4906@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <6ee75696d3eaed56b46e91fe242fdfab51feb066.1593342067.git.berto@igalia.com>
 <fae77394-92fd-d170-0ae6-051c0a024d04@redhat.com>
 <w51mu4jurqe.fsf@maestria.local.igalia.com>
 <6c06d36e-c074-fff0-fad8-fa96962b4906@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 00:00:01 +0200
Message-ID: <w51a70htw66.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 18:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 02 Jul 2020 11:57:46 AM CEST, Max Reitz wrote:
>> The reason why we would want to check it is, of course, because that
>> bit does have a meaning in regular L2 entries.
>>=20
>> But that bit is ignored in images with subclusters so the only reason
>> why we would check it is to report corruption, not because we need to
>> know its value.
>
> Sure.  But isn=E2=80=99t that the whole point of having
> QCOW2_SUBCLUSTER_INVALID in the first place?

At the moment we're only returning QCOW2_SUBCLUSTER_INVALID in cases
where there is no way to interpret the entry correctly: a) the
allocation and zero bits are set for the same subcluster, and b) the
allocation bit is set but the entry has no valid offset.

It doesn't mean that we cannot use _SUBCLUSTER_INVALID for cases like
the one we're discussing, but this one is different from the other two.

Berto

