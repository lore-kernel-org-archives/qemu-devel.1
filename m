Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97BC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF462080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKhqFsxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF462080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyffN-0000GG-Fu
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 12:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyfeZ-0007zx-Bd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyfeV-000053-Vp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:36:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyfeV-0008TE-5V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580751410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RoxYHzF0ZBAWHf4/gqmbihRKf3xoux1ACQnLuCVihGM=;
 b=KKhqFsxpamISxnw9qweoe6Ql8nImixdf1A9MUl9myBl2LnGLDyxQhLurv1lOJ5dna5eOCJ
 mgGo6SGwfffXSCisp2pEWMjkdLLYFDVfiv9fI0WyDnRrFjaqET6CTSdZke+sE3tyW32/Pl
 HgCrpenIyjYq8aldxNpQ2ZCoIVYYOZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-dMf42tCGObuh8ottucy8Jw-1; Mon, 03 Feb 2020 12:36:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94628190D340;
 Mon,  3 Feb 2020 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-90.gru2.redhat.com
 [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 691F187B1C;
 Mon,  3 Feb 2020 17:36:30 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
Date: Mon, 3 Feb 2020 15:36:28 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203032328.12051-2-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dMf42tCGObuh8ottucy8Jw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative;
 boundary="------------73494C4FC0442136A03FA905"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------73494C4FC0442136A03FA905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Cleber,

On 2/3/20 1:23 AM, Cleber Rosa wrote:
> This is a crude and straightforward mapping of Peter's
> "remake-merge-builds" and "pull-buildtest" scripts.
>
> Some characteristics were removed for simplicity sake (but eventually
> will), including:
>   * number of simultaneous make jobs
>   * make's synchronous output, not needed because of previous point
>   * out-of-tree builds
>
> This covers the "x86-64 Linux with a variety of different build
> configs"[1].  I've personally tested all of them, and only had
> issues with the "notcg" job[2], but it seems to be a test specific
> issue with the nested KVM I was using.


Could you put a comment in the commit text or in-code explaining why it=20
builds QEMU with=C2=A0 --disable-libssh on all the jobs?

>
> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
> [2] - https://paste.centos.org/view/1dd43a1c
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d2c7d2198e..eb4077e2ab 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,6 +2,8 @@ include:
>     - local: '/.gitlab-ci-edk2.yml'
>  =20
>   build-system1:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script: &before_scr_apt
>    - apt-get update -qq
>    - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev gen=
isoimage
> @@ -17,6 +19,8 @@ build-system1:
>    - make -j2 check
>  =20
>   build-system2:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -31,6 +35,8 @@ build-system2:
>    - make -j2 check
>  =20
>   build-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -47,6 +53,8 @@ build-disabled:
>    - make -j2 check-qtest SPEED=3Dslow
>  =20
>   build-tcg-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -67,6 +75,8 @@ build-tcg-disabled:
>               248 250 254 255 256
>  =20
>   build-user:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -78,6 +88,8 @@ build-user:
>    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>  =20
>   build-clang:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -92,6 +104,8 @@ build-clang:
>    - make -j2 check
>  =20
>   build-tci:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -111,3 +125,105 @@ build-tci:
>    - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qtes=
t/pxe-test
>    - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
>      ./tests/qtest/pxe-test -m slow
> +
> +ubuntu-18.04.3-x86_64-notools:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n22
> + - ./configure --target-list=3Darm-softmmu --disable-tools --disable-lib=
ssh
> + # There is no make / make check in the "pull-buildtest" script for this=
.
> + # Question: should it at least be built? Or dropped?
> + - make
> +
> +ubuntu-18.04.3-x86_64-all-linux-static:

Doesn't it need to LD_PRELOAD on this runner too? ->

|https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-bui=
ldtest#n24=20
|

> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n25
> + - ./configure --enable-debug --static --disable-system --disable-gluste=
rfs --disable-libssh

Shouldn't it --disable-gnutls instead of --disable-glusterfs?

> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n36
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n45
> + - make check V=3D1
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n48
> + - make check-tcg V=3D1


Any special reason to split it in 3 steps instead of a single `make=20
check check-tcg`?

That pattern continues on next jobs...


> +
> +ubuntu-18.04.3-x86_64-all:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n26
> + - ./configure --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n28
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n37
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-alldbg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n27
> + - ./configure --disable-libssh
Missing --enable-debug, right?
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n27
> + - make clean
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n29
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n37
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-clang:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n31
> + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-gt=
k --extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -Werr=
or'
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n33
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n39
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-tci:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n33
> + - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n34
> + - make

Would make sense to add a commented `make check` entry as well?

https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buil=
dtest#n40

> +
> +ubuntu-18.04.3-x86_64-notcg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n35
> + - ./configure --disable-libssh --enable-debug --disable-tcg
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n35
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n39
> + # Question: check is disabled on the original script, because the machi=
ne
> + # is said to be running VirtualBox.  Should this be dropped or should t=
he
> + # machine be tweaked or substituted?
> + - make check V=3D1

--------------73494C4FC0442136A03FA905
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hi Cleber,<br>
    </p>
    <div class=3D"moz-cite-prefix">On 2/3/20 1:23 AM, Cleber Rosa wrote:<br=
>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">This is a crude and straightfo=
rward mapping of Peter's
"remake-merge-builds" and "pull-buildtest" scripts.

Some characteristics were removed for simplicity sake (but eventually
will), including:
 * number of simultaneous make jobs
 * make's synchronous output, not needed because of previous point
 * out-of-tree builds

This covers the "x86-64 Linux with a variety of different build
configs"[1].  I've personally tested all of them, and only had
issues with the "notcg" job[2], but it seems to be a test specific
issue with the nested KVM I was using.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Could you put a comment in the commit text or in-code explaining
      why it builds QEMU with=C2=A0 --disable-libssh on all the jobs?<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

[1] - <a class=3D"moz-txt-link-freetext" href=3D"https://wiki.qemu.org/Requ=
irements/GatingCI#Current_Tests">https://wiki.qemu.org/Requirements/GatingC=
I#Current_Tests</a>
[2] - <a class=3D"moz-txt-link-freetext" href=3D"https://paste.centos.org/v=
iew/1dd43a1c">https://paste.centos.org/view/1dd43a1c</a>

Signed-off-by: Cleber Rosa <a class=3D"moz-txt-link-rfc2396E" href=3D"mailt=
o:crosa@redhat.com">&lt;crosa@redhat.com&gt;</a>
---
 .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d2c7d2198e..eb4077e2ab 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,6 +2,8 @@ include:
   - local: '/.gitlab-ci-edk2.yml'
=20
 build-system1:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script: &amp;before_scr_apt
  - apt-get update -qq
  - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geniso=
image
@@ -17,6 +19,8 @@ build-system1:
  - make -j2 check
=20
 build-system2:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -31,6 +35,8 @@ build-system2:
  - make -j2 check
=20
 build-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -47,6 +53,8 @@ build-disabled:
  - make -j2 check-qtest SPEED=3Dslow
=20
 build-tcg-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -67,6 +75,8 @@ build-tcg-disabled:
             248 250 254 255 256
=20
 build-user:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -78,6 +88,8 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
=20
 build-clang:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -92,6 +104,8 @@ build-clang:
  - make -j2 check
=20
 build-tci:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -111,3 +125,105 @@ build-tci:
  - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/p=
xe-test
  - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
    ./tests/qtest/pxe-test -m slow
+
+ubuntu-18.04.3-x86_64-notools:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n22">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
22</a>
+ - ./configure --target-list=3Darm-softmmu --disable-tools --disable-libss=
h
+ # There is no make / make check in the "pull-buildtest" script for this.
+ # Question: should it at least be built? Or dropped?
+ - make
+
+ubuntu-18.04.3-x86_64-all-linux-static:</pre>
    </blockquote>
    <p>Doesn't it need to LD_PRELOAD on this runner too? -&gt;<br>
    </p>
    <pre><code><a class=3D"moz-txt-link-freetext" href=3D"https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n24">https:=
//git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#=
n24</a>
</code></pre>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n25">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
25</a>
+ - ./configure --enable-debug --static --disable-system --disable-glusterf=
s --disable-libssh</pre>
    </blockquote>
    <p>Shouldn't it --disable-gnutls instead of --disable-glusterfs?<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n36">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n36</a>
+ - make
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n45">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n45</a>
+ - make check V=3D1
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n48">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n48</a>
+ - make check-tcg V=3D1</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Any special reason to split it in 3 steps instead of a single
      `make check check-tcg`?</p>
    <p>That pattern continues on next jobs...</p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+
+ubuntu-18.04.3-x86_64-all:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n26">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
26</a>
+ - ./configure --disable-libssh
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n28">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n28</a>
+ - make
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37</a>
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-alldbg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n27">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
27</a>
+ - ./configure --disable-libssh</pre>
    </blockquote>
    Missing --enable-debug, right? <br>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n27">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n27</a>
+ - make clean
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n29">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n29</a>
+ - make
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37</a>
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-clang:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n31">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
31</a>
+ - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-gtk =
--extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -Werror=
'
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n33">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n33</a>
+ - make
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39</a>
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-tci:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n33">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
33</a>
+ - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n34">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n34</a>
+ - make</pre>
    </blockquote>
    <p>Would make sense to add a commented `make check` entry as well?<br>
    </p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/pe=
ople/peter.maydell/misc-scripts.git/tree/pull-buildtest#n40">https://git.li=
naro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n40</a><=
br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200203032328.12051-2-crosa@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+
+ubuntu-18.04.3-x86_64-notcg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n35">https://git.=
linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n=
35</a>
+ - ./configure --disable-libssh --enable-debug --disable-tcg
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n35">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n35</a>
+ - make
+ # <a class=3D"moz-txt-link-freetext" href=3D"https://git.linaro.org/peopl=
e/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39">https://git.linar=
o.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39</a>
+ # Question: check is disabled on the original script, because the machine
+ # is said to be running VirtualBox.  Should this be dropped or should the
+ # machine be tweaked or substituted?
+ - make check V=3D1
</pre>
    </blockquote>
  </body>
</html>

--------------73494C4FC0442136A03FA905--


