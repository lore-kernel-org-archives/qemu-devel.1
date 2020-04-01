Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F32C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1A220719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7CElRT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhPs-0005dy-PY
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 13:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jJhOs-0005B6-PF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jJhOr-0000rO-6e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:43:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jJhOr-0000po-2Y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585763015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyHkXJBUddlRK8VN0fqmUA8Mcbe3OtPX4oZhkHiOkIA=;
 b=V7CElRT8G31OD6PyXfMmsvRmfWtUlN/XKoOgSWRraNMqBGejwY4PoOKury3jDKbu2Rqfee
 ZNlzG9R7jwUbRFcnuM2RIq9oatLSn3yKkIr4x0lqQbkm7cOj1lVM0PpTBinvhtmfIVOi+e
 ADSYCMNXgXQDqPSMJBaX+6yjLmO9d3Q=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-mbZm5-pTMP-x-IknXhmHzw-1; Wed, 01 Apr 2020 13:43:32 -0400
X-MC-Unique: mbZm5-pTMP-x-IknXhmHzw-1
Received: by mail-vk1-f197.google.com with SMTP id m130so176168vkh.18
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 10:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OyHkXJBUddlRK8VN0fqmUA8Mcbe3OtPX4oZhkHiOkIA=;
 b=VdcbHRLmaK6euOH8RQ8xIhcQbdcGYbe5Z+em/DBnxTdFkd9z0y3FGjlqHUPLABQzG6
 wQiFFrYLuzPECatltf17kOs1wN3VQ0NlTXHX4o6ql4+TKO+8UECezDe9Nk6Yy2Uv84en
 gqbsFe+bGxwO24tI/bCRh8klHEsqqEfbop8avY5nxqOW6NHATQglI1LqXGIkbPACks8/
 tLf9XUFCuCIJwK96hFOXKwsaT3iIdUzvgPKz50tXoJQfla6Wi7iMMTnUWtpSCAPefVYu
 0mwPzwD1HOpFTCf+3wtKheSQNP6UJsbw+PRmeqIEeAOUuyLmZYD++1xLWIdxUq/GZdO+
 5nTg==
X-Gm-Message-State: AGi0PuZydXnwPQLvE0nf5x7IW+KOua9zyjvzRUSNwtryPbOy+vf/R6pO
 bBvxWE9bN5D3G2/hRINcc73R/n6u4dZH8J4uRZWj2j4+vHDHWW6IIbOHzOnaAVNj1lgiWp4hhHF
 DJAFKoBjYE42VtDQOYo4k6niuKfQZJV8=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr1389687vso.145.1585763011251; 
 Wed, 01 Apr 2020 10:43:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJnbVEFLdXV86IboMWGg8gFa01bWdForVFuUtmJ9eIvPpS7ZW1KzUVNXMJorFzB2yT+9Bl/vbegjdepV16looI=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr1389663vso.145.1585763010914; 
 Wed, 01 Apr 2020 10:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
In-Reply-To: <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 1 Apr 2020 14:43:20 -0300
Message-ID: <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 5:07 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
<snip>
>
> First job failed by timeout, 2nd succeeded:
> https://travis-ci.org/github/philmd/qemu/jobs/669265466
>
> However "Ran for 46 min 48 sec"
>
>  From the log:
>
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_mal=
ta_5KEc_cpio
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_mal=
ta_5KEc_cpio
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_initrd
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_initrd
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_sd
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_sd
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_bionic
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9
> Fetching asset from
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9
> Fetching asset from
> tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netb=
sd
> ...
>   (13/82)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_mal=
ta_5KEc_cpio:
>   SKIP: untrusted code
>   (24/82)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_bionic:
>   SKIP: storage limited
> ...
>   (25/82)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9:
>   SKIP: storage limited
> ...
>   (63/82)
> tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netb=
sd:
>   SKIP: Running on Travis-CI
>
> Is it possible that we are now fetching assets for tests we are not
> running? In particular the one marked @skip because the downloading time
> was too long on Travis?

Yes, your assumption is correct, this execution of Avocado downloaded
assets for tests that were skipped. Let me try to explain how the
asset feature works today on Avocado.

Avocado has two basic ways to work with assets:

1. Parse limited use cases of `fetch_asset` call in the test file and
execute them. This operation can happen in two different scenarios.
First, when using the command line `avocado assets fetch <test_file>`.
In this case, it is a standalone execution of each fetch call and the
test is not executed at all. Second, by running the test. The, enabled
by default, plugin FetchAssetJob will do the same operation of parsing
the test file and executing occurrences of `fetch_asset` call before
the tests start to run. Again, the fetch time is not computed in the
job time.

2. Execute the `fetch_asset` call from each test during the test
execution. In this case, the FetchAssetJob plugin should be disabled.
The fetch time is added to the job time as the asset download occurs
during the test execution.

The acceptance tests which make use of `fetch_asset` are all using the
first method with FetchAssetJob plugin enabled. As Avocado is parsing
the test file before it starts to run the tests, it is not aware of
possible skips that may occur during a test execution due to possible
dynamic dependency.

This is not the desired behavior, as you mentioned, Avocado is
downloading an asset that will not be used because its test will be
skipped. To minimize the damage on the download side, the Travis job
is holding the avocado cache. It means the download should happen just
once. This does not minimize the damage to space usage.

One possible workaround here is to temporarily disable the
FetchAssetJob plugin, now that the needed assets are on Travis Avocado
cache. The downside is that when an asset is not available in the
cache, it will be downloaded during the test execution and the
download time will be added to the job time. I don't know if it is
possible to manually remove an asset from Travis Avocado cache. If so,
this can be done for the tests that should be skipped because of space
usage.

We have been trying to make the Asset feature as flexible as possible
to accommodate the use cases we have been identifying. Thanks for
reporting this!

>
> RESULTS    : PASS 65 | ERROR 0 | FAIL 0 | SKIP 14 | WARN 0 | INTERRUPT 0
> | CANCEL 3
> JOB TIME   : 1480.72 s
>
> Does this "JOB TIME" sums the 'Fetching asset' part?

Answered in the comments above.

>
> Thanks,
>
> Phil.
>

Willian


