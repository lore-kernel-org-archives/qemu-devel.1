Received: from eggs.gnu.org ([209.51.188.92]:41578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1greqX-0001OC-8O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 03:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1greqR-0003We-Fw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 03:15:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1greqI-0003Kw-6x
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 03:15:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B170C062C6A
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 08:15:20 +0000 (UTC)
References: <cb3e0855-a729-9a3d-e6ef-bfebea17b2cb@redhat.com>
	<20190205075249.6tx74rgbnojzssyp@sirius.home.kraxel.org>
	<225bc7bb-3c2c-1e26-4a29-4a900f60fe11@redhat.com>
	<20190205094229.5p27mdjj55awy3j2@sirius.home.kraxel.org>
	<129f0590-324a-0fc6-dc12-52965fef66d7@redhat.com>
	<f8e99916-b992-c89b-8137-a74d50ebf1a6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2087497-4ba1-810a-8f3b-9e97041a7398@redhat.com>
Date: Thu, 7 Feb 2019 09:15:11 +0100
MIME-Version: 1.0
In-Reply-To: <f8e99916-b992-c89b-8137-a74d50ebf1a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SeaBIOS regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2019-02-06 18:29, John Snow wrote:
>=20
>=20
> On 2/5/19 4:47 AM, Thomas Huth wrote:
>> On 2019-02-05 10:42, Gerd Hoffmann wrote:
>>> On Tue, Feb 05, 2019 at 10:31:24AM +0100, Thomas Huth wrote:
>>>> On 2019-02-05 08:52, Gerd Hoffmann wrote:
>>>>> On Mon, Feb 04, 2019 at 04:10:37PM +0100, Thomas Huth wrote:
>>>>>>
>>>>>>  Hi Gerd,
>>>>>>
>>>>>> I noticed that certain FreeDOS images are not working correctly an=
ymore
>>>>>> with the current version of QEMU, for example
>>>>>> http://www.qemu-advent-calendar.org/2016/download/day10.tar.xz ...=
 It
>>>>>> aborts with:
>>>>>>
>>>>>>  Error reading from drive C: DOS area: write-protection violation =
attempted
>>>>>>
>>>>>> I've bisected the issue, and it has apparently been introduced wit=
h:
>>>>>>
>>>>>>  cd1bfd5ef336166b275a09dc9842542bf5e63ae3
>>>>>>  seabios: update bios and vgabios binaries
>>>>>>
>>>>>> Any idea what might be going wrong here?
>>>>>
>>>>> Hmm, no.  bisect seabios?
>>>>
>>>> I haven't bisected yet, but it seems to be related to CONFIG_ATA_DMA=
=3Dy
>>>> in our roms/config.seabios-128k config file. When I switch that to "=
n",
>>>> then the old FreeDOS disks are working again...
>>>
>>> Hmm, guess I should turn that off again on the next update (there wil=
l
>>> be a seabios 1.12.1 release before qemu 4.0).
>>
>> Ah, right, I just noticed that this has just been enabled in QEMU for
>> the 3.0 release, where the problem occurred for the first time. So thi=
s
>> switch is likely the culprit, not a change in SeaBIOS. I'd also vote t=
o
>> revert commit eda553a442e94d now.
>>
>>  Thomas
>>
>=20
> If you enable the tracing in hw/ide/core, does it say anything that
> looks interesting? I'm wondering if there's some deficiency there.

At the end of the log, I can see:

ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x01;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x84;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_write IDE PIO wr @ 0x1f7 (Command); val 0xc8;=20
ide_exec_cmd IDE exec cmd: bus 0x55eb8c5c0620; state 0x55eb8c5c0698; cmd =
0xc8
ide_dma_cb IDEState 0x55eb8c5c0698; sector_num=3D132 n=3D1 cmd=3DDMA READ
ide_cancel_dma_sync_remaining draining all remaining requests
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0e;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0a;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xa0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x08;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x01;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x84;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_write IDE PIO wr @ 0x1f7 (Command); val 0xc8;=20
ide_exec_cmd IDE exec cmd: bus 0x55eb8c5c0620; state 0x55eb8c5c0698; cmd =
0xc8
ide_dma_cb IDEState 0x55eb8c5c0698; sector_num=3D132 n=3D1 cmd=3DDMA READ
ide_cancel_dma_sync_remaining draining all remaining requests
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0e;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0a;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xa0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x08;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x01;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x84;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_write IDE PIO wr @ 0x1f7 (Command); val 0xc8;=20
ide_exec_cmd IDE exec cmd: bus 0x55eb8c5c0620; state 0x55eb8c5c0698; cmd =
0xc8
ide_dma_cb IDEState 0x55eb8c5c0698; sector_num=3D132 n=3D1 cmd=3DDMA READ
ide_cancel_dma_sync_remaining draining all remaining requests
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0e;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0a;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xa0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x08;
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x01;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x84;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_write IDE PIO wr @ 0x1f7 (Command); val 0xc8;=20
ide_exec_cmd IDE exec cmd: bus 0x55eb8c5c0620; state 0x55eb8c5c0698; cmd =
0xc8
ide_dma_cb IDEState 0x55eb8c5c0698; sector_num=3D132 n=3D1 cmd=3DDMA READ
ide_cancel_dma_sync_remaining draining all remaining requests
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0e;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0a;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xa0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x08;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f2 (Sector Count); val 0x01;=20
ide_ioport_write IDE PIO wr @ 0x1f3 (Sector Number); val 0x84;=20
ide_ioport_write IDE PIO wr @ 0x1f4 (Cylinder Low); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f5 (Cylinder High); val 0x00;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xe0;=20
ide_ioport_write IDE PIO wr @ 0x1f7 (Command); val 0xc8;=20
ide_exec_cmd IDE exec cmd: bus 0x55eb8c5c0620; state 0x55eb8c5c0698; cmd =
0xc8
ide_dma_cb IDEState 0x55eb8c5c0698; sector_num=3D132 n=3D1 cmd=3DDMA READ
ide_cancel_dma_sync_remaining draining all remaining requests
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0e;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x0a;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_ioport_write IDE PIO wr @ 0x1f6 (Device/Head); val 0xa0;=20
ide_ioport_read IDE PIO rd @ 0x1f7 (Status); val 0x50;=20
ide_cmd_write IDE PIO wr @ 0x3f6 (Device Control); val 0x08;=20

Looks like command 0xc8 (READDMA) goes wrong for some reason?

Anyway, looking at commit eda553a442e94dc16d424849b65c6cb7f1
it seems like there is a known problem in SeaBIOS with
CONFIG_ATA_DMA=3Dy with real hardware - so maybe we just hit
the same problem here, too? That would mean that the bug
is in SeaBIOS and not in QEMU, thus we should simply disable
that config switch again.

 Thomas
