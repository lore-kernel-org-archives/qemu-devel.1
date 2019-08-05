Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC5CC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8ED2087B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Pm4geeCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8ED2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZu5-0004OG-IM
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1huZtf-0003yA-OH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1huZte-0001Nc-NH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:07:19 -0400
Received: from mout.web.de ([212.227.15.4]:52571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1huZte-0001NJ-7K
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564999627;
 bh=iUA/KiucJTLTi4JiKqkLhF7NGZZby1wZTt006IK3C4M=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Pm4geeCroPxLft01bZsfdML+gnSQntP1w8oUfbjs5dLhE+sXUF0LDBU6QbscBW9d/
 vkXt1tkgGOa4S+UHNFQMIB5yXGUJYrPpPlHqbgQV9mUkUuL7riwpgKfVZx86t+9qpa
 slvIdGw+r9njQGxOaWEmLz7+d1eRTtHbqnYF+d70=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [139.25.68.37] ([95.157.55.156]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIoz-1i34Dj3nd3-0096d1; Mon, 05
 Aug 2019 12:07:07 +0200
To: Stefano Garzarella <sgarzare@redhat.com>
References: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
 <20190805083352.mtu7pwoekwstmzp2@steredhat>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a7e4fbe4-f7ea-ee9a-d883-89a7f6756330@web.de>
Date: Mon, 5 Aug 2019 12:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805083352.mtu7pwoekwstmzp2@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XBEARwgFph8PFtX8lT4wa2j95Nz+iQjG/w0uGqr9aWwxKiiBL/Y
 qru7bUff1UyQvhgoi6hmwtK5ggb6rcI7WWi4eXGYYEEaqw+lf5aLxpBMuBxM95FqIysfCCG
 sQ5ms6roais/dwtPgmi0TOK052ANFgE4MIePoEcDoP/qzidhN9b4KISQoS23ahpGIBymg+S
 DaoTXNr0fcPiU/7jLqxbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5BejcfBx1Cc=:azUIku87p/P4N58AKoJRqJ
 Okjcc0qXbr6BTl1ftDHaYEusdJyChLmTKdIhmAvSqXzC6MBGXKRPtyhoPfvMnV+8XwRPB5OgU
 025028CCr5fL0aBdDkwCDx9d/gpfQBlVwSaUCe0us8R/OfzgepAH6SrAMZxq9RBRRmxXR7lTv
 7dg58NNYJXMuCV/M4TdmCF6gT32+x4JJfxjd0hkZR7IVPvjAXVq7XfwhZLPbkFGhKZ9rJEmRH
 rx0D8HLSkrIbAE+1cVGRKNjQNhWrU6RM4+NgBYXH9xN7lxxPmTaqVYXmKnl34ip2cR6on38co
 G6rqZQJ8KfNeKSXclY4WUlNoRVhFszVk9XIB3wqf6VsH0mEJ4SRYixY9ZKnYGM9feeTHPkzpG
 H6T++GJTLylUxBGmrO04QizqmXW1DdRvKjliElr418m5zXjV6rOzDkx/CQJ1Y94AqNwKuHV7V
 Z44MpKNfjmS2hDCKycg45+Nd2XroVFUVZOUegHS2T8Go1MFGAvTRp28SuGBKc4qwfdo/QlMqu
 tkr7eRurEwGgyZ+JcBZDG0x4fDtmw6o6c3ZTQk/MW9WRr4IUt2DnfJQz2a6k+8ITp+ZngCK3A
 QoOkr7cxuA27mH2jGyBFCd0OiymNOI2ouP35VO46/pwtxPMNP//FFjZ0Y77PNV3cnQYVBA1yH
 7qoRNCaxjel1rw6HWpuuLJYAlXXrhfiv/W+Ng1qf7s0wSlfI/kfMqtbdIpAy2s+96B73vGOpt
 JV9z/HHz8SF7AjITAoUnd6dJLchQjtH3vt/lq7xMIyOUbFhO4JFVF5/3GMRudr63eooHybF1p
 oeQpdaWjc0+mKDvnXgu+BiXMjgIIqCwpILVOsd5AEbcnkYimZSZ0273DjU96MWxSD2el30tsA
 CkenAZfGkYV/DHjiVTzCEN94DT/f6yRMnYjk3wUqVxuYqvmxFCe8AABACBYmLQW0PqmDVqZFY
 4BqGDukmGHrx3wJUxF4PkdeF1+K+4KLRrGgSsJ0ri4kb1GcjH4hq+UrsJcxsSrTQke5JrSXwO
 +kltE55/ta6LjmlLz+5vuQftyhFqXJe7lH+anVkeYsW//WjlcLblwCjmoJ/kuFHZoFOphQ8Nd
 kej/J1KU0rlofCs8YcAB0uG5DwNbWY6myWPFSDl06811v4jMpLhVxglCKiWduItJXGRiQSO/8
 3b0Gs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: Re: [Qemu-devel] [PATCH v2] ivshmem-server: Terminate also on SIGINT
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.08.19 10:33, Stefano Garzarella wrote:
> On Sat, Aug 03, 2019 at 03:22:04PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allows to shutdown a foreground session via ctrl-c.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Changes in v2:
>>  - adjust error message
>>
>>  contrib/ivshmem-server/main.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/mai=
n.c
>> index 197c79c57e..e4cd35f74c 100644
>> --- a/contrib/ivshmem-server/main.c
>> +++ b/contrib/ivshmem-server/main.c
>> @@ -223,8 +223,9 @@ main(int argc, char *argv[])
>>      sa_quit.sa_handler =3D ivshmem_server_quit_cb;
>>      sa_quit.sa_flags =3D 0;
>>      if (sigemptyset(&sa_quit.sa_mask) =3D=3D -1 ||
>> -        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1) {
>> -        perror("failed to add SIGTERM handler; sigaction");
>> +        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1 ||
>> +        sigaction(SIGINT, &sa_quit, 0) =3D=3D -1) {
>> +        perror("failed to add signal handler; sigaction");
>>          goto err;
>>      }
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks.

>
> Not related with this patch, but since I was looking at the code,
> I noticed the 'ivshmem_server_quit' variable, set in the signal handler,
> is not volatile.
> Should we define it volatile to avoid possible compiler optimizations?

Yes, would be better.

I'm sure there is more, possibly also on the current device model side. I =
only
started to dig through it while implementing a new revision of the protoco=
l on
top and aside of it.

Jan


