Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9412082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxawB6l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9412082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ1J-00022K-5H
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixY4c-0005T5-9A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixY4Z-0000hV-CQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:19:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixY4Z-0000fQ-8T
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49lXZwtRaQqPm/K63p1Y5Z5AcTd39PdcBYjE1dNKtww=;
 b=RxawB6l4UlijDTHuVLCb1ILR7YVkONIZdCCetv9z6jeuk8c9fhxJQFEIblC615FcfD4em/
 NaE9nkOTde+O4OucLp+eAV7yGsUCIY4d4kA5jy6suH8x2dLMqiNIU7t75b43YrDngjMGP0
 SUZ1TB1ucziWjG3RL1SDzUgcFF2mKXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-A7QIBJzwO9-LTKV73kBphg-1; Fri, 31 Jan 2020 10:19:02 -0500
Received: by mail-wm1-f69.google.com with SMTP id a10so2159267wme.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i4LKDrjSRGHv2h04TmEepaQ4XYEPKqxh5lrtgHk0uSE=;
 b=F39jFcK1iwI6M/IlxVgtznRO8lWMS1EooRFV5iaLiJ8h7aBomHdHn8Ss15A+ahuWrP
 DQDvLGgzC5+l2OhykW+4Npmcoeq6QNnJfDDXBp9ujAdp6RTcupCLSEClVUHQFp0w6iAt
 hnEMBXgNo9KRC5WDVqUdpULtDA5ckXUoQvJdPd0Lzo7r05Zut0Vcs3JxZF23JymKR1MI
 hiKhNEaFfDfMhUt1H8kS1PFfMi7QMtyByyB6BUhwB9xE4gyiy17Uq0dTksgZLuBhHAzZ
 NmjIZT83JkdExjLmd5I9bFCGTQrH87gdPFzPf6K0XF2O6O1gmeHFVWESjVVx49CtH0/t
 2f+Q==
X-Gm-Message-State: APjAAAW0/pDxks26h1J8ZZZKlYHBhE+H3u64ASHg3GFJkpRIPoe89wAU
 FH23jFDWpeL6/AO4lux9qSxVPG2QP0PsDoy1c84p8mxjGQr7Z0ndQxrcKMv+hJfVeLOq39idA4h
 07YpGaL3LG3GwPmw=
X-Received: by 2002:a1c:5445:: with SMTP id p5mr12521878wmi.75.1580483938928; 
 Fri, 31 Jan 2020 07:18:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqySUZeZb/Hyt68qe+3ypMsKke2DIhPsiNLgXokZ2HWi1bF1TsZWuXB8my0EM9dtYr8sOcyoYQ==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr12521854wmi.75.1580483938654; 
 Fri, 31 Jan 2020 07:18:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm12346075wru.6.2020.01.31.07.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:18:57 -0800 (PST)
Subject: Re: [PATCH 6/6] tests/boot_linux_console: add PVH acceptance tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
 <33e03e74-e579-c0e8-e1fc-bd408aeb32e8@redhat.com>
 <8bf4b25b-0e1b-1d7a-d166-e7b746dba207@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f602309-123d-4227-9fe0-4933a6e2ac57@redhat.com>
Date: Fri, 31 Jan 2020 16:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8bf4b25b-0e1b-1d7a-d166-e7b746dba207@oracle.com>
Content-Language: en-US
X-MC-Unique: A7QIBJzwO9-LTKV73kBphg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: pbonzini@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org,
 slp@redhat.com, wainersm@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 4:03 PM, Liam Merwick wrote:
> On 30/01/2020 23:57, Philippe Mathieu-Daud=E9 wrote:
>> On 1/27/20 5:36 PM, Liam Merwick wrote:
>>> Add tests to boot an uncompressed kernel using the x86/HVM direct=20
>>> boot ABI.
>>> The vmlinux binary is obtained from a small RPM for Kata containers and
>>> extracted using the new extract_from_rpm() method.
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> ---
>>> =A0 tests/acceptance/boot_linux_console.py | 49=20
>>> +++++++++++++++++++++++++++++-----
>>> =A0 1 file changed, 43 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index 6af19ae3b14a..ab2200aa0e47 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -65,15 +65,26 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + '/' + path
>>> -=A0=A0=A0 def do_test_x86_64_machine(self):
>>> +=A0=A0=A0 def do_test_x86_64_machine(self, pvh=3DFalse):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> -=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>> - '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '/vmli=
nuz')
>>> -=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7adedb0335321=
63a792495'
>>> -=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(kernel_url,=20
>>> asset_hash=3Dkernel_hash)
>>> +=A0=A0=A0=A0=A0=A0=A0 if pvh:
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_url =3D ('https://yum.oracle.com=
/repo/OracleLinux/'
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'OL=
7/olcne/x86_64/getPackage/'
>>> + 'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm')
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_hash =3D '4c781711a9d32dcb8e81da=
2b397cb98926744e23'
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_path =3D self.fetch_asset(rpm_ur=
l, asset_hash=3Drpm_hash)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.extract_from_rp=
m(rpm_path,
>>> + './usr/share/kata-containers/'
>>> + 'vmlinux-4.14.35-1902.6.6.1.el7.container')
>>> +=A0=A0=A0=A0=A0=A0=A0 else:
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>>> ('https://archives.fedoraproject.org/pub/archive/'
>>> + 'fedora/linux/releases/29/Everything/x86_64/os/'
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 'images/pxeboot/vmlinuz')
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7=
adedb033532163a792495'
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(ker=
nel_url,=20
>>> asset_hash=3Dkernel_hash)
>>> +
>>
>> Can you try using a dictionaries instead? This way we can add more=20
>> images easily.
>> See IMAGE_INFO in tests/acceptance/linux_ssh_mips_malta.py.
>=20
> I can. I won't convert the users of extract_from_deb() but will try make=
=20
> it easily extendable.
>=20
>=20
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -31,6 +31,29 @@ class BootLinuxConsole(Test):
>=20
>  =A0=A0=A0=A0 KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>=20
> +=A0=A0=A0 KERNEL_PATH_INFO =3D {
> +=A0=A0=A0=A0=A0=A0=A0 ('x86_64', 'bzImage'): {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'type': 'file',
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'url': 'https://archives.fedoraproject=
.org/'
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'pub/archive/fedo=
ra/linux/releases/29/Everything/'
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'x86_64/os/images=
/pxeboot/vmlinuz',
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'hash': '23bebd2680757891cf7adedb03353=
2163a792495'
> +=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0 }

I was thinking of something simpler, adding the dictionary local to=20
do_test_x86_64_machine().

  def do_test_x86_64_machine(self, test_type):
    d =3D {
      'pvh_disabled': {
         'url': 'https://archives.fedoraproject.org/'
                'pub/archive/fedora/linux/releases/29/Everything/'
                'x86_64/os/images/pxeboot/vmlinuz',
          'hash': '23bebd2680757891cf7adedb033532163a792495'
      },
      'pvh_enabled': {...}
    }
    ...

  def test_x86_64_pc_pvh(self):
         """
         :avocado: tags=3Dmachine:pc
         """
         self.do_test_x86_64_machine('pvh_enabled')

> +
> +=A0=A0=A0 def get_kernel_path(self, key):
> +=A0=A0=A0=A0=A0=A0=A0 """
> +=A0=A0=A0=A0=A0=A0=A0 For the provided key, download (and extract, if ne=
cessary) the=20
> kernel
> +=A0=A0=A0=A0=A0=A0=A0 and return the path the the kernel binary.
> +
> +=A0=A0=A0=A0=A0=A0=A0 :param key: index into KERNEL_PATH_INFO dict conta=
ining kernel=20
> location
> +=A0=A0=A0=A0=A0=A0=A0 :returns: path of the extracted file
> +=A0=A0=A0=A0=A0=A0=A0 """
> +=A0=A0=A0=A0=A0=A0=A0 dinfo =3D self.KERNEL_PATH_INFO[(self.arch, key)]
> +
> +=A0=A0=A0=A0=A0=A0=A0 if dinfo['type'] is 'file':
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.fetch_asset(dinfo['url'],=
=20
> asset_hash=3Ddinfo['hash'])
> +
>  =A0=A0=A0=A0 def wait_for_console_pattern(self, success_message):
>  =A0=A0=A0=A0=A0=A0=A0=A0 wait_for_console_pattern(self, success_message,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 failure_message=3D'Kernel panic - not=20
> syncing')
> @@ -72,11 +95,7 @@ class BootLinuxConsole(Test):
>  =A0=A0=A0=A0=A0=A0=A0=A0 Common routine to boot an x86_64 guest.
>  =A0=A0=A0=A0=A0=A0=A0=A0 Caller must specify tags=3Darch and tags=3Dmach=
ine
>  =A0=A0=A0=A0=A0=A0=A0=A0 """
> -=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
> ('https://archives.fedoraproject.org/pub/archive/fedora'
> - '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '/vmlinu=
z')
> -=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7adedb033532163=
a792495'
> -=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(kernel_url, asset=
_hash=3Dkernel_hash)
> +=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.get_kernel_path('bzImage')
>  =A0=A0=A0=A0=A0=A0=A0=A0 self.vm.set_console()
>  =A0=A0=A0=A0=A0=A0=A0=A0 kernel_command_line =3D self.KERNEL_COMMON_COMM=
AND_LINE +=20
> 'console=3DttyS0'
>  =A0=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-kernel', kernel_path,
>=20
>=20
> Regards,
> Liam
>=20
>=20


