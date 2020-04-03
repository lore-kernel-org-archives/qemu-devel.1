Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F1C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDD32078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgMs9tcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDD32078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNYQ-00075R-J6
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKNWl-0005oS-04
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKNWj-0005bv-5t
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKNWj-0005bK-1Y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585924952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nuh6dmuWiAnHcERJDynhNjc3xxpwYwJGgua2pN0SnPc=;
 b=bgMs9tcWsbv2JAW6gFFprzeUlyGV8VZh3mpDYWq6Nsf9rg1KAIPpQFvMzH+WFvk7OF3tJY
 RpYvPIGC3u+Bq2U3yGK6hwZYcWQmMhznjD4smZVxNosNeu+eOSw7mCJkZKOCwsc86rLSan
 AA7pG1fj4EYYuyfh29epqN/gzspqXVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-RpQSYkaONvueTcttUtYtuQ-1; Fri, 03 Apr 2020 10:42:27 -0400
X-MC-Unique: RpQSYkaONvueTcttUtYtuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66CC28017FF;
 Fri,  3 Apr 2020 14:42:26 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C0715DA2C;
 Fri,  3 Apr 2020 14:42:25 +0000 (UTC)
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200403135306.665493-1-berrange@redhat.com>
 <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <813a6453-0cc1-2ee7-20fb-3ba624aad57a@redhat.com>
Date: Fri, 3 Apr 2020 09:42:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 9:02 AM, Eric Blake wrote:
> On 4/3/20 8:53 AM, Daniel P. Berrang=C3=A9 wrote:
>> Running configure directly from the source directory is a build
>> configuration that will go away in future. It is also not currently
>> covered by any automated testing. Display a deprecation warning if
>> the user attempts to use an in-srcdir build setup, so that they are
>> aware that they're building QEMU in an undesirable manner.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>
>> Changed in v4:
>> =C2=A0=C2=A0 - Adopted Eric's suggested wording
>=20
>> +if test "$in_srcdir" =3D "yes"; then
>> +=C2=A0=C2=A0=C2=A0 echo
>> +=C2=A0=C2=A0=C2=A0 echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DI=
R IS DEPRECATED"
>> +=C2=A0=C2=A0=C2=A0 echo
>> +=C2=A0=C2=A0=C2=A0 echo "Support for running the 'configure' script dir=
ectly from the"
>> +=C2=A0=C2=A0=C2=A0 echo "source directory is deprecated. In-tree builds=
 are not=20
>> covered"
>> +=C2=A0=C2=A0=C2=A0 echo "by automated testing and thus may not correctl=
y build QEMU."
>> +=C2=A0=C2=A0=C2=A0 echo "Users are recommended to use a separate build =
directory:"
>> +=C2=A0=C2=A0=C2=A0 echo
>> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 $ mkdir build"
>> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 $ cd build"
>> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 $ ../configure"
>> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 $ make"
>=20
> Late question, but:
>=20
> Since this is just a warning, we still manage to complete the=20
> ./configure run, including whatever generated files it leaves in-tree.=20
> Is there any additional step we need to recommend prior to 'mkdir build'=
=20
> that will clean up the in-tree artifacts, so that the user then=20
> attempting the VPATH build won't still have a broken build due to the=20
> leftovers from the in-tree attempt?=C2=A0 'make distclean', perhaps?
>=20
> /me starts testing; I'll reply back once it finishes...

tl;dr: 'make distclean' isn't perfect (it still leaves 2 directories=20
behind), but does clean up a lot of directories and .mak files, and IS=20
necessary before you can build in the subdirectory; but at least make=20
warns you.  Still, I'd prefer adding that step in the warning, rather=20
than getting an error several steps later.

On a fresh git checkout:

$ ./configure
...
$ git clean -dfxn
Would remove aarch64-linux-user/
Would remove aarch64-softmmu/
Would remove aarch64_be-linux-user/
Would remove alpha-linux-user/
Would remove alpha-softmmu/
Would remove arm-linux-user/
Would remove arm-softmmu/
Would remove armeb-linux-user/
Would remove config-all-disas.mak
Would remove config-host.mak
Would remove config.log
Would remove config.status
Would remove cris-linux-user/
Would remove cris-softmmu/
Would remove docs/sphinx/__pycache__/
Would remove hppa-linux-user/
Would remove hppa-softmmu/
Would remove i386-linux-user/
Would remove i386-softmmu/
Would remove linux-headers/asm
Would remove lm32-softmmu/
Would remove m68k-linux-user/
Would remove m68k-softmmu/
Would remove microblaze-linux-user/
Would remove microblaze-softmmu/
Would remove microblazeel-linux-user/
Would remove microblazeel-softmmu/
Would remove mips-linux-user/
Would remove mips-softmmu/
Would remove mips64-linux-user/
Would remove mips64-softmmu/
Would remove mips64el-linux-user/
Would remove mips64el-softmmu/
Would remove mipsel-linux-user/
Would remove mipsel-softmmu/
Would remove mipsn32-linux-user/
Would remove mipsn32el-linux-user/
Would remove moxie-softmmu/
Would remove nios2-linux-user/
Would remove nios2-softmmu/
Would remove or1k-linux-user/
Would remove or1k-softmmu/
Would remove ppc-linux-user/
Would remove ppc-softmmu/
Would remove ppc64-linux-user/
Would remove ppc64-softmmu/
Would remove ppc64abi32-linux-user/
Would remove ppc64le-linux-user/
Would remove riscv32-linux-user/
Would remove riscv32-softmmu/
Would remove riscv64-linux-user/
Would remove riscv64-softmmu/
Would remove rx-softmmu/
Would remove s390x-linux-user/
Would remove s390x-softmmu/
Would remove sh4-linux-user/
Would remove sh4-softmmu/
Would remove sh4eb-linux-user/
Would remove sh4eb-softmmu/
Would remove sparc-linux-user/
Would remove sparc-softmmu/
Would remove sparc32plus-linux-user/
Would remove sparc64-linux-user/
Would remove sparc64-softmmu/
Would remove tests/qemu-iotests/common.env
Would remove tests/qgraph/
Would remove tests/tcg/config-aarch64-linux-user.mak
Would remove tests/tcg/config-aarch64-softmmu.mak
Would remove tests/tcg/config-aarch64_be-linux-user.mak
Would remove tests/tcg/config-alpha-linux-user.mak
Would remove tests/tcg/config-alpha-softmmu.mak
Would remove tests/tcg/config-arm-linux-user.mak
Would remove tests/tcg/config-arm-softmmu.mak
Would remove tests/tcg/config-armeb-linux-user.mak
Would remove tests/tcg/config-cris-linux-user.mak
Would remove tests/tcg/config-cris-softmmu.mak
Would remove tests/tcg/config-hppa-linux-user.mak
Would remove tests/tcg/config-hppa-softmmu.mak
Would remove tests/tcg/config-i386-linux-user.mak
Would remove tests/tcg/config-i386-softmmu.mak
Would remove tests/tcg/config-lm32-softmmu.mak
Would remove tests/tcg/config-m68k-linux-user.mak
Would remove tests/tcg/config-m68k-softmmu.mak
Would remove tests/tcg/config-mips-linux-user.mak
Would remove tests/tcg/config-mips-softmmu.mak
Would remove tests/tcg/config-mips64-linux-user.mak
Would remove tests/tcg/config-mips64-softmmu.mak
Would remove tests/tcg/config-mips64el-linux-user.mak
Would remove tests/tcg/config-mips64el-softmmu.mak
Would remove tests/tcg/config-mipsel-linux-user.mak
Would remove tests/tcg/config-mipsel-softmmu.mak
Would remove tests/tcg/config-mipsn32-linux-user.mak
Would remove tests/tcg/config-mipsn32el-linux-user.mak
Would remove tests/tcg/config-ppc-linux-user.mak
Would remove tests/tcg/config-ppc-softmmu.mak
Would remove tests/tcg/config-ppc64-linux-user.mak
Would remove tests/tcg/config-ppc64-softmmu.mak
Would remove tests/tcg/config-ppc64abi32-linux-user.mak
Would remove tests/tcg/config-ppc64le-linux-user.mak
Would remove tests/tcg/config-riscv64-linux-user.mak
Would remove tests/tcg/config-riscv64-softmmu.mak
Would remove tests/tcg/config-s390x-linux-user.mak
Would remove tests/tcg/config-s390x-softmmu.mak
Would remove tests/tcg/config-sh4-linux-user.mak
Would remove tests/tcg/config-sh4-softmmu.mak
Would remove tests/tcg/config-sh4eb-linux-user.mak
Would remove tests/tcg/config-sh4eb-softmmu.mak
Would remove tests/tcg/config-sparc64-linux-user.mak
Would remove tests/tcg/config-sparc64-softmmu.mak
Would remove tests/tcg/config-x86_64-linux-user.mak
Would remove tests/tcg/config-x86_64-softmmu.mak
Would remove tests/tcg/config-xtensa-linux-user.mak
Would remove tests/tcg/config-xtensa-softmmu.mak
Would remove tests/tcg/config-xtensaeb-linux-user.mak
Would remove tests/tcg/config-xtensaeb-softmmu.mak
Would remove tilegx-linux-user/
Would remove tricore-softmmu/
Would remove unicore32-softmmu/
Would remove x86_64-linux-user/
Would remove x86_64-softmmu/
Would remove xtensa-linux-user/
Would remove xtensa-softmmu/
Would remove xtensaeb-linux-user/
Would remove xtensaeb-softmmu/
$ make distclean
...
$ git clean -dfxn
Would remove docs/sphinx/__pycache__/
Would remove tests/qgraph/
$ ./configure
...
$ mkdir build
$ cd build
$ ../configure
$ make
Makefile:58: *** This is an out of tree build but your source tree=20
(/home/eblake/qemu-tmp) seems to have been used for an in-tree build.=20
You can fix this by running "make distclean && rm -rf *-linux-user=20
*-softmmu" in your source tree.  Stop.
$ cd ..
$ make distclean && rm -rf *-linux-user *-softmmu
$ cd build
$ make
...


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


