Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8820658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpdBqzZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGRp-0007Vu-OY
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJGRB-00071R-2y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJGR9-0006jy-Qu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:56:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJGR9-0006j2-N5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585659371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZD04EpnCFO4oqRvOvzAea502MrLmghpYiaiuIEmirV0=;
 b=LpdBqzZeER3FMK2yrqH5uPx3eO7BIGEtPeyc62EAevHw5AIllsrS1wgqwrAPfLCYTeP1PT
 2t9wcXo+6vidAxzJ3W2vFTmruiaJamg9TJL0nhh0ohzwGpXIN6tfoZryUcRtegLVA1KG+z
 38UIOJJ+xZpbPRH9wcHyVsOHQkYhsts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-p2MBn_T4OeqDBVJFQVdsZw-1; Tue, 31 Mar 2020 08:56:09 -0400
X-MC-Unique: p2MBn_T4OeqDBVJFQVdsZw-1
Received: by mail-ed1-f70.google.com with SMTP id j10so18528419edy.21
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 05:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LG0IQSTX05YxRHYTxzTWZWqxxYSA1kozjKqt+Y2asoo=;
 b=UJIphYOrCYxmtmDEK/iSMlGPxUamTE614AWIdcngQJvEJn9G01xkNKojp5DSeNs2VP
 oyiOq5A1iq+wjA7Tiz+w1HGEk+zTgvKLMtBTupqmoNyGzbuZF5O5/dyVYoTP9N6OMYYK
 jJE17+bjWqxvj5H5XytT6yczyw15PZBCPjfKoK9gYAVo5DKIi65ki3qi+ibyMgg7x31z
 74NOnZzd4pmyGBU+okPDXGM6GBhf0GmBSncM1P+Z4EjKMWXqBaGo4+12OmA76sf3bSld
 s2o9mc23+P9niHK19MFlXZjZmZX6RgBcc4MDTz00VAQ+SgZoah6kfDt5dMKde5U0+Rpj
 BJyg==
X-Gm-Message-State: AGi0PuYjywaas3pQ0g5cg5RSEgNIx+4ooiHPqk9HLrjM+B7ZfIrq1qZH
 50yoasGnl23zTznQbJqkKjMOlZn/n4q1KdZegycSz6kp9PZympsAJo/QRKK+PIfE2q2kexVkCaB
 kkag0h25bSfER/r4=
X-Received: by 2002:a17:906:cb92:: with SMTP id
 mf18mr213475ejb.366.1585659367811; 
 Tue, 31 Mar 2020 05:56:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLaYVBL4NvTzsxuZkpAO6K6oPU/yvkcarw0m7PmbXmBjLwh5ZVLi2xDGYMwoaP4o4ZRHZxB+Q==
X-Received: by 2002:a17:906:cb92:: with SMTP id
 mf18mr213438ejb.366.1585659367452; 
 Tue, 31 Mar 2020 05:56:07 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g18sm2307953edy.80.2020.03.31.05.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 05:56:06 -0700 (PDT)
Subject: Re: [PATCH] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200331103758.370644-1-berrange@redhat.com>
 <9b81074d-b9c8-8392-19a2-2f377224b66f@redhat.com>
 <20200331114103.GE353752@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <890a5780-6765-44f2-5830-1c53cea05589@redhat.com>
Date: Tue, 31 Mar 2020 14:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331114103.GE353752@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 1:41 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 31, 2020 at 01:11:45PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 3/31/20 12:37 PM, Daniel P. Berrang=C3=A9 wrote:
>>> Running configure directly from the source directory is a build
>>> configuration that will go away in future. It is also not currently
>>> covered by any automated testing. Display a deprecation warning if
>>> the user attempts to use an in-srcdir build setup, so that they are
>>> aware that they're building QEMU in an undesirable manner.
>>>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>    configure | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index e225a1e3ff..1ab7492ab5 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -3,6 +3,19 @@
>>>    # qemu configure script (c) 2003 Fabrice Bellard
>>>    #
>>> +BUILDDIR=3D$(pwd)
>>> +SRCDIR=3D$(dirname "$0")
>>
>> This duplicates $source_path.
>> Maybe you can rename it $source_path and remove the $source_path assignm=
ent
>> later.
>=20
> Sure, could do that..
>=20
>>
>>> +
>>> +ABS_BUILDDIR=3D$(realpath $BUILDDIR)
>>> +ABS_SRCDIR=3D$(realpath $SRCDIR)
>>> +
>>> +in_srcdir=3Dno
>>> +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
>>> +then
>>> +    in_srcdir=3Dyes
>>> +fi
>>> +
>>> +
>>>    # Unset some variables known to interfere with behavior of common to=
ols,
>>>    # just as autoconf does.
>>>    CLICOLOR_FORCE=3D GREP_OPTIONS=3D
>>> @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
>>>        echo "us upstream at qemu-devel@nongnu.org."
>>>    fi
>>> +if test "$in_srcdir" =3D "yes"; then
>>> +    echo
>>> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
>>> +    echo
>>> +    echo "Support for running the 'configure' script directly from the=
"
>>> +    echo "source directory is deprecated and will go away in a future"
>>> +    echo "release. In source dir builds are not covered by automated"
>>> +    echo "testing and are liable to break without warning. Users are"
>>> +    echo "strongly recommended to switch to a separate build directory=
:"
>>> +    echo
>>> +    echo "  $ mkdir build"
>>> +    echo "  $ cd build"
>>> +    echo "  $ ../configure"
>>> +    echo "  $ make"
>>> +    echo
>>> +fi
>>
>> I'd move it at the very end of the file, to be the last thing displayed.
>=20
> You can't see it from the diff, but immediately before here are a bunch
> of other big warnings for users, so I figured it was a good idea to keep
> them all together.

IMO we should move them to the end too.

I'm getting this output:

$ ./configure
[...]
plugin support    no
fuzzing support   no
gdb               /usr/bin/gdb

WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED

Support for running the 'configure' script directly from the
source directory is deprecated and will go away in a future
release. In source dir builds are not covered by automated
testing and are liable to break without warning. Users are
strongly recommended to switch to a separate build directory:

   $ mkdir build
   $ cd build
   $ ../configure
   $ make

cross containers  docker

NOTE: guest cross-compilers enabled: cc cc
$

We might also move the cross-x messages earlier.
Anyway all my comments can be postponed to 5.1, so if other agree with=20
your patch, let's KISS for 5.1-rc1.

>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> +
>>>    config_host_mak=3D"config-host.mak"
>>>    echo "# Automatically generated by configure - do not modify" >confi=
g-all-disas.mak
>>>
>>
>=20
> Regards,
> Daniel
>=20


