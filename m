Received: from eggs.gnu.org ([209.51.188.92]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXvc-0001Cm-Jw
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXvb-0000zs-Lc
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:16:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goXvb-0000zE-Fb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:16:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so23133607wrt.11
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 10:16:07 -0800 (PST)
References: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
	<8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
	<alpine.BSF.2.21.9999.1901291123160.84186@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1901291156010.93614@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <411a9bb8-1264-1e8f-5af0-741d8af6cd89@redhat.com>
Date: Tue, 29 Jan 2019 19:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901291156010.93614@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] macOS build error after ddac19f534 (virtio: split
 virtio 9p bits from virtio-pci)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 1/29/19 11:58 AM, BALATON Zoltan wrote:
> On Tue, 29 Jan 2019, BALATON Zoltan wrote:
>> On Tue, 29 Jan 2019, Philippe Mathieu-Daudé wrote:
>>> On 1/29/19 2:20 AM, BALATON Zoltan wrote:
>>>> Hello,
>>>>
>>>> I'm getting error building on macOS after commit ddac19f534:
>>>>
>>>> ? CC????? aarch64-softmmu/hw/virtio/virtio-blk-pci.o
>>>> In file included from qemu/hw/virtio/virtio-9p-pci.c:19:
>>>> In file included from qemu/hw/9pfs/virtio-9p.h:6:
>>>> In file included from qemu/hw/9pfs/9p.h:7:
>>>> qemu/fsdev/file-op-9p.h:19:10: fatal error: 'sys/vfs.h' file not found
>>>> #include <sys/vfs.h>
>>>> ???????? ^~~~~~~~~~~
>>>>
>>>> Am I missing something? (Apart from the include file which is not
>>>> present on OS X... Maybe this needs the #ifdefs it had before the
>>>> split?)
>>>
>>> It seems commits are not correctly ordered for bisectability :(
>>>
>>> If you cherry-pick ecd3b89b054, does it build?
>>
>> No it fails with same error on HEAD as well ever since the above commit.
> 
> Now it has built after completely removing build directory. Somehow a
> CONFIG_VIRTIO_9P got set before even after doing make distclean several
> times. Only completetly removing build dir has helped.

I think a similar bug you experienced hits me via another way, while
running the block tests:

--- /home/phil/source/qemu/tests/qemu-iotests/095.out	2018-12-12
15:06:54.019029386 +0100
+++ /home/phil/source/qemu/build/tests/qemu-iotests/095.out.bad
2019-01-29 08:34:54.701705730 +0100
@@ -10,18 +10,5 @@

 === Running QEMU Live Commit Test ===

-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "test"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_COMPLETED", "data": {"device": "test", "len":
104857600, "offset": 104857600, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "test"}}
-
-=== Base image info after commit and resize ===
-image: TEST_DIR/t.IMGFMT.base
-file format: IMGFMT
-virtual size: 100M (104857600 bytes)
-*** done
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=virtio,id=test:
'virtio-blk-pci' is not a valid device model name
+Timeout waiting for return on handle 0

I'm using out-of-tree builds, I rebased by branch onto /master, which
correctly triggered a reconfigure:

  config-host.mak is out-of-date, running configure

But then there was a desync with the config variables (CONFIG_VIRTIO_BLK
here?). Maybe I did something wrong at some point, I was working with VM
tests at the same time.
However in my case a 'make clean' was enough and I could rebuild/test in
the same directory.
Anyway, I won't worry much about this.

Regards,

Phil.
