Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02AFC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6C320715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPSNceqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6C320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03ng-00039j-2l
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j03md-0002P0-Qd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j03mc-0007Pz-Ed
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:34:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j03mc-0007PE-BP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581082497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ML8ENtK1HLrfV9mMEH+CBFCHrgpZDaP7yeqtAHQ2OQ=;
 b=VPSNceqpEntSv07mRcxfMB2zRl7MYyZSqbu6BITdSSHbpV9P4cUs8CAxeP9IUvD8My0Gc6
 QFFFBBpSap4qDfUoBGAL59RdecbvpsRAerp4ErlRRyR4bZgFNm3fNMAJD+HCONJNfZA5k7
 i7EaASOpyx3Io78z6o71J/e4OtBVSQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-TYbRxEZvN0mHIUce5QtScQ-1; Fri, 07 Feb 2020 08:34:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so1222577wrs.22
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 05:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3ML8ENtK1HLrfV9mMEH+CBFCHrgpZDaP7yeqtAHQ2OQ=;
 b=p2MaRq/+emmrE6CR0UuijAuush+LRpp+w3hJOBa3RI17gb9zxlCIF3XE4jQLYkkGPQ
 36idz4gLhabO1othazpdIRL7/IzoytcpudmczyMOiRPkdAMMiFFQKezmVoYWbSQGUDNc
 GnUvX6dMlwayADQXya+1a3t1UT+9AE/a4kgOJiFiPFGdihZzRRv4ZcG9VeQ8DU8nFmMZ
 gdKVD7QDDA3NUBdn65DAz3rNrcl2Ng+soE0VIgxvbeLkSvhhYRyzN16ZZe+96yzvDfbz
 7UUOVd7cltMJmp4bdi1fzJ1sI5Ec9eR8b57b5qwA4vpV+qqghAu6jbgZylcwwHWcSKj9
 xGYQ==
X-Gm-Message-State: APjAAAU3paMPLgtFY/UPEkLyOsTU8OVfSpXdW8B2ZKM4ZpDlmWGrIdpP
 aPBO5eHK7hdZw3i7Coq/TXv1nvxvmugm1de4xNqY702qFKF3iiq0rHPtAeoJBQ357WSlkb3b9jg
 9JfD1V3B35uni7c70WIj8aP1/FRD1vas=
X-Received: by 2002:a1c:451:: with SMTP id 78mr4291231wme.125.1581082490113;
 Fri, 07 Feb 2020 05:34:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxISXnftkbRCE8kpy6MOwdywFecEq5eAxRRpfAaOoTadN5DdRsskkAk/8YG3a1UJsEjLJY+Dp/yc0a32TBgU0E=
X-Received: by 2002:a1c:451:: with SMTP id 78mr4291212wme.125.1581082489846;
 Fri, 07 Feb 2020 05:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20200206211936.17098-1-philmd@redhat.com>
 <CAFEAcA_bHE1s5q4bUrna0ph4Zw4m0VynjTcRo9GPjZDThqHZZQ@mail.gmail.com>
 <2caf3728-448c-cd90-a59f-3540c13e8374@redhat.com>
In-Reply-To: <2caf3728-448c-cd90-a59f-3540c13e8374@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 7 Feb 2020 14:34:38 +0100
Message-ID: <CAP+75-US7=9p3sZyiSeYZtA5Ex3rbjwcmLutc+XbbscN=E5Ucw@mail.gmail.com>
Subject: Re: [PULL 00/46] Python queue 2020-02-06
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: TYbRxEZvN0mHIUce5QtScQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 7, 2020 at 2:30 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Cc'ing qemu-block@
>
> On 2/7/20 12:51 PM, Peter Maydell wrote:
> > On Thu, 6 Feb 2020 at 21:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> I prepared this series on behalf of Eduardo and
> >> Cleber (one of them will ack this cover).
> >>
> >> Regards,
> >>
> >> Phil.
> >>
> >> The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d=
7611c:
> >>
> >>    Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040=
220-1' into staging (2020-02-04 18:55:06 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://gitlab.com/philmd/qemu.git tags/python-next-20200206
> >>
> >> for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d30=
8:
> >>
> >>    .readthedocs.yml: specify some minimum python requirements (2020-02=
-06 21:48:24 +0100)
> >
> > Hi; this fails 'make check' (all hosts):
> >
> >    TEST    iotest-qcow2: 252
> >    TEST    iotest-qcow2: 256
> >    TEST    iotest-qcow2: 265
> >    TEST    iotest-qcow2: 267
> >    TEST    iotest-qcow2: 268
> >    TEST    iotest-qcow2: 283 [fail]
> > QEMU          --
> > "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../=
../x86_64-softmmu/qemu-system-x86_64"
> > -nodefaults -display none -accel qtest
> > QEMU_IMG      --
> > "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../=
../qemu-img"
> > QEMU_IO       --
> > "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../=
../qemu-io"
> >   --cache writeback --aio threads -f qcow2
> > QEMU_NBD      --
> > "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../=
../qemu-nbd"
> > IMGFMT        -- qcow2 (compat=3D1.1)
> > IMGPROTO      -- file
> > PLATFORM      -- Linux/x86_64 e104462 4.15.0-74-generic
> > TEST_DIR      --
> > /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/scra=
tch
> > SOCK_DIR      -- /tmp/tmp.oppAzNNHIY
> > SOCKET_SCM_HELPER --
> > /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/sock=
et_scm_helper
> >
> > --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/283.out
> >   2020-02-06 18:59:06.291529139 +0000
> > +++ /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/=
283.out.bad
> >       2020-02-07 11:25:38.477373907 +0000
> > @@ -1,8 +1 @@
> > -{"execute": "blockdev-add", "arguments": {"driver": "null-co",
> > "node-name": "target"}}
> > -{"return": {}}
> > -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
> > "image": {"driver": "null-co", "node-name": "base", "size": 1048576},
> > "node-name": "source"}}
> > -{"return": {}}
> > -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
> > "image": "base", "node-name": "other", "take-child-perms": ["write"]}}
> > -{"return": {}}
> > -{"execute": "blockdev-backup", "arguments": {"device": "source",
> > "sync": "full", "target": "target"}}
> > -{"error": {"class": "GenericError", "desc": "Cannot set permissions
> > for backup-top filter: Conflicts with use by other as 'image', which
> > uses 'write' on base"}}
> > +./check: line 866: ./283: Permission denied
> > Not run: 220
> > Failures: 283
> > Failed 1 of 115 iotests
> > /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:842:
> > recipe for target 'check-tests/check-block.sh' failed
>
> I only run out-of-tree builds.
>
> I noticed the block tests were not run until I add this change:
>
> -- >8 --
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -836,7 +836,7 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>   QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D
> tests/qemu-iotests/socket_scm_helper$(EXESUF)
>
>   .PHONY: check-tests/check-block.sh
> -check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
> +check-tests/check-block.sh: $(SRC_PATH)/tests/check-block.sh
> qemu-img$(EXESUF) \
>                  qemu-io$(EXESUF) qemu-nbd$(EXESUF)
> $(QEMU_IOTESTS_HELPERS-y) \
>                  $(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
>          @$<
> ---
>
> Peter, are you running only in-tree builds?

Oops nevermind, I was in a '--disable-tools' build directory when I
restarted testing.


