Received: from eggs.gnu.org ([209.51.188.92]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxacn-0000Wf-HH
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxacm-00073T-1w
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:58:05 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxacj-0006at-8y
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:58:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id v62so4527873otb.3
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 08:57:35 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190221111147.GB3282@stefanha-x1.localdomain>
	<VI1PR0602MB3245593855B029B427ED544FA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUs9Yz2-k1KyVMwpgx6RwY9cK7qdQRCQ74xmgXJPJR-qw@mail.gmail.com>
	<VI1PR0602MB32453A8B5CBC0308C7D18F1DA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Feb 2019 16:57:23 +0000
Message-ID: <CAFEAcA9xXoM-Bh=oAwX5KOaNoRo1vg_oYV+o6WpPTOVPFC=8Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Natanael Copa <ncopa@alpinelinux.org>

On Fri, 22 Feb 2019 at 14:07, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Richard: Commit 7db2145a6826b14efceb8dd64bfe6ad8647072eb ("bswap: Add
> host endian unaligned access functions") introduced the unaligned
> memory access functions in question here.  Please see below for
> details on the bug - basically QEMU code assumes they are atomic, but
> that is not guaranteed :(.  Any ideas for how to fix this?

I suspect we want a separate family of access functions for
"I guarantee this will be an aligned access and I need the
atomicity". (The other place where we've talked about needing
the atomicity is in emulation of page-table-walk, where you
need the page table loads to be atomic w.r.t. other CPU
threads, especially in the case where you need to emulate
a hardware update of a dirty/access bit in the page table entry.)

Mostly this hasn't bitten us before because any sensible compiler
will turn the memcpy into a straight load on most common hosts,
which will be atomic (but accidentally rather than on purpose).

thanks
-- PMM
