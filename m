Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXvUn-0006lj-PI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXvUk-00040l-I3
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:27:29 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXvUk-00040H-3v
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:27:26 -0400
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so9133508plj.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 14:27:25 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
	<dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
	<CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
	<CAFXwXrk+X_heyWnwAzLQ6E9+j5=AxJ-Dh+nM5e7zuQcJCEAsyg@mail.gmail.com>
	<6918D473-064B-4356-B8B0-EE20ED05544F@gmail.com>
	<2c18018e-24a1-c098-e0a0-b8f497804c1d@linaro.org>
	<28A15D70-9F99-4939-95F7-DBBA4EF31D6C@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc0fa3ec-fd41-d229-c4bb-1f391995bac4@linaro.org>
Date: Tue, 26 Jun 2018 14:27:20 -0700
MIME-Version: 1.0
In-Reply-To: <28A15D70-9F99-4939-95F7-DBBA4EF31D6C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

On 06/26/2018 12:50 PM, G 3 wrote:
> 
> If FPSCR[ZE] is set or not set, answer = 0x7ff0000000000000. This indicates to
> me that the fdiv instruction needs a little work. This is what I think should
> happen. If division by zero takes  place and the FPSCR[ZE] bit is set, then the
> value in the destination register should not be altered (rather than returning
> zero).

I have not tested, but I suspect the same will be true for all other
floating-point exceptions.

E.g. try fmul of DBL_MAX * DBL_MAX with FPSCR[OE] set.

To my eye we would need to rearrange all of the fp operations:

(1) Remove helper_reset_fpstatus.
    Every fp operation should leave 0 in the exception_flags.

    Failure to do so indicates we're missing the post-operation
    processing of exceptions via float_check_status.  Which is
    in fact exactly the bug here for fdiv.  And based on a quick
    browse, also fmul, fsub, and fadd.

(2) float_check_status should be re-organized.

  (a) if status == 0, early exit,
  (b) otherwise, set_float_exception_flags(&env->fp_status, 0) immediately.

(3) I suspect that all of the exception special cases can be
    reordered such that we test them after the operation, as
    they should all be unlikely.

    A good example is target/tricore/fpu_helper.c, in which
    we test the exception flags, do special cases when we
    find e.g. float_flags_invalid set, and then process the
    exceptions that were raised.


r~
