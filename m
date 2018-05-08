Received: from eggs.gnu.org ([2001:4830:134:3::10]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4gq-0001Tv-Sx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4go-0005oh-I9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:08 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:41434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG4go-0005oR-D5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:06 -0400
Received: by mail-ot0-x230.google.com with SMTP id t1-v6so36576583oth.8
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:38:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180302185448.6314-9-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
	<20180302185448.6314-9-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 16:37:45 +0100
Message-ID: <CAFEAcA9eQ6be2Db89kR_OrrG2Hz-M_H7=NYDSTFQEXk62Lj9Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 08/37] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 2 March 2018 at 18:54, Kevin Wolf <kwolf@redhat.com> wrote:
> From: Eric Blake <eblake@redhat.com>
>
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the iscsi driver accordingly.  In this case,
> it is handy to teach iscsi_co_block_status() to handle a NULL map
> and file parameter, even though the block layer passes non-NULL
> values, because we also call the function directly.  For now, there
> are no optimizations done based on the want_zero flag.
>

> -    *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
> +    *pnum = lbasd->num_blocks * iscsilun->block_size;

Hi; following this change Coverity complains (CID1390646) about
this multiplication, which is a 32-bit multiply whose result
is then put into a 64-bit result. Is it intended to be a
64-bit multiply ?

thanks
-- PMM
