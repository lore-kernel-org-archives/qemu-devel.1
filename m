Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B26C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3070F20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OEFB3/Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfsN-00047k-5d
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izfnq-0001eN-Mh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izfnp-0007w3-9F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:56361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izfno-0007ll-Rc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580990304;
 bh=8UVtcPBjsdPXa6EDqfa2L9WWhzoahjerbl1XbZ50QEg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OEFB3/Q6EmPGCUketM5RkJMnKl3qBTCU+8E0Rwwztnk9ZG5HslMbDAJ5kz/4SFVBH
 h8ugs4EXDRvi7Kwzp+Si49QhMlE63TquZej4WJl5YrIOjWcvdY/D/NMFvbpchLKAoY
 D5fx0eJ/ZdQjxY9KEiM5MgF3Biq9/vG+7hS4V5Bc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MryXN-1jMIpp0vO1-00nyBc; Thu, 06 Feb 2020 12:58:24 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net
Subject: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Date: Thu,  6 Feb 2020 12:57:27 +0100
Message-Id: <20200206115731.13552-1-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128140945.929-1-n54@gmx.com>
References: <20200128140945.929-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:odWWlaWX1XBgzxzcosTaDsbJ6OaTeGfCqz9J2/00uLlxMokP/AN
 hih73hIr53sURqmp6SwJstACFX2EoBbDWxTlawJjRcwSIVNJWGJekngnMHWWa7ekpLZ9r8N
 b65czhZ/J/up6hCcHA9ypQW/KYQMskRjHoKvLhJKAIWQaAUJ36SY0BmwxZLiMXeSpqa8T4K
 /T5+Ieyv8bCALdMnapSiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o8k5FRsGizM=:RmIgF1JmyTDP8z4TUvRTcg
 30w8qizZyYak+KnvO6iseQbcV2fJ5BjVvqcbXuW5oc2EQX+7wX3FPUMSYv4e1MRQghM2QQjOP
 2OPkI0pK0QPb+f8hoRnIq69yQIZVVwDc2lMFgm5GNKrq8ii3zrOh6EbyawAAsV+I7vM980sXZ
 32V+FYT6Fg2wxIqXhSBFkUre/y1pjT7VtQnhRW2+9UH/1GXAllY7vPHTiuJcDu+L/vJ93ZCKQ
 61KKVK+qQftyh32NjZKObfdzXxy2azrlY2lLxTqi/uwwv1QyZoi/jV4ZW0AgXVkKoCPROdqX0
 Gf6//CgpYom52QzFIAE0x8zffHvORyLKW4mnBUUZPLZFlhEXWTvmrF18mh5EQGBROq+Eoh9LE
 Z3WNofnmMQ0/RufDIiS3LLEKuLHSaknUlva0O/IEi4VIqGazAMeS13xYp0J7FzBXbHUln+oaK
 WmvRnaQ4GOZopYVSMV3/SToLLAxMbNShcwaxURe0sg+Qp87ZF5ELIrAZdgE/2+X5xFbNlwcis
 ZUlMtxLgXv75unn5qJz3VvP95/gbXX0GRehR+klMsZBfywlZ9ythfPz++LDTRFE8YyuojbTkm
 5POI+kRsonP2HUl64v5vhgin+hRESMyQ8k44PFb7ZG5F9tCdja1ALnGVkqz7+j+HcpvONuaw8
 h32f0BekHm0vlmN0owgXqiD/Jz1DeA5QomlcLf2trPWjEejf8m2Z/1GSaIJCuDek04qIFhvPU
 +LGUe4EqBXENr8A0/TKS1YRGOM3pPJe+7v/H81vOGhuQ6OSWNcDGf7QDaX4orJjEG34tS2WBn
 2KaQmFlOFwPPdva34QTWY6jz6gQ7+Aa50/bGlsPWDjAGEOSCRLbqRue5UIJamQfaMQp9fDibT
 3eqDpIZwM4eyhYw680cGW6krzLS1+JiPKQN1hT+mTWVobOh1uH+p3mq61EOqDabamqx22+10D
 Omr8riH5HjQJMI8oZ3KZpOL8lknLvvv02l5Ogw7krDlRFWFC4doJ3tXo5wBhL1IjeNi6LK0OJ
 8X4/CrtiMFs99YtRGvu9TwLOiqu0dkzM67t3gzlWnVIs08zIh2blPPZ8njjrIy+Yqyqeg9aAM
 uNB/EZVVDRY/C7BYlqN0dnmYrSXYAMaruy5s2gjbAMcA/Iophbax4tLYEV7mqSSCQQ3L6s8pD
 6sB4AYaNFMoDzbMqW0pXyKi0IXejlSVRU82cLY25FBsDA0ByHxFkESpjWEjfzawOmEyD8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello QEMU Community!

Over the past year the NetBSD team has been working hard on a new user-mod=
e API
for our hypervisor that will be released as part of the upcoming NetBSD 9.=
0.
This new API adds user-mode capabilities to create and manage virtual mach=
ines,
configure memory mappings for guest machines, and create and control execu=
tion
of virtual processors.

With this new API we are now able to bring our hypervisor to the QEMU
community! The following patches implement the NetBSD Virtual Machine Moni=
tor
accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.

When compiling QEMU for x86_64 passing the --enable-nvmm flag will compile=
 the
accelerator for use. At runtime using the '-accel nvmm' should see a
significant performance improvement over emulation, much like when using '=
hax'
on NetBSD.

The documentation for this new API is visible at https://man.netbsd.org un=
der
the libnvmm(3) and nvmm(4) pages.

NVMM was designed and implemented by Maxime Villard.

Thank you for your feedback.

Refrences:
https://m00nbsd.net/4e0798b7f2620c965d0dd9d6a7a2f296.html

Test plan:

1. Download a NetBSD 9.0 pre-release snapshot:
http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/images/NetBSD-9.0=
_RC1-amd64.iso

2. Install it natively on a not too old x86_64 hardware (Intel or AMD).

There is no support for nested virtualization in NVMM.

3. Setup the system.

 export PKG_PATH=3Dhttp://www.ki.nu/pkgsrc/packages/current/NetBSD-9.0_RC1=
/All
 pkg_add git gmake python37 glib2 bison pkgconf pixman

Install mozilla-rootcerts and follow post-install instructions.

 pkg_add mozilla-rootcerts

More information: https://wiki.qemu.org/Hosts/BSD#NetBSD

4. Build qemu

 mkdir build
 cd build
 ../configure --python=3Dpython3.7
 gmake
 gmake check

5. Test

 qemu -accel nvmm ...


History:
v2 -> v3:
 - Register nvmm in targetos NetBSD check
 - Stop including hw/boards.h
 - Rephrase old code comments (remove XXX)
v1 -> v2:
 - Included the testing plan as requested by Philippe Mathieu-Daude
 - Formatting nit fix in qemu-options.hx
 - Document NVMM in the accel section of qemu-options.hx

Maxime Villard (4):
  Add the NVMM vcpu API
  Add the NetBSD Virtual Machine Monitor accelerator.
  Introduce the NVMM impl
  Add the NVMM acceleration enlightenments

 accel/stubs/Makefile.objs |    1 +
 accel/stubs/nvmm-stub.c   |   43 ++
 configure                 |   37 ++
 cpus.c                    |   58 ++
 include/sysemu/hw_accel.h |   14 +
 include/sysemu/nvmm.h     |   35 ++
 qemu-options.hx           |   16 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/nvmm-all.c    | 1221 +++++++++++++++++++++++++++++++++++++
 10 files changed, 1419 insertions(+), 9 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h
 create mode 100644 target/i386/nvmm-all.c

=2D-
2.25.0

