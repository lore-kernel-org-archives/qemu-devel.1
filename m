Received: from eggs.gnu.org ([2001:4830:134:3::10]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1crIeH-00058g-6B
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1crIeE-0001CT-10
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:24:33 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com
	([104.47.1.91]:45124
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1crIeD-0001Be-EB
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:24:29 -0400
References: <1490275739-14940-1-git-send-email-den@openvz.org>
	<377732f8-b41f-5ca8-d418-26d524ba4ea9@redhat.com>
	<20170323150456.GA5344@noname.redhat.com>
	<ce38d665-547c-a9e6-a698-ba586cba9ec1@openvz.org>
	<20170323212001.GE28118@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <37f96fb3-a132-5fba-80a2-ccb0eb8f81cf@openvz.org>
Date: Fri, 24 Mar 2017 09:24:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170323212001.GE28118@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/1] qcow2: add ZSTD compression feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/24/2017 12:20 AM, Kevin Wolf wrote:
> Am 23.03.2017 um 16:35 hat Denis V. Lunev geschrieben:
>> On 03/23/2017 06:04 PM, Kevin Wolf wrote:
>>> Am 23.03.2017 um 15:17 hat Eric Blake geschrieben:
>>>> On 03/23/2017 08:28 AM, Denis V. Lunev wrote:
>>>>> ZSDT compression algorithm consumes 3-5 times less CPU power with a=

>>>> s/ZSDT/ZSTD/
>>>>
>>>>> comparable comression ratio with zlib. It would be wise to use it f=
or
>>>> s/comression/compression/
>>>>
>>>>> data compression f.e. for backups.
>>> Note that we don't really care that much about fast compression becau=
se
>>> that's an one time offline operation. Maybe a better compression rati=
o
>>> while maintaining decent decompression performance would be the more
>>> important feature?
>>>
>>> Or are you planning to extend the qcow2 driver so that compressed
>>> clusters are used even for writes after the initial conversion? I thi=
nk
>>> it would be doable, and then I can see that better compression speed
>>> becomes important, too.
>> we should care about backups :) they can be done using compression
>> event right now and this is done in real time when VM is online.
>> Thus any additional CPU overhead counts, even if compressed data is
>> written only once.
> Good point. I have no idea about ZSTD, but maybe compression speed vs.
> ratio can even be configurable?
>
> Anyway, I was mostly trying to get people to discuss the compression
> algorithm. I'm not against this one, but I haven't checked whether it's=

> the best option for our case.
>
> So I'd be interested in which algorithms you considered, and what was
> the reason to decide for ZSTD?

Actually I was a bit lazy here and followed result of investigations of
my friends. Anyway, here is a good comparison:

http://fastcompression.blogspot.ru/2015/01/zstd-stronger-compression-algo=
rithm.html

Name            Ratio  C.speed D.speed
                        MB/s    MB/s
zlib 1.2.8 -6   3.099     18     275
*zstd            2.872    201     498*
zlib 1.2.8 -1   2.730     58     250
LZ4 HC r127     2.720     26    1720
QuickLZ 1.5.1b6 2.237    323     373
LZO 2.06        2.106    351     510
Snappy 1.1.0    2.091    238     964
LZ4 r127        2.084    370    1590
LZF 3.6         2.077    220     502

I have validated lines 1 and 2 from this table and obtained same results.=

2.87 and 3.01 compression ratios are quite nearby while the speed is
MUCH different.

Den
