Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB072C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7F02073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjxVj36A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9n4I-0004wP-L1
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j9n2E-0003KS-Mv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j9n2C-0001yN-CV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:43:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j9n2C-0001xg-7V
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583401395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8g3UsaeiFnCvWREfxvBiuoxpdpsMsgsiWZsp/zK1x4M=;
 b=SjxVj36Ac3I2upxxTvhA2rCReBAZb9WrSLJrXnMUTRSrI1E43+a2mS7B19cmOkQ3fbJDMq
 k1bpzckZetH65XI9cjKIXlESP6CNfjB7sIj/D19O5lduDWINLDPkFIFyrVGRyEqfXjDj0D
 CUbH3hlfz762RTmXIxhjjD2bEZeFAw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-wJ7qjlGoPNmZ2h8XYfy8TQ-1; Thu, 05 Mar 2020 04:43:13 -0500
X-MC-Unique: wJ7qjlGoPNmZ2h8XYfy8TQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D68CA18C43C0;
 Thu,  5 Mar 2020 09:43:12 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 106A85D9C9;
 Thu,  5 Mar 2020 09:43:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 07/10] configure: fix check for libzstd
In-Reply-To: <874kv68lg9.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 02 Mar 2020 22:02:14 +0000")
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-8-alex.bennee@linaro.org>
 <874kv68lg9.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 05 Mar 2020 10:43:08 +0100
Message-ID: <87v9njf87n.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Fixes: 3a67848134d0
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 7b373bc0bb8..caa65f58831 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2464,7 +2464,7 @@ fi
>>  # zstd check
>> =20
>>  if test "$zstd" !=3D "no" ; then
>> -    if $pkg_config --exist libzstd ; then
>> +    if $pkg_config --exists libzstd ; then

Hi

several things:

a- I found why I didn't get the error.  Fedora pkg-config is really
"smart":

b- I have tried (with this patch), the following configurations:
   * --enable-zstd
   * --disable-zstd
   with both libzstd-devel installed and not installed. Everything
   worked as expected.
   (BTW, I tested that before submmiting the patch in the first place, I
   thought that I had done all testing needed for such a check).

Can you told me what architecture/distro/os are you using.


> Dropping this patch as it breaks the build even more!
>
>   CC      migration/block.o
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:24:5: error: unk=
nown type name =E2=80=98ZSTD_CStream=E2=80=99
>
>      ZSTD_CStream *zcs;
>
>      ^

This is really weird.  if you arrive here, that means:
- you have zstd devel installed (whatever is that called for your
  os/distro/whatever).

- pkg-config has found zstd devel packages and configured them (that
  file depends on CONFiG_ZSTD beoing defined)

- gcc has found <zstd.h> (i.e. it don't give one error about that
  include file not found).

And zstd don't have ZSTD_CStream defined?  What is going on here?
Can you post/show what is on your zstd.h file?
What zstd library version do you have?

I thought that zstd was a new library, and that we didn't need to check
for versions.  It appears that I was wrong.  And no, the include file
don't show what features are new/old.

Sorry for the inconveniences.

Later, Juan.

>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:26:5: error: unk=
nown type name =E2=80=98ZSTD_DStream=E2=80=99
>
>      ZSTD_DStream *zds;
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:28:5: error: unk=
nown type name =E2=80=98ZSTD_inBuffer=E2=80=99
>
>      ZSTD_inBuffer in;
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:29:5: error: unk=
nown type name =E2=80=98ZSTD_outBuffer=E2=80=99
>
>      ZSTD_outBuffer out;
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_send_setup=E2=80=99:
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:14: error: im=
plicit declaration of function =E2=80=98ZSTD_createCStream=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
>
>      z->zcs =3D ZSTD_createCStream();
>
>               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:5: error: nes=
ted extern declaration of =E2=80=98ZSTD_createCStream=E2=80=99 [-Werror=3Dn=
ested-externs]
>
>      z->zcs =3D ZSTD_createCStream();
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:12: error: as=
signment makes pointer from integer without a cast [-Werror=3Dint-conversio=
n]
>
>      z->zcs =3D ZSTD_createCStream();
>
>             ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:62:11: error: im=
plicit declaration of function =E2=80=98ZSTD_initCStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
>
>      res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());
>
>            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:62:5: error: nes=
ted extern declaration of =E2=80=98ZSTD_initCStream=E2=80=99 [-Werror=3Dnes=
ted-externs]
>
>      res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:64:9: error: imp=
licit declaration of function =E2=80=98ZSTD_freeCStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
>
>          ZSTD_freeCStream(z->zcs);
>
>          ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:64:9: error: nes=
ted extern declaration of =E2=80=98ZSTD_freeCStream=E2=80=99 [-Werror=3Dnes=
ted-externs]
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_send_prepare=E2=80=99:
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:120:11: error: r=
equest for member =E2=80=98dst=E2=80=99 in something not a structure or uni=
on
>
>      z->out.dst =3D z->zbuff;
>
>            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:121:11: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>      z->out.size =3D z->zbuff_len;
>
>            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:122:11: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>      z->out.pos =3D 0;
>
>            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:9: error: un=
known type name =E2=80=98ZSTD_EndDirective=E2=80=99
>
>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
>
>          ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:35: error: =
=E2=80=98ZSTD_e_continue=E2=80=99 undeclared (first use in this function)
>
>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
>
>                                    ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:35: note: ea=
ch undeclared identifier is reported only once for each function it appears=
 in
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:128:21: error: =
=E2=80=98ZSTD_e_flush=E2=80=99 undeclared (first use in this function)
>
>              flush =3D ZSTD_e_flush;
>
>                      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:130:14: error: r=
equest for member =E2=80=98src=E2=80=99 in something not a structure or uni=
on
>
>          z->in.src =3D iov[i].iov_base;
>
>               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:131:14: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>          z->in.size =3D iov[i].iov_len;
>
>               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:132:14: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          z->in.pos =3D 0;
>
>               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:143:19: error: i=
mplicit declaration of function =E2=80=98ZSTD_compressStream2=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
>
>              ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush)=
;
>
>                    ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:143:13: error: n=
ested extern declaration of =E2=80=98ZSTD_compressStream2=E2=80=99 [-Werror=
=3Dnested-externs]
>
>              ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush)=
;
>
>              ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:144:35: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>          } while (ret > 0 && (z->in.size - z->in.pos > 0)
>
>                                    ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:144:48: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          } while (ret > 0 && (z->in.size - z->in.pos > 0)
>
>                                                 ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:145:36: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>                           && (z->out.size - z->out.pos > 0));
>
>                                     ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:145:50: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>                           && (z->out.size - z->out.pos > 0));
>
>                                                   ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:146:30: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>          if (ret > 0 && (z->in.size - z->in.pos > 0)) {
>
>                               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:146:43: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          if (ret > 0 && (z->in.size - z->in.pos > 0)) {
>
>                                            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:157:33: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>      p->next_packet_size =3D z->out.pos;
>
>                                  ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_recv_setup=E2=80=99:
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:14: error: i=
mplicit declaration of function =E2=80=98ZSTD_createDStream=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
>
>      z->zds =3D ZSTD_createDStream();
>
>               ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:5: error: ne=
sted extern declaration of =E2=80=98ZSTD_createDStream=E2=80=99 [-Werror=3D=
nested-externs]
>
>      z->zds =3D ZSTD_createDStream();
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:12: error: a=
ssignment makes pointer from integer without a cast [-Werror=3Dint-conversi=
on]
>
>      z->zds =3D ZSTD_createDStream();
>
>             ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:206:11: error: i=
mplicit declaration of function =E2=80=98ZSTD_initDStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
>
>      ret =3D ZSTD_initDStream(z->zds);
>
>            ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:206:5: error: ne=
sted extern declaration of =E2=80=98ZSTD_initDStream=E2=80=99 [-Werror=3Dne=
sted-externs]
>
>      ret =3D ZSTD_initDStream(z->zds);
>
>      ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:208:9: error: im=
plicit declaration of function =E2=80=98ZSTD_freeDStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
>
>          ZSTD_freeDStream(z->zds);
>
>          ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:208:9: error: ne=
sted extern declaration of =E2=80=98ZSTD_freeDStream=E2=80=99 [-Werror=3Dne=
sted-externs]
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_recv_pages=E2=80=99:
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:281:10: error: r=
equest for member =E2=80=98src=E2=80=99 in something not a structure or uni=
on
>
>      z->in.src =3D z->zbuff;
>
>           ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:282:10: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>      z->in.size =3D in_size;
>
>           ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:283:10: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>      z->in.pos =3D 0;
>
>           ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:288:15: error: r=
equest for member =E2=80=98dst=E2=80=99 in something not a structure or uni=
on
>
>          z->out.dst =3D iov->iov_base;
>
>                ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:289:15: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>          z->out.size =3D iov->iov_len;
>
>                ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:290:15: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          z->out.pos =3D 0;
>
>                ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:301:19: error: i=
mplicit declaration of function =E2=80=98ZSTD_decompressStream=E2=80=99 [-W=
error=3Dimplicit-function-declaration]
>
>              ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);
>
>                    ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:301:13: error: n=
ested extern declaration of =E2=80=98ZSTD_decompressStream=E2=80=99 [-Werro=
r=3Dnested-externs]
>
>              ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);
>
>              ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:302:35: error: r=
equest for member =E2=80=98size=E2=80=99 in something not a structure or un=
ion
>
>          } while (ret > 0 && (z->in.size - z->in.pos > 0)
>
>                                    ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:302:48: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          } while (ret > 0 && (z->in.size - z->in.pos > 0)
>
>                                                 ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:303:36: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>                           && (z->out.pos < iov->iov_len));
>
>                                     ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:304:31: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          if (ret > 0 && (z->out.pos < iov->iov_len)) {
>
>                                ^
>
> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:314:27: error: r=
equest for member =E2=80=98pos=E2=80=99 in something not a structure or uni=
on
>
>          out_size +=3D z->out.pos;
>
>                            ^
>
> cc1: all warnings being treated as errors
>
> /home/travis/build/stsquad/qemu/rules.mak:69: recipe for target 'migratio=
n/multifd-zstd.o' failed
>
> make: *** [migration/multifd-zstd.o] Error 1
>
> make: *** Waiting for unfinished jobs....
>
> rm tests/qemu-iotests/socket_scm_helper.o
>
>>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>>          LIBS=3D"$zstd_libs $LIBS"


