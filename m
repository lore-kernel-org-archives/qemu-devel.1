Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BCC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01502072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABAwrrGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01502072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBG4K-0006N1-Nu
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBG3L-0005uU-Cu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBG3J-0006an-P9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:54:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBG3J-0006aW-La
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583751269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7aJNM2DOf3kSJFybGpzsj8dTeNTWMCgl9fMYzAvHVw=;
 b=ABAwrrGl8W6W/WQgYp3FgjHbwK6Ci/NnP17ZBp53speaHOtHiI3gE+gW6tD0vsZZQNPlkz
 oEeQDTt97bUzqQ7seQekw7hj3gNYHf8xILIulocGsj38fCTkDoLv5puDG8U/F5b7CbvIfu
 NIDqWNka6by1T9lIWO6N7v3+75JYKZo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-kWI3jLaPOIysjj82yhHBVA-1; Mon, 09 Mar 2020 06:54:23 -0400
X-MC-Unique: kWI3jLaPOIysjj82yhHBVA-1
Received: by mail-ed1-f71.google.com with SMTP id d12so7661672edq.16
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v2zYNh/hY0124L/jRs0KVxpti45srTpy8+ObUO1pmv8=;
 b=iLthfI2F/a4cp/FWo7RX5vgfBuJVs5OYXEXj0EVkKbM+DdMjPYESTk3kZiZeUkqmWr
 C5/GZP2LAuSDGc/Ws5GhuD4zpg48rt4nU2v1RqsZAznPy7Q2XOXqdSnuglNqdOff9EJU
 FEttf9NR9laTr7A+nULf+8VjPGnD8Il/jSC5qiFZhR9LyMDP2+qVlxxQ/NqGdTz3vITB
 AzFaXy3GcfwcAD71hc3F+U9mS0TztBcmeoguXUl7kwBJPDz3zVIwRCv0PfQ6Ww+jtVQ5
 /BEy3lbzc+nUNxalJvaQIZqg0DKixffnt8dZNSVelFJqJBODZI+xGwfC+17IA1qNQNYb
 A0UQ==
X-Gm-Message-State: ANhLgQ3BXT5W5LIQVOojsptR4V4UcsuddIKbtP3Awyo9Ws/VPsO+6D1d
 5sgTqkI/ONnpyJ9VCoLnnrQvjeFPmeqrgRWsLVA/krmj5BwUwcLGCqDRcq3TpfPLmG4VuBjlvTO
 H7H8IN4KCIBxAow8=
X-Received: by 2002:a05:6402:1f3:: with SMTP id
 i19mr16643413edy.103.1583751262249; 
 Mon, 09 Mar 2020 03:54:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtR0mudUx3+eqVceOtwt8RbQGfSOaoxGyyjeU1X+RgVi23Qnb7sMBeFhDapuStWZXcpziOhnQ==
X-Received: by 2002:a05:6402:1f3:: with SMTP id
 i19mr16643400edy.103.1583751261877; 
 Mon, 09 Mar 2020 03:54:21 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id ew9sm572589ejb.31.2020.03.09.03.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 03:54:21 -0700 (PDT)
Subject: Re: [PATCH v32 21/22] BootLinuxConsoleTest: Test the RX-Virt machine
To: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200224141923.82118-1-ysato@users.sourceforge.jp>
 <20200224141923.82118-22-ysato@users.sourceforge.jp>
 <2c26a629-59d4-f6d5-d06d-cf3d1cf65f4c@redhat.com>
 <87k13u9h0p.wl-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ead8621-e590-d81c-c71a-9213108fa13f@redhat.com>
Date: Mon, 9 Mar 2020 11:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87k13u9h0p.wl-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 7:30 AM, Yoshinori Sato wrote:
> On Mon, 09 Mar 2020 01:20:05 +0900,
> Philippe Mathieu-Daud=E9 wrote:
>>
>> On 2/24/20 3:19 PM, Yoshinori Sato wrote:
>>> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>>
>>> Add two tests for the rx-virt machine, based on the recommended test
>>> setup from Yoshinori Sato:
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03586.html
>>>
>>> - U-Boot prompt
>>> - Linux kernel with Sash shell
>>>
>>> These are very quick tests:
>>>
>>>     $ avocado run -t arch:rx tests/acceptance/boot_linux_console.py
>>>     JOB ID     : 84a6ef01c0b87975ecbfcb31a920afd735753ace
>>>     JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84=
a6ef0/job.log
>>>      (1/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test=
_rx_uboot: PASS (0.11 s)
>>>      (2/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test=
_rx_linux: PASS (0.45 s)
>>>     RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUP=
T 0 | CANCEL 0
>>>
>>> Tests can also be run with:
>>>
>>>     $ avocado --show=3Dconsole run -t arch:rx tests/acceptance/boot_lin=
ux_console.py
>>>     console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - =
21:56:06 +0900)
>>>     console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc vers=
ion 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
>>>     console: Built 1 zonelists, mobility grouping on.  Total pages: 812=
8
>>>     ...
>>>     console: SuperH (H)SCI(F) driver initialized
>>>     console: 88240.serial: ttySC0 at MMIO 0x88240 (irq =3D 215, base_ba=
ud =3D 0) is a sci
>>>     console: console [ttySC0] enabled
>>>     console: 88248.serial: ttySC1 at MMIO 0x88248 (irq =3D 219, base_ba=
ud =3D 0) is a sci
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>> Based-on: 20190517045136.3509-1-richard.henderson@linaro.org
>>> "RX architecture support"
>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> ---
>>>    tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++=
++
>>>    1 file changed, 46 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
>>> index 34d37eba3b..367cf480a5 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -686,3 +686,49 @@ class BootLinuxConsole(Test):
>>>            tar_hash =3D '49e88d9933742f0164b60839886c9739cb7a0d34'
>>>            self.vm.add_args('-cpu', 'dc233c')
>>>            self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride=
.elf')
>>> +
>>> +    def test_rx_uboot(self):
>>> +        """
>>> +        :avocado: tags=3Darch:rx
>>> +        :avocado: tags=3Dmachine:rx-virt
>>> +        :avocado: tags=3Dendian:little
>>> +        """
>>> +        uboot_url =3D ('https://acc.dl.osdn.jp/users/23/23888/u-boot.b=
in.gz')
>>> +        uboot_hash =3D '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
>>> +        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_=
hash)
>>> +        uboot_path =3D archive.uncompress(uboot_path, self.workdir)
>>> +
>>> +        self.vm.set_machine('rx-virt')
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-bios', uboot_path,
>>> +                         '-no-reboot')
>>> +        self.vm.launch()
>>> +        uboot_version =3D 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
>>> +        self.wait_for_console_pattern(uboot_version)
>>> +        gcc_version =3D 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (ex=
perimental)'
>>> +        # FIXME limit baudrate on chardev, else we type too fast
>>> +        #self.exec_command_and_wait_for_pattern('version', gcc_version=
)
>>> +
>>> +    def test_rx_linux(self):
>>> +        """
>>> +        :avocado: tags=3Darch:rx
>>> +        :avocado: tags=3Dmachine:rx-virt
>>> +        :avocado: tags=3Dendian:little
>>> +        """
>>> +        dtb_url =3D ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dt=
b')
>>
>> Sourceforge URL are not very stable, I'm now getting:
>>
>> HTTP request sent, awaiting response... 302 Found
>> Location: https://osdn.dl.osdn.net/users/23/23887/rx-qemu.dtb [following=
]
>> --2020-03-08 17:17:31--  https://osdn.dl.osdn.net/users/23/23887/rx-qemu=
.dtb
>> Resolving osdn.dl.osdn.net (osdn.dl.osdn.net)... 202.221.179.23
>> Connecting to osdn.dl.osdn.net
>> (osdn.dl.osdn.net)|202.221.179.23|:443... connected.
>> HTTP request sent, awaiting response... 404 Not Found
>> 2020-03-08 17:17:32 ERROR 404: Not Found.
>=20
> Permernet link is bellow.
> https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> https://osdn.net/users/ysato/pf/qemu/dl/rx-virt.dtb
> https://osdn.net/users/ysato/pf/qemu/dl/zImage

Acceptance tests assert that "something that used to work in the past is=20
still working today". The artifact hash is here to verify the file has=20
not been modified (for security reasons or replaced by something else)=20
so we keep testing the same.

If you upgrade these files, we should keep testing the older version,=20
and eventually add a new test (or entry in the same test) to test the=20
new files.

>=20
> I was misunderstanding. sorry.
>=20
>>> +        dtb_hash =3D '7b4e4e2c71905da44e86ce47adee2210b026ac18'
>>> +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
>>> +        kernel_url =3D ('http://acc.dl.osdn.jp/users/23/23845/zImage')
>>> +        kernel_hash =3D '39a81067f8d72faad90866ddfefa19165d68fc99'
>>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
>>> +
>>> +        self.vm.set_machine('rx-virt')
>>> +        self.vm.set_console()
>>> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'ear=
lycon'
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-dtb', dtb_path,
>>> +                         '-no-reboot')
>>> +        self.vm.launch()
>>> +        self.wait_for_console_pattern('Sash command shell (version 1.1=
.1)')
>>> +        self.exec_command_and_wait_for_pattern('printenv',
>>> +                                               'TERM=3Dlinux')
>>>
>>
>>
>=20


