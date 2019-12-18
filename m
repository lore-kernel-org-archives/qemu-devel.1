Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF2F218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InxC95A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihTs5-0000pm-PQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 02:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihTrQ-0000Ih-26
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihTrO-0003vW-SX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:35:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihTrO-0003uf-Or
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576654506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SadRx0ucG/io5p8saq/HZ6TYwOcTiPIAXFyaOu9BEDI=;
 b=InxC95A6OStZQgQbU6ZyRWYqe7agH2WIVwpMnXqFJmzJopaR4xv8E5fmhWjggnuT5z29WH
 y3Ym7W7Ld26pdEn8J5vYfeN4Ko47Vivj8C0EP6zyX3vcDG6a6W72+jBtCIk36BwwBjCvmR
 /ppwA9Niz5TYJZzimftUiinV2ZArXU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Gcss4_nbPbq88U8vUfl6TQ-1; Wed, 18 Dec 2019 02:35:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC7B10054E3;
 Wed, 18 Dec 2019 07:35:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B52C620D3;
 Wed, 18 Dec 2019 07:35:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 289F211386A7; Wed, 18 Dec 2019 08:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/34] Error reporting patches for 2019-12-16
References: <20191217062651.9687-1-armbru@redhat.com>
 <CAFEAcA8a=E9GLnAz+vFtSQ8w=5RJK5aZJvQhEzxsRrThvMT5FQ@mail.gmail.com>
Date: Wed, 18 Dec 2019 08:35:00 +0100
In-Reply-To: <CAFEAcA8a=E9GLnAz+vFtSQ8w=5RJK5aZJvQhEzxsRrThvMT5FQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Dec 2019 15:49:27 +0000")
Message-ID: <87eex284t7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Gcss4_nbPbq88U8vUfl6TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: David Gibson <dgibson@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 17 Dec 2019 at 06:33, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166=
304:
>>
>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16=
-2019' into staging (2019-12-16 14:07:56 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-16
>>
>> for you to fetch changes up to 0e7f83bab6559775cd71e418b12a49145e59faa7:
>>
>>   nbd: assert that Error** is not NULL in nbd_iter_channel_error (2019-1=
2-16 20:50:16 +0100)
>>
>> ----------------------------------------------------------------
>> Error reporting patches for 2019-12-16
>>
>> ----------------------------------------------------------------
>
> This gets conflicts:
> diff --cc target/ppc/kvm.c
> index 7406d18945,27ea3ce535..0000000000
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@@ -2076,7 -2076,7 +2076,11 @@@ int kvmppc_set_smt_threads(int smt
>       return ret;
>   }
>
> ++<<<<<<< HEAD
>  +void kvmppc_error_append_smt_possible_hint(Error **errp_in)
> ++=3D=3D=3D=3D=3D=3D=3D
> + void kvmppc_error_append_smt_possible_hint(Error *const *errp)
> ++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
>   {
>       int i;
>       GString *g;
> diff --cc target/ppc/kvm_ppc.h
> index 47b08a4030,f22daabf51..0000000000
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@@ -28,7 -28,7 +28,11 @@@ void kvmppc_set_papr(PowerPCCPU *cpu)
>   int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>   void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>   int kvmppc_smt_threads(void);
> ++<<<<<<< HEAD
>  +void kvmppc_error_append_smt_possible_hint(Error **errp_in);
> ++=3D=3D=3D=3D=3D=3D=3D
> + void kvmppc_error_append_smt_possible_hint(Error *const *errp);
> ++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
>   int kvmppc_set_smt_threads(int smt);
>   int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>   int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
> @@@ -164,7 -164,7 +168,11 @@@ static inline int kvmppc_smt_threads(vo
>       return 1;
>   }
>
> ++<<<<<<< HEAD
>  +static inline void kvmppc_error_append_smt_possible_hint(Error **errp_i=
n)
> ++=3D=3D=3D=3D=3D=3D=3D
> + static inline void kvmppc_error_append_smt_possible_hint(Error *const *=
errp)
> ++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
>   {
>       return;
>   }
>
> Furthermore, it turns out that the conflicts are due to
> different patches from the same author to the same function
> ("ppc: well form kvmppc_hint_smt_possible error hint helper"
> and "ppc: make Error **errp const where it is appropriate")
> which both seem to be addressing broadly the same thing
> but conflict with each other and arrived via different
> pull requests.
>
> So I'm just bouncing this one back for you to fix and
> figure out which version you want...

You got an outdated version of the patch via David's pull request.
Happens.  I'll fix things up and repost.


