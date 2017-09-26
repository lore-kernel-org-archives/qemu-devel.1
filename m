Received: from eggs.gnu.org ([2001:4830:134:3::10]:42388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwuSv-0007XY-8p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwuSs-0007cK-0b
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:20:17 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:56487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwuSr-0007Zn-FB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:20:13 -0400
Received: by mail-pf0-x233.google.com with SMTP id g65so5923858pfe.13
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:20:11 -0700 (PDT)
Received: from bigtime.twiddle.net ([70.35.39.2])
	by smtp.gmail.com with ESMTPSA id
	q67sm18901327pfg.160.2017.09.26.11.20.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 26 Sep 2017 11:20:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-5-richard.henderson@linaro.org>
Message-ID: <a615f520-a3e1-83eb-da65-a03b0d118903@linaro.org>
Date: Tue, 26 Sep 2017 11:20:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170919150313.10833-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/19/2017 08:03 AM, Richard Henderson wrote:
> +    while (1) {
> +        /* We want to read memory for one insn, but generically we do not
> +           know how much memory that is.  We have a small buffer which is
> +           known to be sufficient for all supported targets.  Try to not
> +           read beyond the page, Just In Case.  For even more simplicity,
> +           ignore the actual target page size and use a 1k boundary.  If
> +           that turns out to be insufficient, we'll come back around the
> +           loop and read more.  */
> +        uint64_t epc = QEMU_ALIGN_UP(pc + csize, 1024);
> +        size_t tsize = MIN(sizeof(cap_buf) - csize, epc - pc);
...
> +        assert(tsize != 0);

By inspection, epc must be computed from pc + csize + 1.
If csize = 0 and pc % 1024 == 0, epc == pc and tsize == 0,
which will assert.


r~
