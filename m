Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586A920702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5HXZZwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586A920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnewK-0002iz-LS
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jneun-0000XB-5N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:08:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jneuk-000454-5V
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uhg4WOZQdNZ1CRUamur1MbLAoMb/HQRZOtcr18AlXX0=;
 b=U5HXZZwmnb3dqxTowtW2k+xmGrTZoTz7iYzG1JOm42G0BEKIqfFDheHNbJ0X9pb9SzF7DD
 5Y/O5+WW1bGSWrOc0rVHi3X/ton60TGa5PQMYaAhSdMFIObk6mCEL9fG2KYsZP5KXKZJMC
 EV6regsvmyzE/AiYgSLPJLMyCFjm7cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-BFsh9SmuMOK_ENrLkKdrBQ-1; Tue, 23 Jun 2020 05:08:17 -0400
X-MC-Unique: BFsh9SmuMOK_ENrLkKdrBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE084804033;
 Tue, 23 Jun 2020 09:08:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A859A512FE;
 Tue, 23 Jun 2020 09:08:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EAEF113846D; Tue, 23 Jun 2020 11:08:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PULL v2 03/32] riscv: Generalize CPU init routine for the base
 CPU
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
 <20200619165817.4144200-4-alistair.francis@wdc.com>
 <CAEUhbmUEREaNBXBP6a0UgAYK6dmVbGFtDu8wLGUjNXHL5mWtoA@mail.gmail.com>
Date: Tue, 23 Jun 2020 11:08:14 +0200
In-Reply-To: <CAEUhbmUEREaNBXBP6a0UgAYK6dmVbGFtDu8wLGUjNXHL5mWtoA@mail.gmail.com>
 (Bin Meng's message of "Tue, 23 Jun 2020 14:22:46 +0800")
Message-ID: <87lfkejgjl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bin Meng <bmeng.cn@gmail.com> writes:

> Hi Alistair,
>
> On Sat, Jun 20, 2020 at 1:09 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> From: Bin Meng <bin.meng@windriver.com>
>>
>> There is no need to have two functions that have exactly the same
>> codes for 32-bit and 64-bit base CPUs.
>>
>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Message-id: 1591837729-27486-1-git-send-email-bmeng.cn@gmail.com
>> Message-Id: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
>
> I noticed that patches from other people than you have the
> "Message-id" tags, but your patch [1] does not. Is this intentional?
>
> (not sure why we need 2 "Message-id" tags here, with one has <> ?)

We don't.  Looks like an accident.

> Just want to know what's the best practice here.

The Message-Id tag's purpose is connecting commits back to the mailing
list.  Useful when you want to look up their review later.

To get them into git, maintainers should use git-am -m to apply
patches.  I have

    [am]
            messageid = true

in my .gitconfig.

Maintainers may be tempted to use git-rebase or git-cherry-pick instead
for patches they already have in their local git (such as their own
patches).  No good, because we don't get the Message-Id that way.

Patch submissions (as opposed to pull requests) generally do not have
Message-Id tags in commit messages.

Hope this helps!

>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  target/riscv/cpu.c | 18 +++++-------------
>>  1 file changed, 5 insertions(+), 13 deletions(-)
>>
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06208.html
>
> Regards,
> Bin


