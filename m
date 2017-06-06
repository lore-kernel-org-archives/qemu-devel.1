Received: from eggs.gnu.org ([2001:4830:134:3::10]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI3yC-0001xB-OH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI3y9-0001O6-JE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:11:44 -0400
Received: from [59.151.112.132] (port=24800 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI3y9-0001Kd-6v
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:11:41 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 0FB0D47C6106
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:11:26 +0800 (CST)
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <82427b34-3de0-9f8a-a9de-1903adeb9619@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 10:11:23 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [BUG] Failed to compile using gcc7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

After upgrading gcc from 6.3.1 to 7.1.1, qemu can't be compiled with gcc.

The error is:

------
   CC      block/blkdebug.o
block/blkdebug.c: In function 'blkdebug_refresh_filename':
block/blkdebug.c:693:31: error: '%s' directive output may be truncated 
writing up to 4095 bytes into a region of size 4086 
[-Werror=format-truncation=]
                   "blkdebug:%s:%s", s->config_file ?: "",
                                ^~
In file included from /usr/include/stdio.h:939:0,
                  from /home/adam/qemu/include/qemu/osdep.h:68,
                  from block/blkdebug.c:25:
/usr/include/bits/stdio2.h:64:10: note: '__builtin___snprintf_chk' 
output 11 or more bytes (assuming 4106) into a destination of size 4096
    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         __bos (__s), __fmt, __va_arg_pack ());
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/adam/qemu/rules.mak:69: block/blkdebug.o] Error 1
------

It seems that gcc 7 is introducing more restrict check for printf.
If using clang, although there are some extra warning, it can at least 
pass the compile.

Thanks,
Qu
