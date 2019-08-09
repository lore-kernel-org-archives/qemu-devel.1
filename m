Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E99C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DAF214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gNMW0dWm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ldUL5X2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DAF214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwxm-0006uo-Tn
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrew@aj.id.au>) id 1hvwxM-0006O5-BE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1hvwxL-0005pC-7U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:56:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1hvwxI-0005jk-0s; Fri, 09 Aug 2019 00:56:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 6432B21C28;
 Fri,  9 Aug 2019 00:56:43 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Fri, 09 Aug 2019 00:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=97PQ0
 ONohDjicXDGQPseSUNahm4RV3a90jPYWmyNsdc=; b=gNMW0dWmsCtlaR/ImTvKA
 BeunRlQ6XMdUKquvDBKgYhG82g+REdHoBrIqmC6zgMaXN956pEVpcquCrcCo8+K4
 YT5RA2JPZOQcpiU5PPznC3rfLu5FwH0+8v5xQeBTS4IH9NQzvpphoh7rtZc3PP2j
 Il4fjNxl88dLXowJrKq+NQw9TYo71ak+nAGrOa9HJ5Adet9CKqJpuP5ANu7L2ZdZ
 2se7mngxc37sEym8qsMhe9kk9WT6N7SESSWuCc+uHHwV6nws+TBoVoba49GxK45p
 t4iaCPIzDlkS4j+RVRuTRjirwEz3dvBLN34ByflhuYSvZ78pkXX8CA/62NarmZE8
 w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=97PQ0ONohDjicXDGQPseSUNahm4RV3a90jPYWmyNs
 dc=; b=ldUL5X2a1QLBtQ+5Ljq60oTsQdwjdwD4IT8DSHpbVFUOBRFhVDaqMG5mA
 JZP00w96Wu1sxgp1nieJRDfQGG/9p5pCfcX+0JzUwOpG//cIQlIeZDnqAlad3Obo
 /sX17O8CRM7gUlrotNvNqAJV24AFxGbTsSIlsAkegoem5m4UO1Wd7URUWE4znpbU
 Bc8X2ObY/XxdP3L5BSg8xW/pPDjhtmZ6qfEpQFOYFItoR4mfHZ7v97oWuO28HAP4
 TY+rJ/LiH1gwiY/BgZ7wRsV6FHTkfPw9QGdf2VfoJjAklRmh5qviVQDToywU4LTW
 usB70qxqWCJawRkKZeBRIoJ9KhePg==
X-ME-Sender: <xms:Cv1MXTycp7nLz1hw6Cqbr_ocCfNmRuWbz7Fl70T61X-YMc9Nhs9hbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffoh
 hmrghinhepphgrthgthhgvfidrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprghn
 ughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Cv1MXcjh4F21OcBwKRHttFh974mPCH47rsxcS8_PPepOCK9G6pvb_g>
 <xmx:Cv1MXaYvDDOZNuj0XjBNmBwlQFK3Kc043tuRfb9qUAndeKpm10EvVg>
 <xmx:Cv1MXQhwK2Ne2nj0Ia_kEghXVa_mqNo_zJ1YQ3I6mA1Lep-LlBfhVA>
 <xmx:C_1MXQHzffGMWLHazCFVnO9CYNhdH6xlgrNO2yURjx5LV1Wtb0zeUA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0A079E00A2; Fri,  9 Aug 2019 00:56:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <84d76bb7-b5b5-488b-ac14-db0e1c009f7d@www.fastmail.com>
In-Reply-To: <156532351253.12874.1201096794967354035@b08f24806b7e>
References: <156532351253.12874.1201096794967354035@b08f24806b7e>
Date: Fri, 09 Aug 2019 14:27:08 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: no-reply@patchew.org, qemu-devel@nongnu.org
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.26
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BPATCH=5D_target-arm=3A_Make_the_counte?=
 =?utf-8?q?r_tick_relative_to_cntfrq?=
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 9 Aug 2019, at 13:36, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190809031321.14760-1-andrew@aj=
.id.au/
>=20
>=20
>=20
> Hi,
>=20
> This series failed build test on s390x host. Please find the details b=
elow.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "ba=
se"
> # branch
> set -e
>=20
> echo
> echo "=3D=3D=3D ENV =3D=3D=3D"
> env
>=20
> echo
> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
> rpm -qa
>=20
> echo
> echo "=3D=3D=3D UNAME =3D=3D=3D"
> uname -a
>=20
> CC=3D$HOME/bin/cc
> INSTALL=3D$PWD/install
> BUILD=3D$PWD/build
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=3D1
> make install
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>   CC      aarch64_be-linux-user/target/arm/helper.o
> /var/tmp/patchew-tester-tmp-hkd7ua1n/src/target/arm/helper.c: In=20
> function =E2=80=98gt_virt_cnt_read=E2=80=99:
> /var/tmp/patchew-tester-tmp-hkd7ua1n/src/target/arm/helper.c:2921:12:=20=

> error: implicit declaration of function =E2=80=98gt_calc_tick=E2=80=99=
=20
> [-Werror=3Dimplicit-function-declaration]
>  2921 |     return gt_calc_tick(env, cpu_get_clock());
>       |            ^~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-hkd7ua1n/src/target/arm/helper.c:2921:12:=20=

> error: nested extern declaration of =E2=80=98gt_calc_tick=E2=80=99=20
> [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> make[1]: *** [/var/tmp/patchew-tester-tmp-hkd7ua1n/src/rules.mak:69:=20=

> target/arm/helper.o] Error 1
> make: *** [Makefile:472: aarch64_be-linux-user/all] Error 2
>=20

Ah, I missed that I put the implementation inside the
#ifndef CONFIG_USER_ONLY` block. Maybe we can just not do the scaling
for userspace anyway?

Andrew

