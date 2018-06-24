Received: from eggs.gnu.org ([2001:4830:134:3::10]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWvdN-0004Mh-Di
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWvdM-0001EV-0X
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:24:13 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWvdL-0001Dm-S2
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:24:11 -0400
Received: by mail-yw0-x242.google.com with SMTP id n187-v6so240702ywd.1
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 20:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 23 Jun 2018 20:24:09 -0700
Message-ID: <CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Sat, Jun 23, 2018 at 2:57 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 06/23/2018 06:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Max, some tests never end, is that normal?

No, you've just found and reported a bug. Thank you.
Bisection points to the following commit:

commit 0b5c91f74f3c83a36f37740969df8c775c997e69
Author: Emilio G. Cota <cota@braap.org>
Date:   Wed Jul 26 20:22:51 2017 -0400

    translate-all: use per-page locking in !user-mode

Bisection log:

git bisect start
# bad: [f28d0dfdce5754d80d2a5993fff2f5312b32cac1] tcg: fix
--disable-tcg build breakage
git bisect bad f28d0dfdce5754d80d2a5993fff2f5312b32cac1
# good: [c74e62ee3e2dc2955e07d004c71badecb68a84eb] Merge
remote-tracking branch 'remotes/rth/tags/cota-target-pull-request'
into staging
git bisect good c74e62ee3e2dc2955e07d004c71badecb68a84eb
# good: [f67c9b693ae3d03305162623a043ba4067a3c00c] Merge
remote-tracking branch 'remotes/mst/tags/for_upstream' into staging
git bisect good f67c9b693ae3d03305162623a043ba4067a3c00c
# good: [21f402093c5ee7363f5ba56916cd5c651b424fef] iommu: Add IOMMU
index concept to IOMMU API
git bisect good 21f402093c5ee7363f5ba56916cd5c651b424fef
# good: [7a5d936b6fc0cf262db86af0df7999ac904f8495] docker: docker.py
wrap StringIO import for python3
git bisect good 7a5d936b6fc0cf262db86af0df7999ac904f8495
# bad: [de44c044420d1139480fa50c2d5be19223391218] Merge
remote-tracking branch
'remotes/stsquad/tags/pull-tcg-testing-revivial-210618-2' into staging
git bisect bad de44c044420d1139480fa50c2d5be19223391218
# good: [7e97017e7db3c0ce552cf1a58df8bb97bde29c98] tests/tcg/Makefile:
update to be called from Makefile.target
git bisect good 7e97017e7db3c0ce552cf1a58df8bb97bde29c98
# bad: [33836a731562e3d07b3a83f26e81c6b1482d216c] Merge
remote-tracking branch 'remotes/rth/tags/pull-tcg-20180615' into
staging
git bisect bad 33836a731562e3d07b3a83f26e81c6b1482d216c
# good: [45c73de594414904b0d6a7ade70fb4514d35f79c] translate-all: move
tb_invalidate_phys_page_range up in the file
git bisect good 45c73de594414904b0d6a7ade70fb4514d35f79c
# bad: [194125e3ebd553acb02aaf3797a4f0387493fe94] translate-all:
protect TB jumps with a per-destination-TB lock
git bisect bad 194125e3ebd553acb02aaf3797a4f0387493fe94
# bad: [6d9abf85d538731ccff25fc29d7fa938115b1a80] translate-all: add
page_locked assertions
git bisect bad 6d9abf85d538731ccff25fc29d7fa938115b1a80
# bad: [0b5c91f74f3c83a36f37740969df8c775c997e69] translate-all: use
per-page locking in !user-mode
git bisect bad 0b5c91f74f3c83a36f37740969df8c775c997e69
# first bad commit: [0b5c91f74f3c83a36f37740969df8c775c997e69]
translate-all: use per-page locking in !user-mode

Emilio, could you please take a look? The following test locks up QEMU:

qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting -icount
6  -kernel ./test_mmu.tst

test_mmu.tst binary may be found here:
http://jcmvbkbc.spb.ru/~dumb/tmp/201806232022/test_mmu.tst

--=20
Thanks.
-- Max
