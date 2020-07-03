Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E352420782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cccEazA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352420782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrL2k-0003GU-5F
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrL2C-0002ll-2L; Fri, 03 Jul 2020 08:43:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrL2A-0000ox-3l; Fri, 03 Jul 2020 08:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=IBa1nyweesRLWPZ8btXSr7T+6KqH4rXV2E011IlSqu0=; 
 b=cccEazA4VI3APPOUaEgE33+VOF4XAnL29JFyX6C/Ckhsavn0+XZV6F32g+i/vyFlwQa2X/9ZlZQiglBam4/kiW24czwD9h4300k9iwhUhVxGEkOXd+IxebN30Y0k1BjUiWJ4cl5b+NCDu5NBwiSn3tTUZTKXAyim2e1IBolNPyAUC7hWilU5cL0WxifDpYzgEbJEHsWVcAEiJGejnJGCI4bV86yoArk3R0TZh87hCvsznILU7hORo+aCqblRliLsIZ1m9vborv5wVajUtZS95GAIQTFvwvYrVbnLEpdtBtGbEDgUVf8thX43QuL3DUFqzBNQiswdq0MLmUsLAz4azw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jrL24-000497-7Z; Fri, 03 Jul 2020 14:43:08 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jrL23-0001Bq-UI; Fri, 03 Jul 2020 14:43:07 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 31/34] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
In-Reply-To: <6c0edc36-8e44-61d2-e2e5-de33c4b84bde@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <d9c3047a4b19769e4167af7b4416d02bce806444.1593342067.git.berto@igalia.com>
 <6c0edc36-8e44-61d2-e2e5-de33c4b84bde@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 14:43:07 +0200
Message-ID: <w51r1tswyzo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 08:43:09
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

On Thu 02 Jul 2020 05:13:02 PM CEST, Max Reitz wrote:
>> +        } else if (!strcmp(desc->name, BLOCK_OPT_EXTL2)) {
>> +            bool extended_l2 =3D qemu_opt_get_bool(opts, BLOCK_OPT_EXTL=
2,
>> +                                                 has_subclusters(s));
>> +            if (extended_l2 !=3D has_subclusters(s)) {
>> +                error_setg(errp, "Toggling extended L2 entries "
>> +                           "is not supported");
>> +                return -EINVAL;
>
> Just a note: I think ENOTSUP would fit better.
>
> (Then again, Maxim=E2=80=99s =E2=80=9Cblock/amend: refactor qcow2 amend o=
ptions=E2=80=9D
> removes all of this code anyway.)

I can still change that :)

Berto

