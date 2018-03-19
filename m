Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exzl3-0001pB-SZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exzl2-0005MK-3x
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:43:45 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exzl1-0005Li-SU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:43:44 -0400
Received: by mail-ot0-x244.google.com with SMTP id t2-v6so9207262otj.4
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 11:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319164152.1077050-1-eblake@redhat.com>
References: <20180319164152.1077050-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:43:22 +0000
Message-ID: <CAFEAcA_gF=tpvZLTJ_K5mU59VzByh7XRJSVHFms2i5RJBH7CoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 March 2018 at 16:41, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805=
be:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-03-19 11:44:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v3
>
> for you to fetch changes up to ebf1105a7086897da6963edefdb247c80f605424:
>
>   qapi: Pass '-u' when doing non-silent diff (2018-03-19 11:32:36 -0500)
>
> in v3:
> rebase to master (a few more qobject_to_qdict() uses crept in)
> squash in Peter Xu's fixup for test failures
> [if tests still fail, then I will send a v4 without OOB from 2.12]
> sending only the patches that changed from v2
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-12, 2.12 softfreeze
>
> - Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
> - Max Reitz: 0/7 block: Handle null backing link
> - Daniel P. Berrange: chardev: tcp: postpone TLS work until machine done
> - Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
> - Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
> - Eric Blake: qapi: Pass '-u' when doing non-silent diff

The assert seems to have gone away, but I get over 10,000 new
clang sanitizer runtime errors like

  /visitor/input/large_number:                                         OK
  /visitor/input/number_keyval:                                        OK
  /visitor/input/number_str_keyval:                                    OK
  /visitor/input/number_str_fail:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:550:12:
runtime error: member access within null pointer of type 'QNum' (aka
'struct QNum')
OK
  /visitor/input/size_str_keyval:                                      OK
  /visitor/input/size_str_fail:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:433:12:
runtime error: member access within null pointer of type 'QNum' (aka
'struct QNum')
OK
  /visitor/input/string:                                               OK
  /visitor/input/enum:                                                 OK
  /visitor/input/struct:                                               OK
  /visitor/input/struct-nested:                                        OK
  /visitor/input/list:                                                 OK
  /visitor/input/any:                                                  OK
  /visitor/input/null:                                                 OK
  /visitor/input/union-flat:                                           OK
  /visitor/input/alternate:                                            OK
  /visitor/input/errors:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:521:12:
runtime error: member access within null pointer of type 'QString'
(aka 'struct QString')
OK
  /visitor/input/wrong-type:                                           OK
  /visitor/input/alternate-number:                                     OK
  /visitor/input/qapi-introspect:                                      OK


Here's some backtraces for some of those:

/visitor/input/int_keyval:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:188:12:
runtime error: member access within null pointer of type 'QString'
(aka 'struct QString')
    #0 0x56375e642549 in qobject_input_get_keyval
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:188:12
    #1 0x56375e63f76b in qobject_input_type_int64_keyval
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:409:23
    #2 0x56375e63c13d in visit_type_int
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:150:5
    #3 0x56375e61a025 in test_visitor_in_int_keyval
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:18=
7:5
    #4 0x7f84d08df7da  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f7da)
    #5 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #6 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #7 0x7f84d08dfbad in g_test_run_suite
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbad)
    #8 0x7f84d08dfbd0 in g_test_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbd0)
    #9 0x56375e619ab6 in main
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:13=
85:5
    #10 0x7f84cea7482f in __libc_start_main
/build/glibc-Cl5G7W/glibc-2.23/csu/../csu/libc-start.c:291
    #11 0x56375e5f6f88 in _start
(/home/petmay01/linaro/qemu-for-merges/build/clang/tests/test-qobject-input=
-visitor+0xabf88)

OK

/visitor/input/int_str_fail:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:398:12:
runtime error: member access within null pointer of type 'QNum' (aka
'struct QNum')
    #0 0x56375e63ec7e in qobject_input_type_int64
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:398:12
    #1 0x56375e63c13d in visit_type_int
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:150:5
    #2 0x56375e61a149 in test_visitor_in_int_str_fail
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:21=
2:5
    #3 0x7f84d08df7da  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f7da)
    #4 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #5 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #6 0x7f84d08dfbad in g_test_run_suite
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbad)
    #7 0x7f84d08dfbd0 in g_test_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbd0)
    #8 0x56375e619ab6 in main
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:13=
85:5
    #9 0x7f84cea7482f in __libc_start_main
/build/glibc-Cl5G7W/glibc-2.23/csu/../csu/libc-start.c:291
    #10 0x56375e5f6f88 in _start
(/home/petmay01/linaro/qemu-for-merges/build/clang/tests/test-qobject-input=
-visitor+0xabf88)

OK


/visitor/input/bool_str_fail:
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:480:13:
runtime error: member access within null pointer of type 'QBool' (aka
'struct QBool')
    #0 0x56375e63eeb4 in qobject_input_type_bool
/home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:480:13
    #1 0x56375e63cfdd in visit_type_bool
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:285:5
    #2 0x56375e61a3a5 in test_visitor_in_bool_str_fail
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:26=
2:5
    #3 0x7f84d08df7da  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f7da)
    #4 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #5 0x7f84d08df9a2  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6f9a2)
    #6 0x7f84d08dfbad in g_test_run_suite
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbad)
    #7 0x7f84d08dfbd0 in g_test_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x6fbd0)
    #8 0x56375e619ab6 in main
/home/petmay01/linaro/qemu-for-merges/tests/test-qobject-input-visitor.c:13=
85:5
    #9 0x7f84cea7482f in __libc_start_main
/build/glibc-Cl5G7W/glibc-2.23/csu/../csu/libc-start.c:291
    #10 0x56375e5f6f88 in _start
(/home/petmay01/linaro/qemu-for-merges/build/clang/tests/test-qobject-input=
-visitor+0xabf88)

OK


thanks
-- PMM
