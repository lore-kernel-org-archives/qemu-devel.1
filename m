Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CADFC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D3D206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D3D206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhSs-0000ey-73
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:43:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonio.ospite@collabora.com>) id 1hJhS1-0000Fh-8R
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonio.ospite@collabora.com>) id 1hJhS0-0002yj-1p
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:42:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <antonio.ospite@collabora.com>)
	id 1hJhRz-0002ri-QT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:42:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: ao2)
	with ESMTPSA id E82182613D9
From: Antonio Ospite <antonio.ospite@collabora.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190318134019.23729-1-peter.maydell@linaro.org>
	<41b21196-5401-898d-4afc-6fffa71d09dd@collabora.com>
Message-ID: <498af98a-5be0-a589-c7b5-246c4d0ee7ef@collabora.com>
Date: Thu, 25 Apr 2019 18:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <41b21196-5401-898d-4afc-6fffa71d09dd@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.235.227.227
Subject: Re: [Qemu-devel] [PATCH] configure: Remove --source-path option
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425164214.SGAYSRL-hQJ9SJSF61YVFnAeOrFIqqpP4-pgNcQLPuY@z>

On 19/03/19 09:41, Antonio Ospite wrote:
> On 18/03/19 14:40, Peter Maydell wrote:
>> Normally configure identifies the source path by looking
>> at the location where the configure script itself exists.
>> We also provide a --source-path option which lets the user
>> manually override this.
>>
>> There isn't really an obvious use case for the --source-path
>> option, and in commit 927128222b0a91f56c13a in 2017 we
>> accidentally added some logic that looks at $source_path
>> before the command line option that overrides it has been
>> processed.
>>
>> The fact that nobody complained suggests that there isn't
>> any use of this option and we aren't testing it either;
>> remove it. This allows us to move the "make $source_path
>> absolute" logic up so that there is no window in the script
>> where $source_path is set but not yet absolute.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Since this is a "noticed while reading code" issue rather than
>> one that's actually causing a problem, it's probably 4.1
>> material at this point.
>>
>> Cc'ing Antonio since they also have a patch to configure
>> which this will affect.
>=20
> Thanks for CC-ing me, I will send a v2 of my patch after this one gets =
in.
>=20
> A minor comment below.
>=20
>> ---
>> =C2=A0 configure | 10 ++--------
>> =C2=A0 1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 7071f525843..bc2953e6114 100755
>> --- a/configure
>> +++ b/configure
>> @@ -278,6 +278,8 @@ ld_has() {
>> =C2=A0 # default parameters
>> =C2=A0 source_path=3D$(dirname "$0")
>> +# make source path absolute
>> +source_path=3D$(cd "$source_path"; pwd)
>=20
> While we are at it, can't source_path be set only once?
>=20
> And probably $(dirname -- "$0") is a little more robust, it covers the=20
> case of directories starting with a dash, so maybe:
>=20
> # default parameters
> # make source path absolute
> source_path=3D$(cd "$(dirname -- "$0")"; pwd)
> ...
>

Ping.

Now that 4.0 has been released, maybe we can move on with this minor chan=
ge.

I will send a fix for https://bugs.launchpad.net/qemu/+bug/1817345 after=20
this patch lands.

Thank you,
    Antonio

>> =C2=A0 cpu=3D""
>> =C2=A0 iasl=3D"iasl"
>> =C2=A0 interp_prefix=3D"/usr/gnemul/qemu-%M"
>> @@ -519,8 +521,6 @@ for opt do
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --cxx=3D*) CXX=3D"$optarg"
>> =C2=A0=C2=A0=C2=A0 ;;
>> -=C2=A0 --source-path=3D*) source_path=3D"$optarg"
>> -=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --cpu=3D*) cpu=3D"$optarg"
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --extra-cflags=3D*) QEMU_CFLAGS=3D"$QEMU_CFLAGS $op=
targ"
>> @@ -599,9 +599,6 @@ if test "$debug_info" =3D "yes"; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LDFLAGS=3D"-g $LDFLAGS"
>> =C2=A0 fi
>> -# make source path absolute
>> -source_path=3D$(cd "$source_path"; pwd)
>> -
>> =C2=A0 # running configure in the source tree?
>> =C2=A0 # we know that's the case if configure is there.
>> =C2=A0 if test -f "./configure"; then
>> @@ -945,8 +942,6 @@ for opt do
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --interp-prefix=3D*) interp_prefix=3D"$optarg"
>> =C2=A0=C2=A0=C2=A0 ;;
>> -=C2=A0 --source-path=3D*)
>> -=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --cross-prefix=3D*)
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --cc=3D*)
>> @@ -1624,7 +1619,6 @@ $(echo Available targets: $default_target_list |=
 \
>> =C2=A0=C2=A0=C2=A0 fold -s -w 53 | sed -e 's/^/=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /')
>> =C2=A0 Advanced options (experts only):
>> -=C2=A0 --source-path=3DPATH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =
of source code [$source_path]
>> =C2=A0=C2=A0=C2=A0 --cross-prefix=3DPREFIX=C2=A0=C2=A0=C2=A0 use PREFI=
X for compile tools [$cross_prefix]
>> =C2=A0=C2=A0=C2=A0 --cc=3DCC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use C compil=
er CC [$cc]
>> =C2=A0=C2=A0=C2=A0 --iasl=3DIASL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use ACPI compiler IASL [$iasl]
>>
>=20


