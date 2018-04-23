Received: from eggs.gnu.org ([2001:4830:134:3::10]:37784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fAe3b-0002Ke-QP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fAe3X-0002Tw-MA
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:11:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44116
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fAe3X-0002PC-GG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:11:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3NGASBX095135
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:10:55 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hhgxcp7eh-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:10:54 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 23 Apr 2018 10:10:53 -0600
Reply-To: muriloo@linux.ibm.com
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Mon, 23 Apr 2018 13:10:47 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c7e00162-cf50-0194-d283-17e7dc8fae56@linux.ibm.com>
Subject: [Qemu-devel] [RFC] configure script mistakenly detects static
 libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: muriloo@linux.ibm.com

Hi, everyone!

I'm facing an issue on how configure script detects static libraries and
would like to hear from community to find a common ground on how to
possibly fix it.

Throughout configure, we use pkg-config command to verify if a library
is installed so qemu can be linked to it. This works fine when linking
qemu dynamically. However, configuring qemu with --static can mistakenly
detect a library that is actually not present on the system.

For example, on Ubuntu Xenial, libcacard-dev package provides only
libcacard.so (not libcacard.a) and pkg-config reports success in both
cases:

    $ pkg-config libcacard
    $ echo $?
    0

    $ pkg-config --static libcacard
    $ echo $?
    0

Since we use `pkg-config libcacard` to set smartcard=yes, this
mistakenly enables smartcard feature. This is acceptable with dynamic
linkage, but can be an issue with static linkage, where libcacard.a
doesn't exist on the system, resulting on a build error:

    $ ./configure --target-list=ppc64-softmmu --static && make -j$(nproc)
    [...]
    /usr/bin/ld: cannot find -lcacard

A workaround can be specifying --disable-<feature> for all missing
libraries.

One possible solution would be having a function, e.g. check_pkg_config,
that writes a C skeleton and tries to compile it using the desired
library, given as function parameter. Thus, compile_prog would return
success if library actually exists on the system. For example:

    check_pkg_config() {
        local_pkg_name=$1
        local_cflags=$($pkg_config --cflags $local_pkg_name)
        local_ldflags=$($pkg_config --libs $local_pkg_name)
        write_c_skeleton
        compile_prog "$local_cflags" "$local_ldflags"
    }

That would work for both dynamic and static linkages. Then we could just
replace `$pkg_config <package>` by `check_pkg_config <package>` in the
configure script.

My approach might not be the best and only one, so I'd like to hear from
you what would be a reasoanble solution to fix this situation.

Cheers
Murilo
