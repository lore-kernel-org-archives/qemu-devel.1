Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55881C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710E12083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710E12083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN0Xj-0004x4-5E
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 17:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kN0Vz-0004UL-BP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:16:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kN0Vx-0008AM-Ls
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:16:55 -0400
Received: by mail-io1-f67.google.com with SMTP id z25so2656372iol.10
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 14:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UvtB/Jsq/8u0y77RfICCILdfoPJyD2g///QdUrUc8CU=;
 b=Ng/KRAmhEIFg43gCKUZX5VFdVFkY2V5XGqlpVbt1OFGTxbmThumYrFjaT6VkDx0gW7
 gfVQOzsMLtx62o6cExSghdusOQc9IxvPt37prjByN39173uKFdJP/WBhDaCnJoT3WziJ
 uEMb6NVkzUTDRPbY8XbXgXiCPeK+TwrUv8SIAebsQKkmccZh43/iZObrCsbEJC97UTqx
 8eVRFnx/y4HfE4D127T8xhvhbnsKG0hDihDBLltWhDn7GloInkPXIfX7egZ7cFckM2if
 uVvSs0GLaAr0UABhcTfrCbyhvNOyf/Ll5GVRw8JtkqM1u4hNU0jODs6FEkyqH5sbiCsf
 w6ew==
X-Gm-Message-State: AOAM532a/cL8ElPol+9Lnh38q4Ma6ZlYrSxx/da7B1r5hHVFzs6EgEt9
 CoFLdnxgsQU6gIh9EPINw7QBbVpJOQrbZNe16qk=
X-Google-Smtp-Source: ABdhPJzprk+aetim7FItB3l0r5TwjFZuwuH1FpxsAR65JCibZ3gNEAyrWH4obYV4i38y98cC39JdulHxA+BuZgun/XE=
X-Received: by 2002:a05:6602:2e0e:: with SMTP id
 o14mr151625iow.111.1601327811934; 
 Mon, 28 Sep 2020 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-7-philmd@redhat.com>
In-Reply-To: <20200928131934.739451-7-philmd@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Mon, 28 Sep 2020 17:16:40 -0400
Message-ID: <CAPyFy2DE0Ad6FWPtA31s+fnCS_CfvDQ+Dn9CYJSoU6YQynBrEw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] qemu/bswap: Use compiler __builtin_bswap() on
 FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.67; envelope-from=carpeddiem@gmail.com;
 helo=mail-io1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 17:16:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 09:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports __builtin_bswap().
> Remove the FreeBSD specific ifdef'ry.
>
> This reverts commit de03c3164accc21311c39327601fcdd95da301f3
> ("bswap: Fix build on FreeBSD 10.0").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Ed Maste <emaste@FreeBSD.org>

Aside, to test building with this change on Clang 11 (default compiler
in FreeBSD-CURRENT) I needed a few other changes to avoid warnings:

hw/s390x/ipl.h, hw/usb/dev-uas.c variable sized type warnings

../hw/usb/dev-uas.c:157:31: error: field 'status' with variable sized
type 'uas_iu' not at the end of a struct or class is a GNU extension
[-Werror,-Wgnu-variable-sized-type-not-at-end]
    uas_iu                    status;
                              ^

target/s390x/cpu_models.c pointer to smaller integer type cast

../target/s390x/cpu_models.c:984:21: error: cast to smaller integer
type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
    S390Feat feat =3D (S390Feat) opaque;
                    ^~~~~~~~~~~~~~~~~

