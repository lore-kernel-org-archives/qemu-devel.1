Received: from eggs.gnu.org ([2001:4830:134:3::10]:37284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXITK-0002QQ-VO
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXITH-0001hW-T3
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:47:23 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:34701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXITH-0001ge-JW
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:47:19 -0400
Received: by mail-pl0-x234.google.com with SMTP id g20-v6so6171733plq.1
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 20:47:19 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
Date: Sun, 24 Jun 2018 20:47:15 -0700
MIME-Version: 1.0
In-Reply-To: <2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

On 06/24/2018 11:38 AM, Programmingkid wrote:
> void test_division_by_zero()
> {
>     Converter c;
>     uint64_t expected_answer = 0x0;
>     uint32_t actual_fpscr, expected_fpscr = 0xc4000010;
>     reset_fpscr();
>     set_fpscr_bit(ZE);
>     asm volatile("fdiv %0, %1, %2" : "=f"(c.d) : "f"(1.0), "f"(0.0));

Try

    uint64_t expected_answer = 0xffff0000deadbeef;
    ...
    c.i = expected_answer;
    asm volatile("fdiv %0, %1, %2" : "+f"(c.d) : "f"(1.0), "f"(0.0));

to avoid depending on uninitialized data.  (This expected value is
an SNaN with a deadbeef marker Just to be Sure.)


r~
