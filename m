Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3001C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77AA2085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRhwQ4wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77AA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inN3s-0001v7-QJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 08:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1inN2x-0000bj-IE
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1inN2u-00023J-Fm
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:31:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1inN2t-0001wc-UP
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578058279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRET7Eiz2b8xzuJI1K56VUGnMp7jwIBOK4cHI3GKR+c=;
 b=aRhwQ4wSIPTDa/z+JGapcwMbSWjR8eziJmZaAZQZMPh/vrPYuYGGI2vUuoS8oZp4Hr+aj6
 B+4UsJnrLgO+fpCt0848IcacAfSVYZh/IPnRtVJCUf4/iF22zL3GDwnIHndwKP9GpuGwCI
 JFKxB8qus5HtNBZmXu24M5GyaJEs4zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Gv15o-zsMkiRnirkqNZAng-1; Fri, 03 Jan 2020 08:31:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 301C91883521;
 Fri,  3 Jan 2020 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-18.gru2.redhat.com
 [10.97.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4305D9C9;
 Fri,  3 Jan 2020 13:31:09 +0000 (UTC)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: Add initrd test for the
 CubieBoard
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-2-f4bug@amsat.org>
 <31147d48-2f31-9fce-b8a4-1a270f114a45@redhat.com>
 <d7abcb92-4405-2ba8-b524-281d5913f980@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6453ffc1-4bf6-4501-016d-ef403f742bd6@redhat.com>
Date: Fri, 3 Jan 2020 11:31:08 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d7abcb92-4405-2ba8-b524-281d5913f980@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Gv15o-zsMkiRnirkqNZAng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/31/19 9:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/30/19 9:52 PM, Wainer dos Santos Moschetta wrote:
>> On 12/30/19 9:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> This test boots a Linux kernel on a CubieBoard and verify
>>> the serial output is working.
>>>
>>> The kernel image and DeviceTree blob are built by the Armbian
>>> project (based on Debian):
>>> https://docs.armbian.com/Developer-Guide_Build-Preparation/
>>>
>>> The cpio image used comes from the linux-build-test project:
>>> https://github.com/groeck/linux-build-test
>>>
>>> If ARM is a target being built, "make check-acceptance" will
>>> automatically include this test by the use of the "arch:arm" tags.
>>>
>>> Alternatively, this test can be run using:
>>>
>>> =C2=A0=C2=A0 $ avocado --show=3Dconsole run -t machine:cubieboard=20
>>> tests/acceptance/boot_linux_console.py
>>> =C2=A0=C2=A0 console: Uncompressing Linux... done, booting the kernel.
>>> =C2=A0=C2=A0 console: Booting Linux on physical CPU 0x0
>>> =C2=A0=C2=A0 console: Linux version 4.20.7-sunxi (root@armbian.com) (gc=
c=20
>>> version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8=20
>>> 09:02:10 CET 2019
>>> =C2=A0=C2=A0 console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7=
),=20
>>> cr=3D50c5387d
>>> =C2=A0=C2=A0 console: CPU: PIPT / VIPT nonaliasing data cache, VIPT=20
>>> nonaliasing instruction cache
>>> =C2=A0=C2=A0 console: OF: fdt: Machine model: Cubietech Cubieboard
>>> =C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0 console: Boot successful.
>>> =C2=A0=C2=A0 console: cat /proc/cpuinfo
>>> =C2=A0=C2=A0 console: / # cat /proc/cpuinfo
>>> =C2=A0=C2=A0 console: processor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0
>>> =C2=A0=C2=A0 console: model name=C2=A0=C2=A0=C2=A0=C2=A0 : ARMv7 Proces=
sor rev 0 (v7l)
>>> =C2=A0=C2=A0 console: BogoMIPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 83=
2.51
>>> =C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0 console: Hardware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Al=
lwinner sun4i/sun5i Families
>>> =C2=A0=C2=A0 console: Revision=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 00=
00
>>> =C2=A0=C2=A0 console: Serial=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : 0000000000000000
>>> =C2=A0=C2=A0 console: cat /proc/iomem
>>> =C2=A0=C2=A0 console: / # cat /proc/iomem
>>> =C2=A0=C2=A0 console: 01c00000-01c0002f : system-control@1c00000
>>> =C2=A0=C2=A0 console: 01c02000-01c02fff : dma-controller@1c02000
>>> =C2=A0=C2=A0 console: 01c05000-01c05fff : spi@1c05000
>>> =C2=A0=C2=A0 console: 01c0b080-01c0b093 : mdio@1c0b080
>>> =C2=A0=C2=A0 console: 01c0c000-01c0cfff : lcd-controller@1c0c000
>>> =C2=A0=C2=A0 console: 01c0d000-01c0dfff : lcd-controller@1c0d000
>>> =C2=A0=C2=A0 console: 01c0f000-01c0ffff : mmc@1c0f000
>>> =C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0 PASS (54.35 s)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> =C2=A0 tests/acceptance/boot_linux_console.py | 41=20
>>> ++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 41 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index 9c6aa2040a..4643f60e37 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -400,6 +400,47 @@ class BootLinuxConsole(Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_co=
nsole_pattern('Boot successful.')
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # TODO user comm=
and, for now the uart is stuck
>>> +=C2=A0=C2=A0=C2=A0 def test_arm_cubieboard_initrd(self):
>>
>> Unless you have two tests, one with and without initrd (not the case=20
>> though) the suffix '_initrd' is useless. So I suggest to remove it.
>
> The next patch adds a SD card test:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg667628.html
>
> If one developer has other tests in progress, but one done, I think it=20
> might sense to add the full test name when the first patch is merged,=20
> so next tests don't have to modify the first test name.


That's right. Disregard my comment.

- Wainer


>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:cu=
bieboard
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D ('https://apt.a=
rmbian.com/pool/main/l/'
>>> + 'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_hash =3D '1334c29c44d98=
4ffa05ed10de8c3361f33d78315'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_path =3D self.fetch_ass=
et(deb_url, asset_hash=3Ddeb_hash)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.extrac=
t_from_deb(deb_path,
>>> + '/boot/vmlinuz-4.20.7-sunxi')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D=20
>>> '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D self.extract_f=
rom_deb(deb_path, dtb_path)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_url =3D=20
>>> ('https://github.com/groeck/linux-build-test/raw/'
>>> + '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'arm/rootfs-armv5=
.cpio.gz')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_hash =3D '2b50f1873e=
113523967806f4da2afe385462ff9b'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_path_gz =3D self.fet=
ch_asset(initrd_url,=20
>>> asset_hash=3Dinitrd_hash)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_path =3D os.path.joi=
n(self.workdir, 'rootfs.cpio')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 archive.gzip_uncompress(ini=
trd_path_gz, initrd_path)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_command_line =3D (se=
lf.KERNEL_COMMON_COMMAND_LINE +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'console=3DttyS0,115200 '
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'usbcore.nousb '
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'panic=3D-1 noreboot')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel',=
 kernel_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-dtb', dtb_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-initrd', initrd_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-append', kernel_command_line,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-no-reboot')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_console_patte=
rn('Boot successful.')
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_p=
attern(self, 'cat /proc/cpuinfo',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Allwinner=
=20
>>> sun4i/sun5i')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_p=
attern(self, 'cat /proc/iomem',
>>> + 'system-control@1c00000')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_p=
attern(self, 'reboot',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'reboot: Re=
starting=20
>>> system')
>>
>>
>> I ran this test case with success, so:
>>
>> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>
> Thanks Wainer!
>
>>
>> With the comment regarding the _initrd suffix:
>>
>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>
>>
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_s390x_s390_ccw_virtio(self):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=
=3Darch:s390x
>>
>>
>


