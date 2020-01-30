Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E102051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0hH0wcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E102051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBJM-0006Xa-UT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixBHr-0005d8-1D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixBHp-0004fQ-Oj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:59:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixBHp-0004f5-L1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580396357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKD5QoO0QqbmI6IAnPST7AiuzrzqJQdbYDrpj8Soi9w=;
 b=T0hH0wcAOef+oKkJPUTULPCnV1ueLwCR0qUllkfrwgqsCaJSot0aS/y3h9Oi0HnDh99SMA
 4JHO+Im5xnz/UvLVMdnfKl+YVvnY80nqgd8GIKUQnRWaXsll73IX2AiCwNSi2OZHXMPxcH
 47fFaocxdQaT8rdhZXneXxgFJUtYE48=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-8_vca_g7MkWzfZGr1jWq2Q-1; Thu, 30 Jan 2020 09:59:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so1822529wru.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8HJqmid7T5Dc0Zqk/ZrfahxWyasd3qBIE0odOnrhzZo=;
 b=izA1H7u0hjXV1WhBUJVwQaHEroO/JMq9JXylIMglkmY8/oE5i0wwciQu7Zdfs/e1rp
 0Da0dJ9VozD0B8r+TjEGAhdYWSSBewEx9bAsy7NxVhmHf5+JAXg2zAxV2HhcvQeu2rzZ
 nVEjuAL+E4Uomoohwcj4yTII1ajNlsXlaT0iY4vQ89CNNFUBShvnxjUomBV0Z8B9ogJp
 lP8WhZKY4SvUVudhjHfRkjtirbXqwWkz/uzerGJYycYtHk5BCbyu3g81fLXipxEDjbij
 3OK1U+O+TPEoFqgm5+bTtvvop8InR/TQ3FCEtATrDrseezsFR1GX62CKzvAlNRFGBgjm
 mscQ==
X-Gm-Message-State: APjAAAWDdalhxnAMGUAc0QCkSo4YWBu/BbFiqOX/9xqGnOakKNhkDjJw
 qKqKClahmAKuPULkh8Yus7dQuQfJF2ToueIN59VAv3FOv/uoTFR0aUocFcNrIm1nC7c8VIbt4Vy
 JkHwM+b6I30LP0HA=
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr6031948wmj.18.1580396353806;
 Thu, 30 Jan 2020 06:59:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6ytsPqPa1/qQtUo3Ka1bFexywJ9GUkIg8kG6FSWG4rNol1ipj+/9TIWl8FaC9pgEUUqER2g==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr6031918wmj.18.1580396353479;
 Thu, 30 Jan 2020 06:59:13 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x17sm7404320wrt.74.2020.01.30.06.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 06:59:12 -0800 (PST)
Subject: Re: [PATCH v2 02/12] tests/docker: better handle symlinked libs
To: Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAEyhzFugFgAuy=r+JsoTxzqYWxTB6LAnETBWS4ubMOmbjrFP3w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <95cdd5d6-d7da-8fdc-926a-bff3feda2257@redhat.com>
Date: Thu, 30 Jan 2020 15:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEyhzFugFgAuy=r+JsoTxzqYWxTB6LAnETBWS4ubMOmbjrFP3w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 8_vca_g7MkWzfZGr1jWq2Q-1
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, f4bug@amsat.org,
 qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 3:37 PM, Robert Foley wrote:
> Hi,
> I was looking at this patch and have a comment about the number of
> groups that are expected to be found by this regex.
> It seems like the old code expected two groups to be found otherwise
> it will not append the library to the found libs.
> def _get_so_libs(executable):
>      libs =3D []
>      ldd_re =3D re.compile(r"(/.*/)(\S*)")
>      try:
>          ldd_output =3D subprocess.check_output(["ldd",
> executable]).decode('utf-8')
>          for line in ldd_output.split("\n"):
>              search =3D ldd_re.search(line)
>              if search and len(search.groups()) =3D=3D 2:  <<<<<<<<<<<<<<=
<
>                  so_path =3D search.groups()[0]
>                  so_lib =3D search.groups()[1]
>                  libs.append("%s/%s" % (so_path, so_lib))

Yes you are right, this part need change to handle a single group now.

>=20
> I did a bit of experimenting with output from ldd and found a few
> strings where the new regex seems
> to generate only one group for the entire path+lib rather than one group
> for the path and another group for the lib.
>=20
> $ ldd build/aarch64-softmmu/qemu-system-aarch64
> __snip__
>        /lib/ld-linux-aarch64.so.1 (0x0000ffff9c41f000)
>        libgmodule-2.0.so.0 =3D>
> /usr/lib/aarch64-linux-gnu/libgmodule-2.0.so.0 (0x0000ffff9a96e000)
> __snip
> $ python3
> Python 3.6.8 (default, Oct  7 2019, 12:59:55)
> [GCC 8.3.0] on linux
> Type "help", "copyright", "credits" or "license" for more information.
>>>> import re
>>>> ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>>>> a =3D "/lib/ld-linux-aarch64.so.1 (0x0000ffff9c41f000)"
>>>> b =3D "libgmodule-2.0.so.0 =3D> /usr/lib/aarch64-linux-gnu/libgmodule-=
2.0.so.0 (0x0000ffff9a96e000)"
>>>> ldd_re.search(a).groups()
> ('/lib/ld-linux-aarch64.so.1',)
>>>> ldd_re.search(b).groups()
> ('/usr/lib/aarch64-linux-gnu/libgmodule-2.0.so.0',)
>>>> len(ldd_re.search(a).groups())
> 1
>>>> len(ldd_re.search(b).groups())
> 1
>>>> ldd_re_old =3D re.compile('(/.*/)(\S*)')
>>>> ldd_re_old.search(a).groups()
> ('/lib/', 'ld-linux-aarch64.so.1')
>>>> ldd_re_old.search(b).groups()
> ('/usr/lib/aarch64-linux-gnu/', 'libgmodule-2.0.so.0')
>>>> len(ldd_re_old.search(a).groups())
> 2
>>>> len(ldd_re_old.search(b).groups())
> 2
>>>>
>=20
> Thanks & Regards,
> -Rob
>=20
> On Thu, 30 Jan 2020 at 06:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> When we are copying we want to ensure we grab the first
>> resolution (the found in path section). However even that binary might
>> be a symlink so lets make sure we chase the symlinks to copy the right
>> binary to where it can be found.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/docker/docker.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 31d8adf836..7dfca63fe4 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>>       ensure theright data is copied."""
>>
>>       libs =3D []
>> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
>> +    ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>>       try:
>>           ldd_output =3D subprocess.check_output(["ldd", executable]).de=
code('utf-8')
>>           for line in ldd_output.split("\n"):
>> @@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>>       if libs:
>>           for l in libs:
>>               so_path =3D os.path.dirname(l)
>> -            _copy_with_mkdir(l, dest_dir, so_path)
>> +            real_l =3D os.path.realpath(l)
>> +            _copy_with_mkdir(real_l, dest_dir, so_path)
>>   def _check_binfmt_misc(executable):
>> --
>> 2.20.1
>>
>=20


