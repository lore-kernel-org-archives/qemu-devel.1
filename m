Received: from eggs.gnu.org ([2001:4830:134:3::10]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKPB4-0008A7-NE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKPB3-0005Oe-9h
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:14:42 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKPB3-0005Ny-1c
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:14:41 -0400
Received: by mail-wr0-x236.google.com with SMTP id q97so96872713wrb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:14:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607175419.13558-1-berrange@redhat.com>
References: <20170607175419.13558-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 14:14:19 +0100
Message-ID: <CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2017 at 18:54, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376af:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-07 11:56:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-sockets-2017-06-07-1
>
> for you to fetch changes up to 8dd2c27927b93aa352c43e8f0b9437f85d2f5f55:
>
>   tests: add functional test validating ipv4/ipv6 address flag handling (2017-06-07 17:15:08 +0100)
>
> ----------------------------------------------------------------
> Merge sockets 2017/06/07 v1
>
> ----------------------------------------------------------------

Hi; I'm afraid this ran into 'make check' problems:

On OSX and FreeBSD:
  GTESTER check-qtest-i386
ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
test_listen(const void *): assertion failed: (data->ipv6 != 0)
GTester: last random seed: R02Sc21fa7784ab13d0fd3274d86c5a52367
**
ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
test_listen(const void *): assertion failed: (data->ipv6 != 0)
GTester: last random seed: R02Sdf653a63e8d9a5d03bfadb49122f3e9a



On the clang runtime undefined-behavior sanitizer:
  GTESTER check-qtest-i386
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
runtime error: load of value 254, which is not a valid value for type
'bool'

(ditto for check-qtest-ppc64, x86_64
  GTESTER check-qtest-ppc64
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
runtime error: load of value 254, which is not a valid value for type
'bool'

More specifically:
$ UBSAN_OPTIONS=print_stacktrace=1
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386 gtester -k --verbose
-m=quick tests/test-sockets-proto -p=/sockets/migrate/wildcard/all
TEST: tests/test-sockets-proto... (pid=1710)
  /sockets/migrate/wildcard/all:
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
runtime error: load of value 224, which is not a valid value for type
'bool'
    #0 0x56308e8ba318 in visit_optional
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12
    #1 0x56308e892598 in visit_type_InetSocketAddress_members
/home/petmay01/linaro/qemu-for-merges/build/clang/qapi-visit.c:7030:9
    #2 0x56308e8a8ab3 in visit_type_SocketAddress_members
/home/petmay01/linaro/qemu-for-merges/build/clang/qapi-visit.c:12820:9
    #3 0x56308e8829b6 in visit_type_SocketAddress
/home/petmay01/linaro/qemu-for-merges/build/clang/qapi-visit.c:12850:5
    #4 0x56308e873f63 in qapi_free_SocketAddress
/home/petmay01/linaro/qemu-for-merges/build/clang/qapi-types.c:3897:5
    #5 0x56308e827e19 in test_listen
/home/petmay01/linaro/qemu-for-merges/tests/test-sockets-proto.c:831:5
    #6 0x7f1cea6757da  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f7da)
    #7 0x7f1cea6759a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #8 0x7f1cea6759a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #9 0x7f1cea6759a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #10 0x7f1cea675b7a in g_test_run_suite
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fb7a)
    #11 0x7f1cea675bd0 in g_test_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbd0)
    #12 0x56308e82798d in main
/home/petmay01/linaro/qemu-for-merges/tests/test-sockets-proto.c:854:11
    #13 0x7f1ce860582f in __libc_start_main
/build/glibc-9tT8Do/glibc-2.23/csu/../csu/libc-start.c:291
    #14 0x56308e8053f8 in _start
(/home/petmay01/linaro/qemu-for-merges/build/clang/tests/test-sockets-proto+0xb93f8)

OK
PASS: tests/test-sockets-proto


This usually means "forgot to initialize a bool". May or may not
be the same bug in both cases...

thanks
-- PMM
