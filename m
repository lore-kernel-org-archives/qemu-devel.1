Received: from eggs.gnu.org ([209.51.188.92]:43874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJbAf-0004MG-Mx
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJb8c-0000Zr-6K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 05:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJb8b-0000Sy-TQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 05:57:54 -0400
References: <20190424140643.62457-1-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
Date: Thu, 25 Apr 2019 11:57:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 24/04/2019 16.06, Li Qiang wrote:
> In the disscuss of adding reboot timeout test case:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
> 
> Philippe suggested we should uses the only related option for one
> specific test. However currently we uses one QTestState for all the
> test cases. In order to achieve Philippe's idea, I split the test case
> for its own QTestState. As this patchset has changed a lot, I don't bump
> the version.
> 
> Change since v1:
> Add a patch to store the reboot_timeout as little endian
> Fix the endian issue per Thomas's review

The test still aborts on a big endian host:

$ QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-test
/x86_64/fw_cfg/signature: OK
/x86_64/fw_cfg/id: OK
/x86_64/fw_cfg/uuid: OK
/x86_64/fw_cfg/ram_size: OK
/x86_64/fw_cfg/nographic: OK
/x86_64/fw_cfg/nb_cpus: OK
/x86_64/fw_cfg/max_cpus: OK
/x86_64/fw_cfg/numa: OK
/x86_64/fw_cfg/boot_menu: OK
/x86_64/fw_cfg/reboot_timeout: **
ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cfg_reboot_timeout:
assertion failed (reboot_timeout == 15): (251658240 == 15)
Aborted

251658240 is 0x0F000000, i.e. a byte-swapped 0xf = 15 ... i.e. you still
got an endianess issue somewhere in the code.

 Thomas
