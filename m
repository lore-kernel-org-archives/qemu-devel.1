Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403C20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nT2fmfRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9403C20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr7KG-00008t-PN
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 18:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7JM-0007d3-RY; Thu, 02 Jul 2020 18:04:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:60695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr7JL-000542-6q; Thu, 02 Jul 2020 18:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=6vUsQ4k7PmBSvS+iXf11KjqijzWq8Sk1xlIAC/PgXrQ=; 
 b=nT2fmfRs+2N2RI1s6l7xnrBSBmYQOiV8sTzGODKqOFQsu53oPauwS3Ynm4OB05BaTOOAu/q895iZCw/Y8Vi8qJH4PZvGkmAyqZQS6kREZn0dN5NdhWZKuEXDp12ot4g94jm7sSuh4SgE0VIf+sK4u1AzlGNSqYZqn562XlYGJ1Xqv2FTZsPyvutpbdvpeC8D4g5UKPpYgFjz+jVI8JXmYCnG795AChCX9pDV2kd3NKP7JGBpKEgc5mCJ13juOXSo1R5+1SNlZt2R9j0Cep3Y/WIguQwrcuDZLiKAkpWb8E2BaNcFExZMoNdm+nqgOTywBSsWav70LMnc1YXnARWHag==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jr7JI-0001wB-Je; Fri, 03 Jul 2020 00:04:00 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jr7JI-0002xy-6q; Fri, 03 Jul 2020 00:04:00 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 21/34] qcow2: Add subcluster support to
 qcow2_get_host_offset()
In-Reply-To: <2dada231-fc81-04af-0f70-d883ca41433a@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <d82b7e4829f466eda81f3a33b536dde43aa3e26a.1593342067.git.berto@igalia.com>
 <2dada231-fc81-04af-0f70-d883ca41433a@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 00:04:00 +0200
Message-ID: <w517dvltvzj.fsf@maestria.local.igalia.com>
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

On Thu 02 Jul 2020 02:46:27 PM CEST, Max Reitz wrote:
>> -    /* must be allocated */
>> -    assert(first_cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
>> -           first_cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC);
>> +    assert(*l2_index + nb_clusters <=3D s->l2_size);
>
> Not l2_slice_size?

Oh, indeed!

>> +        } else if (check_offset) {
>
> My gcc (v10.1.1) appears to be a bit daft, and so doesn=E2=80=99t recogni=
ze
> that check_offset must always be initialized before this line is hit.

Yeah I noticed that patchew complained, I'll fix that.

Berto

