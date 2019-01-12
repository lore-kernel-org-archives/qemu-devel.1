Received: from eggs.gnu.org ([209.51.188.92]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1giMr7-0003kw-Aj
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1giMlu-0003bl-HL
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:08:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:34655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1giMlr-0003Uz-S1
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:08:33 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <29ff1bde-73ab-3033-ac5d-1ecf79b523ee@msgid.tls.msk.ru>
Date: Sat, 12 Jan 2019 20:08:14 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] block: Update flags in bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

     commit eeae6a596b0efc092f5101c67683053e245e6250
     Author: Kevin Wolf <kwolf@redhat.com>
     Date:   Tue Oct 9 16:57:12 2018 +0200

         block: Update flags in bdrv_set_read_only()

         To fully change the read-only state of a node, we must not only change
         bs->read_only, but also update bs->open_flags.

sort of broke vfat support:

  $ qemu-system-x86_64 -hda fat:foo/
  WARNING: Image format was not specified for 'json:{"fat-type": 0, "dir": "foo/", "driver": "vvfat", "floppy": false, "rw": false}' and probing guessed raw.
           Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.
  qemu-system-x86_64: Initialization of device ide-hd failed: Block node is read-only
  $ _

The warning is annoying but harmless, but the read-only error is fatal.

"Sort-of" is because there's a somewhat strange workaround:

   -hda fat:rw:foo/

but it is a bit more dangerous as well.

It looks like vfat should be handled differently somewhere, to
eliminate both the warning and the error?

Thanks,

/mjt
